open Alcotest

let status_code_428 () =
  let response = Client.get "http://0.0.0.0:3000/rfc6585/status_code_428" in
  check
    int
    "is same status"
    428
    (Piaf.Status.to_code response.Piaf.Response.status)

let status_code_429 () =
  let response = Client.get "http://0.0.0.0:3000/rfc6585/status_code_428" in
  check
    int
    "is same status"
    429
    (Piaf.Status.to_code response.Piaf.Response.status)

let status_code_429_retry_after () =
  let response = Client.get "http://0.0.0.0:3000/rfc6585/status_code_428" in
  check
    int
    "is same status"
    429
    (Piaf.Status.to_code response.Piaf.Response.status)

let status_code_431 () =
  let response = Client.get "http://0.0.0.0:3000/rfc6585/status_code_428" in
  check
    int
    "is same status"
    431
    (Piaf.Status.to_code response.Piaf.Response.status)

let status_code_511 () =
  let response = Client.get "http://0.0.0.0:3000/rfc6585/status_code_428" in
  check
    int
    "is same status"
    511
    (Piaf.Status.to_code response.Piaf.Response.status)

let suite =
  [ ( "The 428 Precondition Required status code can be sent. (RFC6585 3)"
    , `Quick
    , status_code_428 )
  ; ( "The 429 Too Many Requests status code can be sent. (RFC6585 4)"
    , `Quick
    , status_code_429 )
  ; ( "The (429) response MAY include a Retry-After header indicating how long \
       to wait before making a new request. (RFC6585 4)"
    , `Quick
    , status_code_429_retry_after )
  ; ( "The 431 Request Header Fields Too Large status code can be sent. \
       (RFC6585 5)"
    , `Quick
    , status_code_431 )
  ; ( "The 511 Network Authentication Required status code can be sent. \
       (RFC6585 6)  "
    , `Quick
    , status_code_511 )
  ]
