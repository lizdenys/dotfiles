(add-to-list 'load-path "~/.elisp/")

(menu-bar-mode -1)
(setq inhibit-startup-message t)
(setq split-width-threshold 120) ; force vertical window splitting earlier than defaults

(setq visible-bell t)

(add-hook 'before-save-hook 'delete-trailing-whitespace) ; del trailing whitespace

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