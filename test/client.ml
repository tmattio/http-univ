open Piaf

let get url =
  let result = Lwt_main.run (Client.Oneshot.get (Uri.of_string url)) in
  match result with
  | Ok response ->
    response
  | Error _ ->
    Alcotest.failf "The request to %s failed with an error" url

let post url =
  let result = Lwt_main.run (Client.Oneshot.post (Uri.of_string url)) in
  match result with
  | Ok response ->
    response
  | Error _ ->
    Alcotest.failf "The request to %s failed with an error" url
