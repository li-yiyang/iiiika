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
  ;; ("、" "、")
  ;; ("。" "。")
  ;; ("？" "？")
  ;; ("！" "！")
  ("（" "(")
  ("）" ")")
  ("【" "[")
  ("】" "]")
  ("｛" "{")
  ("｝" "}")

  ;; 数字
  ("零" "0")
  ("一" "ー")
  ("二" (:katakana :ni)) ;; ニ
  ("三" (:katakana :mi)) ;; Ξ
  ("八" (:katakana :ha)) ;; ハ

  ;; 单字映射
  ("全" "仝")
  ("羊" "¥")
  ("申" "φ")
  ("十" "+")
  ("丫" "Y")
  ("贝" "Ω")

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
  ;; ("儿" "ノし")
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
  ("林" "木木")
  ("式" "工じ")

  ;; 一些长得像的字
  (("云") "テ.")
  (("天" "无") ".モ")

  ;; 左右结构字
  ("测" (:三点水 "贝" :立刀旁))
  ("试" (:言字旁 "式"))
  ("好" (:女字旁 "子"))
  ("奶" (:女字旁 "乃"))
  ("材" (:木字旁 "才"))
  ("冰" (:双点水 "水"))
  ("队" (:双耳旁 "人"))
  ("阿" (:双耳旁 "可"))
  ("神" (:示字旁 "申"))
  ("福" (:示字旁 "る"))
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
  ("琳" (:王字旁 "林"))
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
  ;; ("月" #\Π)
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
  ;; ("几" (:hiragana :n))  ;; ん
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
  ((:言字旁 "讠") "ī")
  ("让" (:言字旁 "上"))
  ((:双人旁 "彳") "ヲ")
  ("行" "ヲテ")
  ("多" "タタ")
  ("少" "ゾ")
  ("扫" "オヨ")
  (("土") "ヒ")
  ("也" "や")

  ;; removed to bilibili user 777rain777's rule
  ;; ("地" "ヒや")
  ;; ("机" "ホπ")
  ("机" (:木字旁 "几"))
  ("死" "ちE")
  ("在" "オェ")

  ;; ("河" (:三点水 "可"))
  ("边" "でカ")
  ((:禾字旁 "禾") "ポ")
  ("种" (:禾字旁 "中")))

(defrule*
  ;; Credits:
  ;; bilibili user: 硫离子还是琉璃子
  ;; original comment is screen shorts
  ;; oΠβoモ (Bミ
  ;; ("月" "Л")
  ("哪" (:口字旁 "月" :双耳旁))
  ("吒" (:口字旁 "モ"))

  ;; inspired from "吒":
  ("托" (:提手旁 "モ"))
  ("毛" "モ"))

(defrule*
  ;; Credits:
  ;; bilibili user: 酢饴
  ;; original comment:
  ;; 之前取的“乡下人”（ξ T・ ノ、）不知道能不能看出来x
  ("乡" "ξ"))

(defrule*
  ;; Credits:
  ;; bilibili user: 勺子c
  ;; original comment 1:
  ;; 几→Л，
  ("几" "Л")
  ;; 儿→ル，
  ("儿" "ル")
  ;; 弓→ζ，
  ("弓" "ζ")
  ;; 回→◎
  ("回" "◎")
  ;; 双→ヌヌ，
  ("双" "ヌヌ")
  ;; 休→イホ，
  ("休" "イホ")

  ;; 维→ξイΞ，
  ("维" :绞丝旁 "イΞ")
  ;; 谁→iイΞ，
  ("谁" :言字旁 "イΞ")
  ;; 准→；イΞ，
  ("准" :双点水 "イΞ")

  ;; inspired:
  ("仨" :单人旁 "三")
  ("们" :单人旁 "门")

  ;; 动→をカ，
  ("动" "をカ")
  ;; 弛→}セ，
  (:弓字旁 "}")
  ("弛" :弓字旁 "也")
  ;; inspired:
  ("松" :木字旁 "û")
  ("白" "Ó")
  ("柏" :木字旁 "ó")

  ;; 玩→モえ，
  ("玩" :王字旁 "元")
  ;; 妈→δら，
  ("妈" :女字旁 "马")
  ;; 妹→δホ，
  ("未" "ホ")
  ("妹" :女字旁 "ホ")
  ;; 折→キF
  ("斤" "F")
  ("折" :提手旁 "斤")

  ;; original comment 2:
  ;; 冲→; ゆ
  ("冲" :双点水 "中")

  ;; 2025-2-20 update
  ;;
  ;; original comment:
  ;; _モ 小 ÐĄ 王小明
  ;; イŁ Ąセ 化肥
  ;; リヨ イш ノ、 归仙人
  ;; ΞĦ フ」く 泔水
  ;; Ζ; ホЛ 飞机
  ;; -К Ξエ 7 ♀ 长江七号
  ;; キT Ą± Ą± 打肚肚
  ;; οð}Κi+ネβイニ 咕张计祁仁
  ((:王字旁 "王") "_モ")
  ((:日字旁 "日") "Ð")
  ("月" "Ą")
  ("明" :日字旁 "月")
  ((:月字旁 "月") "Ą")
  ("化" "イŁ")
  ("肥" :月字旁 "巴")
  ("归" "リヨ")
  ("甘" "Ħ")
  ("泔" (:三点水 "甘"))
  ("飞" "Ζ;")

  ;; inspired
  ("杯" (:木字旁 "不"))
  ("长" "-К")
  ("号" "♀")
  ("土" "±")
  ("肚" (:月字旁 "土"))
  ("古" "ð")
  ("咕" (:口字旁 "古"))
  ("张" (:弓字旁 "K"))
  ("计" (:言字旁 "十"))
  ("祁" (:示字旁 :双耳旁))
  ("仁" (:单人旁 "二"))
  )

(defrule*
  ;; Credits:
  ;; bilibili user: 777rain777
  ;; original comment
  ;; 玩了一下发现我自己整的“地”字比程序里的可能稍微好一点：tせ
  (:土字旁 "t")
  ("地" (:土字旁 "せ")))

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
