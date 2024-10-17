#lang racket
(require berkeley)

;                                                                 
;                                                                 
;                                                                 
;                                                                 
;            ;;                                                   
;     ;;;;;   ;                                             ;;;;  
;    ;    ;   ;                      ;                     ;;   ; 
;   ;     ;   ;                      ;                     ;    ; 
;   ;         ; ;;    ;;;;  ;; ;;;; ;;;;;  ;;;   ;; ;;     ;    ; 
;   ;         ;;  ;  ;   ;   ;;   ;; ;    ;   ;   ;;        ;; ;  
;   ;         ;   ;      ;   ;     ; ;    ;;;;;   ;        ;; ; ;;
;   ;         ;   ;    ;;;   ;     ; ;    ;       ;        ;     ;
;   ;     ;   ;   ;  ;;  ;   ;     ; ;    ;       ;        ;     ;
;    ;    ;   ;   ;  ;   ;   ;    ;  ;    ;;  ;   ;        ;     ;
;     ;;;;;  ;;; ;;; ;;;;;;  ;;;;;   ;;;;  ;;;;  ;;;        ;;;;; 
;                            ;                                    
;                            ;                                    
;                           ;;;                                   
;                                                                 


;===========================================================================================
; 8.4

; >(choose-beatles ends-vowel?)
; (GEORGE RINGO)

;> (choose-beatles even-count?)
;(JOHN PAUL GEORGE)

(define beatels '(john paul george ringo))

(define (choose-beatles pred)
  (keep pred beatels))
 
;Word -> Boolean
(define (ends-vowel? wd)
  (vowel? (last wd)))

;Letter -> Boolean
(define (vowel? letter)
  (member? letter '(a e i o u)))
; Word -> Boolean
(define (even-count? wd)
  (even? (count wd)))

;===========================================================================================
; 8.5

#|
> (transform-beatles amazify)
(THE-AMAZING-JOHN THE-AMAZING-PAUL THE-AMAZING-GEORGE
 THE-AMAZING-RINGO)

> (transform-beatles butfirst)
(OHN AUL EORGE INGO)
|#

(define (transform-beatles fn)
  (every fn beatels))

(define (amazify name)
  (word 'the-amazing- name))

;============================================================================================
; 8.6

#|
> (words 'cab)
(CHARLIE ALPHA BRAVO)
|#


; Word -> Sentence
(define (words code)
  (every figure-name code))

(define (figure-name letter)
  (cond [(equal? letter 'a) 'alpha]
        [(equal? letter 'b) 'bravo]
        [(equal? letter 'c) 'charlie]
        [(equal? letter 'd) 'dunno]
        [(equal? letter 'e) 'ergo]
        [(equal? letter 'f) 'fun]
        [(equal? letter 'g) 'google]
        [(equal? letter 'h) 'hi]
        [else '()]))


;============================================================================================
; 8.7

#|
>(letter-count '(fixing a hole))
11
|#

(define (letter-count sent)
  (accumulate + (every count sent)))



;===========================================================================================
; 8.8

#|
> (exaggerate '(i ate 3 potstickers))
(I ATE 6 POTSTICKERS)

> (exaggerate '(the chow fun is good here))
(THE CHOW FUN IS GREAT HERE)
|#

(define (exaggerate sent)
  (every exaggerate-word sent))

(define (exaggerate-word wd)
  (cond [(number? wd) (* wd 2)]
        [(eq? wd 'good) 'greate]
        [(eq? wd 'bad) 'terible]
        [(eq? wd 'good) 'greate]
        [else wd]))

;==========================================================================================
; 8.9

#|
What procedure can you use as the first argument to every
so that for any sentence used as the second argument, every returns that sentence?

What procedure can you use as the first argument to keep
so that for any sentence used as the second argument, keep returns that sentence?

What procedure can you use as the first argument to accumulate
so that for any sentence used as the second argument, accumulate returns that sentence?
|#

(define same-sent '(the smae sentence))

(every word same-sent)

(keep word same-sent)

(accumulate se same-sent)

;====================================================================================
; 8.10

#|

> (true-for-all? even? '(2 4 6 8))
#T

> (true-for-all? even? '(2 6 3 4))
#F

|#

(define (true-for-all? pred sent)
 (equal? (keep even? sent) sent))


;====================================================================================
; 8.11
#|
> (gpa '(A A+ B+ B))
3.67
|#

(define (gpa grade)
  (define sum (accumulate + (every grade-modifier grade)))
  (define num (count grade))
  (string->number (real->decimal-string (/ sum num) 2)))

(define (grade-modifier g)
  (cond [(equal? (last g) '+) (+ (base-grade g) 0.33)]
        [(equal? (last g) '-) (- (base-grade g) 0.33)]
        [else (base-grade g)]))

(define (base-grade grade)
  (cond [(equal? (first grade) 'A) 4]
        [(equal? (first grade) 'B) 3]
        [(equal? (first grade) 'C) 2]
        [(equal? (first grade) 'D) 1]
        [(equal? (first grade) 'F) 0]))


;====================================================================================
; 8.12

#|
> (count-ums'(today um we are going to um talk about functional um programming))
3
|#

(define (count-ums sent)
  (count (filter um? sent)))

(define (um? wd)
  (equal? 'um wd))


;====================================================================================
; 8.13

#|
>(phone-unspell 'popcorn)
7672676
|#

; Word -> Number
(define (phone-unspell wd)
  (accumulate word (every phone-key-pad wd)))

; Letter -> Number
(define (phone-key-pad key)
  (cond [(member? key 'abc)  2]
        [(member? key 'def)  3]
        [(member? key 'ghi)  4]
        [(member? key 'jkl)  5]
        [(member? key 'mno)  6]
        [(member? key 'pqrs) 7]
        [(member? key 'tuv)  8]
        [(member? key 'wxyz) 9]))

;====================================================================================
; 8.14

#|
> (subword 'polythene 5 8)
THEN
|#

(define (subword wd start end)
  ((repeated bl (- (count wd) end))
   ((repeated bf (- (count wd) start)) wd)))

