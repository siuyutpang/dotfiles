;;; init-evil.el -*- lexical-binding: t; -*-

;; 这两个选项必须在加载 Evil 前设置。
(setq evil-undo-system 'undo-redo
      evil-want-keybinding nil)
(require 'evil)

(setq evil-normal-state-cursor 'box
      evil-insert-state-cursor '(bar . 2)
      evil-visual-state-cursor 'box)
(evil-mode 1)

(require 'evil-collection)
(evil-collection-init)

;; Evil 复制后短暂高亮复制区域。
(require 'pulse)
(defun my-flash-yank (orig beg end &optional register yank-handler)
  (prog1 (funcall orig beg end register yank-handler)
    (let ((pulse-delay 0.08)
          (pulse-iterations 20))
      (pulse-momentary-highlight-region beg end))))

(dolist (fn '(evil-yank-characters evil-yank-lines evil-yank-rectangle))
  (advice-add fn :around #'my-flash-yank))

;; fcitx5：离开插入模式时切英文，返回时恢复此前的中文输入状态。
(defvar my-evil-ime-was-chinese nil
  "离开 Evil 插入模式前，fcitx5 是否处于中文状态。")

(defun my-evil-ime-to-english ()
  "记住当前输入法状态，然后切换到英文。"
  (setq my-evil-ime-was-chinese
        (= 2 (string-to-number
              (string-trim (shell-command-to-string "fcitx5-remote")))))
  (call-process "fcitx5-remote" nil nil nil "-c"))

(defun my-evil-ime-restore ()
  "如果离开插入模式前是中文，则恢复中文输入。"
  (when my-evil-ime-was-chinese
    (call-process "fcitx5-remote" nil nil nil "-o")))

(add-hook 'evil-insert-state-exit-hook #'my-evil-ime-to-english)
(add-hook 'evil-insert-state-entry-hook #'my-evil-ime-restore)

(provide 'init-evil)
