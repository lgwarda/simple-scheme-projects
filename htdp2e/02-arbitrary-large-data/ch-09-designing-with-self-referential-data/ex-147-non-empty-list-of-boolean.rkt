;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex-147-non-empty-list-of-boolean) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))
; An NEList-of-booleans is one of: 
; – (cons Boolean '())
; – (cons Boolean NEList-of-boolean)
; interpretation non-empty lists of boolean values

(define LOB1 (cons #t '()))
(define LOB2 (cons #f (cons #t '())))
(define LOB3 (cons #t (cons #t (cons #t '()))))
(define LOB4 (cons #t (cons #t (cons #t (cons #f '())))))

; process-nelob: NEList-of-boolean
#;
(define (processs-nelob ne-l)
  (cond [(empty? (rest ne-l)) (... (first ne-l))]
        [else
          (... (first ne-l)
              (processs-nelob (rest ne-l)) ...)]))

; all-true: NELOB -> Boolean
; produce #t, if the given lob contains all #t boolean values
(check-expect (all-true? LOB1) #t)
(check-expect (all-true? (cons #f '())) #f)
(check-expect (all-true? LOB2) #f)
(check-expect (all-true? LOB3) #t)
(check-expect (all-true? LOB4) #f)

(define (all-true? ne-l)
  (cond
    [(empty? (rest ne-l)) (first ne-l)]
    [else
        (and  (first ne-l)
              (all-true? (rest ne-l)))]))

; one-true: NELOB -> Boolean
; produce true, if one item of least is #t
(check-expect (one-true? LOB1) #t)
(check-expect (one-true? (cons #f '())) #f)
(check-expect (one-true? LOB2) #t)
(check-expect (one-true? LOB3) #t)
(check-expect (one-true? LOB4) #t)
(check-expect (one-true? (cons #f '())) #f)

(define (one-true? ne-l)
  (cond
    [(empty? (rest ne-l)) (first ne-l)]
    [else
     (or  (first ne-l)
          (one-true? (rest ne-l)))]))