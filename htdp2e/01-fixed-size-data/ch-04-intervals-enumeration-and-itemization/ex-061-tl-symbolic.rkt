;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex-061-tl-symbolic) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; constans:
(define RED 0)
(define GREEN 1)
(define YELLOW 2)

; date definition:

; An S-TrafficLight is one of:
; – RED
; – GREEN
; – YELLOW

; S-TrafficLight -> S-TrafficLight
; yields the next state, given current state cs
     
(check-expect (tl-next-symbolic RED) GREEN)
(check-expect (tl-next-symbolic GREEN) YELLOW)
(check-expect (tl-next-symbolic YELLOW) RED)

(define (tl-next-symbolic cs)
  (cond
    [(equal? cs RED) GREEN]
    [(equal? cs GREEN) YELLOW]
    [(equal? cs YELLOW) RED]))

#|equal? can compare two of any values,
so a tl-next-symbolic will work if the constans are changed:
(define RED "red")
(define GREEN "green")
(define YELLOW "yellow")

; a S-TrafficLight shows one of three colors:
; - RED
; - ...|#
