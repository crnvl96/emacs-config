;;; lang.el --- Lang -*- no-byle-compile: t; lexical-binding t; -*-

(use-package go-mode
  :after tree-sitter)

(use-package json-mode
  :after tree-sitter)

(use-package markdown-mode
  :after tree-sitter
  :mode "\\.md\\'"
  :config
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

(provide 'lang)

;;; lang.el ends here
