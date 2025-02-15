;;; base-part.lisp --- Basic part mapping rules for IIIIka

;; File:        base-part.lisp
;; Description: Basic part mapping rules for IIIIka
;; Author:      凉凉
;; Maintainer:  凉凉
;; Copyright (c) 2025, 凉凉, all rights reserved
;; Created: 2025-02-13 14:37
;; Version: 0.0.0
;; Last-Updated: 2025-02-13 14:45
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

;;; How to contribute?                    如何参与编写规则?
;; here's a template example:             以下是一个简单的示例的模板:
;;
;;    (defpart*
;;      ;; author name and notes          ;; 建议写上作者和声明注释
;;      ;; please refer to character-sets ;; 请参考 character-sets 中的字符定义
;;      ("羊" "¥")
;;      ...)

(defpart* ;; 单字映射
  ;; Note:
  ;; these mapping rules are what I found while
  ;; playing the game.
  ;;
  ;; 注: 这些映射规则只是我在平时玩游戏的时候遇到的
  ;;
  ;; collector: 凉凉
  ("羊" "¥")
  ("丁" (:katakana :a))  ;; ア
  ("工" (:katakana :e))  ;; エ
  ("才" (:katakana :o))  ;; オ
  ("力" (:katakana :ka)) ;; カ
  ("夕" (:katakana :ta)) ;; タ
  ("八" (:katakana :ha)) ;; ハ
  ("也" (:katakana :se)) ;; セ
  )

(defpart* ;; 偏旁部首
  ;; Note:
  ;; these mapping rules are what I found while
  ;; playing the game.
  ;;
  ;; 注: 这些映射规则只是我在平时玩游戏的时候遇到的
  ;;
  ;; collector: 凉凉
  (((:双耳旁 "阝")) #\β)
  (((:日字旁 "日")) #\θ)
  (((:绞丝旁 "纟")) #\ξ)
  (((:三点水 "氵")) #\Ξ)

  (((:单人旁 "亻")) (:katakana :i))  ;; イ
  (((:提手旁 "扌")) (:katakana :ki)) ;; キ
  (((:口字旁 "口")) (:katakana :ro)) ;; ロ
  )

;;; base-part.lisp ends here
