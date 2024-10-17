;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname ex-237-squared>?-evaluation) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; Lon Number -> Lon
; select those numbers on l
; that are below t
(define (small l t)
  (extract < l t))
#;
(define (small l t)
  (cond
    [(empty? l) '()]
    [else
     (cond
       [(< (first l) t)
        (cons (first l)
          (small
            (rest l) t))]
       [else
        (small
          (rest l) t)])]))
     
; Lon Number -> Lon
; select those numbers on l
; that are above t
(check-expect (large '() 5) '())
(check-expect (large '(5) 5) '())
(check-expect (large '(6) 5) '(6))
(check-expect (large '(4 3 6 7) 5) '(6 7))
(define (large l t)
  (extract > l t))
#;
(define (large l t)
  (cond
    [(empty? l) '()]
    [else
     (cond
       [(> (first l) t)
        (cons (first l)
          (large
            (rest l) t))]
       [else
        (large
          (rest l) t)])]))
(check-expect (extract < '() 5) (small '() 5))
(check-expect (extract < '(3) 5) (small '(3) 5))
(check-expect (extract < '(1 6 4) 5)
              (small '(1 6 4) 5))

(define (extract R l t)
  (cond
    [(empty? l) '()]
    [else (cond
            [(R (first l) t)
             (cons (first l)
                   (extract R (rest l) t))]
            [else
             (extract R (rest l) t)])]))

; Lon Number -> Lon
; select those numbers on l that are equal to t
; !!!
(define (equal l t)
  (extract = l t))

; Lon Number -> Lon
; select those numbers on l that are less than or equal to t
; !!!
(define (less-than-or-equal l t)
  (extract <= l t))

; Lon Number -> Lon
; select those numbers on l that are larger than or equal to t
(define (larger-than-or-equal l t)
  (extract >= l t))

; exercise 237
; Number Number -> Boolean
; is the area of a square with side x larger than c
(define (squared>? x c)
  (> (* x x) c))

(extract squared>? (list 3 4 5) 10) ;(list 4 5)

(squared>? 3 10)
(> (* 3 3) 10)  ;#f
(> 9 10)        ;#f
#f              ;#f

(squared>? 4 10) ;#t
(> (* 4 4) 10)   ;#t
(> 16 10)        ;#t
#t               ;#t

(squared>? 5 10) ;#t
(> (* 5 5) 10)   ;#t
(> 25 10)        ;#t
#t               ;#t

