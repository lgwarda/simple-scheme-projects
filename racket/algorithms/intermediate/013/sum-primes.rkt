#lang racket


(define (sum-primes n)
  (apply + (filter prime? (range 2 (add1 n)))))

; Number -> Boolean
; > prime? 15
; #f
; > prime? 17
; #t
(define (prime? n)
  (define (f n c)
    (cond [(< n (* c c)) #t]
          [(zero? (modulo n c)) #f]
          [else (f n (add1 c))]))
  ;in
  (f n 2))
  













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
  "sum-primes tests" 
  (test-equal? "should return a number 2" (sum-primes 2) 2)
  (test-equal? "should return a number 10" (sum-primes 10) 17)
  (test-equal? "should return a number 73156" (sum-primes 977) 73156))))