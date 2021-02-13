;; -*- lexical-binding: t; -*-


(setq inhibit-startup-message t               ; Disable startup message.
      initial-scratch-message nil             ; Disable scratch message.
      initial-major-mode 'fundamental-mode    ; Do not start in text mode.
      large-file-warning-threshold 536870911  ; Increase large file threshold.
      backup-inhibited t                      ; Do not create backup files.
      auto-save-default nil                   ; Disable autosave.
      create-lockfiles nil                    ; Disable lockfiles.
      echo-keystrokes 0.1                     ; Echo keystrokes faster.
      visual-bell nil)                        ; Disable visual bell.

;; Maximize the window.
(toggle-frame-maximized)

;; Display line numbers.
(column-number-mode)
(global-display-line-numbers-mode t)

;; Font settings.
(add-to-list 'default-frame-alist '(font . "Fira Code-12"))
(set-face-attribute 'default nil :family '(font . "Fira Code-12"))
(set-face-attribute 'fixed-pitch nil :family '(font . "Fira Code-12"))

;; Stop cursor blinking.
(blink-cursor-mode -1)

;; Configure scrolling behavior.
(setq redisplay-dont-pause t
      scroll-margin 3
      scroll-step 1
      scroll-conservatively 10000
      scroll-preserve-screen-position 1)

