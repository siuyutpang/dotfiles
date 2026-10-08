;;; init-state.el -*- lexical-binding: t; -*-

;; 将 recentf 和 TRAMP 的运行状态文件放到 XDG state 目录。
(let ((state-dir
       (expand-file-name
        "emacs/"
        (or (getenv "XDG_STATE_HOME")
            (expand-file-name "~/.local/state/")))))
  (setq recentf-save-file
        (expand-file-name "recentf.eld" state-dir)
        tramp-persistency-file-name
        (expand-file-name "tramp" state-dir)))

(provide 'init-state)
