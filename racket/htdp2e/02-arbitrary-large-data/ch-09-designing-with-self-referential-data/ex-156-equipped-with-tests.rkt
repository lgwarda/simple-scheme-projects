;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex-156-equipped-with-tests) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp")) #f)))
; Constans:

(define HEIGHT 80) ; distances in terms of pixels 
(define WIDTH 100)
(define XSHOTS (/ WIDTH 2))
 
; graphical constants 
(define BACKGROUND (empty-scene WIDTH HEIGHT))
(define SHOT (triangle 3 "solid" "red"))

; Data definition:

; A List-of-shots is one of: 
; – '()
; – (cons Shot List-of-shots)
; interpretation the collection of shots fired

; A Shot is a Number.
; interpretation represents the shot's y-coordinate 

; A ShotWorld is List-of-numbers. 
; interpretation each number on such a list
;   represents the y-coordinate of a shot 

; Functions:

; main: ShotWorld -> ShotWorld
; start program with (main '())
(define (main sw)
  (big-bang sw
    (to-draw to-image)
    (on-tick tock)
    (on-key keyh)))

; to-image: ShotWorld -> Image
; adds the image of a shot for each  y on w 
; at (MID,y} to the background image
(check-expect (to-image '())BACKGROUND)
(check-expect (to-image (cons 9 '()))
              (place-image SHOT XSHOTS 9 BACKGROUND))
(check-expect (to-image (cons 18 (cons 9 '())))
              (place-image SHOT XSHOTS 18
                           (place-image SHOT XSHOTS 9 BACKGROUND)))

(define (to-image w)
  (cond [(empty? w) BACKGROUND]
        [else
         (place-image SHOT XSHOTS (first w)
                      (to-image (rest w)))]))

; tock: ShotWorld -> ShotWorld
; moves each shot on w up by one pixel
(check-expect (tock '()) '())
(check-expect (tock (cons 3 '())) (cons 2 '()))
(check-expect (tock (cons 4 (cons 5 (cons 2 '())))) (cons 3 (cons 4 (cons 1 '()))))

(define (tock w)
  (cond [(empty? w) '()]
        [else
         (cons (sub1 (first w))
               (tock (rest w)))]))

; keyh: ShotWorld KeyEvent -> ShotWorld 
; adds a shot to the world 
; if the player presses the space bar
(check-expect (keyh (cons 9 '()) "up") (cons 9 '()))
(check-expect (keyh '() " ") (cons HEIGHT '()))
(check-expect (keyh (cons 9 '()) " ") (cons HEIGHT (cons 9 '())))
                                        
(define (keyh w ke)
  (if (key=? ke " ") (cons HEIGHT w) w))

 (main '())