(setq mouse-wheel-follow-mouse t
      mouse-wheel-scroll-amount '(1 ((shift) . 1)))

;; Do not use tabs for indentation.
(setq-default indent-tabs-mode nil)

;; Show matching parenthesis.
(show-paren-mode 1)

;; Shorter yes/no.
(defalias 'yes-or-no-p 'y-or-n-p)

;; Force UTF-8.
(prefer-coding-system 'utf-8-unix)

;; Disable built-in version control tools.
(setq vc-display-status nil
      vc-handled-backends nil
      vc-follow-symlinks t)

;; Initialize package sources.
(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

(unless (package-installed-p 'use-package)
  (package-refresh-contents)  ; Update packages archive.
  (package-install 'use-package))  ; Install the latest version of use-package.

(eval-when-compile (require 'use-package))
(setq use-package-always-ensure t)

;; These keys are used by evil mode.
(global-unset-key (kbd "C-h"))
(global-unset-key (kbd "C-j"))
(global-unset-key (kbd "C-k"))
(global-unset-key (kbd "C-l"))

;; Replace the undo-redo monstrosity Emacs comes with.
(use-package undo-tree)

;; Evil mode.
(use-package evil
  :init
  (setq evil-want-integration t
        evil-want-keybinding nil
        evil-want-C-d-scroll t
        evil-want-C-u-scroll t
        evil-want-C-i-jump nil
        evil-want-Y-to-eol t
        evil-split-window-below t
        evil-vsplit-window-right t
        evil-search-module 'evil-search)
  (global-undo-tree-mode)
  (setq evil-undo-system 'undo-tree)
  :config
  (evil-mode 1)

  ; Use visual line motions even outside of visual-line-mode buffers.
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)

  ; Make the escape key quit all prompts.
  (define-key evil-normal-state-map [escape] 'keyboard-quit)
  (define-key evil-visual-state-map [escape] 'keyboard-quit)
  (define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
  (define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
  (define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
  (define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
  (define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)

  ; Switch panes using C-hjkl.
  (define-key evil-normal-state-map (kbd "C-h") 'evil-window-left)
  (define-key evil-normal-state-map (kbd "C-j") 'evil-window-down)
  (define-key evil-normal-state-map (kbd "C-k") 'evil-window-up)
  (define-key evil-normal-state-map (kbd "C-l") 'evil-window-right)

  ; Press enter to insert a newline character.
  (define-key evil-motion-state-map (kbd "RET") nil)

  ; Make redo behave in a sane way.
  (define-key evil-normal-state-map (kbd "C-r") 'undo-tree-redo)

  ; Clear search highlighting.
  (define-key evil-normal-state-map (kbd ", SPC") 'evil-ex-nohighlight)

  ; Start in the normal mode except in REPLs.
  (setq evil-normal-state-modes
        (append evil-emacs-state-modes
                evil-normal-state-modes
                evil-motion-state-modes))
  (setq evil-emacs-state-modes nil)
  (setq evil-motion-state-modes nil))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

;; Theme configuration.
(use-package doom-themes
  :init (load-theme 'doom-one t))

;; Enhanced modeline.
;; Run `M-x all-the-icons-install-fonts` after
;; loading the config for the first time.
(use-package all-the-icons)

(use-package doom-modeline
  :after all-the-icons
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 15)))

;; Display all possible completions for the entered prefix.
(use-package which-key
  :defer 0
  :diminish which-key-mode
  :config
  (which-key-mode)
  (setq which-key-idle-delay 0.5))

;; Load the Ivy completion framework.
(use-package ivy
  :diminish
  :bind (("C-s" . swiper)
         :map ivy-minibuffer-map
         ("TAB" . ivy-alt-done)
         ("C-l" . ivy-alt-done)
         ("C-j" . ivy-next-line)
         ("C-k" . ivy-previous-line)
         :map ivy-switch-buffer-map
         ("C-k" . ivy-previous-line)
         ("C-l" . ivy-done)
         ("C-d" . ivy-switch-buffer-kill)
         :map ivy-reverse-i-search-map
         ("C-k" . ivy-previous-line)
         ("C-d" . ivy-reverse-i-search-kill))
  :config
  (ivy-mode 1))

(use-package ivy-rich
  :after ivy
  :init
  (ivy-rich-mode 1))

;; Counsel enhances some Emacs commands with Ivy versions.
(use-package counsel
  :bind ("C-M-j" . 'counsel-switch-buffer)
  :custom
  (counsel-linux-app-format-function #'counsel-linux-app-format-function-name-only)
  :config
  (counsel-mode 1))

;; Display Emacs startup time.
(defun my/display-startup-time ()
  (message "Emacs loaded in %s with %d garbage collections."
           (format "%.2f seconds"
                   (float-time
                     (time-subtract after-init-time before-init-time)))
           gcs-done))

(add-hook 'emacs-startup-hook #'my/display-startup-time)

;; Haskell mode.
(use-package haskell-mode
  :hook haskell-mode-hook)

;; Org mode.
(defun my/org-mode-setup ()
  (org-indent-mode)
  (auto-fill-mode 1)
  (set-fill-column 81)
  (setq evil-auto-indent nil)
  (dolist (face '((org-level-1 . 1.2)
                  (org-level-2 . 1.1)
                  (org-level-3 . 1.05)
                  (org-level-4 . 1.0)
                  (org-level-5 . 1.0)
                  (org-level-6 . 1.0)
                  (org-level-7 . 1.0)
                  (org-level-8 . 1.0)))
    (set-face-attribute (car face) nil :height (cdr face))))

(use-package org
  :hook (org-mode . my/org-mode-setup)
  :config
  (setq org-ellipsis " ▾")
  (setq org-agenda-start-with-log-mode t)
  (setq org-log-done 'time)
  (setq org-log-into-drawer t)
  (setq org-agenda-files
        '("~/notes/todos/tasks.org"
          "~/notes/todos/periodic.org"))
  (setq org-tag-alist
        '(("errand" . ?E) ("home" . ?H) ("work" . ?W) ("idea" . ?I)))
  (setq org-todo-keywords
        '((sequence "TODO" "|" "DONE" "CANCELLED")))
  (setq org-refile-targets
        '((nil :maxlevel . 2 )))
  (setq org-refile-use-outline-path 'file)
  (setq org-outline-path-complete-in-steps nil)
  (advice-add 'org-refile :after 'org-save-all-org-buffers))

(use-package org-bullets
  :hook (org-mode . org-bullets-mode)
  :custom
  (org-bullets-bullet-list '("●" "◉" "○" "●" "○" "●" "○")))

(defun my/org-mode-visual ()
  (setq visual-fill-column-width 100
        visual-fill-column-center-text t)
  (visual-fill-column-mode 1))

(use-package visual-fill-column
  :hook (org-mode . my/org-mode-visual))
