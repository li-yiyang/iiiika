;;; package.lisp --- Package definition for IIIIka

;; File:        package.lisp
;; Description: Package definition for IIIIka
;; Author:      凉凉
;; Maintainer:  凉凉
;; Copyright (c) 2025, 凉凉, all rights reserved
;; Created: 2025-02-12 18:05
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

(defpackage :iiiika
  (:use :cl)
  (:export
   #:defcharacters
   #:defrule
   #:ikasu-char
   #:ikasu))

(in-package :iiiika)

;;; package.lisp ends here
