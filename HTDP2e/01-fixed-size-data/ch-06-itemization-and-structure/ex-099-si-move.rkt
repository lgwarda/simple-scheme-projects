;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex-099-si-move) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
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

; si-move: SIGS -> SIGS
; move all the space-invader objects

(define (si-move s)
  (si-move-proper s (random 3)))

; si-move-proper: SIGS Number -> SIGS 
; moves the space-invader objects predictably by delta:
; 0 - sub1 from  U-SPEED
; 1 - move -1
; 2 - move  1
(check-expect (si-move-proper (make-aim (make-posn 10 20)
                                        (make-tank 50 0))
                              0)
              (make-aim (make-posn 10 (+ 20 (- U-SPEED JUMP)))
                        (make-tank 50 0)))

(check-expect (si-move-proper (make-aim (make-posn 10 20)
                                        (make-tank 50 3))
                              1)
              (make-aim (make-posn (- 10 JUMP) (+ 20 U-SPEED))
                        (make-tank 53 3)))
(check-expect (si-move-proper (make-aim (make-posn 10 20)
                                        (make-tank 50 3))
                              2)
              (make-aim (make-posn (+ 10 JUMP) (+ 20 U-SPEED))
                        (make-tank 53 3)))

(check-expect (si-move-proper (make-fired (make-posn 10 20)
                                          (make-tank 50 3)
                                          (make-posn 20 30))
                              0)
              (make-fired (make-posn 10 (+ 20 (- U-SPEED JUMP)))
                          (make-tank 53 3)
                          (make-posn 20 (- 30 M-SPEED))))


(define (si-move-proper s r)
  (cond [(aim? s)
         (make-aim (move-ufo (aim-ufo s) r)
                   (move-tank (aim-tank s)))]
        [(fired? s)
         (make-fired (move-ufo (fired-ufo s) r)
                     (move-tank (fired-tank s))
                     (move-missile (fired-missile s)))]))


; ufo-move: UFO Number-> UFO
; move the ufo u randomly:
; 0 - subtract JUMP from U-SPEED
; 1 - JUMP left (-) in x direction
; 2 - JUMP right (+) in x direction

(check-expect (move-ufo (make-posn 20 30) 0)
              (make-posn 20 (+ 30 (- U-SPEED JUMP))))
(check-expect (move-ufo (make-posn 20 30) 1)
              (make-posn (- 20 JUMP) (+ 30 U-SPEED)))
(check-expect (move-ufo (make-posn 20 30) 2)
              (make-posn (+ 20 JUMP) (+ 30 U-SPEED)))

(define (move-ufo u r)
  (cond [(= r 0) (make-posn (posn-x u) (+ (posn-y u) (- U-SPEED JUMP)))]
        [(= r 1) (make-posn (- (posn-x u) JUMP) (+ (posn-y u) U-SPEED))]
        [(= r 2) (make-posn (+ (posn-x u) JUMP) (+ (posn-y u) U-SPEED))]))

; tank-move: Tank -> Tank
; move the tank t by T-SPEED

(check-expect (move-tank (make-tank 58 -3))
              (make-tank 55 -3))
(check-expect (move-tank (make-tank 55 3))
              (make-tank 58 3))

(define (move-tank t)
  (make-tank (+ (tank-loc t) (tank-vel t))
             (tank-vel t)))

; missile-move: Missile -> Missile
; move the missile m by M-SPEED

(check-expect (move-missile (make-posn 58 TANK-HEIGHT))
              (make-posn 58 (- TANK-HEIGHT M-SPEED)))

(define (move-missile m)
  (make-posn (posn-x m)
             (- (posn-y m) M-SPEED)))
