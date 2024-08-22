;;; post-init.el --- Post init -*- no-byle-compile: t; lexical-binding t; -*-

(define-key key-translation-map (kbd "ESC") (kbd "C-g"))
(define-key key-translation-map (kbd "C-<escape>") (kbd "ESC"))
(define-key key-translation-map (kbd "C-k") (kbd "C-S-<backspace>"))
(global-set-key (kbd "C-c /") #'comment-or-uncomment-region)

(load "~/.config/emacs/crnvl96/zenburn.el")
(load "~/.config/emacs/crnvl96/evil.el")

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
  :bind ("C-c p" . projectile-command-map)
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

(use-package diff-hl
  :hook((magit-pre-refresh . diff-hl-magit-pre-refresh)
        (magit-post-refresh . diff-hl-magit-post-refresh))
  :custom
  (diff-hl-show-staged-changes nil)
  :init
  (global-diff-hl-mode))

(use-package consult
  :bind (("C-c f f" . consult-fd)
         ("C-c f b" . consult-buffer)
         ("C-c f g" . consult-ripgrep)
         ("C-c f l" . consult-line)))

(use-package embark
  :bind (("C-." . embark-act)))

(use-package embark-consult
  :after embark
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))

(use-package wgrep)

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

(use-package markdown-mode
  :after tree-sitter
  :mode "\\.md\\'"
  :config
  (setq markdown-command "pandoc")
  (setq markdown-asymmetric-header t)
  (setq markdown-header-scaling t)
  (setq markdown-enable-math t))

(use-package markdown-preview-mode
  :commands markdown-preview)

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
  (flycheck-check-syntax-automatically '(save))
  (flycheck-disabled-checkers '(emacs-lisp-checkdoc emacs-lisp)))

(use-package lsp-mode
  :hook ((typescriptreact-mode . lsp)
         (lsp-mode . lsp-enable-which-key-integration))
  :commands lsp
  :init
  (setq lsp-keymap-prefix "C-c l")
  :custom
  (lsp-enable-symbol-highlighting nil)
  (lsp-ui-doc-show-with-cursor nil)
  (lsp-ui-doc-show-with-mouse nil)
  (lsp-lens-enable nil)
  (lsp-headerline-breadcrumb-enable nil)
  (lsp-idle-delay 0))

(load "~/.config/emacs/crnvl96/eat.el")

(provide 'post-init)

;;; post-init.el ends here
