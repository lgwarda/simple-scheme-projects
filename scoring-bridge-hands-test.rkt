#lang simply-scheme

(require "scoring-bridge-hands.rkt")



;                                
;                                
;                                
;  ;;;;; ;;;;;   ;;; ;;;;;   ;;; 
;  ; ; ;  ;  ;  ;  ; ; ; ;  ;  ; 
;    ;    ; ;   ;      ;    ;    
;    ;    ;;;    ;;    ;     ;;  
;    ;    ; ;      ;   ;       ; 
;    ;    ;   ; ;  ;   ;    ;  ; 
;   ;;;  ;;;;;; ;;;   ;;;   ;;;  
;                                
;                                
;                                


(module+ test
  (require rackunit rackunit/text-ui)

  (define suite
    (test-suite
     "scoring bridge hands tests"

     (test-equal? "returns 0" (card-val 's7) 0)
     (test-equal? "returns 1" (card-val 'dj) 1)
     (test-equal? "returns 2" (card-val 'cq) 2)
     (test-equal? "returns 3" (card-val 'sk) 3)
     (test-equal? "returns 4" (card-val 'ha) 4)
     
     
     
     (test-equal? "returns 9" (high-card-points '(sa s10 hq ck c4)) 9)
     (test-equal? "returns 13" (high-card-points '(sa s10 s7 s6 s2 hq hj h9 ck c4 dk d9 d3)) 13)
     

     (test-equal? "returns 2" (count-suit 's '(sa s10 hq ck c4)) 2) 
     (test-equal? "returns 2" (count-suit 'c '(sa s10 s7 s6 s2 hq hj h9 ck c4 dk d9 d3)) 2)
     (test-equal? "returns 5" (count-suit 'd '(h3 d7 sk s3 c10 dq d8 s9 s4 d10 c7 d4 s2)) 5)

     (test-equal? "returns '(2 1 2 0)" (suit-counts '(sa s10 hq ck c4)) '(2 1 2 0))
     (test-equal? "returns '(5 3 2 3)" (suit-counts '(sa s10 s7 s6 s2 hq hj h9 ck c4 dk d9 d3))
                  '(5 3 2 3))
     (test-equal? "returns '(5 1 2 5)" (suit-counts '(h3 d7 sk s3 c10 dq d8 s9 s4 d10 c7 d4 s2))
                  '(5 1 2 5))
     (test-equal? "returns 1" (suit-dist-points 2) 1)
     (test-equal? "returns 2" (suit-dist-points 1) 2)
     (test-equal? "returns 3" (suit-dist-points 0) 3)
     (test-equal? "returns 0" (suit-dist-points 7) 0)
     ))

  (run-tests suite))

