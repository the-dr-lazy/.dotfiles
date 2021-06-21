;;; the-dr-lazy/haskell/config.el -*- lexical-binding: t; -*-

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Major Mode

(use-package! haskell-mode
  :mode "\\.hs-boot\\'"
  :config
  (set-ligatures! 'haskell-mode
    ;; Functional
    :delta "delta"
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

(add-hook! 'haskell-mode-hook 'haskell-auto-insert-module-template)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; LSP

(use-package! lsp-haskell
  :config
  (setq lsp-haskell-server-path "haskell-language-server-wrapper"
        lsp-haskell-liquid-on t
        lsp-haskell-formatting-provider "stylish-haskell"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; MISC

(after! projectile
  (add-to-list 'projectile-project-root-files "cabal.project"))
