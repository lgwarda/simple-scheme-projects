;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex-053-lauching-rocket) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; Constans:

(define HEIGHT 300) ; distances in pixels 
(define WIDTH  100)
(define YDELTA 3)
 
(define BACKG  (empty-scene WIDTH HEIGHT))
(define ROCKET (rectangle 5 30 "solid" "red"))
(define ROCKET-X (/ WIDTH 2)) 
(define CENTER (/ (image-height ROCKET) 2))

(place-image ROCKET ROCKET-X HEIGHT BACKG)
(place-image ROCKET ROCKET-X (- HEIGHT CENTER) BACKG)

(place-image ROCKET ROCKET-X 100 BACKG)

(place-image ROCKET ROCKET-X 0 BACKG)
(place-image ROCKET ROCKET-X (+ 0 CENTER) BACKG)