;;; the-dr-lazy/tools/config.el -*- lexical-binding: t; -*-

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Projectile

;; (setq projectile-project-search-path '("~/Projects/github"
;;                                        "~/Projects/gitlab"
;;                                        "~/Projects/experiments"
;;                                        "~/.doom.d"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; GPG

(setq epg-pinentry-mode 'loopback)
(pinentry-start)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Magit


(setq use-magit-commit-prompt-p nil)

(defun use-magit-commit-prompt (&rest args)
  (setq use-magit-commit-prompt-p t))
(defun magit-commit-prompt ()
  "Magit prompt and insert commit header with faces."
  (interactive)
  (when use-magit-commit-prompt-p
    (setq use-magit-commit-prompt-p nil)
    (insert (ivy-read "Commit Type " pretty-magit-prompt
                      :require-match t :sort t :preselect "Add: "))
    ;; Or if you are using Helm...
    ;; (insert (helm :sources (helm-build-sync-source "Commit Type "
    ;;                          :candidates pretty-magit-prompt)
    ;;               :buffer "*magit cmt prompt*"))
    ;; I haven't tested this but should be simple to get the same behaior
    (add-magit-faces)
    (evil-insert 1)  ; If you use evil
    ))

(remove-hook! 'git-commit-setup-hook 'with-editor-usage-message)
(add-hook! 'git-commit-setup-hook 'magit-commit-prompt)
(advice-add 'magit-commit :after 'use-magit-commit-prompt)
