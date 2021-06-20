;;; the-dr-lazy/dhall/config.el -*- lexical-binding: t; -*-

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Major Mode

(use-package! dhall-mode
  :init
  (when (featurep! +lsp) (add-hook 'dhall-mode #'lsp!))
  :config
  (setq dhall-format-arguments (\` ("--ascii"))
        dhall-use-header-line nil))
