;;; init-fonts.el -*- lexical-binding: t; -*-

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

(provide 'init-fonts)
