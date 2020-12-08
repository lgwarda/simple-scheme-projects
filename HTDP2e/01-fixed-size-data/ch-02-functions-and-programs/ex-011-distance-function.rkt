;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex-011-distance-function) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; distance-to-the-point: Number Number -> Number
; produce the distance of point (x, y) to the orgine 
(check-expect (distance-to-the-point 3 4) 5)

(define (distance-to-the-point x y)
  (sqrt (+ (sqr x) (sqr y))))
  