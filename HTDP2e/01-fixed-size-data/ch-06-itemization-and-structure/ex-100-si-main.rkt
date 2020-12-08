;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex-100-si-main) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
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
(define U-SPEED 6)
(define M-SPEED (* U-SPEED 2))
(define JUMP 5) 

(define REACH (+ (/ UFO-HEIGHT 2) (/ MISSILE-HEIGHT 2))) 

(define GAME-OVER (text "GAME OVER" 48 "red"))

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

; si-main: SIGS -SIGS
; start the game with
;(si-main (make-fired (make-posn  200 0)(make-tank 30 3)(make-posn 30 30)))
(define (si-main sig)
  (big-bang sig
    (on-tick si-move)
    (to-draw si-render)
    (stop-when si-game-over? si-render-final)
    (on-key si-control)))

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
  (>= (posn-y u) (- HEIGHT (/ UFO-HEIGHT 2))))

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
  (and (< (abs (- (posn-x u) (posn-x m))) REACH)
       (< (abs (- (posn-y u) (posn-y m))) REACH)))
; si-render-final: SIGS -> Image
; produce GAME OVER,if the a missile shot down the UFO or UFO landed
(check-expect (si-render-final
               (make-aim (make-posn 20 10) (make-tank 28 -3)))
              (overlay
               (text "GAME OVER" 48 "red") BACKGROUND))

(define (si-render-final si)
  (overlay GAME-OVER BACKGROUND))



; si-control: SIGS KeyEvent -> SIG
; if the left arrow pressed, tank moves left
; if the right arrow pressed, tank moves right
; if the space bar is pressed, shoot missel from a tank
(check-expect (si-control (make-aim (make-posn 10 50) (make-tank 30 3)) "up")
              (make-aim (make-posn 10 50) (make-tank 30 3)))
(check-expect (si-control (make-aim (make-posn 10 50) (make-tank 30 3)) "left")
              (make-aim (make-posn 10 50) (make-tank 30 -3)))
(check-expect (si-control (make-aim (make-posn 10 50) (make-tank 30 3)) "right")
              (make-aim (make-posn 10 50) (make-tank 30 3)))
(check-expect (si-control (make-fired (make-posn 10 50)
                                      (make-tank 30 3)
                                      (make-posn 30 10))
                          " ")
              (make-fired  (make-posn 10 50) (make-tank 30 3) (make-posn 33 390)))

; !!!
; add  more tests

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

 
(si-main (make-fired (make-posn 200 0)
                     (make-tank 30 3)
                     (make-posn 30 30)))


