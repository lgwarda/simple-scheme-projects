#lang racket

#|

Sum All Numbers in a Range

Return the sum of all the numbers between them.
The lowest number will not always come first.

For example, the input '(4 1) should return 10
because sum of all the numbers between 1 and 4 (both inclusive) is 10.

|#

(define (sum-all l)
  (apply + (range-of-numbers l)))

; List-of-Numbers -> List-of-Numbers
; produce the range of numbers between two numbres in the given list
; > '(4 1)
; '(4 3 2 1)
; > '(5 9)
; '(5 6 7 8 9)
(define (range-of-numbers l)
    (if (> (first l) (second l))
           (range (first l) (- (second l) 1) -1)
           (range (first l)  (+ (second l) 1))))












;                                   
;                                   
;                                   
;                                   
;                                   
;  ;;;;;;;;;                        
;  ;   ;   ;              ;         
;      ;                  ;         
;      ;      ;;;    ;;; ;;;;;  ;;; 
;      ;     ;   ;  ;  ;  ;    ;  ; 
;      ;     ;;;;;  ;     ;    ;    
;      ;     ;       ;;   ;     ;;  
;      ;     ;      ;  ;  ;    ;  ; 
;      ;     ;;  ;  ;  ;  ;    ;  ; 
;     ;;;     ;;;;  ;;;;  ;;;; ;;;; 
;                                   
;                                   
;                                   
;                                   

(module+ test
  (require rackunit rackunit/text-ui)

  (run-tests
   (test-suite "sum-all tests"
               (test-equal? "should return 10" (sum-all '(1 4)) 10)
               (test-equal? "should return 10" (sum-all '(4 1)) 10)
               (test-equal? "should return 45" (sum-all '(5 10)) 45)
               (test-equal? "should return 45" (sum-all '(10 5)) 45))))