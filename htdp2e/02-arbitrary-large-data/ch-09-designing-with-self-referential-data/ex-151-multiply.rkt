;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex-151-multiply) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp")) #f)))
; multiply: N Number -> Number
; computes (* n x) without using *
(check-expect (multiply 0 0) 0)
(check-expect (multiply 0 1) 0)
(check-expect (multiply 2 1) 2)
(check-expect (multiply 2 2) 4) 
(check-expect (multiply 3 4) (+ 4 4 4)) 

(define (multiply n x)
  (cond [(zero? n) 0]
        [else (+ (multiply (sub1 n) x) x)]))

(multiply 3 2)
; == 6
(cond [(zero? 3) 0]
      [else (+ (multiply (sub1 3) 2) 2)])
; == 6
(cond [#f 0]
      [else (+ (multiply (sub1 3) 2) 2)])
; == 6
(cond  [else (+ (multiply (sub1 3) 2) 2)])
; == 6
(+ (multiply 2 2) 2)
; == 6
(+ (cond [(zero? 2) 0]
         [else (+ (multiply (sub1 2) 2) 2)])
   2)
; == 6
(+ (cond [#f 0]
         [else (+ (multiply (sub1 2) 2) 2)])
   2)
; == 6
(+ (cond 
     [else (+ (multiply (sub1 2) 2) 2)])
   2)
; == 6
(+ (cond 
     [else (+ (multiply (sub1 2) 2) 2)])
   2)
; == 6
(+ (+ (multiply (sub1 2) 2) 2) 2)
; == 6
(+ (+ (multiply 1 2) 2) 2)
; == 6
(+ (+ (cond
        [(zero? 1) 0]
        [else (+ (multiply (sub1 1) 2) 2)])
      2)
   2)
; == 6
(+ (+ (cond
        [#f 0]
        [else (+ (multiply (sub1 1) 2) 2)])
      2)
   2)
; == 6
(+ (+ (cond
        [else (+ (multiply (sub1 1) 2) 2)])
      2)
   2)
; == 6
(+ (+ (+ (multiply (sub1 1) 2) 2) 2) 2)
; == 6
(+
 (+
  (+
   (cond
       [#t 0]
       [else (+ (multiply (sub1 0) 2) 2)])
     2)
   2)
 2)
; == 6
(+ (+ (+ 0 2) 2) 2)
; == 6
(+ (+ 2 2) 2)
; == 6
(+ 4 2)
; == 6
6