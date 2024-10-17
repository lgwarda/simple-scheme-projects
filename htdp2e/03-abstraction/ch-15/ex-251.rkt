;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname ex-251) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define (fold1 fn base l)
  (cond
    [(empty? l) base]
    [else
     (fn base (first l)
        (fold1 fn base (rest l)))]))

; [List-of Number] -> Number
; computes the sum of 
; the numbers on l
(check-expect (sum '()) 0)
(check-expect (sum (list 1 2 3)) 6)
(define (sum l)
  (fold1 + 0 l))

; [List-of Number] -> Number
; computes the product of 
; the numbers on l
(check-expect (product '()) 1)
(check-expect (product (list 1 2 3)) 6)
(define (product l)
  (fold1 * 1 l))

