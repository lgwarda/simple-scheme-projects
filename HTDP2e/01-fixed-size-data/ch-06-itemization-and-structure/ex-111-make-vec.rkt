;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex-111-make-vec) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp")) #f)))
(define MASSAGE#1 "make-vec: second parameter must be a positve number")
(define MASSAGE#2 "make-vec: second parameter must be a positve number")

(define-struct vec [x y])
; A vec is
;   (make-vec PositiveNumber PositiveNumber)
; interpretation represents a velocity vector
(define VEC1 (make-vec 1 2))
(define VEC2 (make-vec -1 2))


; checked-make-vec: PositiveNumber PositiveNumber -> Vec
; return positive number, if make-vec arguments are positive
; otherwise yields MASSAGE
(check-expect (checked-make-vec  1  2) (make-vec 1 2))
(check-expect (checked-make-vec -1  2) (error MASSAGE#1))
(check-expect (checked-make-vec  1 -2) (error MASSAGE#2))


(define (checked-make-vec n1 n2)
  (cond [(and (number? n1) (>= n1 0))
         (cond
           [(and (number? n2) (>= n2 0))
                (make-vec n1 n2)]
               [else
               (error MASSAGE#2)])]
         [else (error MASSAGE#1)]))