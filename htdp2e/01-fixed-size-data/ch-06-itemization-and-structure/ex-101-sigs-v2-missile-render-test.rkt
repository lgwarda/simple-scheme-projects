;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex-101-sigs-v2-missile-render-test) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; Cosntans:

(define WIDTH 400)
(define HEIGHT 400)

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

(define REACH (+ (/ UFO-HEIGHT 2) (/ MISSILE-HEIGHT 2))) 

(define GAME-OVER (text "GAME OVER" 48 "red"))

; Data definitions:

(define-struct sigs [ufo tank missile])

; A UFO is a Posn
; interpretation (make-posn x y) is the UFO's location
; (using the top-down, left-to-right convention)
(define U0 (make-posn 10 200))
(define U2 (make-posn 20  10))
; fn-for-ufo : UFO -> ...
#;
(define (fn-for-ufo u)
  (... (... (posn-x u))
       (... (posn-y u))))

(define-struct tank [loc vel])
; A Tank is a structure:
;     (make-tank Number Number)
; interpretation (make-tank x dx) specifies the position:
; (x, HEIGHT) and the tank's speed: dx pixels/tick
(define T0 (make-tank 28 -3))
(define T1 (make-tank 100 3))
#;
(define (fn-for-tank t)
  (... (... (tank-loc))
       (... (tank-vel))))

; A Missile is a structure:
;   (make-posn Number Number)
; interpretation (make-posn x y) is the Missile's location
; (using the top-down, left-to-right convention)
(define M1 (make-posn 10 103))

; A SIGS.v2 (short for SIGS version 2) is a structure:
;   (make-sigs UFO Tank MissileOrNot)
; interpretation represents the complete state of a
; space invader game
(define SIGS1 (make-sigs (make-posn 100 120)
                        (make-tank 50 3)
                        #false))

(define SIGS2 (make-sigs (make-posn 100 120)
                          (make-tank 50 3)
                          (make-posn 20 150)))
 
; A MissileOrNot is one of: 
; – #false
; – Posn
; interpretation #false means the missile is in the tank;
; Posn says the missile is at that location
(define MNOT #false)
(define M2 (make-posn 32 (- HEIGHT TANK-Y 10)))

; fn-for-missile-or-not: MissileOrNoT -> ...
#;
(define (fn-for-missile-or-not mon)
  (cond [(boolean? mon) (...)]
        [(posn? mon) (...)]))

; fn-for-sigs.v2: SIGS.v2 -> ....
#;
(define (fn-for-sisgs.v2 sig)
  (... (fn-for-ufo (fierd-ufo s))
       (fn-for-tank (fierd-tank s))
       (fn-for-misssile-or-not (fired-missile s))))


; Functions:

; SIGS.v2 -> Image 
; renders the given game state on top of BACKGROUND 
#;
(define (si-render.v2 s)
  (tank-render
    (sigs-tank s)
    (ufo-render (sigs-ufo s)
                (missile-render.v2 (sigs-missile s)
                                   BACKGROUND))))

; MissileOrNot Image -> Image 
; adds an image of missile m to scene s
(check-expect (missile-render.v2 #f BACKGROUND)
              BACKGROUND)
(check-expect (missile-render.v2 (make-posn 32 (- HEIGHT TANK-Y 10)) BACKGROUND)
            (place-image MISSILE
                         32 (- HEIGHT TANK-Y 10)
                         BACKGROUND))

(define (missile-render.v2 m s)
  (cond
    [(boolean? m) s]
    [(posn? m) (place-image MISSILE (posn-x m) (posn-y m) s)]))

