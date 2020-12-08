;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex-186-sort-check-satisfied) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))
; A List-of-numbers is one of: 
; – '()
; – (cons Number List-of-numbers)

; List-of-numbers -> List-of-numbers 
; rearranges alon in descending order
 
(check-expect (sort> '()) '())
(check-expect (sort> (list 3 2 1)) (list 3 2 1))
(check-expect (sort> (list 1 2 3)) (list 3 2 1))
(check-expect (sort> (list 12 20 -5))
              (list 20 12 -5))

(define (sort> alon)
  (cond [(empty? alon) '()]
        [else
         (insert (first alon)
                (sort> (rest alon)))]))

; Number List-of-numbers -> List-of-numbers
; inserts n into the sorted list of numbers alon
(check-expect (insert 5 '()) (list 5))
(check-expect (insert 5 (list 6)) (list 6 5))
(check-expect (insert 5 (list 4)) (list 5 4))
(check-expect (insert 12 (list 20 -5))
              (list 20 12 -5))
(check-expect (insert 12 (list 20 13 10 -5))
              (list 20 13 12 10 -5))
(check-expect (insert 7 (list 6 5 4)) (list 7 6 5 4))
(check-expect (insert 0 (list 6 2 1 -1)) (list 6 2 1 0 -1))

(define (insert n alon)
  (cond
    [(empty? alon) (cons n '())]
    [else (if(>= n (first alon))
             (cons n alon)
             (cons (first alon)(insert n (rest alon))))]))

; List-of-number -> Boolean
; produce true, if the given list is arranged in descending order
(check-expect (sorted>? (list 1 2 3)) #f)
(check-expect (sorted>? (list 3 2 1)) #t)

(define (sorted>? n-alon)
  (cond [(empty? (rest n-alon)) #true]
        [else (and (> (first n-alon) (first (rest n-alon)))
                   (sorted>? (rest n-alon)))]))

; sorted>? process only non empty list of numbers
(check-satisfied (sort> (list 5)) sorted>?)
(check-satisfied (sort> (list 3 2 1)) sorted>?)
(check-satisfied (sort> (list 1 2 3)) sorted>?)
(check-satisfied (sort> (list 12 -5 20)) sorted>?)

; List-of-numbers -> List-of-numbers
; produces a sorted version of l
(define (sort>/bad l)
  (list 9 8 7 6 5 4 3 2 1 0))

; since sort>/bad returns a constant list, any other example beside
; given: (list 9 8 7 6 5 4 3 2 1 0) should fail.

; we can formulate the following function

; List-of-number -> Boolean
; produce #t if the given list is of the lenght 3
(define (length=3? l)
  (= (length l) 3))
(check-expect (length=3? (list 3 2 1))#t)
(check-expect (length=3? (list 5)) #f)
; and we will be sure that the sort>/bad result doesnt satisfy length=3?
; (check-satisfied (sort>/bad (list 3 2 1)) length=3?)



