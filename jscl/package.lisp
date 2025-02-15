;;; package.lisp --- Package definition of IIIIka web

;; File:        package.lisp
;; Description: Package definition of IIIIka web
;; Author:      凉凉
;; Maintainer:  凉凉
;; Copyright (c) 2025, 凉凉, all rights reserved
;; Created: 2025-02-13 17:08
;; Version: 0.0.0
;; Last-Updated: 2025-02-13 17:08
;;           By: 凉凉
;; URL:
;; Keywords:
;; Compatibility: JSCL
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

(defpackage :iiiika/web
  (:use :cl)
  (:export
   #:*default-language*
   #:*language*
   #:deftranslation
   #:define-byname-adj
   #:define-byname-noun
   #:get-byname
   #:get-byname-adj
   #:get-byname-noun))

(in-package :iiiika/web)

;;; package.lisp ends here
