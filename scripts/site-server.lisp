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

;;; Documentation:
;; To compile a server executable:
;;
;;     sbcl --load site-server.lisp
;;

(in-package :cl-user)

(ql:quickload '(:hunchentoot :func2exec))

;;; Configurable variables

(defvar *iiiika-web-path* #P"../"
  "Path to IIIIka sources. ")

;;; Server

(defun serve (&optional (path *iiiika-web-path*) (port 4000))
  "Create a IIIIKA server at PATH of PORT. "
  (let ((server (make-instance 'hunchentoot:easy-acceptor :port port)))
    (setf (hunchentoot:acceptor-document-root server) path)
    (hunchentoot:start server)
    (sleep 100)))

(func2exec:f2e 'serve
               :executable "serve"
               :parse-hint '((:path . :plain)
                             (:port . :read)))

;;; site-server.lisp ends here
