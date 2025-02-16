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

(defcharacters :english
  (:lower #\a #\z)
  (:upper #\A #\Z))

(defcharacters :number
  (:num #\1 #\9))

(defcharacters :japanese-symbol
  "、「」")

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
  (:wa . #\わ) (:wo . #\を) (:n  . #\ん) (:yu . #\ゆ))

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
  (:wa . #\ワ) (:wo . #\ヲ) (:n  . #\ン) (:yu . #\ユ))

(defcharacters :symbols-1
  "?!¿¡,. # &-"
  "()[];:'‘’,‛"
  " /{}·…\"“”„_"
  "<>《》«»←→↑↓⇒⇔~"
  "$¢€£¥  𝑓¤|^")

;; Not finished
(defcharacters :symbols-2
  )

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

;;; character-sets.lisp ends here
