(** Represents an HTTP request or response body. *)

type content =
  [ `Empty
  | `String of string
  | `Bigstring of Bigstringaf.t
  | (* TODO: switch to a iovec based stream *)
    `Stream of string Lwt_stream.t
  ]

(** [t] represents an HTTP message body. *)
type t =
  { length : Int64.t option
  ; content : content
  }

(** {1 Constructor} *)

val of_string : string -> t
(** [of_string] creates a fixed length body from a string. *)

val of_bigstring : Bigstringaf.t -> t
(** [of_bigstring] creates a fixed length body from a bigstring. *)

val of_stream : ?length:Int64.t -> string Lwt_stream.t -> t
(** [of_stream] takes a [string Lwt_stream.t] and creates a HTTP body from it. *)

val empty : t
(** [empty] represents a body of size 0L. *)

val copy : t -> t
(** [copy t] creates a new instance of the body [t]. If the body is a stream, it
    is be duplicated safely and the initial stream will remain untouched. *)

(** {1 Decoders} *)

val to_string : t -> string Lwt.t
(** [to_string t] returns a promise that will eventually be filled with a string
    representation of the body. *)

val to_stream : t -> string Lwt_stream.t
(** [to_stream t] converts the body to a [string Lwt_stream.t]. *)

(** {1 Getters and Setters} *)

val length : t -> Int64.t option

(** {1 Utilities} *)

val drain : t -> unit Lwt.t
(** [drain t] will repeatedly read values from the body stream and discard them. *)

val sexp_of_t : t -> Sexplib0.Sexp.t
(** [sexp_of_t t] converts the body [t] to an s-expression *)

val pp : Format.formatter -> t -> unit
  [@@ocaml.toplevel_printer]
(** [pp] formats the body [t] as an s-expression *)

val pp_hum : Format.formatter -> t -> unit
  [@@ocaml.toplevel_printer]
(** [pp_hum] formats the body [t] as an string.

    If the body content is a stream, the pretty printer will output the value
    ["<stream>"]*)
