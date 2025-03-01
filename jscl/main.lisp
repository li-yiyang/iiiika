;;; main.lisp --- Main logic of IIIIka web

;; File:        main.lisp
;; Description: Main logic of IIIIka web
;; Author:      凉凉
;; Maintainer:  凉凉
;; Copyright (c) 2025, 凉凉, all rights reserved
;; Created: 2025-02-13 23:44
;; Version: 0.0.0
;; Last-Updated: 2025-02-16 11:59
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

;;; Note: this file only works under JSCL.
;;; loading it into developing Lisp (like SBCL) will raise error.

#-jscl (error "This file only work under JSCL")

;;; ===================== IIIIka Layer ==========================
;; This wraps functions from IIIIka package.

;; `*user-defined-rule-list*'
;; `update-rule' char rule
;; `dump-user-defined-rule'

(defparameter *user-defined-rule-list* ()
  "User defined rule list.

Within the list is

   (char rule)

")

(defun update-rule (char rule)
  "Update rule and pushnew to `*user-defined-rule-list*'.
Return `T' if `rule' is valid, `NIL' if not.

Arguments:
+ `char' from character
+ `rule' a string
"
  (handler-case
      (progn
        (iiiika::define-rule char (array->list (iiiika:ikasu rule)) T)
        (pushnew char *user-defined-rule-list*)
        T)
    (iiiika::invalid-rule (err)
      (print err))))

;; `update-ikasu' from-id to-id &key fallback editable tooltip

(defun update-ikasu (from-id to-id
                     &key
                       (fallback "???")
                       (editable NIL)
                       (tooltip  T))
  "Get original `from-id' <input> value and update `to-id' contents.

