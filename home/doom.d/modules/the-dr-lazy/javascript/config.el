;;; the-dr-lazy/javascript/config.el -*- lexical-binding: t; -*-

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Major Mode

(dolist (feature '(rjsx-mode
	           typescript-mode
	           web-mode
                   (nodejs-repl-mode . nodejs-repl)))
  (let ((pkg  (or (cdr-safe feature) feature))
	(mode (or (car-safe feature) feature)))
    (with-eval-after-load pkg
      (set-ligatures! mode
        ;; Functional
	:defalt "delta"
	:lambda "() =>"
	:function "function"
	;; Logical
	:not "!"
	:and "&&"
	:or "||"
	:import "import"
	:export "export"
	;; Types
	:int "number"
	:bool "boolean"
	:true "true"
	:false "false"
	:bottom "throw"
	;; Brand
	:monarch "Monarch"))))

(add-hook! 'js2-mode-hook
  (unless (locate-dominating-file default-directory ".prettierrc")
    (format-all-mode -1)))
