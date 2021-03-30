(** Trie based router. Allows for no ambiguities beteween routes. *)

module Route : sig
  (** A route is defined by the following (pseaudo) bnf:

      {[
        <route> ::= "/" <elements> "/**"?

        <elements> ::=
          | ""
          | <elements> "/" <param>
          | <elements> "/" <literal>

        <param> ::=
          | ":" [^/]+
          | "*"

        <literal> ::= [^/]+
      ]}

      Examples:

      - "/foo/bar" : route that only matches "/foo/bar"
      - "/:foo/*" : route that matches a named parmeter "foo" and unnamed
        parameter
      - "/foo/:bar/**" : A route that matches any route of the regex form
        /foo/[^/]+/.* *)
  type t

  val of_string_result : string -> (t, string) result

  val of_string : string -> t

  val sexp_of_t : t -> Sexplib0.Sexp.t

  val to_string : t -> string
end

module Params : sig
  (** Parameters obtained after a route matches *)
  type t

  val named : t -> string -> string
  (** Extract a single named parameter *)

  val all_named : t -> (string * string) list
  (** only for testing *)

  val make
    :  named:(string * string) list
    -> unnamed:string list
    -> full_splat:string option
    -> t
  (** Only for testing *)

  val unnamed : t -> string list
  (** Etract all unnamed "*" parameters in order *)

  val full_splat : t -> string option
  (** [full_splat t] returns the raw string matched by "**". *)

  val splat : t -> string list
  (** [splat t] extracts unnamed + full_splat in a single list. This is present
      to match the old routing behavior *)

  val sexp_of_t : t -> Sexplib0.Sexp.t

  val equal : t -> t -> bool

  val pp : Format.formatter -> t -> unit
end

(** Represents a router *)
type 'a t

val empty : 'a t
(** Empty router that matches no routes *)

val add : 'a t -> string -> 'a -> 'a t
(** [add router route h] Builds a string from [route] and add it to [router] and
    attach [h] when [route] matches.

    It's not allowed to have more than a single route match a single path.*)

val add_route : 'a t -> Route.t -> 'a -> 'a t
(** [add router route h] Add [route] to [router] and attach [h] when [route]
    matches.

    It's not allowed to have more than a single route match a single path.*)

val update : 'a t -> Route.t -> f:('a option -> 'a) -> 'a t
(** [update router route ~f] updates the value at [route]. [f None] is called if
    the route wasn't added before. *)

val match_url : 'a t -> string -> ('a * Params.t) option
(** [match_url router url] atempts to match [url] and returns the handler at the
    route and parsed parameters. *)

val sexp_of_t : ('a -> Sexplib0.Sexp.t) -> 'a t -> Sexplib0.Sexp.t
