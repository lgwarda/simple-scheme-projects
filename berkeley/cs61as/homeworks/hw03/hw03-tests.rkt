#lang racket

(require racket/sandbox)

(provide (all-defined-out))

(define (create-tests e questions)
   (define all-names '())
   (define-syntax-rule
    (define/test name code ...)
    (when (or (null? questions) (member (symbol->string 'name) questions))
      (set! all-names (append all-names (list (symbol->string 'name))))
      (e
       '(define name
          (test-suite
           (symbol->string 'name)
           (test-case (symbol->string 'name) code ...))))
      (e '(hash-set! test-map (symbol->string 'name) name))))
  (define/test
    describe-time-tests
    (define (sent-equal? x y)
      (define (item-equal? a b)
        (if (and (number? a) (number? b))
            (< (abs (- a b)) 0.0001)
            (equal? a b)))
      (andmap item-equal? x y))
    (check sent-equal? (describe-time 0) '(0 SECONDS))
    (check sent-equal? (describe-time 120) '(2 MINUTES 0 SECONDS))
    (check sent-equal? (describe-time 7200) '(2 HOURS 0 SECONDS))
    (check sent-equal? (describe-time 22222) '(6 HOURS 10 MINUTES 22 SECONDS))
    (check sent-equal? (describe-time 345600) '(4 DAYS 0 SECONDS))
    (check sent-equal? (describe-time 550441) '(6 DAYS 8 HOURS 54 MINUTES 1 SECONDS)))
   (define/test
     remove-once-tests
     (check-equal? (remove-once 'morning '())
                   '())
     (check-equal? (remove-once 'evening '(good morining good morning))
                   '(good morining good morning))
     (check-equal? (remove-once 'good '(good morning good morning))
                   '(morning good morning))
     (check-equal? (remove-once 'morning '(good morning good morning))
                   '(good good morning)))
    
   (define/test
    differences-tests
     (check-equal? (differences '(4 23 9 87 6 12)) '(19 -14 78 -81 6)))
   
   (define/test
    location-tests
    (check-equal? (location 'me '(you never give me your money)) 4)
    (check-equal? (location 'i '(you never give me your money)) #f)
    (check-equal? (location 'the '(the fork and the spoon)) 1))
    
   (define/test
     initials-tests
     (check-equal? (initials '()) '())
     (check-equal? (initials '(if i needed someone)) '(i i n s))
     (check-equal? (initials '(u s a)) '(u s a))
     (check-equal? (initials '(she loves you)) '(s l y)))

  
    
   (define/test
     copies-tests
     (check-equal? (copies 0 'spam) '())
     (check-equal? (copies 8 'spam) '(spam spam spam spam spam spam spam spam)))
     
    
    
    
   (define/test
     gpa-tests
     (check-= (gpa '(F)) 0 0.01)
     (check-= (gpa '(A B A B))  3.5 0.01)
     (check-= (gpa '(A A+ B+ B)) 3.665 0.01))
    
    
    
   (define/test
    repeat-words-tests
     (check-equal? (repeat-words '(4 calling birds 3 french hens))
                   '(calling calling calling calling birds french french french hens))
     (check-equal? (repeat-words '(the 7 samurai))
                   '(the samurai samurai samurai samurai samurai samurai samurai)))
    
   (define/test
    same-shape-tests
     (check-equal? (same-shape? '(the fool on the hill)'(you like me too much)) #t)
     (check-equal? (same-shape?  '(the fool on the hill)'(and your bird can sing)) #f))

   all-names)
