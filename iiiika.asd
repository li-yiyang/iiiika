;;; iiiika.asd --- System definition for IIIIka, the Splatoon Chinese name inputer

;; File:        iiiika.asd
;; Description: System definition for IIIIka, the Splatoon Chinese name inputer
;; Author:      凉凉
;; Maintainer:  凉凉
;; Copyright (c) 2025, 凉凉, all rights reserved
;; Created: 2025-02-12 18:02
;; Version: 0.0.0
;; Last-Updated: 2025-02-12 18:02
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

(asdf:defsystem #:iiiika
  :author ("凉凉")
  :version "0"
  :description "IIIIka is a Chinese-like word input for Splatoon. "
  :depends-on ()
  :serial t
  :pathname "lisp"
  :components
  ((:file "package")
   (:file "utils")
   (:file "characters")
   (:file "character-sets")
   (:file "core")
   (:file "base-part")
   (:file "base-word")))

;;; iiiika.asd ends here
