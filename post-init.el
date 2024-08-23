;;; post-init.el --- Post init -*- no-byte-compile: t; lexical-binding t; -*-

(define-key key-translation-map (kbd "ESC") (kbd "C-g"))
(define-key key-translation-map (kbd "C-<escape>") (kbd "ESC"))
(define-key key-translation-map (kbd "C-k") (kbd "C-S-<backspace>"))
(global-set-key (kbd "C-c /") #'comment-or-uncomment-region)

(load "~/.config/emacs/crnvl96/zenburn.el")
(load "~/.config/emacs/crnvl96/evil.el")
(load "~/.config/emacs/crnvl96/completion.el")
(load "~/.config/emacs/crnvl96/project.el")
(load "~/.config/emacs/crnvl96/git.el")
(load "~/.config/emacs/crnvl96/treesitter.el")
(load "~/.config/emacs/crnvl96/lang.el")
(load "~/.config/emacs/crnvl96/lint.el")
(load "~/.config/emacs/crnvl96/lsp.el")
(load "~/.config/emacs/crnvl96/minibuffer.el")
(load "~/.config/emacs/crnvl96/eat.el")

(load "~/.config/emacs/crnvl96/org.el")

(provide 'post-init)

;;; post-init.el ends here
