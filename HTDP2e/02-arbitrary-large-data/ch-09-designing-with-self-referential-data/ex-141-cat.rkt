;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex-141-cat) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; List-of-string -> String
; concatenates all strings in l into one long string
 
(check-expect (cat '()) "")
(check-expect (cat (cons "a" (cons "b" '()))) "ab")
(check-expect (cat (cons "ab" (cons "cd" (cons "ef" '())))) "abcdef")
 
(define (cat l)
  (cond
    [(empty? l) ""]
    [else (string-append (first l)
                         (cat (rest l)))]))

; l                 (first l)    (rest l)          (cat (rest l))     (cat l)
; ==============================================================================
(cons                                                             
 "a"
 (cons 
  "b" '()))        "a"         (list "b")         "b"               "ab"

(cons
 "ab"
 (cons
  "cd"
  (cons
   "ef" '())))     "ab"       (list "cd" "ed" )   "cded"            "abcdf"


(cat (cons "a" '())) 
; == "a"
(cat (list "a"))
; == "a"
(cond
  [(empty? (list "a")) ""]
  [else (string-append (first (list "a"))
                       (cat (rest (list "a"))))])
; == "a"
(cond
  [#false ""]
  [else (string-append (first (list "a"))
                       (cat (rest (list "a"))))])
; == a
(cond
  [else (string-append (first (list "a"))
                       (cat (rest (list "a"))))])
; == "a"
(string-append (first (list "a"))
               (cat (rest (list "a"))))
; == "a"
(string-append "a"
               (cat (rest (list "a"))))
; == "a"
(string-append "a" (cat '()))
; == "a"
(string-append "a" (cat '()))
; == "a"
(string-append "a"
               (cond
                 [(empty? '()) ""]
                 [else (string-append (first '())
                                      (cat (rest '())))]))
; == "a"
(string-append "a"
               (cond
                 [#true ""]
                 [else (string-append (first '())
                                      (cat (rest '())))]))
; == "a"
(string-append "a" "")
; == "a"
"a"

