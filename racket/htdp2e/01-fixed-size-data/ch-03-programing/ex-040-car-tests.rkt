;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex-040-car-tests) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; Constans:

(define WIDTH-OF-WORLD 200)
(define HEIGHT-OF-WORLD 50)
(define BACKGROUND
  (empty-scene WIDTH-OF-WORLD HEIGHT-OF-WORLD))

(define Y-CAR (/ HEIGHT-OF-WORLD 2))
 
(define WHEEL-RADIUS 5)
(define WHEEL-DISTANCE (* WHEEL-RADIUS 5))

(define WHEEL
  (circle WHEEL-RADIUS "solid" "black"))

(define SPACE
  (rectangle 10 WHEEL-RADIUS "solid" "white"))

(define BOTH-WHEELS
  (beside WHEEL SPACE WHEEL))

(define CAR (above (overlay/align "middle" "bottom"
                                  (rectangle (* WHEEL-RADIUS 5)
                                             (* WHEEL-RADIUS 4)
                                             "solid" "red")
                                  (rectangle
                                   (* WHEEL-RADIUS 10)
                                   (* WHEEL-RADIUS 2)
                                   "solid" "red"))
                   BOTH-WHEELS))


; A WorldState is a Number.
; interpretation the number of pixels between
; the left border of the scene and the car

; WorldState -> WorldState 
; moves the car by 3 pixels for every clock tick
(check-expect (tock 20) 23)
(check-expect (tock 78) 81)
(define (tock ws)
  (+ ws 3))

; WorldState -> Image
; places the car into the BACKGROUND scene,
; according to the given world state
(check-expect (render 50) (place-image CAR 50 Y-CAR BACKGROUND))
(check-expect (render 100) (place-image CAR 100 Y-CAR BACKGROUND))
(check-expect (render 150) (place-image CAR 150 Y-CAR BACKGROUND))

(define (render ws)
   (place-image CAR ws Y-CAR BACKGROUND))


; WorldState -> WorldState
; launches the program from some initial state 
(define (main ws)
  (big-bang ws
    [on-tick tock]
    [to-draw render]))