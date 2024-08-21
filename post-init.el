;;; post-init.el --- Post init -*- no-byle-compile: t; lexical-binding t; -*-

;;; Commentary:

;;; Code:

(defun kill-other-buffers ()
  "Kill all other buffers."
  (interactive)
  (mapc 'kill-buffer (delq (current-buffer) (buffer-list))))

(define-key key-translation-map (kbd "ESC") (kbd "C-g"))
(define-key key-translation-map (kbd "C-<escape>") (kbd "ESC"))
(define-key key-translation-map (kbd "C-k") (kbd "C-S-<backspace>"))

(unbind-key "C-d")
(bind-keys :prefix-map personal-ops-map
           :prefix "C-d"
           :prefix-docstring "Personal key bindings")

(global-set-key (kbd "C-d b o") #'kill-other-buffers)
(global-set-key (kbd "C-d /") #'comment-or-uncomment-region)


(use-package gruvbox-theme
  :init
  (load-theme 'gruvbox-dark-hard t))

(use-package devil
  :init
  (global-devil-mode))

(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))

(use-package vertico
  :bind (:map minibuffer-local-map
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
  :init
  (global-company-mode))

(use-package which-key
  :custom
  (which-key-side-window-location 'bottom)
  :init
  (which-key-mode))

(use-package projectile
  :bind ("C-d p p" . projectile-switch-project)
  :init
  (projectile-mode))

(use-package apheleia
  :init
  (apheleia-global-mode +1)
  :hook
  (go-mode . (lambda() (setq apheleia-inhibit t))))

(use-package magit
  :commands magit)

(use-package transient
  :after magit)

(use-package consult
  :bind (("C-d f f" . consult-fd)
         ("C-d f b" . consult-buffer)
         ("C-d s g" . consult-ripgrep)
         ("C-d f l" . consult-line)))

(use-package embark
  :bind (("C-." . embark-act)))

(use-package embark-consult
  :after embark
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))


(use-package wgrep)

(use-package golden-ratio-scroll-screen
  :bind (("C-v" . golden-ratio-scroll-screen-up)
         ("M-v" . golden-ratio-scroll-screen-down)))

(use-package ace-window
  :bind (("C-d w" . ace-window))
  :custom
  (aw-dispatch-always t))

(use-package avy
  :bind ("C-d j". avy-goto-char-2))

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

(use-package flycheck
  :init
  (global-flycheck-mode)
  :custom
  (flycheck-idle-change-delay 0)
  (setq-local flycheck-check-syntax-automatically '(save)))

(defun crnvl96-lsp-find-definition ()
  "Open lsp definitions in a splitted window."
  (interactive)
  (lsp-find-definition :display-action 'window))

(use-package lsp-mode
  :hook ((typescriptreact-mode . lsp)
         (lsp-mode . lsp-enable-which-key-integration))
  :bind (("C-d g d" . crnvl96-lsp-find-definition)
         ("C-d g r" . lsp-find-references)
         ("C-d g i" . lsp-find-implementation))
  :commands lsp
  :init
  (setq lsp-keymap-prefix "C-d l")
  :custom
  (lsp-idle-delay 0))

(use-package lsp-ui :commands lsp-ui-mode)

(provide 'post-init)

;;; post-init.el ends here
