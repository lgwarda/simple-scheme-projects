;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex-236-tests-and-abstract-for-adds) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; Lon -> Lon
; adds 1 to each item on l
(check-expect (add1* '()) '())
(check-expect (add1*  (list 1)) (list 2))
(check-expect (add1*  (list  1 2)) (list 2 3))
(check-expect (add1*  (list  1 2 3)) (list 2 3 4))
(define (add1* l)
  (plus 1 l))
#;
(define (add1* l)
  (cond
    [(empty? l) '()]
    [else
     (cons
       (add1 (first l))
       (add1* (rest l)))]))


     
; Lon -> Lon
; adds 5 to each item on l
(check-expect (plus5 '()) '())
(check-expect (plus5  (list 1)) (list 6))
(check-expect (plus5  (list  1 2)) (list 6 7))
(check-expect (plus5  (list  0 4 5)) (list 5 9 10))

(define (plus5 l)
  (plus 5 l))

#;
(define (plus5 l)
  (cond
    [(empty? l) '()]
    [else
     (cons
       (+ (first l) 5)
       (plus5 (rest l)))]))

; Number Lon -> Lon
; adds the given # to each item on l
(define (plus num l)
  (cond [(empty? l) '()]
        [else (cons (+ num (first l))
                    (plus num (rest l)))]))


; Lon -> Lon
; subtracts 2 from each item on l
(check-expect (sub2 '()) '())
(check-expect (sub2 (list 3)) (list 1))
(check-expect (sub2 (list 0 1 2)) (list -2 -1 0))
(define (sub2 l)
  (cond [(empty? l)'()]
        [else (cons (- (first l) 2)
                    (sub2 (rest l)))]))