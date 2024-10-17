#lang racket

;; A line starting with a semicolon is a "comment".  You write
;; comments in order to explain in English what your code does, and
;; Racket knows to ignore comments since they aren't part of the
;; program.

;; This tells Racket that you want to use words and sentences (which
;; are disabled by default).
(require (planet dyoo/simply-scheme))

;; This tells Racket that it should "know" about all the functions you
;; define in this file.  (Don't worry about this for now.)
(provide (all-defined-out))

;; Exercise 0 - Introduce yourself

#|

This is a comment that spans multiple lines.

1) What is your name?

2) What is your major?

3) Are you a returning student? (i.e. Did you take 61AS last semester?)

4) What made you to take 61AS?

5) Tell us interesting things about yourself.

|#

;; Make a followup on the "Hello World!" post on Piazza introducing yourself.


;; Exercise 1 - Define sum-of-squares
(define (square x) (* x x))
;; Number Number -> Number
;; yieldsthe sum of the x and y
;; > (sum-of-squares 3 4)
;; 25
(define (sum-of-squares x y)
  (+ (square x) (square y)))  

;; Exercise 2a - Define can-drive
;; Natural -> Sentece 
;; if the given natural number is less then 16,
;; yields'(Not yet), otherwise '(Good to go)
(define (can-drive n)
  (if (< n 16)
      '(Not yet)
      '(Good to go)))


;; Exercise 2b - Define fizzbuzz
;; Number -> Word
;; yields 'fizzbuzz, if the n is divisible by 15 (both 5 and 3), 
;; 'buzz if it's divisible by 5,
;; 'buzz, if it's divisible by both,
;; otherwise the n itself
(define (fizzbuzz n)
  (cond [(zero? (modulo n 15)) 'fizzbuzz]
        [(zero? (modulo n 5)) 'buzz]
        [(zero? (modulo n 3)) 'fizz]       
        [else n]))

;; Exercise 3 - Why did the Walrus cross the Serengeti?

#|
Your answer here


|#

;; Exercise 4 - new-if vs if

#|
Your answer here

|#
