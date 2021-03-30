module Method_map = Map.Make (struct
  type t = Httpaf.Method.t

  let compare a b =
    let left = String.uppercase_ascii (Httpaf.Method.to_string a) in
    let right = String.uppercase_ascii (Httpaf.Method.to_string b) in
    String.compare left right
end)

type t = Handler.t Method_map.t Router.t

let empty = Router.empty

let add_route (t : t) ~route ~meth ~action =
  Router.update t route ~f:(function
      | None ->
        Method_map.singleton meth action
      | Some m ->
        Method_map.add meth action m)

let add (t : t) ~route ~meth ~action =
  let route = Router.Route.of_string route in
  add_route t ~route ~meth ~action

let get t route action = add t ~route ~action ~meth:`GET

let post t route action = add t ~route ~action ~meth:`POST

(** finds matching endpoint and returns it with the parsed list of parameters *)
let matching_endpoint (endpoints : t) meth uri =
  match Router.match_url endpoints uri with
  | None ->
    None
  | Some (a, params) ->
    (match Method_map.find_opt meth a with
    | None ->
      None
    | Some h ->
      Some (h, params))

module Env = struct
  let key : Router.Params.t Context.key =
    Context.Key.create ("path_params", Router.Params.sexp_of_t)
end

let splat req =
  Context.find_exn Env.key req.Request.env |> Router.Params.unnamed

(* not param_exn since if the endpoint was selected it's likely that the
   parameter is already there *)
let param req param =
  let params = Context.find_exn Env.key req.Request.env in
  Router.Params.named params param

let m endpoints =
  let filter default req =
    match matching_endpoint endpoints req.Request.meth req.Request.target with
    | None ->
      default req
    | Some (handler, params) ->
      let env_with_params = Context.add Env.key params req.Request.env in
      handler { req with Request.env = env_with_params }
  in
  Middleware.create ~name:"Router" ~filter
