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

  ;; 中文符号
  ("，" ",")
  ("、" "、")
  ("。" "。")
  ("？" "？")
  ("！" "！")
  ("（" "(")
  ("）" ")")
  ("【" "[")
  ("】" "]")
  ("｛" "{")
  ("｝" "}")
  ("《" "》")

  ;; 数字
  ("零" "0")
  ("一" "ー")
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
  ("寸" (:hiragana :su)) ;; す
  (("子" "乃") (:hiragana :ro)) ;; ろ

  ;; ("丁" (:katakana :a))  ;; ア
  ;; 丁: ア -> T
  ;; Credits:
  ;; rednote user: 小红薯 63A7B0C2
  ;; original comment:
  ;; “打”字可以换成“キT”更像哦
  ("丁" "T")
  
  ("工" (:katakana :e))  ;; エ
  ("才" (:katakana :o))  ;; オ
  (("力" "刀") (:katakana :ka)) ;; カ
  ("又" (:katakana :nu)) ;; ヌ
  ("千" (:katakana :ti)) ;; チ
  (("卜" "不") (:katakana :to)) ;; ト
  ("夕" (:katakana :ta)) ;; タ
  ("八" (:katakana :ha)) ;; ハ

  ;; removed "也" to bilibili user: 糯麻_Nomani rule: "地"
  (("巴") (:katakana :se)) ;; セ
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
  ;; ((:双人旁 "彳") (:katakana :ti)) ;; チ
  ((:提手旁 "扌") (:katakana :ki)) ;; キ
  ((:王字旁 "𤣩") (:katakana :mo)) ;; モ
  ((:立刀旁 "刂") (:katakana :ri)) ;; リ
  ((:示字旁 "礻") (:katakana :ne)) ;; ネ
  ((:木字旁 "木") (:katakana :ho)) ;; ホ

  ;; "左右结构" 拆字规则
  ("我" "チギ")
  ("儿" "ノし")
  ("久" "ク、")
  ("人" "ノ、")
  ("大" "ナ、")
  ("么" "ノム")
  ("山" "ιυ")
  ("小" "·」·")
  ("水" "フ」く")
  ("从" "人人")
  ;; ("北" "ヲヒ")
  ("对" "又寸")

  ;; 一些长得像的字
  (("云") "テ.")
  (("天" "无") ".モ")

  ;; 左右结构字
  ("好" (:女字旁 "子"))
  ("奶" (:女字旁 "乃"))
  ("材" (:木字旁 "才"))
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
  ;; ("行" (:双人旁 "丁"))
  ("打" (:提手旁 "丁"))
  ("咩" (:口字旁 "羊"))
  ("吖" (:口字旁 "丫"))
  ("啊" (:口字旁 "阿"))
  ("吗" (:口字旁 "马"))
  ("加" ("力" :口字旁))
  ("班" (:王字旁 :立刀旁 :王字旁))
  )

;; Rules from Bilibili
;; link: https://www.bilibili.com/video/BV1VSAVeZE4m/

(defrule*
  ;; Credit:
  ;; bilibili user: 今天潜行用箱子了吗
  ;; original comment:
  ;; ゐ イ+ ノム キT チξ
  ;; Яll キT チギ
  ;; iコ タ卜 シマ
  ("为" "ゐ")
  ("什" "イ+")

  ;; Note: currently character-table is not complete
  ;; see `lisp/character-sets.lisp' `:patch' for the
  ;; character patches.
  ("别" "Яll")

  ("门" "iコ")
  ("外" "タ卜")
  ("汉" "シマ"))

(defrule*
  ;; Credit:
  ;; bilibili user: 无明常夜
  ;; original comment is a collection screen shorts
  ;; 哇好方便！发点遇到的国人id
  ;; ミゆΠ キヒ ノ、<- 湖北人
  ;; ,す, オヒ ノ、 <- 京北人?
  ;; オヒ ,す, ノ、 <- 北京人
  ;; ミキF ミエ ノ、<- 浙江人
  ;; 4 lll ノ、     <- 四川人
  ;; ミす Nαη ノ、  <- 河南人
  ;;
  ;; Note:
  ;; read from image, probably not exactly like the
  ;; original characters
  ("月" #\Π)
  ("湖" (:三点水 "中" "月"))
  ("北" "オヒ")

  ;; Credit:
  ;; github user: SlenderData
  ;; original comment:
  ;; 第二条应该是 东北人 吧， ,す, 也可以解释成形近的 东。
  ;;
  ;; https://github.com/li-yiyang/iiiika/commit/9e200ec46a72ee3490697400e0994d87de33ea60#commitcomment-152654479
  (("京" "东") ",す,")
  ("浙" (:三点水 :提手旁 "F"))
  ("江" (:三点水 "工"))
  ("川" "lll")
  ("河" (:三点水 "可"))
  ("南" "Nαη"))

(defrule*
  ;; Credit:
  ;; bilibili user: 哪来的完蛋玩意儿
  ;; original comment is a collection screen shorts
  ("几" (:hiragana :n))  ;; ん
  ("机" (:木字旁 "几")))

(defrule*
  ;; Credit:
  ;; bilibili user: 糯麻_Nomani
  ;; original comment:
  ;; 上下左右 _ヒ'Fナェナo
  ;; 礼让行人 ネしi_ヒヲテノ、
  ;; 多少 タタゾ
  ;; 扫地机 オヨヒやホπ
  ;; si在河边 ちEオェΞすでカ
  ;; 种 ポφ
  ;; 在这里看着不像，换个字体就像了（）
  ("上" "_ヒ")
  ("下" "'F")
  ("左" "ナェ")
  ("右" "ナo")
  ("乚" "し")
  ("礼" "ネし")
  ((:言字旁 "讠") "i")
  ("让" (:言字旁 "上"))
  ((:双人旁 "彳") "ヲ")
  ("行" "ヲテ")
  ("多" "タタ")
  ("少" "ゾ")
  ("扫" "オヨ")
  ((:土字旁 "土") "ヒ")
  ("也" "や")
  ("地" "ヒや")
  ;; ("机" "ホπ")
  ("机" (:木字旁 "几"))
  ("死" "ちE")
  ("在" "オェ")

  ;; ("河" (:三点水 "可"))
  ("边" "でカ")
  ((:禾字旁 "禾") "ポ")
  ("种" (:禾字旁 "中")))

;;;; Missing Request

(defrule*
  ;; Credits:
  ;; rednote user: 青羽
  ;; original comment:
  ;; 蹲个杭州人xwx刚刚试了一下好像没有
  ("亢" "え")
  ("杭" (:木字旁 "亢"))
  ("州" "łłł"))

;;; base.lisp ends here
