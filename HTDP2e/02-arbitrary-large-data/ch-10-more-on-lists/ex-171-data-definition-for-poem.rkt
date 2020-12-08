;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex-171-data-definition-for-poem) (read-case-sensitive #t) (teachpacks ((lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; Data defineitions:

; A List-of-string is one of:
; - '()
; - (cons String List-of-string)

; A List-of-list-of-string is one of
; - '()
; - (cons List-of-string  List-of-list-of-string)
; interpretation a list of lines, each is a list of Strings

(read-lines "ttt.txt")
;(cons
; "  TTT"
; (cons
;  "  "
;  (cons
;   "  Put up in a place"
;   (cons
;    "  where it's easy to see"
;    (cons
;     "  the cryptic admonishment"
;     (cons
;      "  T.T.T"
;      '()))))))


(read-words "ttt.txt")
;(cons "TTT"
;      (cons "Put"
;            (cons "up"
;                  (cons "in"
;                        (cons "a"
;                              '())))))

(read-words/line "ttt.txt")
;(cons (cons "TTT" '())
;  (cons '()
;    (cons (cons "Put"
;            (cons "up"
;              (cons ... '())))
;      (cons ...
;        '()))))




 
