;;; init-fonts.el -*- lexical-binding: t; -*-

;; 中文字体需等 GUI frame 创建后设置；daemon 新建 frame 时也要应用。
(defun my-set-chinese-font (&rest _)
  (set-fontset-font t 'han (font-spec :family "LXGW WenKai Mono")))

(if (display-graphic-p)
    (my-set-chinese-font)
  (add-hook 'after-make-frame-functions #'my-set-chinese-font))

(provide 'init-fonts)
