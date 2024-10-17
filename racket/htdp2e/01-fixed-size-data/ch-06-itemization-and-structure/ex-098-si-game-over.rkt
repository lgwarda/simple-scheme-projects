;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex-098-si-game-over) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
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

; si-game-over?: SIGS -> Boolean
; produce #t, if the UFO lands or the missile shots down the UFO
(check-expect (si-game-over?    ; not landed, no missle
               (make-aim (make-posn 20 100)
                         (make-tank 10 3)))
              #false)

(check-expect (si-game-over?   ; landed, no missle
               (make-aim (make-posn 20 (- HEIGHT (/ UFO-HEIGHT 2)))
                         (make-tank 10 3)))
              #true)

(check-expect (si-game-over?   ; landed, not shot down
               (make-fired (make-posn 20 (- HEIGHT (/ UFO-HEIGHT 2)))
                           (make-tank 10 3) (make-posn 10 10)))
              #true)

(check-expect (si-game-over?   ; not landed, not shot down 
               (make-fired (make-posn 20 100)
                           (make-tank 10 3) (make-posn 10 10)))
              #false)

(check-expect (si-game-over?   ; not landed, shot down!
               (make-fired (make-posn 20 100)
                           (make-tank 10 3) (make-posn 20 100)))
              #true)

(define (si-game-over? s)
  (cond [(aim? s) (ufo-landed? (aim-ufo s))]
        [(fired? s)
         (or (ufo-landed? (fired-ufo s))
             (shot-down? (fired-ufo s)
                         (fired-missile s)))]))

; ufo-landed?: UFO -> Boolean
; produce #t, if UFO has landed
(check-expect (ufo-landed? (make-posn 20 100)) #f)
(check-expect (ufo-landed? (make-posn 20 (- HEIGHT (/ UFO-HEIGHT 2)))) #t)


(define (ufo-landed? u)
  (= (posn-y u) (- HEIGHT (/ UFO-HEIGHT 2))))

; shot-down?: UFO Missile -> Boolean
; produce #t, if the missile shot down the UFO
(check-expect (shot-down? (make-posn 20 (- HEIGHT (/ UFO-HEIGHT 2))) (make-posn 10 10)) #f)
(check-expect (shot-down? (make-posn 10 100) (make-posn 10 10)) #f)
(check-expect (shot-down? (make-posn 20 100) (make-posn 20 100)) #t)
(check-expect (shot-down? (make-posn 20 112) (make-posn 20 100)) #t)
(check-expect (shot-down? (make-posn 20  88) (make-posn 20 100)) #t)
(check-expect (shot-down? (make-posn 20  98) (make-posn 20 100)) #t)
(check-expect (shot-down? (make-posn 20 108) (make-posn 20 100)) #t)
(check-expect (shot-down? (make-posn 20 100) (make-posn 20 112)) #t)
(check-expect (shot-down? (make-posn 20 100) (make-posn 20  88)) #t)
(check-expect (shot-down? (make-posn 20 113) (make-posn 20 100)) #f)

(check-expect (shot-down? (make-posn 20 115) (make-posn 20 100)) #f)
(check-expect (shot-down? (make-posn 20  87) (make-posn 20 100)) #f)
(check-expect (shot-down? (make-posn 20 100) (make-posn 20 113)) #f)
(check-expect (shot-down? (make-posn 20 100) (make-posn 20  87)) #f)

(define (shot-down? u m)
  (and (< (abs (- (posn-x u) (posn-x m)))
          (+ (/ UFO-HEIGHT 2) (/ MISSILE-HEIGHT 2)))
       (< (abs (- (posn-y u) (posn-y m)))
          (+ (/ UFO-HEIGHT 2) (/ MISSILE-HEIGHT 2)))))

; si-render-final: SIGS -> Image
; produce GAME OVER,if the a missile shot down the UFO or UFO landed
(check-expect (si-render-final
               (make-aim (make-posn 20 10)
                         (make-tank 28 -3)))
              (overlay
               (text "GAME OVER" 24 "red") BACKGROUND))
(check-expect (si-render-final
               (make-fired (make-posn 20 100)
                           (make-tank 100 3)
                           (make-posn 22 103)))
              (overlay
               (text "GAME OVER" 24 "red") BACKGROUND))

(define (si-render-final s)
 (overlay (text "GAME OVER" 24 "red") BACKGROUND))





