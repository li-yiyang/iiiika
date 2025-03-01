;;; character-sets.lisp --- Character sets in Nintendo Switch input methods

;; File:        character-sets.lisp
;; Description: Character sets in Nintendo Switch input methods
;; Author:      凉凉
;; Maintainer:  凉凉
;; Copyright (c) 2025, 凉凉, all rights reserved
;; Created: 2025-02-12 22:46
;; Version: 0.0.0
;; Last-Updated: 2025-02-16 11:58
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

(defcharacters :hiragana
  (:a  . #\あ) (:i  . #\い) (:u  . #\う) (:e  . #\え) (:o  . #\お)
  (:ka . #\か) (:ki . #\き) (:ku . #\く) (:ke . #\け) (:ko . #\こ)
  (:ga . #\が) (:gi . #\ぎ) (:gu . #\ぐ) (:ge . #\げ) (:go . #\ご)
  (:sa . #\さ) (:si . #\し) (:su . #\す) (:se . #\せ) (:so . #\そ)
  (:za . #\ざ) (:ji . #\じ) (:zu . #\ず) (:ze . #\ぜ) (:zo . #\ぞ)
  (:ta . #\た) (:ti . #\ち) (:tu . #\つ) (:te . #\て) (:to . #\と)
  (:da . #\だ) (:di . #\ぢ) (:du . #\づ) (:de . #\で) (:do . #\ど)
  (:na . #\な) (:ni . #\に) (:nu . #\ぬ) (:ne . #\ね) (:no . #\の)
  (:ha . #\は) (:hi . #\ひ) (:fu . #\ふ) (:he . #\へ) (:ho . #\ほ)
  (:ba . #\ば) (:bi . #\び) (:bu . #\ぶ) (:be . #\べ) (:bo . #\ぼ)
  (:pa . #\ぱ) (:pi . #\ぴ) (:pu . #\ぷ) (:pe . #\ぺ) (:po . #\ぽ)
  (:ma . #\ま) (:mi . #\み) (:mu . #\む) (:me . #\め) (:mo . #\も)
  (:ra . #\ら) (:ri . #\り) (:ru . #\る) (:re . #\れ) (:ro . #\ろ)
  (:wa . #\わ) (:wi . #\ゐ) (:wo . #\を) (:n  . #\ん)
  (:yu . #\ゆ) (:ya . #\や))

(defcharacters :katakana
  (:a  . #\ア) (:i  . #\イ) (:u  . #\ウ) (:e  . #\エ) (:o  . #\オ)
  (:ka . #\カ) (:ki . #\キ) (:ku . #\ク) (:ke . #\ケ) (:ko . #\コ)
  (:ga . #\ガ) (:gi . #\ギ) (:gu . #\グ) (:ge . #\ゲ) (:go . #\ゴ)
  (:sa . #\サ) (:si . #\シ) (:su . #\ス) (:se . #\セ) (:so . #\ソ)
  (:za . #\ザ) (:ji . #\ジ) (:zu . #\ズ) (:ze . #\ゼ) (:zo . #\ゾ)
  (:ta . #\タ) (:ti . #\チ) (:tu . #\ツ) (:te . #\テ) (:to . #\ト)
  (:da . #\ダ) (:di . #\ヂ) (:du . #\ヅ) (:de . #\デ) (:do . #\ド)
  (:na . #\ナ) (:ni . #\ニ) (:nu . #\ヌ) (:ne . #\ネ) (:no . #\ノ)
  (:ha . #\ハ) (:hi . #\ヒ) (:fu . #\フ) (:he . #\ヘ) (:ho . #\ホ)
  (:ba . #\バ) (:bi . #\ビ) (:bu . #\ブ) (:be . #\ベ) (:bo . #\ボ)
  (:pa . #\パ) (:pi . #\ピ) (:pu . #\プ) (:pe . #\ペ) (:po . #\ポ)
  (:ma . #\マ) (:mi . #\ミ) (:mu . #\ム) (:me . #\メ) (:mo . #\モ)
  (:ra . #\ラ) (:ri . #\リ) (:ru . #\ル) (:re . #\レ) (:ro . #\ロ)
  (:wa . #\ワ) (:wo . #\ヲ) (:n  . #\ン)
  (:yu . #\ユ) (:ya . #\ヤ))

(defcharacters :japanese-symbol
  ;; 1234567890-
  ;; ! #$ ^&*()_
  ;; ~`= +{}|[]¥
  ;; <>;:"',.?/~
  "、。？！〜ー「」"
  "ヵヶ※〃ゝ々〆仝")

(defcharacters :russian
  "абвгдеёжзийклмнопрстуфхцчшщъыьэюя"
  "АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ")

(defcharacters :english-lower-aaa
  "àáâãåæāăąç"
  "ćċčðďǆǳèéêë"
  "ēęěğġħìíîï"
  ;; Note: missing ḽ like character,
  ;; but should have accent above...
  "īįiĳķĺļ ł")

(defcharacters :english-upper-aaa
  "ÀÁÂÃÅÆĀĂĄÇ"
  ;; Note: missing Ǆ and Ǳ.
  ;; not knowing which character to input...
  "ĆĊČÐĎ  ÈÉÊË"
  "ĒĘĚĞĠĦÌÍÎÏ"
  ;; Note: missing Ḽ like character,
  ;; but should have accent above...
  "ĪĮIĲĶĹĻ Ł")

(defcharacters :english-lower-nnn
  "ñńņňòóôõöøœ"
  ;; Note:
  ;; + missing ṱ like character,
  ;;   but should have accent above...
  ;; + missing ꞵ like character
  "ő ŕřš śşþ ț"
  "ùúûüūůűųýÿź"
  "żž")

(defcharacters :english-upper-nnn
  "ÑŃŅŇÒÓÔÕÖØŒ"
  ;; Note:
  ;; + missing Ṱ like character,
  ;;   but should have accent above...
  ;; + missing upper ꞵ like character
  "Ő ŔŘŠ ŚŞÞ Ț"
  "ÙÚÛÜŪŮŰŲÝŸŹ"
  "ŻŽ")

(defcharacters :symbols-1
  "?!¿¡,. # &-"
  "()[];:'‘’,‛"
  " /{}·…\"“”„_"
  "<>《》«»←→↑↓⇒⇔~"
  "$¢€£¥  ƒ¤|^")

;; Not finished
(defcharacters :symbols-2
  "´`+-×÷=±∞√¬"
  "∀⊂⊃∴∵⌒μ№°′∂"
  "¹²³¼½¾*♪♭♀♂"
  "○●◎□■△▲▽▼"
  "☆★  ©®™§¶✝〒")

(defcharacters :symbols-3
  (:alpha   . #\α)
  (:beta    . #\β)
  (:gamma   . #\γ)
  (:delta   . #\δ)
  (:epsilon . #\ε)
  (:zeta    . #\ζ)
  (:eta     . #\η)
  (:theta   . #\θ)
  (:iota    . #\ι)
  (:kappa   . #\κ)
  (:lambda  . #\λ)
  (:mu      . #\μ)
  (:nu      . #\ν)
  (:xi      . #\ξ)
  (:omicron . #\ο)
  (:pi      . #\π)
  (:rho     . #\ρ)
  (:sigma   . #\σ)
  (:tau     . #\τ)
  (:upsilon . #\υ)
  (:phi     . #\φ)
  (:chi     . #\χ)
  (:psi     . #\ψ)
  (:omega   . #\ω))

(defcharacters :symbols-4
  (:alpha   . #\Α)
  (:beta    . #\Β)
  (:gamma   . #\Γ)
  (:delta   . #\Δ)
  (:epsilon . #\Ε)
  (:zeta    . #\Ζ)
  (:eta     . #\Η)
  (:theta   . #\Θ)
  (:iota    . #\Ι)
  (:kappa   . #\Κ)
  (:lambda  . #\Λ)
  (:mu      . #\Μ)
  (:nu      . #\Ν)
  (:xi      . #\Ξ)
  (:omicron . #\Ο)
  (:pi      . #\Π)
  (:rho     . #\Ρ)
  (:sigma   . #\Σ)
  (:tau     . #\Τ)
  (:upsilon . #\Υ)
  (:phi     . #\Φ)
  (:chi     . #\Χ)
  (:psi     . #\Ψ)
  (:omega   . #\Ω))

(defcharacters :english
  (:lower #\a #\z)
  (:upper #\A #\Z))

(defcharacters :number
  (:num #\0 #\9))

;; The `:patch' character is what you could
;; input in NS, but I havn't found where to
;; input the character... I will remove them
;; and place them to correct place after I
;; found their keyboard place.

;; TODO:
;; + `Я': see `lisp/base.lisp' (credit: bilibili user: 今天潜行用箱子了吗)
;;      -> `:ruassian'
;; + `+': see `lisp/base.lisp' (credit: bilibili user: 今天潜行用箱子了吗)
;;      -> `:symbol-2'
;; + `ェ': see `lisp/base.lisp' (credit: bilibili user: 糯麻_Nomani)

(defcharacters :patch
  "ェヨ")

;;; character-sets.lisp ends here
