;; -*- lexical-binding: t; -*-


(setq inhibit-startup-message t                 ; Disable startup message.
      initial-scratch-message nil               ; Disable scratch message.
      initial-major-mode 'fundamental-mode      ; Do not start in text mode.
      large-file-warning-threshold 536870911    ; Increase large file threshold.
      backup-inhibited t                        ; Do not create backup files.
      auto-save-default nil                     ; Disable autosave.
      create-lockfiles nil                      ; Disable lockfiles.
      echo-keystrokes 0.1                       ; Echo keystrokes faster.
      visual-bell nil)                          ; Disable visual bell.

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

;; Evil mode.
(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump nil)
  :config
  (evil-mode 1)
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
  (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join)

  ; Use visual line motions even outside of visual-line-mode buffers.
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)

  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal))

;; TODO: evil-mode window splitting
;(setq evil-vsplit-window-right t
      ;evil-split-window-below t)

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
  :bind (("C-M-j" . 'counsel-switch-buffer)
         :map minibuffer-local-map
         ("C-r" . 'counsel-minibuffer-history))
  :custom
  (counsel-linux-app-format-function #'counsel-linux-app-format-function-name-only)
  :config
  (counsel-mode 1))

(defun efs/display-startup-time ()
  (message "Emacs loaded in %s with %d garbage collections."
           (format "%.2f seconds"
                   (float-time
                     (time-subtract after-init-time before-init-time)))
           gcs-done))
(add-hook 'emacs-startup-hook #'efs/display-startup-time)
