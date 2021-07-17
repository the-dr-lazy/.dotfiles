;;; the-dr-lazy/ui/config.el -*- lexical-binding: t; -*-

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Frame

(add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
(add-to-list 'default-frame-alist '(ns-appearance . dark))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Typography

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two
(setq doom-font                (font-spec :family "VictorMono Nerd Font" :size 18)
      doom-unicode-font        (font-spec :family "VictorMono Nerd Font" :size 18)
      doom-variable-pitch-font (font-spec :family "VictorMono Nerd Font" :size 18))

(custom-set-faces!
  '(font-lock-comment-face :slant italic)
  '(font-lock-keyword-face :slant italic))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Ligature

(setq +ligatures-extra-symbols
      '(;; Functional
        :lambda "λ"
        :delta "∆"
        :left-composition "ᗕ"
        :right-composition "ᗒ"
        :function "ƒ"
        ;; Logical
        :forall "∀"
        :exists "∃"
        :not "¬"
        :and "∧"
        :or "∨"
        :import "⟼"
        :export "⟻"
        ;; Algebraic
        :not-equal "≠"
        ;; Types
        :int "ℤ"
        :int "ℤ"
        :int8 "ℤ₈"
        :int16 "ℤ₁₆"
        :int32 "ℤ₃₂"
        :int64 "ℤ₆₄"
        :void "∅"
        :bool "𝔹"
        :true "𝕋"
        :false "𝔽"
        :bottom "⊥"
        ;; Brand
        :monarch "⋈"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Theme

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. These are the defaults.
(setq doom-theme 'doom-moonlight)

(after! doom-themes
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Dashboard 

(setq +doom-dashboard-functions '(doom-dashboard-widget-banner))
(setq fancy-splash-image (concat doom-private-dir "modules/the-dr-lazy/ui/media/gnu.png"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Modeline

(add-hook! 'window-setup-hook doom-modeline-mode)

(after! doom-modeline
  (setq doom-modeline-bar-width 3
        doom-modeline-buffer-file-name-style 'file-name
        doom-modeline-icon t
        doom-modeline-major-mode-icon t))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Highlight

(after! hl-todo
  (setq hl-todo-keyword-faces '(("ToDo" warning bold)
                                ("TODO" warning bold)

                                ("Note" success bold)
                                ("NOTE" success bold)

                                ("See Note" markdown-url-face)
                                ("SEE NOTE" markdown-url-face)

                                ("Hack" font-lock-constant-face bold)
                                ("HACK" font-lock-constant-face bold)

                                ("FIXME" error bold)

                                ("Deprecated" font-lock-doc-face bold)
                                ("DEPRECATED" font-lock-doc-face bold)

                                ("Bug" error bold)
                                ("BUG" error bold)

                                ("XXX+" font-lock-constant-face bold))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Indent Guide

(setq highlight-indent-guides-method 'column)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; LSP Documentation

(after! lsp-ui
  (setq lsp-ui-doc-enable t
        lsp-ui-doc-delay 0
        lsp-ui-doc-position 'top
        lsp-ui-doc-include-signature t
        lsp-ui-doc-show-with-cursor t
        lsp-ui-doc-show-with-mouse nil
        lsp-ui-doc-max-width 89
        lsp-ui-doc-max-height 8
        lsp-ui-doc-border "#ffffff")
  (set-face-background 'lsp-ui-doc-background "#191b2e"))

(setq +lookup-open-url-fn #'+lookup-xwidget-webkit-open-url-fn)
