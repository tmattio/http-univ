(** Module to create HTTP requests. *)

type t =
  { version : Httpaf.Version.t
  ; target : string
  ; headers : Httpaf.Headers.t
  ; meth : Httpaf.Method.t
  ; body : Body.t
  ; env : Context.t
  }

(** {1 Constructors} *)

(** {3 [make]} *)

val make
  :  ?version:Httpaf.Version.t
  -> ?body:Body.t
  -> ?env:Context.t
  -> ?headers:Httpaf.Headers.t
  -> string
  -> Httpaf.Method.t
  -> t
(** [make ?version ?body ?env ?headers target method] creates a new request from
    the given values.

    By default, the HTTP version will be set to 1.1 and the request will not
    contain any header or body. *)

(** {3 [get]} *)

val get
  :  ?version:Httpaf.Version.t
  -> ?body:Body.t
  -> ?env:Context.t
  -> ?headers:Httpaf.Headers.t
  -> string
  -> t
(** [get ?version ?body ?env ?headers target] creates a new [GET] request from
    the given values.

    By default, the HTTP version will be set to 1.1 and the request will not
    contain any header or body. *)

(** {3 [post]} *)

val post
  :  ?version:Httpaf.Version.t
  -> ?body:Body.t
  -> ?env:Context.t
  -> ?headers:Httpaf.Headers.t
  -> string
  -> t
(** [post ?version ?body ?env ?headers target] creates a new [POST] request from
    the given values.

    By default, the HTTP version will be set to 1.1 and the request will not
    contain any header or body. *)

(** {3 [put]} *)

val put
  :  ?version:Httpaf.Version.t
  -> ?body:Body.t
  -> ?env:Context.t
  -> ?headers:Httpaf.Headers.t
  -> string
  -> t
(** [put ?version ?body ?env ?headers target] creates a new [PUT] request from
    the given values.

    By default, the HTTP version will be set to 1.1 and the request will not
    contain any header or body. *)

(** {3 [delete]} *)

val delete
  :  ?version:Httpaf.Version.t
  -> ?body:Body.t
  -> ?env:Context.t
  -> ?headers:Httpaf.Headers.t
  -> string
  -> t
(** [delete ?version ?body ?env ?headers target] creates a new [DELETE] request
    from the given values.

    By default, the HTTP version will be set to 1.1 and the request will not
    contain any header or body. *)
