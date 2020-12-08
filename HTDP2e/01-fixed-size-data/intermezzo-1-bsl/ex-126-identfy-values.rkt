;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex-126-identfy-values) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp")) #f)))
(define-struct point [x y z])
(define-struct none  [])
;1
(make-point 1 2 3)
; x == 1
; y == 2
; z == 3

;2
(make-point (make-point 1 2 3) 4 5)
; x == (make-point 1 2 3)
; y == 4
; z == 5

;3
(make-point (+ 1 2) 3 4)
; x == 3
; y == 3
; z == 4
;4
(make-none)
; (make-none)

;5
(make-point (point-x (make-point 1 2 3)) 4 5)
; x == 1 
; y == 4
; z == 5
