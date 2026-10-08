;;; early-init.el -*- lexical-binding: t; -*-

;; 将包和原生编译缓存放到 XDG 目录。
(setq package-user-dir
      (expand-file-name
       "emacs/elpa/"
       (or (getenv "XDG_DATA_HOME")
           (expand-file-name "~/.local/share/"))))
(startup-redirect-eln-cache
 (expand-file-name
  "emacs/eln-cache/"
  (or (getenv "XDG_CACHE_HOME")
      (expand-file-name "~/.cache/"))))

(setq inhibit-startup-screen t
      ring-bell-function #'ignore)

(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)
(setq-default cursor-type 'bar)
(blink-cursor-mode -1)

;; 可选：高亮当前行，或清空 *scratch* 初始提示。
;; (global-hl-line-mode 1)
;; (setq initial-scratch-message nil)

;; 在首个 GUI frame 显示前设置默认外观。
(add-to-list 'default-frame-alist '(font . "Iosevka-16"))
(add-to-list 'default-frame-alist '(background-color . "#282a36"))
(add-to-list 'default-frame-alist '(alpha-background . 90))

;; 中文字体需等 GUI frame 创建后再设置，见 init-fonts.el。
