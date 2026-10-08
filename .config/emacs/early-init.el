;;; early-init.el -*- lexical-binding: t; -*-

;; ---- 启动画面 ----
(setq inhibit-startup-screen t)     ; 不显示 GNU 欢迎页（splash screen）

;; ---- 界面元素 ----
(tool-bar-mode -1)                  ; 关工具栏（那一排图标按钮）
(scroll-bar-mode -1)                ; 关滚动条
(menu-bar-mode -1)                ; 菜单栏：学键位阶段建议先留着

;; ---- 光标 ----
;; 竖线光标在 Emacs 里叫 bar，不叫 line。可选值：box / hollow / bar / hbar / nil
;; 想要粗一点用 (bar . N) 指定像素宽度，比如 (bar . 2)
(setq-default cursor-type 'bar)     ; setq-default：cursor-type 是 buffer-local 的
(blink-cursor-mode -1)              ; 关闭光标闪烁

;; ---- 行号 ----
;; display-line-numbers-type: relative = 相对当前行；t = 绝对行号；visual = 按屏幕行算
(setq display-line-numbers-type 'relative)
;; 按文件总行数预留左侧宽度，避免滚动到 9→10 行时整块文字左右抖动
(setq display-line-numbers-width-start t)
(global-display-line-numbers-mode 1)

;; ---- 高亮当前行（已关闭）----
;; 光标所在的那一行整行铺一层浅色底，方便定位。
;; 用的是 hl-line 面，Dracula 主题里有定义，所以开了就能看见。
;;
;; 不想要了，已注释掉。想恢复就取消下面这行的注释：
;; (global-hl-line-mode 1)

;; ---- 响铃 ----
;; ring-bell-function 被 ding 调用；设为 ignore 后彻底静音：不响铃也不闪屏。
;; 若想保留提醒、只是别出声，改用它：(setq visible-bell t)
(setq ring-bell-function #'ignore)

;; ---- scratch 起始页 ----
;; 保留 *scratch* 顶部的默认说明文字；想清空就取消下面这行的注释
;; (setq initial-scratch-message nil)

;; 英文默认字体。default-frame-alist 是"新建窗口的默认参数"，
;; 在这里设，窗口画出来之前就生效，启动不会闪一下默认字体。
;;
;; 字号 16 = 原来 13pt 按一次 C-x C-+ 之后的大小：
;; C-x C-+ 是按 text-scale-mode-step（1.2）放大，13 × 1.2 = 15.6pt，
;; 而 15.6pt 和 16pt 在你这个 DPI 下渲染出来都是 22 像素，所以填 16 正好。
;; 中文字体没单独指定字号，会自动跟着这个一起缩放。
(add-to-list 'default-frame-alist '(font . "Iosevka-16"))

;; 中文字体不在这里设：early-init 阶段 GUI frame 还没建（display-graphic-p
;; 为 nil），set-fontset-font 会失效。见 init.el 里的 my-set-chinese-font。

;; ---- 主题 ----
;; 主题是包里的 dracula，只能在 init.el 里加载（early-init 阶段包系统还没
;; 初始化）。但那样窗口会先按浅色画出来再变深，启动闪一下。这里先把初始
;; frame 的底色设成 Dracula 的背景色，就没有那一下白闪。
;; 注意：以后换主题，这个颜色要跟着改。
(add-to-list 'default-frame-alist '(background-color . "#282a36"))

;; ---- 窗口透明 ----
;; alpha-background 只让"文字背景"透明，文字和边框仍是实的；
;; 比 alpha（整个 frame 连文字一起透，字会发虚）好看得多。
;; 数值为 0-100 的不透明度，越小越透：90 = 只透一点点，80 = 明显透，100 = 完全不透。
(add-to-list 'default-frame-alist '(alpha-background . 90))
