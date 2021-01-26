;;; -*- lexical-binding: t -*-


(setf inhibit-startup-message t                 ; Disable startup message.
      initial-scratch-message nil               ; Disable scratch message.
      large-file-warning-threshold 536870911    ; Increase large file threshold.
      gc-cons-threshold (* 1024 1024 32)        ; Increase GC threshold.
      backup-inhibited t                        ; Do not create backup files.
      auto-save-default nil                     ; Disable autosave.
      create-lockfiles nil                      ; Disable lockfiles.
      echo-keystrokes 0.1                       ; Echo keystrokes faster.
      visual-bell nil)                          ; Disable visual bell.

;; Hide the GUI.
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(set-fringe-mode 10)

;; Stop cursor blinking.
(blink-cursor-mode -1)

;; Disable horizontal scrollbar.
(when (fboundp 'set-horizontal-scroll-bar-mode)
  (set-horizontal-scroll-bar-mode nil))

;; Do not use tabs for indentation.
(setq-default indent-tabs-mode nil)

;; Shorter yes/no.
(defalias 'yes-or-no-p 'y-or-n-p)

;; Force UTF-8.
(prefer-coding-system 'utf-8-unix)

;; Disable built-in version control tools.
(setf vc-display-status nil
      vc-handled-backends nil
      vc-follow-symlinks t)



;; TODO: evil-mode window splitting
;(setq evil-vsplit-window-right t
      ;evil-split-window-below t)
