#lang racket

(require (planet dyoo/simply-scheme))
(provide (all-defined-out))

;;Begin Project 1
(require "adjectives.rkt") 

;;Below is some procedures to help you out. Dont worry about what it says or does.
;;Questions are below.

(define (want-exit? line)
  (or (member? 'exit line) (member? 'quit line) (member? 'bye line)))

(define (print-sentence sent)
  (for-each (lambda (x) (display x) (display " "))
            sent)
  (newline))

(define (interact bot)
  (define (helper)
    (display "> ") (flush-output)
    (let ([line (read-line)])
      (unless (want-exit? line)
        (print-sentence (bot line))
        (helper))))
  (read-line)
  (helper))

(define (chatter bot1 bot2 start iterations)
  (define (helper b1 b2 sent i)
    (when (< i iterations)
          (display "bot ") (display (add1 (remainder i 2))) (display ": ")
          (let ((out (b1 sent)))
            (print-sentence out)
            (helper b2 b1 out (add1 i)))))
  (display "start: ") (print-sentence start)
  (helper bot1 bot2 start 0))

;;; Checks if a given word is an adjective or not
;;; Requires adjectives.scm to be loaded beforehand
(define adjective?
  (let ((hash (make-hash)))
    (for-each (lambda (adj)
		(hash-set! hash adj #t))
	      adjectives)
    (lambda (wd) (hash-ref hash wd #f))))


;; Begin Questions:
;;Q1 - babybot
  (define (babybot sent) sent)

;;Q2 - stupidbot-creator
  (define (stupidbot-creator motto)
   (lambda (x) motto))

;;Q3 - matcherbot-creator
  (define (matcherbot-creator pattern)
    (lambda (sent) (cond
                     [(empty? sent) '()]
                     [(empty? pattern) sent]
                     [(match? pattern sent) (follows-the-pattern pattern sent)] 
                     [else #f])))
;                                                     
;                                                     
;                                                     
;                                                     
;   ;;             ;;                                 
;    ;              ;                                 
;    ;              ;                                 
;    ;              ;                                 
;    ; ;;    ;;;    ; ;; ;;;;   ;;;   ;; ;;  ;;;   ;  
;    ;;  ;  ;   ;   ;  ;;   ;; ;   ;   ;;   ;  ;   ;  
;    ;   ;  ;;;;;   ;  ;     ; ;;;;;   ;    ;         
;    ;   ;  ;       ;  ;     ; ;       ;     ;;       
;    ;   ;  ;       ;  ;     ; ;       ;    ;  ;      
;    ;   ;  ;;  ;   ;  ;    ;  ;;  ;   ;    ;  ;   ;  
;   ;;; ;;;  ;;;;  ;;; ;;;;;    ;;;;  ;;;   ;;;;   ;  
;                      ;                              
;                      ;                              
;                     ;;;                             
;                                                     

(define (match? a b)
  (cond [(equal? a (index-before b (count a))) #t]
        [(equal? (count a) (count b)) (equal? a b)]
        [else (match? a (bf b))]))

 (define (follows-the-pattern pattern sent)
    (cond [(equal? pattern (index-before sent (count pattern))) (index-after sent (count pattern))]
          [(equal? (count pattern) (count sent)) (equal? pattern sent)]
          [else (follows-the-pattern pattern (bf sent))]))

; Sentence Number -> Sentence
; produce a sentence contains elements before the given num inclusive>
; > (index-before '(a b c d) 2)
; '(a b)
(define (index-before sent num)
    (cond [(zero? num )'()]
          [else (se (first sent)
                    (index-before (bf sent) (- num 1)))]))

; Sentence Number -> Sentence
; produce a sentence contains only element after the given num inclusive
; > (index-after '(a b c d) 2)
; '(c d)

(define (index-after sent num)
    (cond [(zero? num) sent]
          [else (index-after (bf sent) (- num 1))]))

;;Q4 - substitutebot-creator
  (define (substitutebot-creator from to)
    (lambda (sent) (substitute from to sent)))
;                                                     
;                                                     
;                                                     
;                                                     
;   ;;             ;;                                 
;    ;              ;                                 
;    ;              ;                                 
;    ;              ;                                 
;    ; ;;    ;;;    ; ;; ;;;;   ;;;   ;; ;;  ;;;   ;  
;    ;;  ;  ;   ;   ;  ;;   ;; ;   ;   ;;   ;  ;   ;  
;    ;   ;  ;;;;;   ;  ;     ; ;;;;;   ;    ;         
;    ;   ;  ;       ;  ;     ; ;       ;     ;;       
;    ;   ;  ;       ;  ;     ; ;       ;    ;  ;      
;    ;   ;  ;;  ;   ;  ;    ;  ;;  ;   ;    ;  ;   ;  
;   ;;; ;;;  ;;;;  ;;; ;;;;;    ;;;;  ;;;   ;;;;   ;  
;                      ;                              
;                      ;                              
;                     ;;;                             
; 


  (define (substitute from to sent)
    (cond [(empty? sent) '()]
          [else (if (member? (first sent) from)
                    (se (correspond from to (first sent)) 
                        (substitute from to (bf sent)))
                    (se (first sent) (substitute from to (bf sent))))]))

  (define (correspond from to sub)
    (cond [(empty? from) '()]
          [else (if (equal? (first from) sub)
                    (first to)
                    (correspond (bf from) (bf to) sub))]))

;;Q5 - switcherbot
 (define (switcherbot sent)
   (let ([viewpoint
          (substitute 
           '(me I am was my yours you you are were your mine) 
           '(you you are were your mine me I am was my yours)
           sent)]) 
      (cond [(equal? 'me (first viewpoint)) (se 'I (bf viewpoint))]
            [else (se viewpoint)])))


;;Q6 - inquisitivebot
 (define (inquisitivebot sent)
  (if (empty? sent)
      '()
      (se (switcherbot sent) '?)))

;;Q7 - eliza
  (define (eliza sent)
    ;;insert your answer here
    (error "not yet implemented")
  )

;;Q8 - reactorbot-creator
  (define (reactorbot-creator bot pat out)
    ;;insert your answer here
    (error "not yet implemented")
  )

;;Q9 - replacerbot-creator
  (define (replacerbot-creator bot pat before after)
    ;;insert your answer here
    (error "not yet implemented")
  )

;;Q10 - exagerate
  (define (exaggerate bot n)
    ;;insert your answer here
    (error "not yet implemented")
  )

;;REMEMBER TO ADD YOUR OWN TESTS TO GRADER.RKT!
;;END OF PROJECT 1
