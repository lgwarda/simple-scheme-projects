;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex-100-si-cntrol) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
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

; si-control: SIGS KeyEvent -> SIG
; if the left arrow pressed, tank moves left
; if the right arrow pressed, tank moves right
; if the space bar is pressed, shoot missel from a tank

(define (si-control sig ke)
  (cond [(key=? ke "left") (move-left sig)]
        [(key=? ke "right") (move-right sig)]
        [(key=? ke " ") (shoot-missile sig)]
        [else sig]))

; move-left: SIGS -> SIGS
; sub tank's velocity
(check-expect (move-left (make-aim (make-posn 10 50) (make-tank 30 3)))
              (make-aim (make-posn 10 50) (make-tank 30 -3)))
(check-expect (move-left (make-aim (make-posn 10 50) (make-tank 30 -3)))
              (make-aim (make-posn 10 50) (make-tank 30 -3)))

(check-expect (move-left (make-fired (make-posn 10 50)
                                     (make-tank 30 3)
                                     (make-posn 30 30)))
              (make-fired (make-posn 10 50)
                          (make-tank 30 -3)
                          (make-posn 30 30)))
(check-expect (move-left (make-fired (make-posn 10 50)
                                     (make-tank 30 -3)
                                     (make-posn 30 30)))
              (make-fired (make-posn 10 50)
                          (make-tank 30 -3)
                          (make-posn 30 30)))

(define (move-left s)
  (cond [(aim? s)
         (make-aim (aim-ufo s)
                   (turn-left (aim-tank s)))]
        [(fired? s)
         (make-fired (fired-ufo s)
                     (turn-left (fired-tank s))
                     (fired-missile s))]))

; turn-left: Tank -> Tank
; turn tank in left direction
(check-expect (turn-left (make-tank 30 -3))
              (make-tank 30 -3))
(check-expect (turn-left (make-tank 30 3))
              (make-tank 30 -3))

(define (turn-left t)
  (cond [(<= 0 (tank-vel t))
         (make-tank (tank-loc t) (- 0 (tank-vel t)))]
        [else t]))

; move-right:  SIGS -> SIGS
; add tank's velocity

(check-expect (move-right (make-aim (make-posn 10 50) (make-tank 30 3)))
              (make-aim (make-posn 10 50) (make-tank 30 3)))
(check-expect (move-right (make-aim (make-posn 10 50) (make-tank 30 -3)))
              (make-aim (make-posn 10 50) (make-tank 30 3)))

(check-expect (move-right (make-fired (make-posn 10 50)
                                      (make-tank 30 3)
                                      (make-posn 30 30)))
              (make-fired (make-posn 10 50)
                          (make-tank 30 3)
                          (make-posn 30 30)))
(check-expect (move-right (make-fired (make-posn 10 50)
                                      (make-tank 30 -3)
                                      (make-posn 30 30)))
              (make-fired (make-posn 10 50)
                          (make-tank 30 3)
                          (make-posn 30 30)))


(define (move-right s)
  (cond [(aim? s)
         (make-aim (aim-ufo s)
                   (turn-right (aim-tank s)))]
        [(fired? s)
         (make-fired (fired-ufo s)
                     (turn-right (fired-tank s))
                     (fired-missile s))]))
; turn-right: Tank -> Tank
; turn tank in the right direction 
(check-expect (turn-right (make-tank 30 -3))
              (make-tank 30 3))
(check-expect (turn-right (make-tank 30 3))
              (make-tank 30 3))

(define (turn-right t)
  (cond [(< (tank-vel t) 0)
         (make-tank (tank-loc t) (- 0 (tank-vel t)))]
        [else t]))

; shoot-missile: SIGS -> SIGS
; fire a missile
(check-expect (shoot-missile (make-aim (make-posn 25 30)
                                      (make-tank 20 3)))
              (make-fired (make-posn 25 30)
                          (make-tank 20 3)
                          (make-posn (+ 20 3) (- HEIGHT TANK-HEIGHT))))

(check-expect (shoot-missile (make-fired (make-posn 25 30)
                                        (make-tank 20 3)
                                        (make-posn 40 10)))
              (make-fired (make-posn 25 30)
                          (make-tank 20 3)
                          (make-posn (+ 20 3) (- HEIGHT TANK-HEIGHT))))


(define (shoot-missile s)
  (cond [(aim? s)
         (make-fired (aim-ufo s)
                     (aim-tank s)
                     (make-posn (+ (tank-loc (aim-tank s))
                                   (tank-vel (aim-tank s)))
                                (- HEIGHT TANK-HEIGHT)))]
        [(fired? s)
         (make-fired (fired-ufo s)
                     (fired-tank s)
                     (make-posn (+ (tank-loc (fired-tank s))
                                   (tank-vel (fired-tank s)))
                                (- HEIGHT TANK-HEIGHT)))]))