;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex-056-lrcd-main2) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
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
(check-expect (launch "resting" " ") -3)
(check-expect (launch "resting" "a") "resting")
(check-expect (launch -3 " ") -3)
(check-expect (launch -1 " ") -1)
(check-expect (launch 33 " ") 33)
(check-expect (launch 33 "a") 33)

(define (launch x ke)
  (cond
    [(string? x) (if (string=? " " ke) -3 x)]
    [(<= -3 x -1) x]
    [(>= x 0) x]))


 
; LRCD -> LRCD
; raises the rocket by YDELTA,
; if it is moving already 
(check-expect (fly "resting") "resting")
(check-expect (fly -3) -2)
(check-expect (fly -2) -1)
(check-expect (fly -1) HEIGHT)
(check-expect (fly 10) (- 10 YDELTA))
(check-expect (fly 22) (- 22 YDELTA))
 
(define (fly x)
  (cond
    [(string? x) x]
    [(<= -3 x -1) (if (= x -1) HEIGHT (+ x 1))]
    [(>= x 0) (- x YDELTA)]))

; LRCD -> Boolean
; stop when rocket dissapire from the canvas
(define (dissapire? s)
  (cond
    [(and (number? s)
          (= s 0)) #t]
    [else #f]))

; LRCD -> LRCD
(define (main2 s)
  (big-bang s
    [to-draw show]
    [on-key launch]
    [on-tick fly 0.1]
    [stop-when dissapire?]))


 (main2 "resting")
