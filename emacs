;; Mitigate Bug#28350 (security) in Emacs 25.2 and earlier.
(eval-after-load "enriched"
  '(defun enriched-decode-display-prop (start end &optional param)
     (list start end)))

(add-to-list 'load-path "~/.elisp/")

(menu-bar-mode -1)
(setq inhibit-startup-message t)
(setq split-width-threshold 120) ; force vertical window splitting earlier than defaults

(setq visible-bell t)

(add-hook 'before-save-hook 'delete-trailing-whitespace) ; del trailing whitespace

;; RET behaves like C-j in version 24.4 and higher, which is the worst.
;(electric-indent-mode -1) ;; actually I only want this for conf mode, so:
(add-hook 'conf-mode-hook '(lambda () (electric-indent-mode -1)))

;; distinguish files with the same name with <>
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)
(setq uniquify-after-kill-buffer-p t) ; if a buffer is killed, don't show the identifying directory

;; try to stick to 80 char
(setq column-number-mode t)
(require 'fill-column-indicator)
(add-hook 'after-change-major-mode-hook 'fci-mode)
(setq fill-column 80)
(setq default-fill-column 80)
(global-set-key "\C-xf" nil) ; no changing fill column too easily

;; tabs suck
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq indent-line-function 'insert-tab)

;; because sometimes I over M-q out of habit.
(defun unfill-paragraph (&optional region)
  (interactive (progn (barf-if-buffer-read-only) '(t)))
  (let ((fill-column (point-max)))
    (fill-paragraph nil region)))
(define-key global-map "\M-Q" 'unfill-paragraph)

;; c/c++ indentation
(setq-default c-basic-offset 4)
(setq c-default-style "linux" c-basic-offset 4)
