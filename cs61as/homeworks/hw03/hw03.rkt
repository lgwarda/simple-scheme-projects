#lang racket

(require berkeley)

(provide (all-defined-out))

; Exercise 1 - Define describe-time
(define (describe-time x)
  (cond [(> (quotient x 86400) 0)
         (se (quotient x 86400) 'DAYS (describe-time (remainder x 86400)))]
        [(> (quotient x 3600)  0)
         (se (quotient x 3600) 'HOURS (describe-time (remainder x 3600)))]
        [(> (quotient x 60) 0)
         (se (quotient x 60) 'MINUTES (describe-time (remainder x 60)))]
        [else (se x 'SECONDS)]))

; Exercise 2 - Define remove-once
(define (remove-once wd sent)
  (cond [(empty? sent) '()]
        [else (if (equal? wd (first sent))
                          (bf sent)
                          (se (first sent) (remove-once wd (bf sent))))]))

; Exercise 3 - Define differences
(define (differences nums)
  (cond [(= (count nums) 1) '()]
        [else (se (- (first (bf nums)) (first nums))
                  (differences (bf nums)))]))

; Exercise 4 - Define location
(define (location small big)
  (helper small big 1))

(define (helper small big counter)
 (cond [(empty? big) #f]
       [else (if (equal? small  (first big))
                 counter
                 (helper small (bf big) (+ counter 1)))]))

; Exercise 5 - Define initials
(define (initials sent)
 (cond [(empty? sent) '()]
       [else (se (first (first sent)) (initials (bf sent)))]))

; Exercise 6 - Define copies
(define (copies num wd)
 (cond [(zero? num) '()]
       [else (se wd (copies (- num 1) wd))]))

; Exercise 7 - Define gpa
(define (gpa grades)
  (/ (gpa-helper grades)
     (count grades)))

(define (gpa-helper grades)
  (cond [(equal? (count grades) 1) (combine (first grades))]
        [else (+ (combine (first grades))
                 (gpa-helper (bf grades)))]))

(define (combine grade)
  (+ (base-grade grade)
     (grade-modifier grade)))

(define (base-grade grade)
  (cond [(equal? (first grade) 'A) 4.0]
        [(equal? (first grade) 'B) 3.0]
        [(equal? (first grade) 'C) 2.0]
        [(equal? (first grade) 'D) 1.0]
        [(equal? (first grade) 'F) 0.0]))

(define (grade-modifier grade)
  (cond [(equal? (last grade) '+)  0.33]
        [(equal? (last grade) '-) -0.33]
        [else 0]))
  
; Exercise 8 - Define repeat-words
(define (repeat-words sent)
    (cond [(empty? sent) '()]
          [else (if (number? (first sent))
                    (se (copies (first sent) (second sent))
                        (repeat-words (bf (bf sent))))
                    (se (first sent)
                        (repeat-words (bf sent))))]))

; Exercise 9 - Define same-shape?
(define (same-shape? sent1 sent2)
  (and (equal? (count sent1) (count sent2))
       (equal? (count-letters sent1)(count-letters sent2))))

(define (count-letters sent)
    (if (empty? sent)
        '()
        (se (count (first sent))
            (count-letters (bf sent)))))
