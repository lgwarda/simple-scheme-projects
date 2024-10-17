;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex-059-tl-fsa) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; constans

(define RAD 10)         
(define SPACE (/ RAD 2)) 
(define MTS (empty-scene (* RAD 8) (* RAD 3)))

; data definition:

; A TrafficLight is one of the following Strings:
; – "red"
; – "green"
; – "yellow"
; interpretation the three strings represent the three 
; possible states that a traffic light may assume

; functions:

; TrafficLight -> TrafficLight
; yields the next state, given current state cs
(check-expect (tl-next "red") "green")
(check-expect (tl-next "yellow") "red")
(check-expect (tl-next "green") "yellow")

(define (tl-next tl)
  (cond [(string=? tl "red") "green"]
        [(string=? tl "yellow") "red"]
        [(string=? tl "green") "yellow"]))
 
; TrafficLight -> Image
; renders the current state cs as an image
(check-expect (tl-render "red")
              (overlay
               (beside (circle RAD "solid" "red")
                       (square SPACE "outline" "white")
                       (circle RAD "outline" "yellow")
                       (square SPACE "outline" "white")
                       (circle RAD "outline" "green"))
               MTS))
(check-expect (tl-render "yellow")
              (overlay
               (beside (circle RAD "outline" "red")
                       (square SPACE "outline" "white")
                       (circle RAD "solid" "yellow")
                       (square SPACE "outline" "white")
                       (circle RAD "outline" "green"))
               MTS))
(check-expect (tl-render "green")
              (overlay
               (beside (circle RAD "outline" "red")
                       (square SPACE "outline" "white")
                       (circle RAD "outline" "yellow")
                       (square SPACE "outline" "white")
                       (circle RAD "solid" "green"))
               MTS))



(define (tl-render cs)
 (overlay
  (beside (bulb cs "red")
          (square SPACE "outline" "white")
          (bulb cs "yellow")
          (square SPACE "outline" "white")
          (bulb cs "green"))
  MTS))

; TrafficLight TrafficLight -> Image
; render the c colored bulb of the traffic light,
; when on is the current state
(check-expect (bulb "red" "red") (circle RAD "solid" "red"))
(check-expect (bulb "red" "yellow") (circle RAD "outline" "yellow"))

(define (bulb on c)
  (if (string=? on c)
      (circle RAD "solid" c)
      (circle RAD "outline" c)))

; TrafficLight -> TrafficLight
; simulates a clock-based American traffic light
; progrma starts w/ (traffic-light-simulation "red")
(define (traffic-light-simulation initial-state)
  (big-bang initial-state
    [to-draw tl-render]
    [on-tick tl-next 1]))

(traffic-light-simulation "red")
