let status_code_308 () = Alcotest.fail "TODO"

let status_code_308_location () = Alcotest.fail "TODO"

let suite =
  [ ( "The 308 Permanent Redirect status code can be sent. (RFC7538 3)"
    , `Quick
    , status_code_308 )
  ; ( "The server SHOULD generate a Location header field ([RFC7231], Section \
       7.1.2) in the response containing a preferred URI reference for the new \
       permanent URI."
    , `Quick
    , status_code_308_location )
  ]
