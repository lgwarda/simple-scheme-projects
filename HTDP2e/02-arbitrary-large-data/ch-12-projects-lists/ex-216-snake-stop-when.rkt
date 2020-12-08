;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex-216-snake-stop-when) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; Snake crawls a diameter for each clock tick

; Constans:
(define DIAMETER 10)
(define RADIUS (/ DIAMETER 2))
(define SNAKE-SEGMENT (circle RADIUS "solid" "red"))

(define WIDTH  (* DIAMETER 20))
(define HEIGHT (* DIAMETER 20))
(define MTS (empty-scene WIDTH HEIGHT))

(define MSG (text " Snake hit border!" 14 "red" ))

; Data Definitions:

(define-struct snake [posn dir])
; A Snake is a (make-snake Position Direction)
; snake position and direction

; A Posn is (make-posn Number Number)
; the current position of the struct

(define-struct dir [x y])
; A Dir is (make-dir Number Number)
; the direction the worm currently moving in

(define P1 (make-posn 50 50))

(define DOWN  (make-dir 0 10)) 
(define UP    (make-dir 0 -10)) 
(define RIGHT (make-dir 10 0)) 
(define LEFT  (make-dir -10 0))

(define S1 (make-snake P1 UP)) 


; Functions:

; Snake -> Snake
; run snake with (snake-main 0.1)
(define (snake-main rate)
  (big-bang S1
    [to-draw render]
    [on-tick clock-tick-handler rate]
    [on-key keystroke-handler]
    [stop-when last-snake? game-over]))

; Snake -> Image
; place the SNAKE-SEGMENT on MTS at the given posn
(check-expect (render (make-snake (make-posn 10 10) DOWN))
              (place-image SNAKE-SEGMENT 10 10 MTS))

(define (render s)
  (place-image SNAKE-SEGMENT
               (posn-x (snake-posn s))
               (posn-y (snake-posn s))
               MTS))
 
; Snake -> Snake
; depends of the given dir adds or subs 10 for each tick of the clock 
(check-expect (clock-tick-handler (make-snake P1 UP))
              (make-snake (make-posn 50 40) UP))
(check-expect (clock-tick-handler (make-snake P1 DOWN))
               (make-snake (make-posn 50 60) DOWN))
(check-expect (clock-tick-handler (make-snake P1 RIGHT))
               (make-snake (make-posn 60 50) RIGHT))
(check-expect (clock-tick-handler (make-snake P1 LEFT))
              (make-snake (make-posn 40 50) LEFT))

(define (clock-tick-handler s) 
  (make-snake
   (make-posn
    (+ (posn-x (snake-posn s)) (dir-x (snake-dir s)))
    (+ (posn-y (snake-posn s)) (dir-y (snake-dir s))))
   (snake-dir s)))
 
; Snake String -> Snake 
; changes direction of the snake, only if one of four arrow keys is pressed
(check-expect (keystroke-handler (make-snake (make-posn 10 10) DOWN) "up")
              (make-snake (make-posn 10 10) UP))
(check-expect (keystroke-handler (make-snake (make-posn 10 10) UP) "down")
              (make-snake (make-posn 10 10) DOWN))
(check-expect (keystroke-handler (make-snake (make-posn 10 10) DOWN) "right")
              (make-snake (make-posn 10 10) RIGHT))
(check-expect (keystroke-handler (make-snake (make-posn 10 10) DOWN) "left")
              (make-snake (make-posn 10 10) LEFT))
(check-expect (keystroke-handler (make-snake (make-posn 10 10) DOWN) " ")
              (make-snake (make-posn 10 10) DOWN))

(define (keystroke-handler s ke)
  (cond [(key=? "up" ke)    (make-snake (snake-posn s) UP)]
        [(key=? "down" ke)  (make-snake (snake-posn s) DOWN)]
        [(key=? "right" ke) (make-snake (snake-posn s) RIGHT)]
        [(key=? "left" ke)  (make-snake (snake-posn s) LEFT)]
        [else s]))

; Snake -> Boolean
; produce #t, if snake hit the border

(check-expect (last-snake? ; exceeding the bottom of the screen
               (make-snake 
                (make-posn (- WIDTH 10) (+ HEIGHT 10)) RIGHT))
              #true)
(check-expect (last-snake? ; exceeding the right side of the scren
               (make-snake 
                (make-posn (+ WIDTH 10) (- HEIGHT 10)) RIGHT))
              #true)
(check-expect (last-snake? ; exceeding the right side of the scren
               (make-snake 
                (make-posn -10 (- HEIGHT 10)) LEFT))
              #true)
(check-expect (last-snake? ; exceeding the left side of the screen
               (make-snake 
                (make-posn (- WIDTH 10) -10) LEFT))
              #true)
(check-expect (last-snake? ;in the middle of the screen - should not collide
               (make-snake 
                (make-posn (- WIDTH 10) (- HEIGHT 10)) LEFT))
              #false)

(define (last-snake? s)
  (cond
    [(> 10 (posn-x (snake-posn s))) #true]
    [(> 10 (posn-y (snake-posn s))) #true]
    [(< (- WIDTH 10) (posn-x (snake-posn s))) #true]
    [(< (- HEIGHT 10) (posn-y (snake-posn s))) #true]
    [else #false]))

; Snake -> Image
; place the given text on the scene 
(check-expect (game-over (make-snake (make-posn 50 0)  (make-dir 0 -10)))
              (overlay/align "left" "bottom"
                             MSG
                             (render (make-snake (make-posn 50 0)  (make-dir 0 -10)))))
(define (game-over s)
 (overlay/align "left" "bottom" MSG (render s)))

(snake-main 0.2)
