#lang racket

(require berkeley)
(provide (all-defined-out))

; Exercise 1 - Define substitute

(define (substitute sent old-word new-word)
  (cond [(empty? sent) '()]
        [else (if (equal? (first sent) old-word)
                  (se new-word (substitute (bf sent) old-word new-word))
                  (se (first sent) (substitute (bf sent) old-word new-word)))]))


; Exercise 2 - Try out the expressions!

#|
(lambda (x) (+ x 3))
-> returns: a procedure

((lambda (x) (+ x 3)) 7)
-> returns: 10

(define (make-adder num)
  (lambda (x) (+ x num))) 
((make-adder 3) 7)
-> returns: 10

(define plus3 (make-adder 3)) 
(plus3 7)
-> returns: 10

(define (square x) (* x x)) 
(square 5)
-> returns: 25

(define square (lambda (x) (* x x))) 
(square 5)
-> returns: 25

(define (try f) (f 3 5)) 
(try +)
-> returns: 8

(try word)
-> returns: 35
|#


; Exercise 3
#|

Number of arguments g has: zero arguments

Type of value returned by g: a procedure

|#

; Exercise 4 - Define f1, f2, f3, f4, and f5

(define f1 1)                                     ; 1
(define (f2) 2)                                   ; 2 
(define (f3 x) 3)                                 ; 3      
(define (f4) (lambda () 4 ))                      ; 4
(define (f5) (lambda () (lambda (x) (+ x 2))))    ; 5

; Exercise 5 - Try out the expressions

(define (t f) 
  (lambda (x) (f (f (f x)))) )

#|
1. ((t add1) 0) returns: 3

2. ((t (t add1)) 0) returns: 9

3. (((t t) add1) 0) returns: 27

|#

; Exercise 6 - Try out the expressions

(define (s x)
  (+ 1 x))

#|

1. ((t s) 0) returns: 3

2. ((t (t s)) 0) returns: 9

3. (((t t) s) 0) returns: 27

|#

; Exercise 7 - Define make-tester

(define (make-tester wd)
  (lambda (x) (equal? x wd)))

(define sicp-author-and-astronomer? (make-tester 'gerry))

; Exercise 8 - SICP exercises

; SICP 1.31a

(define (product term a next b)
  (cond [(> a b) 1] 
        [else (* (term a)
                 (product term (next a) next b))]))

(define (factorial n)
  (product identity 1 next n))

(define (identity x) x)

(define (next x) (+ x 1))

(define (estimate-pi)
 (* (product pi-term 1 next 100) 4.0))

;computes approximations to pi using john wallis' formula
(define (pi-term n) 
   (if (even? n) 
       (/ (+ n 2) (+ n 1)) 
       (/ (+ n 1) (+ n 2)))) 

; SICP 1.32a

;; This is called my-accumulate so it doesn't conflict with Simply
;; Scheme's accumulate.
(define (my-accumulate combiner null-value term a next b)
  (cond [(> a b) null-value]
        [else (combiner (term a)
                        (my-accumulate combiner null-value term (next a) next b))]))

;; Write sum in terms of my-accumulate:
(define (sum-accum term a next b)
  (my-accumulate + 0 a next b))

;; Write product in terms of my-accumulate:
(define (product-accum term a next b)
  (my-accumulate * 1 a next b))



; SICP 1.33

(define (filtered-accumulate combiner null-value term a next b pred)
  (cond [(> a b) null-value]
        [else (combiner 
               (if (pred a)
                   (term a)
                   null-value) 
               (filtered-accumulate combiner null-value term (next a) next b pred))]))

(define (sum-sq-prime a b)
(filtered-accumulate + 0 square a next b prime?))

(define (rel-prime? x y)
  (= (gcd x y) 1))

(define (prod-of-some-numbers n)
  (define (filtred x)
    (rel-prime? x n))
 (filtered-accumulate * 1 identity 1 next n filtred))

; SICP 1.40 - Define cubic

(define (cubic a b c)
  (define (cube x) (* x x x))
  (lambda (x)
    (+ (cube x)
       (* a (square x))
       (* b x)
       c)))

; SICP 1.41 - Define double

(define (double proc)
  (lambda (x) (proc (proc x))))

; SICP 1.43 - Define repeated

(define (my-repeated proc n)
 (if (< n 1) 
     (lambda (x) x) 
     (compose proc (my-repeated proc (- n 1)))))
#;
(define (compose f g)
  (lambda (x) (f (g x))))

; Exercise 9 - Define my-every

(define (my-every proc sent)
  (if (empty? sent)
      '()
      (se (proc (first sent))
          (my-every proc (bf sent)))))

; Exercise 10 - Try out the expressions

#|

(every (lambda (letter) (word letter letter)) 'purple)
-> returns: a sentece of two letter words == '(pp uu rr pp ll ee)

(every (lambda (number) (if (even? number) (word number number) number))
       '(781 5 76 909 24))
-> returns: a sentence of numbers; procedure repeats a number,
            if the number is even == '(781 5 7676 909 2424)

(keep even? '(781 5 76 909 24))
-> returns: a sentence of even numbers == '(76 24)

(keep (lambda (letter) (member? letter 'aeiou)) 'bookkeeper)
-> returns:

(keep (lambda (letter) (member? letter 'aeiou)) 'syzygy)
-> returns: a word containing only vowels === 'ooeee

(keep (lambda (letter) (member? letter 'aeiou)) '(purple syzygy))
-> returns: an error, member? expects a letter as an argument, but gets a word

(keep (lambda (wd) (member? 'e wd)) '(purple syzygy))
-> returns:  a sentence of words that containing a ltetter 'e == '(purple) 
|#

