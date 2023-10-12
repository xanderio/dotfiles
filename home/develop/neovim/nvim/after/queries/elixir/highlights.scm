; extends

; Definition Function Calls
(call target: ((identifier) @keyword.function (#any-of? @keyword.function
  "def"
  "defdelegate"
  "defexception"
  "defguard"
  "defguardp"
  "defimpl"
  "defmacro"
  "defmacrop"
  "defmodule"
  "defn"
  "defnp"
  "defoverridable"
  "defp"
  "defprotocol"
  "defstruct"
  ))
  (arguments [
    (call (identifier) @function)
    (identifier) @function
    (binary_operator left: (call target: (identifier) @function) operator: "when")])?)
