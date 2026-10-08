;;; init-theme.el -*- lexical-binding: t; -*-

;; 该变量会在主题加载时展开到 face 定义中。
(setq dracula-bolder-keywords nil)
(load-theme 'dracula t)

;; 主题加载后再覆盖；custom-theme-set-faces 也能处理稍后才定义的 face。
(custom-theme-set-faces 'user
  '(font-lock-builtin-face   ((t :slant normal)))
  '(line-number              ((t :slant normal)))
  '(markdown-blockquote-face ((t :slant normal)))
  '(dired-symlink            ((t :slant normal)))
  '(org-quote                ((t :slant normal)))
  '(shr-h3                   ((t :slant normal)))
  '(font-latex-italic-face   ((t :slant normal))))

(provide 'init-theme)
