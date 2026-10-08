;;; init-packages.el -*- lexical-binding: t; -*-

;; 官方 ELPA 本来就在 package-archives 里，这里只加 MELPA。
;; Emacs 27+ 会在读 init.el 之前自动激活已装好的包，所以下面能直接用它们。
(require 'package)
(require 'seq)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

;; 缺少包时只刷新一次列表，避免新机器上每安装一个包都刷新一次。
(let ((missing (seq-filter (lambda (pkg) (not (package-installed-p pkg)))
                           '(dracula-theme markdown-mode))))
  (when missing
    (package-refresh-contents)
    (dolist (pkg missing)
      (package-install pkg))))

(provide 'init-packages)
