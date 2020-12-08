;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex-150-add-to-pi) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp")) #f)))
; add-to-pi: N -> Number
; computes (+ n pi) without using +

(check-within (add-to-pi 0) (+ 0 pi) 0.001)
(check-within (add-to-pi 3) (+ 3 pi) 0.001)

; since pi is inexct number, we use check-within  

(define (add-to-pi n)
  (cond [(zero? n) pi]
        [else (add1 (add-to-pi (sub1 n)))]))

; add: N Number -> Number
; computes (+ n x) without using +
(check-expect (add 0 0) 0) 
(check-expect (add 0 3) 3)  
(check-expect (add 3 3.14) 6.14) 
 
(define (add n x)
  (cond [(zero? n) x]
        [else (add1 (add (sub1 n) x))]))
