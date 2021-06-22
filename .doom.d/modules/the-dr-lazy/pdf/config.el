;;; the-dr-lazy/pdf/config.el -*- lexical-binding: t; -*-

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Major Mode

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
