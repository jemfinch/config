(add-to-list 'load-path (expand-file-name "~/.emacs.d"))

; Load usr/local site-start.el.
;(load-file "/usr/local/share/emacs/site-lisp/site-start.el")

(autoload 'sml-mode "sml-mode" "Major mode for editing SML" t)
;(autoload 'html-mode "html-mode" "Major mode for editing HTML" t)
(autoload 'python-mode "python-mode" "Major mode for editing Python" t)

(setq viper-mode t)
(require 'viper)
(global-font-lock-mode t)
;(setq auto-mode-alist (cons '("\\.tmpl$" . html-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.c?py$" . python-mode) auto-mode-alist))
;(setq auto-mode-alist (cons '("\\.[zc]?pt$" . html-mode) auto-mode-alist))
;(setq auto-mode-alist (cons '("httpd.conf$" . apache-mode) auto-mode-alist))

(setq cw/python-mode-viper-modifier-map (make-sparse-keymap))
(define-key cw/python-mode-viper-modifier-map
  (kbd "DEL") 'py-electric-backspace)
(define-key cw/python-mode-viper-modifier-map
  (kbd "<backspace>") 'py-electric-backspace)
(define-key cw/python-mode-viper-modifier-map
  (kbd "C-h") 'help)
(viper-modify-major-mode
  'python-mode 'insert-state cw/python-mode-viper-modifier-map)
(tool-bar-mode -1)

(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(cursor ((t (:background "#FFFF00")))))

(setq make-backup-files nil)

(defun mouse-drag-region-1 (start-event)
  (interactive "e")
  (let ((w (posn-window (event-start start-event))))
    (when (or (not (window-minibuffer-p w))
	      (minibuffer-window-active-p w))
      ;; Give temporary modes such as isearch a chance to turn off.
      (run-hooks 'mouse-leave-buffer-hook)
      (mouse-drag-region-1 start-event))))

; Remove the stupid exit keystrokes.
(when window-system (global-set-key (kbd "C-x C-c") '0))
(when window-system (global-set-key (kbd "M-c") '0))

(when (fboundp 'auto-insert-mode)
  (auto-insert-mode t)
  (setq auto-insert-query nil)
  (when (file-exists-p (expand-file-name "~/.templates/"))
    (setq auto-insert-directory "~/.templates/"))

  (when (file-exists-p
         (concat auto-insert-directory "py"))
    (add-to-list 'auto-insert-alist '(("\\.py$" . "python") . "py"))))

(add-hook 'perl-mode-hook
	  (lambda () (local-set-key (kbd "RET") 'newline-and-indent)))

(setq c-default-style "bsd")
(add-hook 'c-mode-hook
	  (lambda () (local-set-key (kbd "RET") 'newline-and-indent)))

(require 'compile)
(add-to-list 'compilation-error-regexp-alist
             '("^Error: \\([^\t\n]*\\) \\([0-9]+\\)\\.\\([0-9]+\\)\\.$"
               1 2 3))
(add-to-list 'auto-mode-alist '("\\.sig\\'" . sml-mode))
(add-to-list 'auto-mode-alist '("\\.sml\\'" . sml-mode))
(add-to-list 'auto-mode-alist '("\\.fun\\'" . sml-mode))

(setq-default indent-tabs-mode nil)

(setq-default c-basic-offset 2)

(load-file ".emacs.d/work.el")

; Color theme addon.
;(load-file (expand-file-name "~/.emacs.d/color-theme.el"))
(require 'color-theme)
;(color-theme-initialize)
(color-theme-dark-laptop)
(column-number-mode)

(add-hook 'c-mode-common-hook
          (lambda ()
            (auto-fill-mode 1)
            (set (make-local-variable 'fill-nobreak-predicate)
                 (lambda ()
                   (not (eq (get-text-property (point) 'face)
                            'font-lock-comment-face))))))

(add-hook 'python-mode-common-hook
          (lambda ()
            (auto-fill-mode 1)
            (set (make-local-variable 'fill-nobreak-predicate)
                 (lambda ()
                   (not (eq (get-text-property (point) 'face)
                            'font-lock-comment-face))))))

(menu-bar-mode)
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(debug-on-error t))
