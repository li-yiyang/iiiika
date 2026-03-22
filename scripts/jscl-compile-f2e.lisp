;;; jscl-compile-f2e.lisp --- Use F2E to build the compile executable

;; File:        jscl-compile.lisp
;; Description: Using JSCL to compile the system
;; Author:      凉凉
;; Maintainer:  凉凉
;; Copyright (c) 2025, 凉凉, all rights reserved
;; Created: 2025-08-27 20:52
;; Version: 0.0.0
;; Last-Updated: 2025-08-27 20:52
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

(ql:quickload :func2exec)

;; Change this to your JSCL path
(load "~/quicklisp/local-projects/jscl/jscl.lisp")
(jscl:bootstrap)

(pushnew #P"../" ql:*local-project-directories*)
(ql:quickload :iiiika)

;; I messed something up, I will consider rewrite them
;; in the future (maybe)
;;
(load "../jscl/package.lisp")
(load "../jscl/config.lisp")
(load "../jscl/utils.lisp")

(in-package :iiiika/web)
(load "./jscl-compile.lisp")

(func2exec:f2e #'compile-iiiika
               :executable "compile")

;;; jscl-compile-f2e.lisp