Arguments:
+ `from-id'  a HTML <input> obj
+ `to-id'    a HTML <div> or <span> obj
+ `fallback' a string for ikasu fallback value
+ `editable' if `T', can be clicked to defrule
+ `tooltip'  if `T', will add a tooltip for character
"
  (let* ((from  (get-elem-by-id from-id))
         (to    (get-elem-by-id to-id))
         (input (attr from :value)))
    (setf (inner-html to) "")
    (cond ((zerop (length input))
           (setf (inner-html to) fallback))

          (editable
            (map-white-char-only-once (char input)
              ;; for white space, just append SPACE
              (append-children to (create-elem "span" " "))
              ;; for normal char
              (if (iiiika::find-character char)
                  (let* ((char (format NIL "~C" char))
                         (elem (create-elem "span" char)))
                    (attach-tooltip  elem char)
                    (append-children to   elem))
                  (multiple-value-bind (res err) (iiiika:ikasu-char char)
                    (let* ((res  (if err (format NIL "~C" char) res))
                           (elem (create-elem "span" res)))
                      (add-css-class elem "editable")
                      (add-event (elem "click") (define-rule char))
                      (when err (add-css-class elem "unknown"))
                      (when tooltip
                        (if err
                            (attach-tooltip elem (getui err))
                            (attach-tooltip elem (format NIL "~C" char))))
                      (append-children to elem))))))

          (tooltip
           (map-white-char-only-once (char input)
             ;; for white space, just append SPACE
             (let ((space (create-elem "span" " ")))
               (attach-tooltip  space (getui '(:normal :keyboard :space)))
               (append-children to space))
             ;; for normal char
             (multiple-value-bind (res err) (iiiika:ikasu-char char)
               (if err
                   ;; push unknown character as `ロ'
                   (let ((elem (create-elem "span" res)))
                     (attach-tooltip elem (getui err))
                     (append-children to elem))
                   ;; push mapped characters
                   (map-char (char res)
                     (let ((elem (create-elem "span" (format NIL "~C" char))))
                       (multiple-value-bind (found cname)
                           (iiiika::find-character char)
                         (attach-tooltip elem (getui (list (first cname)
                                                           :keyboard
                                                           char)))
                         (append-children to elem))))))))
          (T
           ;; Just write plain ikasu string
           (setf (inner-html to) (iiiika:ikasu input))))))

;;; ===================== Widgets Utils =========================

;; `*widgets*':
;; `show-widget'
;; `hide-widget'
(defparameter *widgets* ()
  "Stack of current widgets lists. ")

(defun show-widget (widget-id)
  "Popup widget with id, push widget-id to `*widgets*'. "
  (dolist (old *widgets*)
    (hide-elem (get-elem-by-id old)))
  (push widget-id *widgets*)
  (show-elem (get-elem-by-id "mask"))
  (show-elem (get-elem-by-id widget-id)))

(defun hide-widget (widget-id)
  "Hide widget with id, pop `*widgets*' list.
If `*widgets*' is empty list, hide mask. "
  (pop *widgets*)
  (hide-elem (get-elem-by-id widget-id))
  (if (endp *widgets*)
      (hide-elem (get-elem-by-id "mask"))
      (show-widget (pop *widgets*))))

;; Keyboard
;;      +--------------------------------------------------------------+
;;      |                                                              |
;;      |                       [ikasu-id]                             |
;;      |   +-[input-id]-------------------------------------------+   |
;;      |   |                                                      |   |
;;      |   +------------------------------------------------------+   |
;;      +-[kbd-div-id]-------------------------------------------------+
;;      |                                                              |
;;      | +-[kbd-sets-id]--------------------------------------------+ |
;;      | | +-[kbd-stat-id]--+ +----------+ +----------+             | |
;;      | | +----------------+ +----------+ +----------+             | |
;;      | +----------------------------------------------------------+ |
;;      |  +-[kbd-id]------------------------------------------------+ |
;;      |  | +-----+ +-----+ +------+ +------+ +------+ +------+     | |
;;      |  | |     | |     | |      | |      | |      | |      |     | |
;;      |  | +-----+ +-----+ +------+ +------+ +------+ +------+     | |
;;      +--+---------------------------------------------------------+-+
;;
;; `*kbd-width*'
;; `append-input'     input-id char &optional ikasu-id
;; `update-keyboard'  kbd-html-table char-set input-id ikasu-id
;; `create-keyboard'  kbd-id char-set input-id ikasu-id
;; `select-keyboard'  kbd-sets-id kbd-stat-id kbd-id
;; `toggle-keyboards' kbd-div-id  stat-id &optional hide
;; `create-keyboards' kbd-sets-id kbd-container-id char-sets-tables input-id ikasu-id
;;
;; Note: the key of char-set (hashtable) is char-code, use `do-charset'

(defparameter *kbd-width* 8
  "Number of keyboard buttons for single line. ")

(defun append-input (input-id char &optional ikasu-id)
  "Append `input' HTML <input> value with `char'.
Return the appended input value.

Arguments:
+ `input' HTML <input> id
+ `char'  character to be appended
+ `ikasu-id' if provided, update the ikasu contents by `update-ikasu'
"
  (let ((input (get-elem-by-id input-id)))
    (setf (attr input :value) (format NIL "~A~C" (attr input :value) char))
    (when ikasu-id (update-ikasu input-id ikasu-id))))

(defun update-keyboard (kbd char-set input-id ikasu-id)
  "Clear the `kbd' <table> content and update buttons.
Return `kbd' itself.

Arguments:
+ `kbd':       a HTML <table> obj, e.g. (get-elem-by-id kbd-id)
+ `char-sets': a hashtable for keyboard buttons
+ `input-id':  a HTML <input> for keyboard char output.
"
  (let ((input (get-elem-by-id input-id))
        (line  (create-elem "tr" ""))
        (count 0))
    (setf (inner-html kbd) "")
    (append-children kbd line)
    (do-charset (char value char-set)
      (let ((button (create-elem "td" (format NIL "~C" char))))
        (add-css-class button "popup-button")
        (add-event (button "click")
          (append-input input-id char ikasu-id))
        (append-children line button)
        (incf count)
        (when (= count *kbd-width*)
          (setf line  (create-elem "tr" ""))
          (setf count 0)
          (append-children kbd line))))
    kbd))

(defun create-keyboard (kbd-id char-set input-id ikasu-id)
  "Create a keyboard with id `kbd-id'.
Return a <table> as keyboard.

Arguments:
+ `kbd-id':   a string for the HTML obj id
+ `char-set': a hashtable for keyboard buttons
+ `input-id': a string for the HTML obj id to input
"
  (let ((kbd (create-elem "table" "")))
    (setf (attr kbd :id) kbd-id)
    (add-css-class kbd "popup-keyboard")
    (update-keyboard kbd char-set input-id ikasu-id)))

(defun select-keyboard (kbd-sets-id kbd-stat-id kbd-container-id kbd-id)
  "Select `kbd-id' keyboard.
Disable all stat button in `kbd-sets-id' but `kbd-stat-id'. "
  (do-children (kbd-stat (get-elem-by-id kbd-sets-id))
    (remove-css-class kbd-stat "button-popuped"))
  (add-css-class (get-elem-by-id kbd-stat-id) "button-popuped")
  (do-children (kbd (get-elem-by-id kbd-container-id))
    (setf (attr kbd :style :display) "none"))
  (setf (attr (get-elem-by-id kbd-id) :style :display) "table"))

(defun toggle-keyboards (kbd-div-id stat-id &optional (hide NIL hide-p))
  "If `stat-id' has CSS style `button-popuped', hide `kbd-div-id';
or show `kbd-div-id' if not.
Return `T' for showing, `NIL' for hidding.

Arguments:
+ `hide' to force show/hide keyboards. "
  (let ((kbd  (get-elem-by-id kbd-div-id))
        (stat (get-elem-by-id stat-id)))
    (flet ((show ()
             (setf (attr kbd :style :display) "block")
             (add-css-class stat "button-popuped"))
           (hide ()
             (setf (attr kbd :style :display) "none")
             (remove-css-class stat "button-popuped")))
      (if hide-p
          (if hide (hide) (show))
          (if (has-css-class-p stat "button-popuped") (hide) (show))))))

(defun create-keyboards (kbd-sets-id kbd-container-id input-id ikasu-id
                         &optional clear)
  "Filling the `kbd-sets-id' by `iiiika::*characters*'. "
  (let ((kbd-sets      (get-elem-by-id kbd-sets-id))
        (kbd-container (get-elem-by-id kbd-container-id)))
    (when clear
      (setf (inner-html kbd-sets)      "")
      (setf (inner-html kbd-container) ""))
    (maphash
     (lambda (stat-name char-set)
       (let* ((char-set (getf char-set :bwd))
              (stat-id  (format NIL "~A~A" kbd-sets-id      (symbol-name stat-name)))
              (kbd-id   (format NIL "~A~A" kbd-container-id (symbol-name stat-name)))
              (stat     (create-elem "button" (getui stat-name)))
              (kbd      (create-keyboard kbd-id char-set input-id ikasu-id)))
         (setf (attr stat :id) stat-id)
         (add-css-class stat "popup-button")
         (add-event (stat "click")
           (select-keyboard kbd-sets-id stat-id kbd-container-id kbd-id))
         (append-children kbd-sets      stat)
         (append-children kbd-container kbd)))
     iiiika::*character-sets*)
    (select-keyboard kbd-sets-id
                     (format NIL "~AHIRAGANA" kbd-sets-id)
                     kbd-container-id
                     (format NIL "~AHIRAGANA" kbd-container-id))))

;;; ========================== Widgets =========================

;; Alert

(defun alert (content &key
                        (title  (getui :alert-title))
                        (button (getui :confirm)))
  "Popup alert. "
  (setf (text (get-elem-by-id "alert-title"))   title)
  (setf (text (get-elem-by-id "alert-content")) content)
  (setf (text (get-elem-by-id "alert-button"))  button)
  (show-widget "alert"))

;; TODO: if have time, rewrite `byname-select' to prerender the
;; byname-adj and byname-noun list to boost up
(defun byname-select (type)
  "Popup byname-select. "
  (setf (text (get-elem-by-id "byname-select-title"))
        (getui (list :byname type)))
  (setf (text (get-elem-by-id "byname-select-message"))
        (getui (list :click :to :choose :byname type)))

  ;; Fill the Byname List
  (let ((list (get-elem-by-id "byname-select-list")))
    (setf (inner-html list) "")
    (map NIL (lambda (byname)
               (let ((tag (create-elem "li" byname)))
                 (add-event (tag "click")
                   (setf (text (get-elem-by-id (if (eq type :adj)
                                                   "byname-adj"
                                                   "byname-noun")))
                         byname)
                   (hide-elem (get-elem-by-id "mask"))
                   (hide-elem (get-elem-by-id "byname-select")))
                 (call list (:append-child tag))))
         (aref (gethash *language* *byname*)
               (if (eq type :adj) 0 1))))
  (show-widget "byname-select"))

;; Query Name:

(defun query-name ()
  "Like `query' but popup `query-name' widget.

The input name will be checked and goes to `query-name-message'
while input, if fails, will goes like color red. "
  (setf (text (get-elem-by-id "query-name-title")) (getui :usage))
  (let ((input   (get-elem-by-id "query-name-input"))
        (message (get-elem-by-id "query-name-message"))
        (keybd   (get-elem-by-id "query-name-kbd"))
        (confirm (get-elem-by-id "query-name-confirm"))
        (cancel  (get-elem-by-id "query-name-cancel")))
    (setf (inner-html message)      "↓↓↓")
    (setf (attr input :value)       "")
    (setf (attr input :placeholder) (getui :name))
    (setf (text confirm) (getui :confirm))
    (setf (text keybd)   (getui :keyboard))
    (setf (text cancel)  (getui :cancel)))
  (toggle-keyboards "query-name-keyboard" "query-name-kbd" T)
  (show-widget "query-name"))

;; Define Rule:

(defparameter *define-rule-stack* ()
  "Store currently editing char. ")

(defun define-rule (char &optional rule)
  "Popup define-rule widget for `char'. "
  (let ((input   (get-elem-by-id "defrule-input"))
        (from    (get-elem-by-id "defrule-from"))
        (to      (get-elem-by-id "defrule-to"))
        (kbd     (get-elem-by-id "defrule-kbd"))
        (confirm (get-elem-by-id "defrule-confirm"))
        (cancel  (get-elem-by-id "defrule-cancel")))
    (multiple-value-bind (res err) (iiiika:ikasu-char char)
      ;; save calling stack
      (unless (endp *define-rule-stack*)
        ;; if current `*define-rule-stack*' is not empty,
        ;; push current rule into `*define-rule-stack*'.
        (let ((prev (first (pop *define-rule-stack*))))
          (push (list prev (attr input :value)) *define-rule-stack*)))
      (push (list char (if err (or rule "") res)) *define-rule-stack*)

      ;; init calling frame
      (setf (text from)               (format NIL "~C" char))
      (cond (err
             (setf (inner-html to)     "ロ")
             (setf (attr input :value) (or rule "")))
            (T
             (setf (inner-html to)     res)
             (setf (attr input :value) (or rule res)))))

    ;; update-ikasu
    (update-ikasu "defrule-input" "defrule-to"
                  :fallback "ロ"
                  :editable T
                  :tooltip  T)

    ;; normal cleanup
    (setf (attr input :placeholder) (getui (list :input char :rule)))
    (setf (text confirm)            (getui :confirm))
    (setf (text kbd)                (getui :keyboard))
    (setf (text cancel)             (getui :cancel)))
  ;; by default show keyboard
  (toggle-keyboards "defrule-keyboard" "defrule-kbd" T)
  (show-widget "defrule"))

(defun close-define-rule (&optional (abort NIL))
  "Try to close define-rule widget.
If `*define-rule-stack*' is empty, close;
or if not empty, show new. "
  (if abort
      (setf *define-rule-stack* ())
      (pop *define-rule-stack*))
  (hide-widget "defrule")
  (unless (endp *define-rule-stack*)
    (apply #'define-rule (pop *define-rule-stack*)))
  (when (endp *define-rule-stack*)
    (hide-widget "defrule")))

;; Utils

(defun show-utils ()
  "Popup utils widgets. "
  (setf (text (get-elem-by-id "utils-about")) (getui :about-msg))
  (setf (text (get-elem-by-id "utils-dump"))  (getui '(:dump :rule)))
  (setf (text (get-elem-by-id "utils-load"))  (getui '(:load :rule)))
  (setf (text (get-elem-by-id "utils-repo"))  (getui '("Github" :repo)))
  (setf (text (get-elem-by-id "utils-close")) (getui :cancel))
  (show-widget "utils"))

;;; ========================== Main ==========================

(defun main ()
  "Binds all the events to front-end UI. "
  ;;; ==================== Banner Widget ====================
  ;; Name:
  ;; click name -> popup query-name widget
  (add-event ((get-elem-by-id "name") "click") (query-name))

  ;; Byname:
  ;; click byname        -> change randomly
  ;; double click byname -> select byname adj/noun
  ;; when init, sets byname randomly
  (flet ((update-adj  (&optional event)
           (if (and event (= (attr event :detail) 2))
               (byname-select :adj)
               (setf (text (get-elem-by-id "byname-adj"))  (get-byname-adj))))
         (update-noun (&optional event)
           (if (and event (= (attr event :detail) 2))
               (byname-select :noun)
               (setf (text (get-elem-by-id "byname-noun")) (get-byname-noun)))))
    (add-event-listener (get-elem-by-id "byname-adj")  "click" #'update-adj)
    (add-event-listener (get-elem-by-id "byname-noun") "click" #'update-noun)
    (update-adj)
    (update-noun))

  ;; Badge:
  ;; TODO: not done yet
  (flet ((sorry (event) (alert (getui '(:sorry :badge :*-is-working)))))
    (add-event-listener (get-elem-by-id "badge-1") "click" #'sorry)
    (add-event-listener (get-elem-by-id "badge-2") "click" #'sorry)
    (add-event-listener (get-elem-by-id "badge-3") "click" #'sorry))

  ;; Banner Background:
  ;; TODO: change randomly or selectable...

  ;;; ==================== ByName Select Widget ====================
  ;; Byname Select Cancel Button:
  ;; click to close Byname widget
  (add-event ((get-elem-by-id "byname-select-cancel") "click")
    (hide-widget "byname-select"))

  (add-event ((get-elem-by-id "byname-select-add") "click")
    (alert (getui '(:sorry :load :byname :*-is-working))))

  ;;; ==================== Query Name Widget ====================
  ;; Toggle Keyboard Button:
  ;; click -> toggle keyboard display
  (add-event ((get-elem-by-id "query-name-kbd") "click")
    (toggle-keyboards "query-name-keyboard" "query-name-kbd"))

  ;; Close query-name widget
  (add-event ((get-elem-by-id "query-name-cancel") "click")
    (toggle-keyboards "query-name-keyboard" "query-name-kbd" T)
    (hide-widget "query-name"))

  ;; Click query-name confirm
  (add-event ((get-elem-by-id "query-name-confirm") "click")
    (update-ikasu "query-name-input" "name"
                  :fallback "CLICK ME"
                  :editable NIL
                  :tooltip  T)
    (toggle-keyboards "query-name-keyboard" "query-name-kbd" T)
    (hide-widget "query-name"))

  ;; Preview and check `query-name-message'
  (add-event ((get-elem-by-id "query-name-input") "input")
    (update-ikasu "query-name-input" "query-name-message"
                  :fallback "..."
                  :editable T
                  :tooltip  T))

  ;;; ================== Define Rule Widget ===================
  ;; Toggle Keyboard Button
  ;; click -> toggle keyboard display
  (add-event ((get-elem-by-id "defrule-kbd") "click")
    (toggle-keyboards "defrule-keyboard" "defrule-kbd"))

  ;; Cancel Defrule
  (add-event ((get-elem-by-id "defrule-cancel") "click")
    (close-define-rule))

  ;; Confirm Defrule
  (add-event ((get-elem-by-id "defrule-confirm") "click")
    (update-rule (aref (text (get-elem-by-id "defrule-from")) 0)
                 (text (get-elem-by-id "defrule-to")))
    (update-ikasu "query-name-input" "query-name-message"
                  :fallback "..."
                  :editable T
                  :tooltip  T)
    (close-define-rule))

  (add-event ((get-elem-by-id "defrule-input") "input")
    (update-ikasu "defrule-input" "defrule-to"
                  :fallback "ロ"
                  :editable T
                  :tooltip  T))

  ;;; ====================== Alert Popup ======================
  ;; Popup Alert Window
  ;; alert-button: click -> close alert window
  (add-event ((get-elem-by-id "alert-button") "click")
    (hide-widget "alert"))

  ;;; ====================== Utils ======================
  ;; Popup Utils Window
  ;; iiiika: click -> open
  (add-event ((get-elem-by-id "iiiika") "click")
    (show-utils))

  ;; utils-close: click -> close utils
  (add-event ((get-elem-by-id "utils-close") "click")
    (hide-widget "utils"))

  (flet ((sorry (event) (alert (getui '(:sorry :badge :*-is-working)))))
    (add-event-listener (get-elem-by-id "utils-title") "click" #'sorry)
    (add-event-listener (get-elem-by-id "utils-load") "click" #'sorry)
    (add-event-listener (get-elem-by-id "utils-repo") "click" #'sorry))

  ;;; Query name keyboard
  (create-keyboards "query-name-sets"  "query-name-kbd-container"
                    "query-name-input" "query-name-message")
  (create-keyboards "defrule-sets"     "defrule-kbd-container"
                    "defrule-input"    "defrule-to")
  )

(main)

;;; main.lisp ends here
