(setq read-process-output-max (* 4 1024 1024)
      gc-cons-threshold most-positive-fixnum)

(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-threshold (* 100 1024 1024))))

(setq custom-file (locate-user-emacs-file "custom.el"))
(load custom-file 'noerror 'nomessage)

(setq use-file-dialog nil
      use-dialog-box nil
      package-quickstart nil
                                        ; package-enable-at-startup t
      package-enable-at-startup nil
      use-package-always-ensure t
      package-install-upgrade-built-in t
      mouse-yank-at-point t
      visible-bell nil
      ring-bell-function #'ignore
      truncate-partial-width-windows nil
      sentence-end-double-space nil
      require-final-newline t
      kill-do-not-save-duplicates t
      comment-empty-lines t)

(setq-default indent-tabs-mode nil
              tab-width 4
              indent-tabs-mode nil
              tab-width 4
              tab-always-indent t
              fill-column 80)

(if (boundp 'use-short-answers)
    (setq use-short-answers t)
  (advice-add #'yes-or-no-p :override #'y-or-n-p))
(defalias #'view-hello-file #'ignore)  ; Never show the hello file

(menu-bar-mode -1)            ; no menu bark
(tool-bar-mode -1)            ; no tools bar
(scroll-bar-mode -1)          ; no scroll bars
(tooltip-mode -1)             ; no tooltips
(set-fringe-mode 10)          ; frame edges set to 10px
(column-number-mode 1)        ; modeline shows column number
(save-place-mode 1)           ; remember cursor position
(recentf-mode 1)              ; remember recent files
(savehist-mode 1)             ; enable history saving
(electric-pair-mode 1)        ; enable keep pairs balanced
(global-auto-revert-mode t)   ; Load external changes
(global-hl-line-mode 1)       ; Current line highlight
(delete-selection-mode t)     ; Overwrite/delete selected text

(dolist (mode '(prog-mode-hook
                conf-mode-hook
                org-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 1))))

(add-hook 'dired-mode-hook 'auto-revert-mode)

(set-face-attribute 'default nil :font "BerkeleyMono Nerd Font 11")
(set-face-attribute 'variable-pitch nil :font "BerkeleyMono Nerd Font 11")
(set-face-attribute 'fixed-pitch nil :font "BerkeleyMono Nerd Font 11")

; (define-key key-translation-map (kbd "ESC") (kbd "C-g"))
; (define-key key-translation-map (kbd "C-<escape>") (kbd "ESC"))
; (define-key key-translation-map (kbd "C-k") (kbd "C-S-<backspace>"))
