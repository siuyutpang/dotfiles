;;; init-theme.el -*- lexical-binding: t; -*-

;; 关掉主题自带的粗体：默认 t 时它会给关键字、函数名、变量名三个 face
;; 都加上 :weight bold，整屏花花的。必须在 load-theme 【之前】设 ——
;; 主题是在加载时把 bold 展开进 face 定义里的，之后再改就没用了。
(setq dracula-bolder-keywords nil)

;; 末尾的 t = 不再询问"是否永久启用"
(load-theme 'dracula t)

;; ---- 干掉 dracula 的斜体 ----
;; 和粗体不同，斜体没有总开关（那个变量只关 bold），主题里是一个 face 一个
;; face 写死的 :slant italic，只能逐个覆盖。下面这些是日常会碰到的：
;;   font-lock-builtin-face  类型名（int/String/List...）—— type-face 是
;;                           :inherit 它的，所以改这个就够了
;;   line-number             行号
;;   markdown-blockquote...  引用块，写 markdown 会碰到
;;   dired-symlink / org-quote / shr-h3 (eww)
;;
;; 必须放在 load-theme 【之后】：load-theme 会把主题里的 face 定义全部应用一遍，
;; 放在前面会被它盖掉。（而粗体那个变量相反，必须在前面 —— 因为它是加载时
;; 展开进 face 定义的，事后改已经晚了。）
;;
;; 用 custom-theme-set-faces 而不是 set-face-attribute，两个原因：
;;   1. set-face-attribute 碰到【还没定义】的 face 会直接报 "Invalid face"，
;;      markdown-blockquote-face / org-quote 这些要等对应模式加载后才存在，
;;      启动时它们还没影儿，一执行就崩。
;;   2. custom-theme-set-faces 会把 spec 记下来，等那个 face 日后被定义出来时
;;      自动套上（实测过）。所以这里写全就行，不用管谁先加载。
(custom-theme-set-faces 'user
  '(font-lock-builtin-face   ((t :slant normal)))
  '(line-number              ((t :slant normal)))
  '(markdown-blockquote-face ((t :slant normal)))
  '(dired-symlink            ((t :slant normal)))
  '(org-quote                ((t :slant normal)))
  '(shr-h3                   ((t :slant normal)))
  '(font-latex-italic-face   ((t :slant normal))))

(provide 'init-theme)
