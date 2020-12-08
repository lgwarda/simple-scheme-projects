;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex-012-cvolume) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; cvolume: Number -> Number
; produce volume of the cube 
(check-expect (cvolume 3) 27)

(define (cvolume a)
  (expt a 3))

; csurface: Number -> Number
; produce surface of the cube 
(check-expect (csurface 3) (* 6 (sqr 3)))

(define (csurface a)
  (* 6 (sqr a)))