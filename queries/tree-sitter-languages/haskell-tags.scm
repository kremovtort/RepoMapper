; RepoMapper Haskell tags
;
; Notes:
; - RepoMap's parser treats any capture containing `name.definition` as a `def`
;   and any capture containing `name.reference` as a `ref`.
; - Keep captures stable and grammar-compatible.
;
; module name
(header (module) @name.definition.module) @definition.module

; imports
(import (module) @name.reference.import) @reference.import

; type-level definitions
(data_type name: (name) @name.definition.type) @definition.type
(newtype name: (name) @name.definition.type) @definition.type
(type_synomym name: (name) @name.definition.type) @definition.type
(type_family name: (name) @name.definition.type) @definition.type
(class name: (name) @name.definition.class) @definition.class
(instance (name) @name.definition.instance) @definition.instance

; data/newtype constructors (prefix form)
(data_constructor
  constructor: (prefix
    name: (constructor) @name.definition.constructor)) @definition.constructor

; record fields
(field
  name: (field_name
    (variable) @name.definition.field)) @definition.field

; top-level value/function declarations
; Keep only explicit type signatures to avoid:
; - picking up equation lines (`foo x = ...`)
; - picking up local defs inside `where`/`let`
(declarations
  (signature
    (variable) @name.definition.function)) @definition.function

; references (best-effort)
(apply constructor: (name) @name.reference.type) @reference.type
(apply argument: (name) @name.reference.type) @reference.type
(promoted (constructor) @name.reference.constructor) @reference.constructor
