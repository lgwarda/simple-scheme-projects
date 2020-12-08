;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex-162-wage-exceeds) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp")) #f)))
(define HOURLY-RATE 14)
(define OVERTIME-LIMIT 100)
(define ERROR-MASSAGE "Error: item of the input list of wage* exceeds 100")
; List-of-numbers -> List-of-numbers
; computes the weekly wages for the weekly hours
(check-expect (wage* '()) '())
(check-expect (wage* (cons 28 '())) (cons 392 '()))
(check-expect (wage* (cons 4 (cons 2 '()))) (cons 56 (cons 28 '())))
(check-expect (wage* (cons 48 (cons 28 (cons 100 '())))) (cons 672 (cons 392 (cons 1400 '()))))
(check-error (wage* (cons 48 (cons 28 (cons 103 '())))))

(define (wage* whrs)
  (cond [(empty? whrs) '()]
        [else
         (if (exceed? (first whrs))
             (error ERROR-MASSAGE)
             (cons (wage (first whrs))
                   (wage* (rest whrs))))]))

; Number -> Number
; computes the wage for h hours of work
(define (wage h)
  (* HOURLY-RATE h))


; Number -> Boolean
; produce #t, if the # of whrs is greater then overtime limit 
(check-expect (exceed? 99) #f)
(check-expect (exceed? 101) #t)
(define (exceed? whrs)
  (< OVERTIME-LIMIT whrs))