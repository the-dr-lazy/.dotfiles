;;; the-dr-lazy/javascript/config.el -*- lexical-binding: t; -*-

(add-hook! 'js2-mode-hook
  (unless (locate-dominating-file default-directory ".prettierrc")
    (format-all-mode -1)))
