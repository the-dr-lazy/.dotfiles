;;; the-dr-lazy/purescript/config.el -*- lexical-binding: t; -*-

(use-package! purescript-mode
  :config
  (set-ligatures! 'haskell-mode
    ;; Functional
    :left-composition "<<<"
    :right-composition ">>>"
    ;; Logical
    :forall "forall"
    :exists "exists"
    :and "&&"
    :or "||"
    :not "not"
    ;; Algebraic
    :not-equal "/="
    ;; Types
    :int "Int"
    :int "Integer"
    :int8 "Int8"
    :int16 "Int16"
    :int32 "Int32"
    :int64 "Int64"
    :void "Void"
    :bool "Bool"
    :true "True"
    :false "False"
    :bottom "undefined"
    ;; Brand
    :monarch "Monarch"))
