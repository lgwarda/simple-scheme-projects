#lang racket

(require berkeley)
(provide (all-defined-out))

; Exercise 1

; SICP 2.7 - Define upper-bound and lower-bound

(define (add-interval x y)
  (make-interval (+ (lower-bound x) (lower-bound y))
                 (+ (upper-bound x) (upper-bound y))))

(define (mul-interval x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
        (p2 (* (lower-bound x) (upper-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4))))

(define (make-interval a b) (cons a b))

(define (upper-bound interval)
  (max (car interval) (cdr interval)))

(define (lower-bound interval)
  (min (car interval) (cdr interval)))

; SICP 2.8 - Define sub-interval

(define (sub-interval x y) 
   (make-interval (- (lower-bound x) (upper-bound y)) 
                  (- (upper-bound x) (lower-bound y)))) 

; SICP 2.10 - Modify div-interval

(define (div-interval x y) 
   (if (<= 0 (* (lower-bound y) (upper-bound y))) 
       (error "Division error (interval spans 0)" y) 
       (mul-interval x  
                     (make-interval (/ 1. (upper-bound y)) 
                                    (/ 1. (lower-bound y)))))) 


;SICP 2.12 - Define make-center-percent and percent

(define (make-center-width c w)
  (make-interval (- c w) (+ c w)))
(define (center i)
  (/ (+ (lower-bound i) (upper-bound i)) 2))
(define (width i)
  (/ (- (upper-bound i) (lower-bound i)) 2))

(define (make-center-percent c tol) 
  (let ([width (* c (/ tol 100.0))]) 
    (make-interval (- c width) (+ c width))))

(define (percent i) 
   (let ([center (/ (+ (upper-bound i) (lower-bound i)) 2.0)]
         [width (/ (- (upper-bound i) (lower-bound i)) 2.0)]) 
     (* (/ width center) 100)))


; SICP 2.17 - Define last-pair

(define (last-pair lst)
  (cons (list-ref lst (sub1 (length lst))) '()))

; SICP 2.20 - Define same-parity

(define (same-parity . args)
 (if (even? (car args))
     (filter even? args)
     (filter odd? args)))

; SICP 2.22 - Write your explanation in the comment block:

#|
Your explanation here
|#

; Exercise 2 - Define my-substitute

(define (substitute lst old new)
  (define (inner elm)
  (cond [(empty? elm) '()]
        [(equal? old elm) new]
        [else (if (list? elm)
                  (cons (inner (car elm))
                        (inner (cdr elm)))
                  elm)]))
  (inner lst))

; Exercise 3 - Define my-substitute2

(define (substitute2 lst old new)
  (define (inner elm)
    (cond [(empty? elm) '()]
          [(list? elm) (cons (inner (car elm)) (inner (cdr elm)))]
          [(member? elm old) (replace elm old new)]
          [else (word elm)]))
  (inner lst))

(define (replace wd lst1 lst2)
    (cond [(equal? wd (car lst1)) (car lst2)]
          [else (replace wd (cdr lst1) (cdr lst2))]))
