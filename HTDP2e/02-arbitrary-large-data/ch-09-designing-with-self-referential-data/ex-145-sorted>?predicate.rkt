;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex-145-sorted>?predicate) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))
; An NEList-of-temperatures is one of: 
; – (cons CTemperature '())
; – (cons CTemperature NEList-of-temperatures)
; interpretation non-empty lists of Celsius temperatures 

;  NEList-of-temperatures -> ...
#;(define (process-nel ne-l)
  (cond
    [(empty? (rest ne-l)) ...]
    [else ...]))


; NEList-of-temperatures -> Boolean
; if the temperatures are sorted in descending order, return #t

; ne-l       (first ne-l)        (rest ne-l)            (sorted>?       (sorted>? 
;                                                        (rest ne-l))    ne-l)
;-------------------------------------------------------------------------------------
(cons
 1
 (cons
  2
  '()))          1               (cons 2 '())                 #t           #f
(cons
 3
 (cons
  2
  '()))          3               (cons 2 '())                 #t           #t
(cons
 0
 (cons
  3
  (cons 2
        '())))   0               (cons 3 (cons 2 '()))        #t           #f

(check-expect (sorted>? (cons 1 (cons 2 '()))) #f)
(check-expect (sorted>? (cons 3 (cons 2 '()))) #t)
(check-expect (sorted>? (cons 0 (cons 3 (cons 2 '())))) #f)

(define (sorted>? ne-l)
   (cond
    [(empty? (rest ne-l)) #t]
    [else
     (and (> (first ne-l) (first (rest ne-l)))
          (sorted>? (rest ne-l)))]))

(sorted>? (cons 3 (cons 2 '())))
