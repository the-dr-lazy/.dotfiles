;;; the-dr-lazy/purescript/config.el -*- lexical-binding: t; -*-

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Major Mode

(use-package! purescript-mode
  :config
  (set-ligatures! 'purescript-mode
      ;; Functional
      :delta "delta"
      :lambda "\\"
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
      :monarch "Monarch")
  (setq purescript-font-lock-prettify-symbols-alist (alist-get 'purescript-mode +ligatures-extra-alist))
  (setq psc-ide-use-npm-bin t))