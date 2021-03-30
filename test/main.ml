let () =
  Alcotest.run
    "http-univ"
    [ "RFC6585", Client_rfc6585.suite; "RFC7538", Client_rfc7538.suite ]
