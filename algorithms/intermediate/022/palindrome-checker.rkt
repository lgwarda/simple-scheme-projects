#lang racket

#|

 Palindrome Checker :

 Produce true if the given string is a palindrome. Otherwise, return false.

 A palindrome is a word or sentence that's spelled the same way both forward and backward,
 ignoring punctuation, case, and spacing.

|#

(define (palindrome? s)
  (string=? (alphanumeric-str s) (reversed-str s)))

(define (alphanumeric-str s)
  (remove-non-alphanum (string-downcase s)))

(define (reversed-str s)
  (define lst (string->list (remove-non-alphanum (string-downcase s)))) 
  (list->string (reverse lst)))

(define (remove-non-alphanum s)
  (list->string (filter alphanum? (string->list s))))

(define (alphanum? c)
  (or (char-numeric? c)
      (char-alphabetic? c)))


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
 (test-suite "polindrome checker tests"
(test-equal? "Should return #t" (palindrome? "RaceCar") #t)
(test-equal? "Should return #t" (palindrome? "race car") #t)
(test-equal? "Should return #t" (palindrome? "2_A3*3a#2") #t)
(test-equal? "Should return #t" (palindrome? "2A3 3a2") #t)
(test-equal? "Should return #t" (palindrome? "_eye") #t)
(test-equal? "Should return #t" (palindrome? "A man, a plan, a canal. Panama") #t)
(test-equal? "Should return #t" (palindrome? "never odd or even") #t)
(test-equal? "Should return #t" (palindrome? "My age is 0, 0 si ega ym.") #t)
(test-equal? "Should return #t" (palindrome? "0_0 (:///\\\":) 0-0") #t)

(test-equal? "Should return #f" (palindrome? "five|/_\"|four") #f)
(test-equal? "Should return #f" (palindrome? "not a palindrome") #f)
(test-equal? "Should return #f" (palindrome? "nope!!") #f)
(test-equal? "Should return #f" (palindrome? "almostomla") #f)
(test-equal? "Should return #f" (palindrome? "1 eye for of 1 eye.") #f))))

