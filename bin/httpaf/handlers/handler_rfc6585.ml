open Rock_httpaf

let status_code_428 _req =
  Lwt.return @@ Response.make ~status:`Internal_server_error ()

let status_code_429 _req =
  Lwt.return @@ Response.make ~status:`Internal_server_error ()

let status_code_429_retry_after _req =
  Lwt.return @@ Response.make ~status:`Internal_server_error ()

let status_code_431 _req =
  Lwt.return @@ Response.make ~status:`Internal_server_error ()

let status_code_511 _req =
  Lwt.return @@ Response.make ~status:`Internal_server_error ()
