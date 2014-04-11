(push "~/.emacs.d" load-path)

(require 'package)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))
(package-initialize)

(defvar my-packages '(auto-complete
                      cider
                      clojure-mode
                      clj-refactor
                      dash
                      flx-ido
                      magit
                      multiple-cursors
                      paredit
                      popup
                      projectile
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

;; Clojure workflow
 (defun nrepl-reset ()
   (interactive)
   (cider-interactive-eval "(user/reset)"))

(global-set-key (kbd "C-c C-o") 'nrepl-reset)

;; Projectile
(projectile-global-mode)

;; Multiple cursors
(require 'multiple-cursors)

(global-set-key (kbd "C-c f") 'mc/mark-next-like-this)
(global-set-key (kbd "C-c b") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c a") 'mc/mark-all-like-this)

;; Clojure refactor
(require 'clj-refactor)
(add-hook 'clojure-mode-hook (lambda ()
                               (clj-refactor-mode 1)
                               (cljr-add-keybindings-with-prefix "C-c C-m")))
