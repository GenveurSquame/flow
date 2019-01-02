(**
 * Copyright (c) 2013-present, Facebook, Inc.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 *)

open Reason
open Type

module type S = sig
  val check_polarity: Context.t -> ?trace:Trace.t -> polarity -> Type.t -> unit
  val eval_selector: Context.t -> ?trace:Trace.t -> reason -> Type.t -> Type.selector -> int ->
    Type.t
  val filter_optional: Context.t -> ?trace:Trace.t -> reason -> Type.t -> Type.t
  val flow: Context.t -> Type.t * Type.use_t -> unit
  val flow_p: Context.t -> ?use_op:use_op -> reason -> reason -> Type.propref ->
    (Type.property * Type.property) -> unit
  val flow_t: Context.t -> Type.t * Type.t -> unit
  val generate_tests: Context.t -> Type.typeparam list -> (Type.t SMap.t -> 'a) -> 'a
  val get_builtin: Context.t -> ?trace:Trace.t -> string -> reason -> Type.t
  val get_builtin_type: Context.t -> ?trace:Trace.t -> reason -> ?use_desc:bool -> string -> Type.t
  val get_builtin_typeapp: Context.t -> ?trace:Trace.t -> reason -> string -> Type.t list -> Type.t
  val is_munged_prop_name: Context.t -> name -> bool
  val lookup_builtin: Context.t -> ?trace:Trace.t -> string -> reason -> Type.lookup_kind -> Type.t
    -> unit
  val match_this_binding: Type.t SMap.t -> (Type.t -> bool) -> bool
  val mk_instance: Context.t -> ?trace:Trace.t -> reason -> ?use_desc:bool -> Type.t -> Type.t
  val mk_typeof_annotation: Context.t -> ?trace:Trace.t -> reason -> ?use_desc:bool -> Type.t ->
    Type.t
  val mk_type_destructor: Context.t -> trace:Trace.t -> use_op -> reason -> Type.t ->
    Type.destructor -> int -> bool * Type.t
  val reposition: Context.t -> ?trace:Trace.t -> ALoc.t -> ?desc:reason_desc -> ?annot_loc:ALoc.t ->
    Type.t -> Type.t
  val resolve_spread_list: Context.t -> use_op:use_op -> reason_op:reason ->
    unresolved_param list -> spread_resolve -> unit
  val set_builtin: Context.t -> ?trace:Trace.t -> string -> Type.t -> unit
  val tvar_with_constraint: Context.t -> ?trace:Trace.t -> ?derivable:bool -> Type.use_t -> Type.t
  val unify: Context.t -> Type.t -> Type.t -> unit
  val unify_opt: Context.t -> ?trace:Trace.t -> ?use_op:Type.use_op -> ?unify_any:bool -> Type.t ->
    Type.t -> unit
end
