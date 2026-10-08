;;; init-evil.el -*- lexical-binding: t; -*-

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

(provide 'init-evil)
