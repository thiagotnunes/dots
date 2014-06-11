(require 'package)

(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))
(package-initialize)

(defvar my-packages '(ace-jump-mode
                      ag
                      anzu
                      cider
                      clj-refactor
                      clojure-mode
                      expand-region
                      flx-ido
                      ido
                      ido-ubiquitous
                      multiple-cursors
                      projectile
                      paredit
                      rainbow-delimiters
                      smex))

(dolist (p my-packages)
  (unless (package-installed-p p)
    (package-install p)))

; Theme
(load-theme 'wombat)

; Initial messages
(setq initial-scratch-message "")
(setq inhibit-startup-message t)

; Quit message
(fset 'yes-or-no-p 'y-or-n-p)

; Turn off tab char
(setq-default indent-tabs-mode nil)

; Set standard indent to 2 rather that 4
(setq standard-indent 2)
(define-key global-map (kbd "RET") 'newline-and-indent)

; Interface
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))

; Remove trailing whitespace before saving
(add-hook 'before-save-hook 'delete-trailing-whitespace)
; Show trailing whitespace
(setq-default show-trailing-whitespace t)

; Selection delete and update
(pending-delete-mode t)
(delete-selection-mode t)

; No backup files
(setq make-backup-files nil)

; Move lines up and down
(defun move-line-up ()
  (interactive)
  (transpose-lines 1)
  (forward-line -2))

(defun move-line-down ()
  (interactive)
  (forward-line 1)
  (transpose-lines 1)
  (forward-line -1))

(global-set-key (kbd "M-p") 'move-line-up)
(global-set-key (kbd "M-n") 'move-line-down)

; Show matching parenthesis
(show-paren-mode t)

; Remap undo / redo
(global-set-key (kbd "C-z") 'undo)
(global-set-key (kbd "C-Z") 'redo)

; No more arrow keys
;(global-set-key [left] 'windmove-left)
;(global-set-key [right] 'windmove-right)
;(global-set-key [up] 'windmove-up)
;(global-set-key [down] 'windmove-down)

; Configure ace-jump-mode
(require 'ace-jump-mode)
(global-set-key (kbd "C-c SPC") 'ace-jump-mode)

; Configure ag
(require 'ag)
(setq ag-highlight-search t)

; Configure anzu
(global-anzu-mode +1)

; Configure cider
(require 'cider)
(add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)
(setq nrepl-hide-special-buffers t)
(setq cider-popup-stacktraces nil)
(setq cider-repl-popup-stacktraces nil)
(setq cider-repl-wrap-history t)
(setq cider-auto-select-error-buffer nil)
(add-hook 'cider-repl-mode-hook 'subword-mode)
(add-hook 'cider-repl-mode-hook 'paredit-mode)
(add-hook 'cider-repl-mode-hook 'rainbow-delimiters-mode)

; Configure clj-refactor
(require 'clj-refactor)
(add-hook 'clojure-mode-hook (lambda ()
                               (clj-refactor-mode 1)
                               (cljr-add-keybindings-with-prefix "C-c C-m")
                               ))

; Configure yas snippets
(yas/global-mode 1)

; Configure expand-region
(require 'expand-region)
(global-set-key (kbd "C-c =") 'er/expand-region)

; Configure ido
(require 'ido)
(require 'flx-ido)
(ido-mode 1)
(ido-everywhere 1)
(flx-ido-mode 1)
;; disable ido faces to see flx highlights.
(setq ido-use-faces nil)

; Configure multiple cursors
(require 'multiple-cursors)
(global-set-key (kbd "C-c n") 'mc/mark-next-like-this)
(global-set-key (kbd "C-c s") 'mc/skip-to-next-like-this)
(global-set-key (kbd "C-c p") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c a") 'mc/mark-all-like-this)
(global-set-key (kbd "C-c w") 'mc/mark-all-words-like-this)
(global-set-key (kbd "C-c i") 'mc/edit-lines)

; Configure paredit
(autoload 'enable-paredit-mode "paredit" "Turn on pseudo-structural editing of Lisp code." t)
(add-hook 'emacs-lisp-mode-hook       #'enable-paredit-mode)
(add-hook 'eval-expression-minibuffer-setup-hook #'enable-paredit-mode)
(add-hook 'ielm-mode-hook             #'enable-paredit-mode)
(add-hook 'lisp-mode-hook             #'enable-paredit-mode)
(add-hook 'lisp-interaction-mode-hook #'enable-paredit-mode)
(add-hook 'scheme-mode-hook           #'enable-paredit-mode)
(add-hook 'clojure-mode-hook          #'enable-paredit-mode)

; Configure projectile
(projectile-global-mode)

; Configure rainbow delimiters
(require 'rainbow-delimiters)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

; Configure SMEX
(require 'smex)
(smex-initialize)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; This is your old M-x.
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)
