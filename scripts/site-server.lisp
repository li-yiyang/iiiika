;;; site-server.lisp --- Local Site Server for IIIIka (debug usage)

;; File:        site-server.lisp
;; Description: Local Site Server for IIIIka (debug usage)
;; Author:      凉凉
;; Maintainer:  凉凉
;; Copyright (c) 2025, 凉凉, all rights reserved
;; Created: 2025-02-13 21:46
;; Version: 0.0.0
;; Last-Updated: 2025-02-13 21:46
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

(in-package :iiiika/web)

;; (ql:quickload :hunchentoot)

;;; Configurable variables

(defvar *iiiika-web-path*
  (asdf:system-relative-pathname :iiiika "./")
  "Path to IIIIka sources. ")

;;; Server

(defparameter *iiiika-server*
  (make-instance 'hunchentoot:easy-acceptor :port 4000))

(setf (hunchentoot:acceptor-document-root *iiiika-server*)
      *iiiika-web-path*)

(hunchentoot:start *iiiika-server*)

;; (hunchentoot:stop *iiiika-server*)

;;; site-server.lisp ends here
