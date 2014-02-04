(push "~/.emacs.d" load-path)

(require 'package)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))
(package-initialize)

(defvar my-packages '(auto-complete
                      clojure-mode
                      elixir-mix
                      elixir-mode
                      less-css-mode
                      magit
                      mustache-mode
                      paredit
                      popup
                      rainbow-delimiters
                      starter-kit))

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

(load-theme 'wombat)

(remove-hook 'prog-mode-hook 'esk-turn-on-hl-line-mode)
(remove-hook 'coding-hook 'turn-on-hl-line-mode)

;; Don't use messages that you don't read
(setq initial-scratch-message "")
(setq inhibit-startup-message t)
;; ;; Don't let Emacs hurt your ears
(setq visible-bell t)

;; rainbow delimiters
(global-rainbow-delimiters-mode)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

;; clojure mode
(require 'clojure-mode)
(add-hook 'clojure-mode-hook 'paredit-mode)
(define-clojure-indent
  (provided 1)
  (context 1)
  (facts 1)
  (lie 1)
  (future-fact 1)
  (fact 1))

;; Setting up cider
(add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)
(setq nrepl-hide-special-buffers t)
(setq cider-popup-stacktraces nil)
(add-hook 'cider-repl-mode-hook 'subword-mode)
(add-hook 'cider-repl-mode-hook 'paredit-mode)
(add-hook 'cider-repl-mode-hook 'rainbow-delimiters-mode)

;; Maps arrows keys to window movement
;;(global-set-key [right] 'windmove-right)
;;(global-set-key [left] 'windmove-left)
;;(global-set-key [up] 'windmove-up)
;;(global-set-key [down] 'windmove-down)

;; Mustache Mode
(require 'mustache-mode)

;; Move line up / down
(defun move-line-up ()
  "Move up the current line."
  (interactive)
  (transpose-lines 1)
  (forward-line -2)
  (indent-according-to-mode))

(defun move-line-down ()
  "Move down the current line."
  (interactive)
  (forward-line 1)
  (transpose-lines 1)
  (forward-line -1)
  (indent-according-to-mode))

(global-set-key [(meta shift up)]  'move-line-up)
(global-set-key [(meta shift down)]  'move-line-down)

;; Clojure workflow
 (defun nrepl-reset ()
   (interactive)
   (cider-interactive-eval "(user/reset)"))

(global-set-key (kbd "C-c C-o") 'nrepl-reset)
