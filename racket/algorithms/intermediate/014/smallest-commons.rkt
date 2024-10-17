#lang racket

#|
Smallest Common Multiple

Find the smallest common multiple of the provided parameters that can be evenly divided by both,
as well as by all sequential numbers in the range between these parameters.

The range will be a list of two numbers that will not necessarily be in numerical order.

For example, if given 1 and 3, find the smallest common multiple of both 1 and 3 that
is also evenly divisible by all numbers between 1 and 3. The answer here would be 6.
|#

; List-of-Numbers -> Number
; produce the least common multiple
; > (smallest-commons '(1 3))
; 6 since 

(define (smallest-commons l)
  (apply lcm (range (apply max l) (sub1 (apply min l)) -1)))



;                                        
;                                        
;                                        
;                                        
;                                        
;  ;;;;;;;;;                             
;  ;   ;   ;              ;              
;      ;                  ;              
;      ;      ;;;    ;;; ;;;;;  ;;;   ;  
;      ;     ;   ;  ;  ;  ;    ;  ;   ;  
;      ;     ;;;;;  ;     ;    ;         
;      ;     ;       ;;   ;     ;;       
;      ;     ;      ;  ;  ;    ;  ;      
;      ;     ;;  ;  ;  ;  ;    ;  ;   ;  
;     ;;;     ;;;;  ;;;;  ;;;; ;;;;   ;  
;                                        
;                                        
;                                        
;                                        




(module+ test
  (require rackunit rackunit/text-ui)
(run-tests
 (test-suite 
  "smallest-commons tests" 
  (test-equal? "should return a number 60" (smallest-commons '(1 5)) 60)
  (test-equal? "should return a number 2520" (smallest-commons '(2 10)) 2520)
  (test-equal? "should return a number 360360" (smallest-commons '(1 13)) 360360)
  (test-equal? "should return a number 6056820" (smallest-commons '(23 18)) 6056820))))





