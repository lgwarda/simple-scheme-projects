#lang racket

(require berkeley)
(provide (all-defined-out))

; Exercise 1 - Define dupls-removed

; Sentence -> Sentence 
(define (dupls-removed sent)
  (cond [(empty? sent) '()]
        [else (if (member? (first sent) (bf sent))
                  (dupls-removed (bf sent))
                  (se (first sent )(dupls-removed (bf sent))))]))

; Exercise 2 - Define count-word

(define (count-word sent wd)
  (cond [(empty? sent) 0]
        [else (if (equal? (first sent) wd)
                  (+ 1 (count-word (bf sent) wd))
                  (count-word (bf sent) wd))]))
; Exercise 3

(define (pigl wd)
  (if (pl-done? wd)
      (word wd 'ay)
      (pigl (word (bf wd) (first wd)))))

(define (pl-done? wd)
  (vowel? (first wd)))

(define (vowel? letter)
  (member? letter '(a e i o u)))

; Explain what would happen if you used new-if instead of if below.
#|


|#

; Exercise 4 - Define squares

(define (squares sent)
  (every sqr sent))

; Exercise 5 - Define switch

(define (switch sent)
  (if (equal? (first sent) 'you)
      (se 'I (bf (every replace sent)))
      (every replace  sent)))


(define (replace wd)
  (cond [(equal? wd 'I) 'you]
        [(equal? wd 'me)'you]
        [(equal? wd 'you) 'me]
        [else wd]))


; Exercise 6 - Define ordered?

(define (ordered? sent)
  (cond [(empty? (bf sent)) #t]
        [else (and (< (first sent) (first (butfirst sent)))
                   (ordered? (butfirst sent)))]))

; Exercise 7 - Define ends-e

(define (ends-e sent)
  (keep (lambda (wd) (equal? 'e (last wd))) sent))

; Exercise 8

#|

Your explanation here

|#
