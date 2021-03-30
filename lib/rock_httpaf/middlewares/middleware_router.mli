type t

val m : t -> Middleware.t

val empty : t

val add : t -> route:string -> meth:Httpaf.Method.t -> action:Handler.t -> t

val add_route
  :  t
  -> route:Router.Route.t
  -> meth:Httpaf.Method.t
  -> action:Handler.t
  -> t

val param : Request.t -> string -> string

val splat : Request.t -> string list

val get : t -> string -> Handler.t -> t

val post : t -> string -> Handler.t -> t
