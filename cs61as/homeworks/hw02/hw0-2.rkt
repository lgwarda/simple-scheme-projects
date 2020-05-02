#lang racket

(require berkeley)
(provide (all-defined-out))

; Exercise 0
; Write 5 expressions whose values are the number ten:
; 1. Atom
 10
; 2. Compound Expression (3 Atoms)
(+ 2 3 5)
; 3. Compound Expression (4 Atoms)
(+ 2.5 2.5 4 1)
; 4. Compound Expression (1 Atom and 2 subexpressions)
(- (* 10 2) (/ 30  3)  0)
; 5. Any Other Kind Expression
(+ 10)

; Exercise 1 
(define (second wd)
  (first (bf wd)))

; 1. Define first-two
(define (first-two wd)
 (word (first wd) (second wd)))

; 2. Define two-first
(define (two-first x y)
  (word (first x) (first y)))

; 3. Define two-first-sent
(define (two-first-sent sent)
  (word (first (first sent))
        (first (second sent))))

;Exercise 2 - Define teen?
(define (teen? num)
  (<= 13 num 19))

;Exercise 3 - Define indef-article
(define (indef-article wd)
  (if (member? (first wd) 'aeiou)
      (se 'an wd)
      (se 'a wd))) 

;Exercise 4 - Define insert-and
(define (insert-and sent)
  (se (bl sent) 'and (last sent)))

;Exercise 5 - Define query
(define (query sent)
  (se (second sent) (first sent)  (bl (bf (bf sent))) (word (last sent) '?)))

;Exercise 6 - Define european-time and american-time
(define (european-time time)
  (define AM (equal? (second time) 'am))
  (define PM (equal? (second time) 'pm))
  (define HOUR (first time))
  (cond
    [(and (= HOUR 12) AM)  0]
    [(and (= HOUR 12) PM) 12]
    [(and (< HOUR 12) AM) HOUR]
    [else (+ HOUR 12)]))
      
(define (american-time time)
  (cond
    [(= time  0) (se 12 'am)]
    [(= time 12) (se 12 'pm)]
    [(> time 12) (se (- time 12) 'pm)]
    [else (se time 'am)]))


;Exercise 7 - Define describe-time
(define (describe-time secs)
  (cond [(<= secs     60) (seconds secs)]
        [(< 60 secs 3600) (minutes secs)]
        [(<= 3600 secs (* 24 3600)) (hours secs)]
        [else (days secs)]))

(define (seconds s)
  (se s 'seconds))
(define (minutes s)
  (se (/ s 60.0) 'minutes))
(define (hours s)
  (se (/ s 3600.0) 'hours))
(define (days s)
  (se (/ s (* 24 3600.0)) 'days))

;Exercise 8 - Explain why superlative doesnt work:
(define (superlative adjective wd)
  (se (word adjective 'est) wd))

#|
We need to chage the name of formal parameter, since the name word 
is already taken over by the higher order procedure dubed word.
We can us  higher order procedur as  foraml parmeters too. 
|#
