(setq read-process-output-max (* 4 1024 1024)
      gc-cons-threshold most-positive-fixnum)

(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-threshold (* 100 1024 1024))))

(setq custom-file (locate-user-emacs-file "custom.el"))
(load custom-file 'noerror 'nomessage)

(setq use-file-dialog nil
      use-dialog-box nil
      package-enable-at-startup t
      package-quickstart nil
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

(set-face-attribute 'default nil :font "BerkeleyMono Nerd Font 13")
(set-face-attribute 'variable-pitch nil :font "BerkeleyMono Nerd Font 13")
(set-face-attribute 'fixed-pitch nil :font "BerkeleyMono Nerd Font 13")

(define-key key-translation-map (kbd "ESC") (kbd "C-g"))
(define-key key-translation-map (kbd "C-<escape>") (kbd "ESC"))

(require 'package)

(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/"))
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))

(customize-set-variable 'package-archive-priorities
                        '(("gnu"    . 99)
                          ("stable" . 70)
                          ("melpa"  . 0)))

(when package-enable-at-startup
  (package-initialize)
  (unless package-archive-contents
    (package-refresh-contents t)))

(unless (package-installed-p 'use-package)
  (package-refresh-contents t)
  (package-install 'use-package)
  (eval-when-compile
    (require 'use-package)))

(use-package zenburn-theme
  :init
  (load-theme 'zenburn t))

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

(use-package crux
  :bind (([remap move-beginning-of-line] . crux-move-beginning-of-line)
         ("C-c o" . crux-open-with)
         ([S-return] . crux-smart-open-line)
         ("M-r" . crux-recentf-find-file)
         ("C-<backspace>" . crux-kill-line-backwards)
         ([remap kill-whole-line] . crux-kill-whole-line))
  :config
  (crux-with-region-or-line comment-or-uncomment-region))   

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

(use-package diff-hl
  :init
  (global-diff-hl-mode)
  :custom
  (diff-hl-show-staged-changes t))

(use-package consult
  :bind (("C-c f f" . consult-fd)
         ("C-c f b" . consult-buffer)
         ("C-c s g" . consult-ripgrep)
         ("C-s" . consult-line)))

(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-avy-goto-char-timercategory-overrides '((file (styles basic partial-completion)))))

(use-package ace-window
  :bind ("M-o" . ace-window))

(use-package avy
  :bind (("M-i" . avy-goto-char-2)
         ("M-l" . avy-goto-line)))

(use-package embark
  :bind (("C-." . embark-act)         ;; pick some comfortable binding
         ("C-;" . embark-dwim)        ;; good alternative: M-.
         ("C-h B" . embark-bindings)) ;; alternative for `describe-bindings'
  :init
  ;; Optionally replace the key help with a completing-read interface
  (setq prefix-help-command #'embark-prefix-help-command))

(use-package embark-consult
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))

(use-package wgrep)

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
