;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname ex-257) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))
; [X] N [N -> X] -> [List-of X]
; build-l*st works just like build-list
(check-expect (build-l*st 4 add1) (build-list 4 add1))
(check-expect (build-l*st 10 sub1) (build-list 10 sub1))

(define (build-l*st n f)
  (cond [(zero? n) '()]
        [else (add-at-end (f (- n 1))
                          (build-l*st (- n 1) f))]))

; [X] X [List-of X] -> [List-of X]
(check-expect (add-at-end '() '()) (list '()))
(check-expect (add-at-end "a" '("c" "b")) '("c" "b" "a")) 
(check-expect (add-at-end  5 '(1 2 3 4)) '(1 2 3 4 5))
(define (add-at-end x l)
  (cond
   [(empty? l) (list x)]
   [else (cons (first l)
               (add-at-end x (rest l)))]))

