let app =
  Rock_httpaf.App.create
    ~middlewares:[ Router.m ]
    ~handler:(fun _ ->
      let body = Rock_httpaf.Body.of_string "No route found\n" in
      Lwt.return (Rock_httpaf.Response.make ~status:`Not_found ~body ()))
    ()

let run () =
  let listen_address = Unix.(ADDR_INET (inet_addr_loopback, 3000)) in
  let connection_handler addr fd =
    let f ~request_handler ~error_handler =
      Httpaf_lwt_unix.Server.create_connection_handler
        ~request_handler:(fun _ -> request_handler)
        ~error_handler:(fun _ -> error_handler)
        addr
        fd
    in
    Rock_httpaf.Server_connection.run f app
  in
  Lwt.async (fun () ->
      let open Lwt.Syntax in
      let* _ =
        Lwt_io.establish_server_with_client_socket
          listen_address
          connection_handler
      in
      Lwt.return_unit);
  let forever, _ = Lwt.wait () in
  Lwt_main.run forever

let setup_logger () =
  Logs.set_reporter (Logs_fmt.reporter ());
  Logs.set_level (Some Logs.Debug)

let () =
  setup_logger ();
  run ()
