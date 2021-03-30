(** A context holds heterogeneous value and is passed to the requests or
    responses. *)

(** {2:keys Keys} *)

(** The type for keys whose lookup value is of type ['a]. *)
type 'a key

(** {3 [Key]} *)

module Key : sig
  (** {2:keys Keys} *)

  (** The type for key information. *)
  type 'a info = string * ('a -> Sexplib0.Sexp.t)

  (** {3 [create]} *)

  val create : 'a info -> 'a key
  (** [create i] is a new key with information [i]. *)

  (** {3 [info]} *)

  val info : 'a key -> 'a info
  (** [info k] is [k]'s information. *)

  (** {2:exists Existential keys}

      Exisential keys allow to compare keys. This can be useful for functions
      like {!filter}. *)

  (** The type for existential keys. *)
  type t

  (** {3 [hide_type]} *)

  val hide_type : 'a key -> t
  (** [hide_type k] is an existential key for [k]. *)

  (** {3 [equal]} *)

  val equal : t -> t -> bool
  (** [equal k k'] is [true] iff [k] and [k'] are the same key. *)

  (** {3 [compare]} *)

  val compare : t -> t -> int
  (** [compare k k'] is a total order on keys compatible with {!equal}. *)
end

(** {2:maps Maps} *)

(** The type for heterogeneous value maps. *)
type t

(** {3 [empty]} *)

val empty : t
(** [empty] is the empty map. *)

(** {3 [is_empty]} *)

val is_empty : t -> bool
(** [is_empty m] is [true] iff [m] is empty. *)

(** {3 [mem]} *)

val mem : 'a key -> t -> bool
(** [mem k m] is [true] iff [k] is bound in [m]. *)

(** {3 [add]} *)

val add : 'a key -> 'a -> t -> t
(** [add k v m] is [m] with [k] bound to [v]. *)

(** {3 [singleton]} *)

val singleton : 'a key -> 'a -> t
(** [singleton k v] is [add k v empty]. *)

(** {3 [rem]} *)

val rem : 'a key -> t -> t
(** [rem k m] is [m] with [k] unbound. *)

(** {3 [find]} *)

val find : 'a key -> t -> 'a option
(** [find k m] is the value of [k]'s binding in [m], if any. *)

(** {3 [find_exn]} *)

val find_exn : 'a key -> t -> 'a
(** [find_exn k m] is the value of [k]'s binding find_exn [m].

    @raise Invalid_argument if [k] is not bound in [m]. *)

(** {2:utilities Utilities} *)

(** {3 [sexp_of_t]} *)

val sexp_of_t : t -> Sexplib0.Sexp.t
(** [sexp_of_t t] converts the request [t] to an s-expression *)

(** {3 [pp_hum]} *)

val pp_hum : Format.formatter -> t -> unit
  [@@ocaml.toplevel_printer]
(** [pp_hum] formats the request [t] as a standard HTTP request *)
