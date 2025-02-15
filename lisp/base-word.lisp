;;; base-word.lisp --- Basic word splitting rules for IIIIka

;; File:        base-word.lisp
;; Description: Basic word splitting rules for IIIIka
;; Author:      凉凉
;; Maintainer:  凉凉
;; Copyright (c) 2025, 凉凉, all rights reserved
;; Created: 2025-02-13 15:13
;; Version: 0.0.0
;; Last-Updated: 2025-02-13 15:22
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

(in-package :iiiika)

;;; How to contribute?                如何参与编写规则?
;; here's a template example:         以下是一个简单的示例的模板:
;;
;;    (defword*
;;      ;; author name and notes      ;; 建议写上作者和声明注释
;;      ;; please refer to base-part  ;; 请参考 base-part 中的成分定义
;;      ("咩咩" "口羊口羊")
;;      ...)

(defword*
  ;; Note:
  ;; these word splitting rules are what I found while
  ;; playing the game.
  ;;
  ;; 注: 这些映射规则只是我在平时玩游戏的时候遇到的
  ;;
  ;; collector: 凉凉
  ("夕" "夕")
  ("阳" (:双耳旁 "日"))
  ("红" (:绞丝旁 "工"))
  ("他" (:单人旁 "也"))
  ("打" (:提手旁 "丁"))
  ("咩" "口羊"))

;;; base-word.lisp ends here
