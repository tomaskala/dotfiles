;; -*- lexical-binding: t; -*-


;; Precompute package activations. Needs Emacs >= 27.
(setq package-quickstart t)

;; Disable filename handlers temporarily, as they are not necessary
;; to parse the configuration.
(defvar old--file-name-handler-alist file-name-handler-alist)
(setq file-name-handler-alist nil)

;; Disable GC on startup.
(setq gc-cons-threshold most-positive-fixnum
      gc-cons-percentage 0.6)

;; Reset GC and the filename handlers after startup.
(add-hook 'emacs-startup-hook
  (lambda ()
    (setq gc-cons-threshold 16777216  ; 16MB
          gc-cons-percentage 0.1
          file-name-handler-alist old--file-name-handler-alist)))

;; Hide the GUI.
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(set-fringe-mode 10)
