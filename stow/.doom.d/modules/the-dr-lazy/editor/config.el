;;; the-dr-lazy/editor/config.el -*- lexical-binding: t; -*-

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Space vs Tab

(setq custom-tab-width 2)
(defun disable-tabs () (setq indent-tabs-mode nil))
(defun enable-tabs  ()
  (local-set-key (kbd "TAB") 'tab-to-tab-stop)
  (setq indent-tabs-mode t)
  (setq tab-width custom-tab-width))

(add-hook 'haskell-mode-hook 'disable-tabs)
(add-hook 'purescript-mode-hook 'disable-tabs)
(add-hook 'typescript-mode-hook 'disable-tabs)
(add-hook 'javascript-mode-hook 'disable-tabs)

(global-whitespace-mode)
(setq whitespace-style '(face tabs tab-mark trailing))
(setq-default evil-shift-width custom-tab-width)
(setq-default haskell-indent-offset custom-tab-width)
(setq-default electric-indent-inhibit t)
(setq backward-delete-char-untabify-method 'hungry)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Line Numbers

;; If you want to change the style of line numbers, change this to `relative' or
;; `nil' to disable it:
(setq display-line-numbers-type 'relative)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Evil

(setq evil-move-cursor-back nil
      evil-move-beyond-eol t)

(auto-save-visited-mode 1)
(global-auto-revert-mode t)
