;;; init-editing.el -*- lexical-binding: t; -*-

;; 相对行号，并预留稳定的行号宽度。
(setq display-line-numbers-type 'relative
      display-line-numbers-width-start t)
(global-display-line-numbers-mode 1)

;; 高亮 Markdown 围栏代码块。
(setq markdown-fontify-code-blocks-natively t)

;; 只在编程模式自动补括号，避免影响普通文本输入。
(add-hook 'prog-mode-hook #'electric-pair-local-mode)

;; 关闭备份文件和自动保存文件；代价是无法用它们恢复旧版本或崩溃内容。
(setq make-backup-files nil
      auto-save-default nil)

(provide 'init-editing)
