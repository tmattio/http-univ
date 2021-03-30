open Rock_httpaf.Router

let t = ref empty

let get r h =
  let new_t = get !t r h in
  t := new_t

let () =
  get "/rfc6585/status_code_428" Handler_rfc6585.status_code_428;
  get "/rfc6585/status_code_429" Handler_rfc6585.status_code_429;
  get
    "/rfc6585/status_code_429_retry_after"
    Handler_rfc6585.status_code_429_retry_after;
  get "/rfc6585/status_code_431" Handler_rfc6585.status_code_431;
  get "/rfc6585/status_code_511" Handler_rfc6585.status_code_511

let m = m !t
