;;; init.el -*- lexical-binding: t; -*-

;; ---- 包管理 ----
;; 官方 ELPA 本来就在 package-archives 里，这里只加 MELPA。
;; Emacs 27+ 会在读 init.el 之前自动激活已装好的包，所以下面能直接用它们。
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

;; ---- 主题 ----
;; 没装就先装上，这样换机器/清缓存后启动也不会报错。
(unless (package-installed-p 'dracula-theme)
  (package-refresh-contents)
  (package-install 'dracula-theme))
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

;; ---- Markdown 语法高亮 ----
;; 注意：bash 脚本的高亮是 Emacs **内置**的（sh-mode），本来就有；
;; 但 markdown 没有内置模式 —— .md 文件默认用 fundamental-mode 打开，
;; 一个 face 都不上，整篇纯白。所以要装 markdown-mode。
(unless (package-installed-p 'markdown-mode)
  (package-refresh-contents)
  (package-install 'markdown-mode))

;; 让 ```bash / ```python 这类围栏代码块按对应语言真正高亮。
;; 默认是 nil，代码块整段只当普通文本，不上色。
(setq markdown-fontify-code-blocks-natively t)

;; ---- Vim 键位（Evil） ----
;; 下面两行都必须在 (require 'evil) 之前设，加载之后再设就没用了。

;; evil-undo-system 默认是 nil，也就是 C-r 不能重做；
;; 指向 Emacs 28+ 内置的 undo-redo 后才有 vim 那样的撤销/重做
(setq evil-undo-system 'undo-redo)

;; 用了 evil-collection 就必须关掉这个，否则启动会报警告：
;; evil 默认会给所有模式再套一套自己的键位（evil-keybindings），
;; 和 evil-collection 的键位冲突。见 evil-collection issue #60。
;; 关掉后 evil-keybindings 根本不会加载，警告自然消失。
(setq evil-want-keybinding nil)

(require 'evil)

;; 光标：让当前处于哪个模式一眼可辨。
;; 注意 evil-normal-state-cursor 默认是 nil（= 不去改），会沿用全局的
;; cursor-type（early-init 里设的 bar），结果普通模式和插入模式长得一样，
;; 丢了 vim 最有用的那个状态提示。所以要显式指定。
;; 如果你想让所有模式都用竖线，把下面这个 setq 整段删掉即可。
;; 可视模式用 box 而不是 hollow：vim 里可视模式光标仍是实心方块，
;; 选中范围靠高亮体现；hollow（空心框）是 Emacs 的习惯，不是 vim 行为。
(setq evil-normal-state-cursor 'box        ; 普通模式：实心方块
      evil-insert-state-cursor '(bar . 2)  ; 插入模式：竖线
      evil-visual-state-cursor 'box)       ; 可视模式：同普通模式，实心方块

(evil-mode 1)

;; 把 dired / help 等内置模式的键位也改成 vim 风格。
;; 不想要的话删掉这两行，那些模式就用回原生 Emacs 键位。
(require 'evil-collection)
(evil-collection-init)

;; ---- 复制后闪一下 ----
;; 复制（yank）完把刚复制的范围闪一小下，确认自己复制到了什么。
;; evil 本身没有这个功能（vim 那边是靠 highlightedyank 插件），
;; 这里用 Emacs 自带的 pulse 实现。
;;
;; 挂载点：evil 的复制最终都走这三个底层函数 ——
;; 按字符复制、按行复制、矩形复制，所以挂这三个就全覆盖了。
(require 'pulse)

(defun my-flash-yank (orig beg end &optional register yank-handler)
  (prog1 (funcall orig beg end register yank-handler)
    ;; pulse 默认只闪 pulse-delay × pulse-iterations = 0.03 × 10 = 0.3 秒，
    ;; 而且是渐隐的，一闪就没了。这里临时调长到约 1.6 秒。
    ;; 用 let 而不是全局 setq：这样只影响"复制闪光"，
    ;; 不会连带把 xref 之类其它用到 pulse 的功能也拖慢。
    ;; 想再长/短：改下面两个数，总时长 ≈ pulse-delay × pulse-iterations。
    (let ((pulse-delay 0.08)
          (pulse-iterations 20))
      (pulse-momentary-highlight-region beg end))))

(dolist (fn '(evil-yank-characters evil-yank-lines evil-yank-rectangle))
  (advice-add fn :around #'my-flash-yank))

;; ---- 输入法自动切换（Evil 联动） ----
;; 你用的是 fcitx5，它自带的命令行工具约定是：
;;   无参数 → 打印状态：0 = 关闭，1 = 英文(inactive)，2 = 中文(active)
;;   -c     → 切到英文
;;   -o     → 激活"上一个用过的"输入法
;; 所以：离开 insert 时切英文，回到 insert 时 -o 就能恢复原来的输入法。
;; 实测 fcitx5-remote 单次约 4ms，用同步的 call-process 完全不会卡。

(defvar my-evil-ime-was-chinese nil
  "离开 insert 模式时，输入法是不是中文。
用来判断回到 insert 时该不该恢复——不记这个的话，本来在用英文写代码，
按 i 也会被 -o 莫名其妙切回中文。")

(defun my-evil-ime-to-english ()
  "离开 insert 模式：先记住当前是不是中文，再切到英文。
这样普通模式的按键立刻可用，不用手动切输入法。"
  (setq my-evil-ime-was-chinese
        (= 2 (string-to-number
              (string-trim (shell-command-to-string "fcitx5-remote")))))
  (call-process "fcitx5-remote" nil nil nil "-c"))

(defun my-evil-ime-restore ()
  "进入 insert 模式：上次离开时是中文的话，切回中文。"
  (when my-evil-ime-was-chinese
    (call-process "fcitx5-remote" nil nil nil "-o")))

(add-hook 'evil-insert-state-exit-hook #'my-evil-ime-to-english)
(add-hook 'evil-insert-state-entry-hook #'my-evil-ime-restore)

;; ---- 中文字体 ----
;; 必须放在这里而不是 early-init.el：early-init 阶段 GUI frame 还没建
;; （display-graphic-p 为 nil），set-fontset-font 会失效。
;; 用 font-spec 指定 family，比直接传字符串更明确。
;; 中文不单独指定字号，这样它跟随英文字体的高度，中英文大小一致。
;;
;; 注：如果以后想让中文单独比英文大/小，只能加 :size，不能加 :height ——
;; 实测在 set-fontset-font 的 font-spec 里 :height 会被静默忽略
;; （:height 100 和 :height 240 出来一样大）。另外那里的 :size 单位是
;; "像素"不是"磅"：:size 20 就是 20 像素高。
(defun my-set-chinese-font (&rest _)
  (set-fontset-font t 'han (font-spec :family "LXGW WenKai Mono")))

(if (display-graphic-p)
    ;; 直接启动 GUI：frame 已经在了，立刻设
    (my-set-chinese-font)
  ;; daemon 模式下 init.el 也是无 frame 时加载的，等 frame 建好再设
  (add-hook 'after-make-frame-functions #'my-set-chinese-font))

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

;; ---- Dired ----
;; dwim = do what I mean。复制/重命名时，如果【另一个窗口】里也开着一个 dired，
;; 就拿它的目录当默认目标，回车即用，不用手打路径。
;; 单窗口下跟默认值 nil 完全一样，没有副作用。
;; 典型用法：开两个窗口各进一个目录，m 选中文件，C 或 R，回车。
(setq dired-dwim-target t)
