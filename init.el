(load "~/.config/emacs/crnvl96/opts.el")
(load "~/.config/emacs/crnvl96/pkg.el")
(load "~/.config/emacs/crnvl96/theme.el")
(load "~/.config/emacs/crnvl96/meow.el")
(load "~/.config/emacs/crnvl96/interface.el")
(load "~/.config/emacs/crnvl96/project.el")
(load "~/.config/emacs/crnvl96/lsp.el")

(use-package golden-ratio-scroll-screen
  :bind (("C-v" . golden-ratio-scroll-screen-up)
         ("M-v" . golden-ratio-scroll-screen-down)))

(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-avy-goto-char-timercategory-overrides '((file (styles basic partial-completion)))))

(use-package ace-window
  :bind ("M-o" . ace-window))

(use-package wgrep)

(use-package expand-region
  :bind ("C-=" . er/expand-region))
