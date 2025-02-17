;;; base.lisp --- Base IIIIka rules

;; File:        base.lisp
;; Description: Base IIIIka rules
;; Author:      凉凉
;; Maintainer:  凉凉
;; Copyright (c) 2025, 凉凉, all rights reserved
;; Created: 2025-02-16 11:30
;; Version: 0.0.0
;; Last-Updated: 2025-02-16 11:30
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

(defrule*
  ;; Note:
  ;; these mapping rules are what I found while
  ;; playing the game.
  ;;
  ;; 注: 这些映射规则只是我在平时玩游戏的时候遇到的
  ;;
  ;; collector: 凉凉

  ;; 数字
  ("零" "0")
  ("一" "-")
  ("二" (:katakana :ni)) ;; ニ
  ("三" (:katakana :mi)) ;; Ξ

  ;; 单字映射

  ("羊" "¥")
  ("申" "φ")
  ("十" "+")
  ("丫" "Y")

  ("元" (:hiragana :e))  ;; え
  ("中" (:hiragana :yu)) ;; ゆ
  ("可" (:hiragana :su)) ;; す
  ("世" (:hiragana :se)) ;; せ
  ("奴" (:hiragana :nu)) ;; ぬ
  ("的" (:hiragana :no)) ;; の
  ("尔" (:hiragana :fu)) ;; ふ
  ("马" (:hiragana :ra)) ;; ら
  (("子" "乃") (:hiragana :ro)) ;; ろ

  ("丁" (:katakana :a))  ;; ア
  ("工" (:katakana :e))  ;; エ
  ("才" (:katakana :o))  ;; オ
  (("力" "刀") (:katakana :ka)) ;; カ
  ("千" (:katakana :ti)) ;; チ
  ("不" (:katakana :to)) ;; ト
  ("夕" (:katakana :ta)) ;; タ
  ("八" (:katakana :ha)) ;; ハ
  (("也" "巴") (:katakana :se)) ;; セ
  ("口" (:katakana :ro)) ;; ロ

  ;; 偏旁部首
  (:口字旁        (:english :lower-o)) ;; o

  ((:女字旁 "女") #\δ)
  ((:双耳旁 "阝") #\β)
  ((:日字旁 "日") #\θ)
  ((:绞丝旁 "纟") #\ξ)
  ((:双点水 "冫") #\:)
  ((:三点水 "氵") #\Ξ)

  ((:单人旁 "亻") (:katakana :i))  ;; イ
  ((:双人旁 "彳") (:katakana :ti)) ;; チ
  ((:提手旁 "扌") (:katakana :ki)) ;; キ
  ((:王字旁 "𤣩") (:katakana :mo)) ;; モ
  ((:立刀旁 "刂") (:katakana :ri)) ;; リ
  ((:示字旁 "礻") (:katakana :ne)) ;; ネ

  ;; "左右结构" 拆字规则
  ("我" "チギ")
  ("久" "ク、")
  ("人" "ノ、")
  ("么" "ノム")
  ("山" "ιυ")
  ("小" "·」·")
  ("水" "フ」く")
  ("从" "人人")
  ("北" "ヲヒ")

  ;; 一些长得像的字
  (("云") "テ.")
  (("天" "无") ".モ")

  ;; 左右结构字
  ("好" (:女字旁 "子"))
  ("奶" (:女字旁 "乃"))
  ("冰" (:双点水 "水"))
  ("队" (:双耳旁 "人"))
  ("阿" (:双耳旁 "可"))
  ("神" (:示字旁 "申"))
  ("阳" (:双耳旁 "日"))
  ("红" (:绞丝旁 "工"))
  ("他" (:单人旁 "也"))
  ("你" (:单人旁 "尔"))
  ("什" (:单人旁 "十"))
  ("仙" (:单人旁 "山"))
  ("行" (:双人旁 "丁"))
  ("打" (:提手旁 "丁"))
  ("咩" (:口字旁 "羊"))
  ("吖" (:口字旁 "丫"))
  ("啊" (:口字旁 "阿"))
  ("吗" (:口字旁 "马"))
  ("加" ("力" :口字旁))
  ("班" (:王字旁 :立刀旁 :王字旁))
  )

;;; base.lisp ends here
