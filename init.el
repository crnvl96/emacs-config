(setq read-process-output-max (* 4 1024 1024))  ; 4mb
(setq gc-cons-threshold most-positive-fixnum)
(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-threshold (* 100 1024 1024))))

(setq custom-file (locate-user-emacs-file "custom.el"))
(load custom-file 'noerror 'nomessage)

(setq use-file-dialog nil)
(setq use-dialog-box nil)

(setq package-enable-at-startup t)
(setq package-quickstart nil)
(setq use-package-always-ensure t)

;; Emacs comes with several built-in packages, such as Org-mode, that are
;; essential for many users. However, these built-in packages are often not the
;; latest versions available. Ensure that your built-in packages are always up
;; to date with:
(setq package-install-upgrade-built-in t)

(if (boundp 'use-short-answers)
    (setq use-short-answers t)
  (advice-add #'yes-or-no-p :override #'y-or-n-p))
(defalias #'view-hello-file #'ignore)  ; Never show the hello file

(require 'package)

(when (version< emacs-version "28")
  (add-to-list 'package-archives
               '("nongnu" . "https://elpa.nongnu.org/nongnu/")))
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/"))
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))

(customize-set-variable 'package-archive-priorities
                        '(("gnu"    . 99)
                          ("nongnu" . 80)
                          ("stable" . 70)
                          ("melpa"  . 0)))

(when package-enable-at-startup
  (package-initialize)
  (unless package-archive-contents
    (package-refresh-contents t)))

;;; use-package
;; Load use-package for package configuration

;; Ensure the 'use-package' package is installed and loaded
(unless (package-installed-p 'use-package)
  (package-refresh-contents t)
  (package-install 'use-package)
  (eval-when-compile
    (require 'use-package)))

(eval-when-compile
  (require 'use-package))

(setq mouse-yank-at-point t)

(setq visible-bell nil)
(setq ring-bell-function #'ignore)

(setq-default word-wrap t)
(setq-default truncate-lines t)

(setq truncate-partial-width-windows nil)

(setq-default indent-tabs-mode nil
              tab-width 4)

(menu-bar-mode -1)            ; no menu bar
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

(setq-default tab-always-indent t)
(setq-default fill-column 80)
(setq sentence-end-double-space nil)
(setq require-final-newline t)
(setq kill-do-not-save-duplicates t)
(setq comment-empty-lines t)

(dolist (mode '(prog-mode-hook
                conf-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 1))))

(add-hook 'dired-mode-hook 'auto-revert-mode)

(set-face-attribute 'default nil :font "BerkeleyMono Nerd Font 13")
(set-face-attribute 'variable-pitch nil :font "BerkeleyMono Nerd Font 13")
(set-face-attribute 'fixed-pitch nil :font "BerkeleyMono Nerd Font 13")

(use-package doom-themes
  :init
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t)
  (load-theme 'doom-moonlight t)
  (doom-themes-org-config))

(use-package vertico
  :bind (:map vertico-map
              ("C-j" . vertico-next)
              ("C-k" . vertico-previous)
              ("C-f" . vertico-exit)
              :map minibuffer-local-map
              ("M-h" . backward-kill-word))
  :custom
  (vertico-cycle t)
  :init
  (vertico-mode))

(use-package marginalia
  :after vertico
  :custom
  (marginalia-annotators '(marginalia-annotators-heavy marginalia-annotators-light nil))
  :init
  (marginalia-mode))

(use-package company
  :bind (:map company-active-map
              ("<return>". nil)
              ("RET" . nil)
              ("C-<return>" . company-complete-selection)
              ("C-y" . company-complete-selection))
  :custom
  (company-minimum-prefix-length 4)
  :hook (after-init . global-company-mode))

(use-package apheleia
  :init
  (apheleia-global-mode +1)
  :hook
  (go-mode . (lambda() (setq apheleia-inhibit t))))

(use-package which-key
  :custom
  (which-key-side-window-location 'bottom)
  :init
  (which-key-mode))

(use-package magit
  :commands magit)

(use-package consult
  :bind (("C-c f f" . consult-fd)
         ("C-c f b" . consult-buffer)
         ("C-c s g" . consult-ripgrep)
         ("C-c s l" . consult-line)))

(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-avy-goto-char-timercategory-overrides '((file (styles basic partial-completion)))))

(use-package ace-window
  :custom
  (aw-dispatch-always t)
  :bind ("C-c w" . ace-window))

(use-package avy
  :bind (("C-c j" . avy-goto-char-2)
         ("C-c l" . avy-goto-line)))

(use-package expand-region
  :bind ("C-=" . er/expand-region))

(use-package tree-sitter
  :init
  (global-tree-sitter-mode)
  :hook
  (tree-sitter-after-on . tree-sitter-hl-mode))

(use-package tree-sitter-langs
  :after tree-sitter)

(use-package go-mode
  :after tree-sitter)

(use-package json-mode
  :after tree-sitter)

(use-package typescript-mode
  :after tree-sitter
  :init
  (define-derived-mode typescriptreact-mode typescript-mode
    "TypeScript TSX")
  (add-to-list 'auto-mode-alist '("\\.tsx?\\'" . typescriptreact-mode))
  (add-to-list 'tree-sitter-major-mode-language-alist '(typescriptreact-mode . tsx)))

(defun crnvl/eglot-typescript-setup ()
  "Configure flycheck for a better TypeScript (eslint) experience."
  (eglot-ensure))

(use-package eglot
  :hook
  (typescript-mode . crnvl/eglot-typescript-setup))
