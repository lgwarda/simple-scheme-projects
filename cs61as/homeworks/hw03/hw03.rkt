#lang racket

(require berkeley)

(provide (all-defined-out))

; Exercise 1 - Define describe-time
(define (describe-time x)
  (cond [(> (quotient x 86400) 0)
         (se (quotient x 86400) 'DAYS (describe-time (remainder x 86400)))]
        [(> (quotient x 3600)  0)
         (se (quotient x 3600) `HOURS (describe-time (remainder x 3600)))]
        [(> (quotient x 60) 0)
         (se (quotient x 60) `MINUTES (describe-time (remainder x 60)))]
        [else (se x `SECONDS)]))

; Exercise 2 - Define remove-once
(define (remove-once wd sent)
  (cond [(empty? sent) '()]
        [else (if (equal? wd (first sent))
                          (bf sent)
                          (se (first sent) (remove-once wd (bf sent))))]))

; Exercise 3 - Define differences
(define (differences nums)
  ;your code here
 (error "Not yet implemented")
)

; Exercise 4 - Define location
(define (location small big)
  ; your code here
 (error "Not yet implemented")
)

; Exercise 5 - Define initials
(define (initials sent)
  ; your code here
 (error "Not yet implemented")
)

; Exercise 6 - Define copies
(define (copies num wd)
  ; your code here
 (error "Not yet implemented")
)

; Exercise 7 - Define gpa
(define (gpa grades)
  ; your code here
 (error "Not yet implemented")
)

; Exercise 8 - Define repeat-words
(define (repeat-words sent)
  ; your code here
 (error "Not yet implemented")
)

; Exercise 9 - Define same-shape?
(define (same-shape? sent1 sent2)
  ; your code here
 (error "Not yet implemented")
)
