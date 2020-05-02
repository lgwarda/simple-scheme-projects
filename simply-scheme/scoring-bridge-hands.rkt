#lang simply-scheme

(provide card-val
         high-card-points
         count-suit
         suit-counts
         suit-dist-points
         hand-dist-points
         bridge-val)



;                                                                         
;                                                                         
;                                                                         
;  ;;;;; ;;;;; ;;;;;;;;    ;;;; ;;;;;     ;; ;;;   ;  ;;   ;;;;;;;    ;;; 
;   ;  ;  ;  ;  ;  ;  ;;  ;   ;  ;  ;      ;  ;   ;;   ;;   ; ;  ;;  ;  ; 
;   ;  ;  ;  ;  ;  ;   ; ;       ; ;       ;  ;   ;;   ; ;  ; ;   ;  ;    
;   ;;;   ;;;   ;  ;   ; ;   ;;; ;;;       ;;;;  ;  ;  ;  ; ; ;   ;   ;;  
;   ;  ;  ;  ;  ;  ;   ; ;    ;  ; ;       ;  ;  ;;;;  ;  ; ; ;   ;     ; 
;   ;  ;  ;  ;  ;  ;  ;;  ;   ;  ;   ;     ;  ;  ;  ;  ;   ;; ;  ;;  ;  ; 
;  ;;;;  ;;;  ;;;;;;;;;    ;;;; ;;;;;;    ;; ;;;;    ;;;;   ;;;;;;   ;;;  
;                                                                         
;                                                                         
;                                                                         
                                                                                                                   
                                                                                                
                                                                                                       
;; produce value of the given card
;; > (card-val 'cq)
;; 2
;; > (card-val 's7)
;; 0
(define (card-val card)
  (define rank (bf card))
  (cond [(equal? 'j rank) 1]
        [(equal? 'q rank) 2]
        [(equal? 'k rank) 3]
        [(equal? 'a rank) 4]
        [else 0]))



;; sum up the total number of points from high cards in the given hand.
;; > (high-card-points '(sa s10 hq ck c4))
;; 9
(define (high-card-points hand)
  (accumulate + (every card-val hand)))

;; produce the number of cards in the hand with the given suit.
;; > (count-suit 's '(sa s10 hq ck c4))
;; 2
(define (count-suit suit hand)
  (count (keep (λ (card) (equal? suit (first card))) hand)))

;;
;; produce the list containing the number of spades, hearts, clubs, diamonds in the hand.
;; > (suit-counts '(sa s10 hq ck c4))
;; (2 1 2 0)
(define (suit-counts hand)
  (every (λ (suit) (count-suit suit hand)) '(s h c d)))

;; produce the number of distribution points the given hand gets for having the number of cards in a particular suit.
;; > (suit-dist-points 2)
;; 1
;; > (suit-dist-points 7)
;; 0
;; > (suit-dist-points 0)
;; 3
(define (suit-dist-points number)
  (cond [(= number 2) 1]
        [(= number 1) 2]
        [(= number 0) 3]
        [else 0]))

;; produce the number of distribution points the hand is worth
;; > (hand-dist-points '(sa s10 s7 s6 s2 hq hj h9 ck c4 dk d9 d3))
;; 1
(define (hand-dist-points hand)
  (accumulate + (every suit-dist-points (suit-counts hand))))

;; produce the total number of points that the hand is worth.
;; > (bridge-val '(sa s10 s7 s6 s2 hq hj h9 ck c4 dk d9 d3))
;; 14
(define (bridge-val hand)
  (+ (high-card-points hand)
     (hand-dist-points hand)))



