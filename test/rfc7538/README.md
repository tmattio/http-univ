# RFC 7538 Test Suite

Compliance tests for [RFC 7538](https://tools.ietf.org/html/rfc7538).

## [T1] status_code_308

**Description:** The 308 Permanent Redirect status code can be sent. (RFC7538 3)

## [T2] status_code_308_location

**Description:** The server SHOULD generate a Location header field ([RFC7231], Section 7.1.2) in the response containing a preferred URI reference for the new permanent URI.
