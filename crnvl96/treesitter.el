;;; treesitter.el --- Treesitter -*- no-byte-compile: t; lexical-binding t; -*-

(use-package tree-sitter
  :init
  (global-tree-sitter-mode)
  :hook
  (tree-sitter-after-on . tree-sitter-hl-mode))

(use-package tree-sitter-langs
  :after tree-sitter)

;;; treesitter.el ends here
