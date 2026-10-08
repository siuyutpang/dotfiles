;;; init.el -*- lexical-binding: t; -*-

(add-to-list 'load-path
             (expand-file-name "lisp" user-emacs-directory))

(require 'init-state)
(require 'init-packages)
(require 'init-theme)
(require 'init-evil)
(require 'init-fonts)
(require 'init-editing)
(require 'init-dired)
(require 'init-url)
