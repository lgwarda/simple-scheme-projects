;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex-140-all-true?) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; A List-of-boolean is one of:
; - '()
; - (cons Boolean List-of-boolean)

(define LOB1 (cons #t '()))
(define LOB2 (cons #f (cons #t '())))
(define LOB3 (cons #t (cons #t (cons #t '()))))
(define LOB4 (cons #t (cons #t (cons #t (cons #f '())))))

; process-lob: LOB -> ...
#;
(define (fn-for-lob l)
  (cond [(empty? l) ...]
        [else
         (... (first l) ...
          ... (fn-for-lob (rest l)) ...)]))

; all-true: LOB -> Boolean
; produce #t, if the given lob contains all #t boolean values
(check-expect (all-true? LOB0) #t)
(check-expect (all-true? LOB1) #t)
(check-expect (all-true? LOB2) #f)
(check-expect (all-true? LOB3) #t)
(check-expect (all-true? LOB4) #f)

(define (all-true? l)
  (cond [(empty? l) #t]
        [else
         (and (first l)
               (all-true? (rest l)))]))


; one-true: LOB -> Boolean
; produce true, if one item of least is #t
(check-expect (one-true? LOB0) #f)
(check-expect (one-true? LOB1) #t)
(check-expect (one-true? LOB2) #t)
(check-expect (one-true? LOB3) #t)
(check-expect (one-true? LOB4) #t)
(check-expect (one-true? (cons #f '())) #f)


(define (one-true? l)
  (cond [(empty? l) #f]
        [else
         (or (first l)
               (one-true? (rest l)))]))

(cons #true '())

(cons #false '())

(cons #true (cons #false '()))