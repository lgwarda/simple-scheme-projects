;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex-097-sigs-render-aux-functions) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; Cosntans:

(define WIDTH 200)
(define HEIGHT 200)

(define BACKGROUND (empty-scene WIDTH HEIGHT "navy"))

(define TANK (rectangle 40 10 "solid" "silver"))
(define TANK-HEIGHT (image-height TANK))
(define TANK-CENTER (/ TANK-HEIGHT 2))
(define TANK-Y (- HEIGHT TANK-CENTER))  

(define UFO (overlay (circle 10 "solid" "green")
                     (rectangle 40 5 "solid" "green")))
(define UFO-HEIGHT (image-height UFO))
(define UFO-WIDTH (image-height UFO))

(define MISSILE (circle 3 "solid" "red"))
(define MISSILE-WIDTH (image-width MISSILE))
(define MISSILE-HEIGHT (image-height MISSILE))

(define T-SPEED 3)
(define U-SPEED 3)
(define M-SPEED (* U-SPEED 2))
(define JUMP 5) 

(define REACH 3)

(define GAME-OVER (text "GAME OVER" 24 "red"))

; Data definition:

(define-struct aim [ufo tank])
(define-struct fired [ufo tank missile])

; A UFO is a Posn. 
; interpretation (make-posn x y) is the UFO's location 
; (using the top-down, left-to-right convention)
 
(define-struct tank [loc vel])
; A Tank is a structure:
;   (make-tank Number Number). 
; interpretation (make-tank x dx) specifies the position:
; (x, HEIGHT) and the tank's speed: dx pixels/tick 
 
; A Missile is a Posn. 
; interpretation (make-posn x y) is the missile's place

; A SIGS is one of: 
; – (make-aim UFO Tank)
; – (make-fired UFO Tank Missile)
; interpretation represents the complete state of a 
; space invader game

; the tank maneuvering into position to fire the missile:
(define SI0 (make-aim (make-posn 20 10) (make-tank 28 -3)))

; just like the previous one but the missile has been fired:
(define SI1 (make-fired (make-posn 20 10)                  
                        (make-tank 28 -3)
                        (make-posn 28 (- HEIGHT TANK-HEIGHT))))

; the missile is about to collide with the UFO:
(define SI2 (make-fired (make-posn 20 100)
                        (make-tank 100 3)
                        (make-posn 22 103)))

; Functions:

; si-render: SIGS -> Image
; place TANK, UFO, and possibly MISSILE on the BACKGROUND 
(check-expect (si-render (make-aim (make-posn 20 10) (make-tank 28 -3)))
              (place-image TANK
                           28 TANK-Y
                           (place-image UFO
                                        20 10
                                        BACKGROUND)))
(check-expect (si-render (make-fired (make-posn 20 100)
                                     (make-tank 100 3)
                                     (make-posn 22 103)))
              (place-image TANK
                           100 TANK-Y
                           (place-image
                            UFO
                            20 100
                            (place-image MISSILE
                                         22 103
                                         BACKGROUND))))

(define (si-render s)
  (cond [(aim? s)
         (tank-render (aim-tank s)
                      (ufo-render (aim-ufo s)
                                  BACKGROUND))]
        [(fired? s)
         (tank-render (fired-tank s)
                      (ufo-render (fired-ufo s)
                                  (missile-render (fired-missile s)
                                                  BACKGROUND)))]))

; Tank Image -> Image 
; adds t to the given image img
(check-expect (tank-render (make-tank 28 -3) BACKGROUND)
              (place-image TANK
                           28 TANK-Y
                           BACKGROUND))

(define (tank-render t img)
  (place-image
   TANK
   (tank-loc t) TANK-Y
   img))
 
; UFO Image -> Image 
; adds u to the given image img
(check-expect (ufo-render (make-posn 20 10) BACKGROUND)
              (place-image
               UFO
               20 10
               BACKGROUND))

(define (ufo-render u img)
  (place-image
   UFO
   (posn-x u) (posn-y u)
   img))


; Missile Image -> Image 
; adds m to the given image img
(check-expect (missile-render (make-posn 32 (- HEIGHT TANK-HEIGHT 5)) BACKGROUND)
              (place-image
               MISSILE
               32 (- HEIGHT TANK-HEIGHT 5)
               BACKGROUND))

(define (missile-render m img)
  (place-image
   MISSILE
   (posn-x m) (posn-y m)
   img))


