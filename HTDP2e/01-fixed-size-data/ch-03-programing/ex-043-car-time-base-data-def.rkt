;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex-043-car-time-base-data-def) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; Constans:

(define WIDTH-OF-WORLD 200)
(define HEIGHT-OF-WORLD 50)

(define tree
  (underlay/xy (circle 10 "solid" "green")
               9 15
               (rectangle 2 20 "solid" "brown")))
(define BACKGROUND
  (overlay tree
           (empty-scene WIDTH-OF-WORLD HEIGHT-OF-WORLD)))

(define Y-CAR (* HEIGHT-OF-WORLD 0.6))
 
(define WHEEL-RADIUS 5)
(define WHEEL-DISTANCE (* WHEEL-RADIUS 5))

(define WHEEL
  (circle WHEEL-RADIUS "solid" "black"))

(define SPACE
  (rectangle 10 WHEEL-RADIUS "solid" "white"))

(define BOTH-WHEELS
  (beside WHEEL SPACE WHEEL))
(define CAR-LENGTH (* 10 WHEEL-RADIUS))
(define CAR (above (overlay/align "middle" "bottom"
                                  (rectangle (* WHEEL-RADIUS 5)
                                             (* WHEEL-RADIUS 4)
                                             "solid" "red")
                                  (rectangle
                                   CAR-LENGTH
                                   (/ CAR-LENGTH 5)
                                   "solid" "red"))
                   BOTH-WHEELS))


; An AnimationState is a Number.
; interpretation the number of clock ticks 
; since the animation started


; AnimationState -> AnimationState 
; moves the car by 3 pixels for every clock tick
(check-expect (tock 20) 23)
(check-expect (tock 78) 81)
(define (tock as)
  (+ as 3))

; AnimationState -> Image
; places the car into the BACKGROUND scene,
; according to the given world state
(check-expect (render 50)  (place-image/align CAR  50 Y-CAR "right" "center" BACKGROUND))
(check-expect (render 100) (place-image/align CAR 100 Y-CAR "right" "center" BACKGROUND))
(check-expect (render 150) (place-image/align CAR 150 Y-CAR "right" "center" BACKGROUND))

(define (render as)
     (place-image/align CAR as Y-CAR "right" "center" BACKGROUND))

; AnimationState -> Boolean
; produce true (stop animation) if the car dissapear on the right edge
(check-expect (dissapear?   13) #f)
(check-expect (dissapear?  230) #t)

(define (dissapear? as)
  (<= 230 as))

; AnimationState -> WorldState
; launches the program from some initial state 
(define (main as)
  (big-bang as
    [on-tick tock]
    [to-draw render]
    [stop-when dissapear?]))

(main 1)
