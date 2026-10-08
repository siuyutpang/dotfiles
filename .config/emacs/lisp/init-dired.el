;;; init-dired.el -*- lexical-binding: t; -*-

;; dwim = do what I mean。复制/重命名时，如果【另一个窗口】里也开着一个 dired，
;; 就拿它的目录当默认目标，回车即用，不用手打路径。
;; 单窗口下跟默认值 nil 完全一样，没有副作用。
;; 典型用法：开两个窗口各进一个目录，m 选中文件，C 或 R，回车。
(setq dired-dwim-target t)

(provide 'init-dired)
