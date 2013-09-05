(push "~/.emacs.d" load-path)

(require 'package)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))
(package-initialize)

(defvar my-packages '(ac-nrepl
                      auto-complete
                      clojure-mode
                      clojure-test-mode
                      elisp-slime-nav
                      elixir-mix
                      elixir-mode
                      less-css-mode
                      magit
                      mustache-mode
                      nrepl
                      paredit
                      popup
                      rainbow-delimiters
                      starter-kit
                      starter-kit-lisp))

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

(load-theme 'wombat)

(remove-hook 'prog-mode-hook 'esk-turn-on-hl-line-mode)
(remove-hook 'coding-hook 'turn-on-hl-line-mode)

;; rainbow delimiters
(global-rainbow-delimiters-mode)

;; Setting up clojure
(add-hook 'clojure-mode-hook 'paredit-mode)

(require 'clojure-mode)
(define-clojure-indent
    (provided 1)
    (context 1)
    (facts 1)
    (lie 1)
    (future-fact 1)
    (fact 1))

;; Setting up nrepl
(add-hook 'nrepl-interaction-mode-hook 'nrepl-turn-on-eldoc-mode)
(add-hook 'nrepl-mode-hook 'rainbow-delimiters-mode)
(add-hook 'nrepl-mode-hook 'paredit-mode)
(add-hook 'nrepl-mode-hook 'subword-mode)
(add-hook 'clojure-mode-hook 'turn-on-eldoc-mode)
(setq nrepl-hide-special-buffers t)
(setq nrepl-popup-stacktraces nil)
(add-to-list 'same-window-buffer-names "*nrepl*")

(require 'auto-complete-config)
(ac-config-default)
(define-key ac-completing-map "\M-/" 'ac-stop) ; use M-/ to stop completion
(require 'ac-nrepl)
(add-hook 'nrepl-mode-hook 'ac-nrepl-setup)
(add-hook 'nrepl-interaction-mode-hook 'ac-nrepl-setup)
(eval-after-load "auto-complete" '(add-to-list 'ac-modes 'nrepl-mode))
(add-hook 'nrepl-mode-hook 'ac-nrepl-setup)

;; Maps arrows keys to window movement
;;(global-set-key [right] 'windmove-right)
;;(global-set-key [left] 'windmove-left)
;;(global-set-key [up] 'windmove-up)
;;(global-set-key [down] 'windmove-down)

;; Requires clojure snippets
(when (require 'yasnippet nil 'noerror)
  (progn
    (yas/load-directory "~/.emacs.d/snippets")))

;; Mustache Mode
(require 'mustache-mode)
