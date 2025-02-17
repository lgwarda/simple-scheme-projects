;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex-055-lrcd-another-look-at-show) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; Constans:

(define HEIGHT 300) ; distances in pixels 
(define WIDTH  100)
(define YDELTA 3)
 
(define BACKG  (empty-scene WIDTH HEIGHT))
(define ROCKET (rectangle 5 30 "solid" "red"))
(define ROCKET-X (/ WIDTH 2)) 
(define CENTER (/ (image-height ROCKET) 2))

; An LRCD is one of:
; – "resting"
; – a Number between -3 and -1
; – a NonnegativeNumber 
; interpretation a grounded rocket, in countdown mode,
; a number denotes the number of pixels between the
; top of the canvas and the rocket (its height)

; LRCD -> Image
; renders the state as a resting or flying rocket
(check-expect
 (show "resting")
 (place-image ROCKET ROCKET-X (- HEIGHT CENTER)  BACKG))

(check-expect
 (show -2)
 (place-image (text "-2" 20 "red")
             ROCKET-X (* 3/4 WIDTH)
              (place-image ROCKET ROCKET-X (- HEIGHT CENTER) BACKG)))


(check-expect
 (show HEIGHT)
 (place-image ROCKET ROCKET-X (- HEIGHT CENTER) BACKG))
 
(check-expect
 (show 53)
 (place-image ROCKET ROCKET-X (- 53 CENTER) BACKG))

(check-expect
 (show 0)
 (place-image ROCKET ROCKET-X (- 0 CENTER) BACKG))


(define (show x)
  (cond
    [(and (string? x) (string=? "resting" x))
     (auxiliary-show HEIGHT)]
    [(<= -3 x -1)
     (place-image (text (number->string x) 20 "red")
              ROCKET-X (* 3/4 WIDTH)
              (auxiliary-show HEIGHT))]
    [(>= x 0)
     (auxiliary-show x)]))

; LRCD -> Image
; renders the state as a resting or flying rocket
(check-expect (auxiliary-show HEIGHT)
              (place-image ROCKET ROCKET-X (- HEIGHT CENTER) BACKG))

(check-expect (auxiliary-show 0)
              (place-image ROCKET ROCKET-X (- 0 CENTER) BACKG))

(define (auxiliary-show x)
    (place-image ROCKET ROCKET-X (- x CENTER) BACKG))



; LRCD KeyEvent -> LRCD
; starts the countdown when space bar is pressed, 
; if the rocket is still resting 
(define (launch x ke)
  x)
 
; LRCD -> LRCD
; raises the rocket by YDELTA,
; if it is moving already 
(define (fly x)
  x)