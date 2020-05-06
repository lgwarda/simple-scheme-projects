#lang racket

#|Destroy

You will be provided with an initial array (the first argument in the destroyer function),
followed by one or more arguments. Remove all elements from the initial array that are of
the same value as these arguments.

|#

(define (seek-and-destroy lst lov)
  (remove* lov lst))








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
   (test-suite "seek-and-destroy tests"

               (test-equal? "should return an empty list"
                            (seek-and-destroy '() '(2 3))
                            '())
                (test-equal? "should return an empty list"
                             (seek-and-destroy '(2 3 2 3 ) '(2 3))
                            '())
                 (test-equal? "should return a list of two elements"
                              (seek-and-destroy '(1 2 3 1 2 3) '(2 3))
                            '(1 1))
                  (test-equal? "should return a list of two elements"
                               (seek-and-destroy
                                '(1 2 3 5) '(2 3))
                            '(1 5))
                   (test-equal? "should return a list of tree elemnts " (seek-and-destroy
                                                  '("possum"
                                                    "trollo"
                                                    12
                                                    "safari"
                                                    "hotdog"
                                                    92
                                                    65
                                                    "grandma"
                                                    "bugati"
                                                    "trojan"
                                                    "yacht")
                                                  '("yacht"
                                                    "possum"
                                                    "trollo"
                                                    "safari"
                                                    "hotdog"
                                                    "grandma"
                                                    "bugati"
                                                    "trojan"))
                            '(12 92 65))
                   (test-equal? "should return a list of one elemnt " (seek-and-destroy
                                                  '("tree" "hamburger" 53) '("tree" 53))
                                '("hamburger")))))
