;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname picture-of-ufo-v0) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; constants 
(define WIDTH  200)
(define HEIGHT 300)
(define ROCK-HEIGHT 10)
(define ROCK-COLOR "brown")
(define ROCK (rectangle 60 ROCK-HEIGHT "solid" ROCK-COLOR))
(define MTSCN  (place-image/align
                ROCK
                50 300
                "center" "bottom"
                (empty-scene WIDTH HEIGHT "blue")))
(define UFO (overlay (circle 10 "solid" "green")
                     (rectangle 40 4 "solid" "green")))

(define UFO-CENTER-TO-TOP
  (- HEIGHT (+ ROCK-HEIGHT(/ (image-height UFO) 2))))
 
; functions
(define (picture-of-ufo.v0 h)
  (cond
    [(<= h UFO-CENTER-TO-TOP)
     (place-image UFO 50 h MTSCN)]
    [(> h UFO-CENTER-TO-TOP)
     (place-image UFO 50 UFO-CENTER-TO-TOP MTSCN)]))

(animate picture-of-ufo.v0)
