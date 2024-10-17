;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex-149-copier-q-and-a) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp")) #f)))
#|Exercise 149. Does copier function properly when you apply it
to a natural number and a Boolean or an image? Or do you have to
 design another function? Read Abstraction for an answer.|#

; An N is one of: 
; – 0
; – (add1 N)
; interpretation represents the counting numbers


; N String -> List-of-strings 
; creates a list of n copies of s
 
(check-expect (copier 0 "hello") '())
(check-expect (copier 2 "hello")
              (cons "hello" (cons "hello" '())))
(check-expect (copier 3 #t)
              (cons #t (cons #t (cons #t '()))))
(check-expect (copier 1 (square  10 "solid" "red"))
              (cons (square 10 "solid" "red") '()))
 
(define (copier n s)
  (cond
    [(zero? n) '()]
    [(positive? n) (cons s (copier (sub1 n) s))]))

;  The function copier doesn't care about the class of it's second argument, since
;  cons  doesn't care either. So it works fine for any class of data 

#;(define (copier.v2 n s)
  (cond
    [(zero? n) '()]
    [else (cons s (copier.v2 (sub1 n) s))]))

; How do copier and copier.v2 behave when you apply them to 0.1 and "x"? Explain.
; Use DrRacket’s stepper to confirm your explanation. 