;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex-051-traffic-light-simulation) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; Constans:

(define WIDTH 50)
(define HEIGHT 150)

(define SPACE (rectangle 50 5 "solid" "black"))

(define RON
  (overlay
   (above (circle 20 "solid" "red")
          SPACE
          (circle 20 "outline" "yellow")
          SPACE
          (circle 20 "outline" "green"))
   (rectangle WIDTH HEIGHT "solid" "black")))

(define GON
  (overlay
   (above (circle 20 "outline" "red")
          SPACE
          (circle 20 "outline" "yellow")
          SPACE
          (circle 20 "solid" "green"))
   (rectangle WIDTH HEIGHT "solid" "black")))

(define YON
  (overlay
   (above (circle 20 "outline" "red")
          SPACE
          (circle 20 "solid" "yellow")
          SPACE
          (circle 20 "outline" "green"))
   (rectangle WIDTH HEIGHT "solid" "black")))

; Data definition

; A TrafficLight is one of the following Strings:
; – "red"
; – "green"
; – "yellow"
; interp. the three strings represent the three 
; possible states that a traffic light may assume

; Functions:

; next-color: TrafficLight -> TrafficLight
; yields the next state given current state s
(check-expect (next-color "red") "green")
(check-expect (next-color "green") "yellow")
(check-expect (next-color "yellow") "red")

(define (next-color s)
  (cond
    [(string=? "red" s) "green"]
    [(string=? "green" s) "yellow"]
    [(string=? "yellow" s) "red"]))

; render-color: TrafficLight -> Image
; produce appropriate image for light color
(check-expect (render-color "green") GON)
(check-expect (render-color "yellow") YON)
(check-expect (render-color "red") RON)

(define (render-color s)
  (cond [(string=? "red" s) RON]
        [(string=? "green" s) GON]
        [(string=? "yellow" s) YON]))

; main: TrafficLight -> TraffincLight
; called to run the animation; start with (main "red")
; no tests for main function

(define (main tl)
  (big-bang tl
    (on-tick next-color 3)
    (to-draw render-color)))

(main "red")