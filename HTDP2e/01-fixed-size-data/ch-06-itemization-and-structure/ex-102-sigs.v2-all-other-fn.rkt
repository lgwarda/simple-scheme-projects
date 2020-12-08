;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex-102-sigs.v2-all-other-fn) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
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

; Data definitions:

(define-struct sigs [ufo tank missile])

; A UFO is a Posn
; interpretation (make-posn x y) is the UFO's location
; (using the top-down, left-to-right convention)
(define U0 (make-posn 10 200))
(define U2 (make-posn 20  10))


(define-struct tank [loc vel])
; A Tank is a structure:
;     (make-tank Number Number)
; interpretation (make-tank x dx) specifies the position:
; (x, HEIGHT) and the tank's speed: dx pixels/tick
(define T0 (make-tank 28 -3))
(define T1 (make-tank 100 3))

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


; Functions:

; SIGS.v2 -> Image 
; renders the given game state on top of BACKGROUND 
(check-expect (si-render.v2 (make-sigs (make-posn 100 120)
                                       (make-tank 50 3)
                                       #false))
              (tank-render
               (make-tank 50 3)
               (ufo-render
                (make-posn 100 120)
                (missile-render.v2 #f
                                   BACKGROUND))))
(check-expect (si-render.v2 SIGS2)
              (tank-render
               (make-tank 50 3)
               (ufo-render
                (make-posn 100 120)
                (missile-render.v2 (make-posn 20 150)
                                   BACKGROUND))))
(define (si-render.v2 s)
  (tank-render
   (sigs-tank s)
   (ufo-render (sigs-ufo s)
               (missile-render.v2 (sigs-missile s)
                                  BACKGROUND))))

; missile-render.v2: MissileOrNot Image -> Image 
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

; ufo-render: UFO Image -> Image
; adds an image of ufo u to scene s
(check-expect (ufo-render (make-posn 20 100) BACKGROUND)
              (place-image UFO 20 100 BACKGROUND))

(define (ufo-render u s)
  (place-image UFO (posn-x u) (posn-y u) s))

; tank-render: Tank Image -> Image
; adds an image of tank t to scene s
(check-expect (tank-render (make-tank 28 -3) BACKGROUND)
              (place-image TANK 28 TANK-Y BACKGROUND))

(define (tank-render t s)
  (place-image TANK (tank-loc t) TANK-Y s))

; si-move: SIGS -> SIGS
; move all the space-invader objects

(define (si-move.v2 s)
  (si-move-proper s (random 3)))

; si-move-proper: SIGS Number -> SIGS 
; moves the space-invader objects predictably by delta:
; 0 - sub1 from  U-SPEED
; 1 - move -1
; 2 - move  1
(check-expect (si-move-proper (make-sigs (make-posn 10 20)
                                         (make-tank 50 0)
                                         #f)
                              0)
              (make-sigs (make-posn 10 (+ 20 (- U-SPEED JUMP)))
                         (make-tank 50 0)
                         #f))

(check-expect (si-move-proper (make-sigs (make-posn 10 20)
                                         (make-tank 50 3)
                                         #f)
                              1)
              (make-sigs (make-posn (- 10 JUMP) (+ 20 U-SPEED))
                         (make-tank 53 3) #f))
(check-expect (si-move-proper (make-sigs (make-posn 10 20)
                                         (make-tank 50 3)
                                         #f)
                              2)
              (make-sigs (make-posn (+ 10 JUMP) (+ 20 U-SPEED))
                         (make-tank 53 3)
                         #f))

(check-expect (si-move-proper (make-sigs (make-posn 10 20)
                                         (make-tank 50 3)
                                         (make-posn 20 30))
                              0)
              (make-sigs (make-posn 10 (+ 20 (- U-SPEED JUMP)))
                         (make-tank 53 3)
                         (make-posn 20 (- 30 M-SPEED))))


(define (si-move-proper s r)
  (make-sigs (move-ufo (sigs-ufo s) r)
             (move-tank (sigs-tank s))
             (move-missile (sigs-missile s))))


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

; missile-move: MissileOrNot -> MissileOrNot
; move the missile m by M-SPEED
(check-expect (move-missile #f) #f)
(check-expect (move-missile (make-posn 58 TANK-HEIGHT))
              (make-posn 58 (- TANK-HEIGHT M-SPEED)))

(define (move-missile m)
  (cond
    [(boolean? m) #f]
    [(posn? m) (make-posn (posn-x m) (- (posn-y m) M-SPEED))]))

; si-game-over?: SIGS -> Boolean
; produce #t, if the UFO lands or the missile shots down the UFO
(check-expect (si-game-over.v2?    ; not landed, no missle
               (make-sigs (make-posn 20 100)
                          (make-tank 10 3)
                          #f))
              #false)

(check-expect (si-game-over.v2?   ; landed, no missle
               (make-sigs (make-posn 20 (- HEIGHT (/ UFO-HEIGHT 2)))
                          (make-tank 10 3)
                          #f))
              #true)

(check-expect (si-game-over.v2?   ; landed, not shot down
               (make-sigs (make-posn 20 (- HEIGHT (/ UFO-HEIGHT 2)))
                          (make-tank 10 3)
                          (make-posn 10 10)))
              #true)

(check-expect (si-game-over.v2?   ; not landed, not shot down 
               (make-sigs (make-posn 20 100)
                          (make-tank 10 3)
                          (make-posn 10 10)))
              #false)

(check-expect (si-game-over.v2?   ; not landed, shot down!
               (make-sigs (make-posn 20 100)
                          (make-tank 10 3)
                          (make-posn 20 100)))
              #true)

(define (si-game-over.v2? s)
  (or (ufo-landed? (sigs-ufo s))
      (shot-down? (sigs-ufo s)
                  (sigs-missile s))))
 

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
  (cond [(boolean? m) #f]
        [(posn? m)
         (and (< (abs (- (posn-x u) (posn-x m))) REACH)
              (< (abs (- (posn-y u) (posn-y m))) REACH))]))
  
; si-render-final: SIGS -> Image
; produce GAME OVER,if the a missile shot down the UFO or UFO landed
(check-expect (si-render-final
               (make-sigs (make-posn 20 100)
                          (make-tank 28 -3)
                          (make-posn 20 100)))
              (overlay
               (text "GAME OVER" 48 "red") BACKGROUND))

(define (si-render-final si)
  (overlay GAME-OVER BACKGROUND))


; si-control: SIGS KeyEvent -> SIG
; if the left arrow pressed, tank moves left
; if the right arrow pressed, tank moves right
; if the space bar is pressed, shoot missel from a tank
(check-expect (si-control.v2 (make-sigs (make-posn 10 50) (make-tank 30 3) #f) "up")
              (make-sigs (make-posn 10 50) (make-tank 30 3) #f))
(check-expect (si-control.v2 (make-sigs (make-posn 10 50) (make-tank 30 3) #f) "left")
              (make-sigs (make-posn 10 50) (make-tank 30 -3) #f))
(check-expect (si-control.v2 (make-sigs (make-posn 10 50) (make-tank 30 3) #f) "right")
              (make-sigs (make-posn 10 50) (make-tank 30 3) #f))
(check-expect (si-control.v2 (make-sigs (make-posn 10 50)
                                     (make-tank 30 3)
                                     (make-posn 30 10))
                          " ")
              (make-sigs  (make-posn 10 50) (make-tank 30 3) (make-posn 33 390)))

; !!!
; add  more tests

(define (si-control.v2 sig ke)
  (cond [(key=? ke "left") (move-left sig)]
        [(key=? ke "right") (move-right sig)]
        [(key=? ke " ") (shoot-missile sig)]
        [else sig]))

; move-left: SIGS -> SIGS
; sub tank's velocity
(check-expect (move-left (make-sigs (make-posn 10 50) (make-tank 30 3) #f))
              (make-sigs (make-posn 10 50) (make-tank 30 -3) #f))
(check-expect (move-left (make-sigs (make-posn 10 50) (make-tank 30 -3) #f))
              (make-sigs (make-posn 10 50) (make-tank 30 -3) #f))

(check-expect (move-left (make-sigs (make-posn 10 50)
                                    (make-tank 30 3)
                                    (make-posn 30 30)))
              (make-sigs (make-posn 10 50)
                         (make-tank 30 -3)
                         (make-posn 30 30)))
(check-expect (move-left (make-sigs (make-posn 10 50)
                                    (make-tank 30 -3)
                                    (make-posn 30 30)))
              (make-sigs (make-posn 10 50)
                         (make-tank 30 -3)
                         (make-posn 30 30)))

(define (move-left s)
  (make-sigs (sigs-ufo s)
             (turn-left (sigs-tank s))
             (sigs-missile s)))

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

(check-expect (move-right (make-sigs (make-posn 10 50) (make-tank 30 3) #f))
              (make-sigs (make-posn 10 50) (make-tank 30 3) #f))
(check-expect (move-right (make-sigs (make-posn 10 50) (make-tank 30 -3) #f))
              (make-sigs (make-posn 10 50) (make-tank 30 3) #f))

(check-expect (move-right (make-sigs (make-posn 10 50)
                                     (make-tank 30 3)
                                     (make-posn 30 30)))
              (make-sigs (make-posn 10 50)
                         (make-tank 30 3)
                         (make-posn 30 30)))
(check-expect (move-right (make-sigs (make-posn 10 50)
                                     (make-tank 30 -3)
                                     (make-posn 30 30)))
              (make-sigs (make-posn 10 50)
                         (make-tank 30 3)
                         (make-posn 30 30)))


(define (move-right s)
  (make-sigs (sigs-ufo s)
             (turn-right (sigs-tank s))
             (sigs-missile s)))

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
(check-expect (shoot-missile (make-sigs (make-posn 25 30)
                                        (make-tank 20 3)
                                        #f))
              (make-sigs (make-posn 25 30)
                         (make-tank 20 3)
                         (make-posn (+ 20 3) (- HEIGHT TANK-HEIGHT))))

(check-expect (shoot-missile (make-sigs (make-posn 25 30)
                                        (make-tank 20 3)
                                        (make-posn 40 10)))
              (make-sigs (make-posn 25 30)
                         (make-tank 20 3)
                         (make-posn (+ 20 3) (- HEIGHT TANK-HEIGHT))))


(define (shoot-missile s)
  (make-sigs (sigs-ufo s)
             (sigs-tank s)
             (make-posn (+ (tank-loc (sigs-tank s))
                           (tank-vel (sigs-tank s)))
                        (- HEIGHT TANK-HEIGHT))))

; si-main.v2: SIGS -SIGS
; start the game with
;(si-main (make-sigs (make-posn  200 0)(make-tank 30 3) (make-posn 30 30)))
(define (si-main.v2 sig)
  (big-bang sig
    (to-draw si-render.v2)
    (on-tick si-move.v2)
    (stop-when si-game-over.v2? si-render-final)
    (on-key si-control.v2)))

(si-main.v2 (make-sigs (make-posn 200 0)
                       (make-tank 30 3)
                       (make-posn 30 30)))