;;; translation-cn-zh.lisp --- Translation for IIIIka web common message

;; File:        translation-cn-zh.lisp
;; Description: Translation for IIIIka web common message
;; Author:      凉凉
;; Maintainer:  凉凉
;; Copyright (c) 2025, 凉凉, all rights reserved
;; Created: 2025-02-14 14:18
;; Version: 0.0.0
;; Last-Updated: 2025-02-16 11:59
;;           By: 凉凉
;; URL:
;; Keywords:
;; Compatibility:
;;
;;

;;; License
;;
;; this package is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published
;; by the Free Software Foundation, either version 3 of the License,
;; or (at your option) any later version.
;;
;; this package is distributed in the hope that it will be useful, but
;; WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
;; General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this package. If not, see <https://www.gnu.org/licenses/>.

(in-package :iiiika/web)

(deftranslation :cn-zh
  (:language     "中文")
  (:sorry        "抱歉")
  (:*-is-working "仍在开发中")
  (:help         "帮助")
  (:byname       "称号")
  (:name         "名字")
  (:hint         "提示")
  (:input        "输入")
  (:badge        "徽章")
  (:adj          "修饰")
  (:noun         "主体")
  (:banner       "背景")
  (:confirm      "确认")
  (:cancel       "取消")
  (:click        "点击")
  (:to           "以")
  (:choose       "选择")
  (:alert-title  "消息")
  (:about        "关于")
  (:usage        "输入中文, 生成伪中文 (不在规则中的将会映射为 `口')")
  (:about-msg    "IIIIka 是一个用来在 Splatoon 游戏中辅助生成类似汉字输入的小工具. ")
  (:how-it-works "IIIIka 的核心逻辑是逐字匹配, 将汉字拆分成类似左右结构, 并对不同的结构进行规则映射. ")
  (:why-fails    "因为当前的规则有限... 请参与本项目帮助编写更多的规则. "))

;;; translation-cn-zh.lisp ends here
