# RFC 6585 Test Suite

Compliance tests for [RFC 6585](https://tools.ietf.org/html/rfc6585).

```
dune build @rfc6585
```

## [T1] status_code_428

**Description:** The 428 Precondition Required status code can be sent. (RFC6585 3)

## [T2] status_code_429

**Description:** The 429 Too Many Requests status code can be sent. (RFC6585 4)

## [T3] status_code_429_retry_after

**Description:** The (429) response MAY include a Retry-After header indicating how long to wait before making a new request. (RFC6585 4)

## [T4] status_code_431

**Description:** The 431 Request Header Fields Too Large status code can be sent. (RFC6585 5)

## [T5] status_code_511

**Description:** The 511 Network Authentication Required status code can be sent. (RFC6585 6)
