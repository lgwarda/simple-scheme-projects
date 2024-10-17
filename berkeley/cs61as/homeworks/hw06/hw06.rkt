#lang racket

(require berkeley)
(provide (all-defined-out))

; Exercise 1 - Define fast-expt-iter

(define (fast-expt-iter b n)
  (define (iter a b n)
    (cond [(zero? n) a]
          [else (if (even? n)
                    (iter a (square b) (/ n 2))
                    (iter (* a b) b (- n 1)))]))
  (iter 1 b n))

; Exericse 2 - Define phi

(define (phi)
  (fixed-point (lambda (x) (+ 1 (/ 1 x))) 0.1))

(define tolerance 0.00001)

(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try next))))
  (try first-guess))

; Exercise 3 - Define cont-frac

;; Recursive version
(define (cont-frac n d k)
  (define (recursiv i)
    (cond [(> i k) 0]
          [else (/ (n i) (+ (d i) (recursiv (+ i 1.0))))]))
  (recursiv 1))



;; Iterative version
(define (cont-frac-iter n d k)
  (define (iter result i)
    (cond [(zero? i) result]
          [else (iter (/ (n 1) (+ (d i) result)) (sub1 i))]))
  (iter k 0))


(define (e k)
  (+ (cont-frac (lambda (i) 1.0) euler k) 2))

(define (euler i)
  (if (zero? (remainder (+ i 1) 3))
      (- i (quotient i 3))
      1))


; Exercise 4 - Define next-perf

(define (next-perf n)
  (define (iter k)
    (cond [(equal? (sum-of-factors k) k) k]
          [else (iter (add1 k))]))
  (iter n))

(define (sum-of-factors n)
  (define (find-factor divisor)
    (cond [(zero? n) 1]
          [(= divisor n) 0]
          [else (if (zero? (remainder n divisor))
                    (+ divisor (find-factor (add1 divisor)))
                    (find-factor (add1 divisor)))]))
  (find-factor 1))

; Exercise 5 - Explain what happens when the base cases are interchanged.

#|

Your explanation here

|#

; Exercise 6 - Give a formula relating b, n, counter and product in expt-iter.

#|

Formula for expt:

Formula for expt-iter:

|#
