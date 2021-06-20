;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Private
;;
;; Place your private configuration here! Remember, you do not need to run 'doom
;; refresh' after modifying this file!

;; These are used for a number of things, particularly for GPG configuration,
;; some email clients, file templates and snippets.
(setq user-full-name "Mohammad Hasani"
      user-mail-address "thebrodmann@protonmail.com")

;; If you intend to use org, it is recommended you change this!
(setq org-directory "~/org/")

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; Doom
;;

;;
;; UI
;;

;;
;; Evil
;;




;;
;; Git
;;


;;
;; Editor
;;


(auto-save-visited-mode 1)
(global-auto-revert-mode t)
(setq +lookup-open-url-fn #'+lookup-xwidget-webkit-open-url-fn)


;;
;; Haskell
;;
;; (add-hook! 'haskell-mode-hook 'haskell-auto-insert-module-template)
;; (setq haskell-process-type 'cabal-new-repl)
;; (defun lsp-haskell--get-root ()
;;   "Get project root directory.
;; First searches for root via projectile.  Tries to find cabal file
;; if projectile way fails"
;;   (if (not (eq projectile-project-root nil))
;;       (projectile-project-root)
;;     (let ((dir (lsp-haskell--session-cabal-dir)))
;;       (if (string= dir "/")
;;           (user-error (concat "Couldn't find cabal file, using:" dir))
;;         dir))))

;; (use-package! haskell-mode
;;   :mode (("\\.hs-boot\\'" . haskell-mode)
;;          )
;;   )

;; (add-hook! 'haskell-mode-hook
;;   (setq lsp-haskell-process-wrapper-function
;;         (lambda (argv)
;;           (append argv (list "--cwd" (lsp-haskell--get-root))))))

;; (use-package! lsp-haskell
;;   :config
;;   (setq lsp-haskell-server-path "haskell-language-server-wrapper")
;;   (setq lsp-haskell-liquid-on t)
;;   (setq lsp-haskell-formatting-provider "stylish-haskell")
;;   )

;;
;; PDF
;;
;; (use-package! org-pdftools
;;   :hook (org-load . org-pdftools-setup-link))

;; (use-package! org-noter-pdftools
;;   :after org-noter
;;   :config
;;   (with-eval-after-load 'pdf-annot
;;     (add-hook 'pdf-annot-activate-handler-functions #'org-noter-pdftools-jump-to-note)))

;; (add-hook! 'purescript-mode-hook
;;   (lambda ()
;;     (mapc (lambda (pair) (push pair prettify-symbols-alist))
;;           '(("forall" . ?∀)))))

;; (global-prettify-symbols-mode +1)


;;
;; Presentation
;;
;; (add-hook! 'org-present-mode-hook
;;   (lambda ()
;;     (org-present-big)
;;     (org-display-inline-images)
;;     (org-present-hide-cursor)
;;     (org-present-read-only)))

;; (add-hook! 'org-present-mode-quit-hook
;;   (lambda ()
;;     (org-present-small)
;;     (org-remove-inline-images)
;;     (org-present-show-cursor)
;;     (org-present-read-write)))
