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

;; Don't use messages that you don't read
(setq initial-scratch-message "")
(setq inhibit-startup-message t)
;; ;; Don't let Emacs hurt your ears
(setq visible-bell t)

;; rainbow delimiters
(global-rainbow-delimiters-mode)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

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
   (set-buffer "*nrepl*")
   (goto-char (point-max))
   (insert "(reset)")
   (nrepl-return))

(global-set-key (kbd "C-c C-o") 'nrepl-reset)
