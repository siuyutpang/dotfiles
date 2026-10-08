;;; init-url.el -*- lexical-binding: t; -*-

(require 'url-cache)

;; 将 Emacs URL 库的缓存放到 XDG cache 目录。
(setq url-cache-directory
      (expand-file-name
       "emacs/url/cache/"
       (or (getenv "XDG_CACHE_HOME")
           (expand-file-name "~/.cache/"))))

(provide 'init-url)
