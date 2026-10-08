;;; init-editing.el -*- lexical-binding: t; -*-

;; ---- 行号 ----
;; display-line-numbers-type: relative = 相对当前行；t = 绝对行号；visual = 按屏幕行算
(setq display-line-numbers-type 'relative)
;; 按文件总行数预留左侧宽度，避免滚动到 9→10 行时整块文字左右抖动
(setq display-line-numbers-width-start t)
(global-display-line-numbers-mode 1)

;; ---- Markdown 语法高亮 ----
;; 注意：bash 脚本的高亮是 Emacs **内置**的（sh-mode），本来就有；
;; 但 markdown 没有内置模式 —— .md 文件默认用 fundamental-mode 打开，
;; 一个 face 都不上，整篇纯白。所以要装 markdown-mode。
;;
;; 让 ```bash / ```python 这类围栏代码块按对应语言真正高亮。
;; 默认是 nil，代码块整段只当普通文本，不上色。
(setq markdown-fontify-code-blocks-natively t)

;; ---- 自动补括号 ----
;; 括号高亮（show-paren-mode）和自动缩进（electric-indent-mode）本来就默认开着
;; （Emacs 24.1 起），只有补括号是关的，要手动开。
;;
;; 这里用 electric-pair-local-mode 而不是 electric-pair-mode：后者是【全局】模式，
;; 挂在 prog-mode-hook 上，第一次打开 .c 文件就会顺手把 text 模式也一起开掉。
;; 想按模式开就只能用 buffer-local 的这个。
;;
;; 不图省事全局开的另一个理由：默认配对表 electric-pair-pairs 里带弯引号
;; ‘ ’ “ ”，写中文散文时会被自动补成一对，很烦。prog-mode 把 text/markdown
;; 挡在外面，正好躲开。
(add-hook 'prog-mode-hook #'electric-pair-local-mode)

;; ---- 关掉备份和自动保存 ----
;; 两套是独立的机制，变量也不共用，得分别关。
;;
;; 备份：每次存盘把上一版写成 foo~，一直堆在项目目录里，永不自动清理。
(setq make-backup-files nil)
;;
;; 自动保存：未存盘时把 buffer 写成 #foo#。正常存盘后会自己删掉，
;; 但崩溃/断电时会残留，而且默认跟文件放在同一个目录。
(setq auto-save-default nil)
;;
;; 副作用：以后没有 foo~ 可退回上一版，崩溃了也没法 M-x recover-file。
;; 你如果开始用 git，这些本来也轮不到 Emacs 来管。

(provide 'init-editing)
