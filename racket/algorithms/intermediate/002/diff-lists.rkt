#lang racket

#|

 Compare two list and return a new list with any
 elemnts only found in one of the two given lists,
 but not both. In other words, return the symmetric
 difference of the two lists.

|#

; [List-of A] [List-of B] -> [List-of C]
; produce (A-B) U (B-A) 
(define (diff-lists l1 l2)
  (append  (remove* l1 l2) (remove* l2 l1)))












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

(diff-lists '(1 2 3 5) '(1 2 3 4 5)) ;should return a list with one elemnt '(4)
(diff-lists '("diorite" "andesite" "grass" "dirt" "pink wool" "dead shrub")
            '("diorite" "andesite" "grass" "dirt"  "dead shrub")) ;'("pink wool")

(diff-lists '() '("snuffleupagus" "cookie monster" "elmo"))
(diff-lists '(1 "calf" 3 "piglet") '(7 "filly"))
