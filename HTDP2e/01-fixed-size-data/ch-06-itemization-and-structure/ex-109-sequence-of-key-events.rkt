;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex-109-sequence-of-key-events) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp")) #f)))
; Constans:

(define WIDTH 100)
(define HEIGHT 100)
(define CTR-X (/ WIDTH 2))
(define CTR-Y (/ HEIGHT 2))
(define MTS (empty-scene WIDTH HEIGHT))

(define AA-WHITE (rectangle 100 100 "solid" "white"))
(define BB-YELLOW (rectangle 100 100 "solid" "yellow"))
(define DD-GREEN (rectangle 100 100 "solid" "green"))
(define ER-RED  (rectangle 100 100 "solid" "red"))

; Data definitions:

; ExpectsToSee is one of:
; – AA
; – BB
; – DD 
; – ER 
 
(define AA "start, expect an 'a'")
(define BB "expect 'b', 'c', or 'd'")
(define DD "finished")
(define ER "error, illegal key" )

; process-ets: ExpextsToSee -> ...
(define (process-ets ets)
  (cond [(string=? AA ets) (...)]
        [(string=? BB ets) (...)]
        [(string=? DD ets) (...)]
        [(string=? ER ets) (...)]))

; Functions:

; main:  ExpextsToSee -> ExpextsToSee
; start program with (main AA)

(define (main ets)
        (big-bang ets
          (to-draw render)
          (on-key desired-letter)))

; render: ExpextsToSee -> Image
; place the given image on MTS
(check-expect (render AA)(place-image AA-WHITE CTR-X CTR-Y MTS))
(check-expect (render BB)(place-image BB-YELLOW CTR-X CTR-Y MTS))
(check-expect (render DD)(place-image DD-GREEN CTR-X CTR-Y MTS))
(check-expect (render ER)(place-image ER-RED CTR-X CTR-Y MTS))

(define (render ets)
  (cond [(string=? AA ets) (place-image AA-WHITE CTR-X CTR-Y MTS)]
        [(string=? BB ets) (place-image BB-YELLOW CTR-X CTR-Y MTS)]
        [(string=? DD ets) (place-image DD-GREEN CTR-X CTR-Y MTS)]
        [(string=? ER ets) (place-image ER-RED CTR-X CTR-Y MTS)]))

; desired-letter: ExpextsToSee KeyEvent ->  ExpextsToSee
; if the desired key pressed, display the rectangel of the desired color,
; otherwise return red rectangle
(check-expect (desired-letter AA "a") BB)
(check-expect (desired-letter AA "s") ER)
(check-expect (desired-letter BB "a") ER)
(check-expect (desired-letter BB "b") BB)
(check-expect (desired-letter BB "c") BB)
(check-expect (desired-letter BB "e") ER)
(check-expect (desired-letter BB "d") DD)
(check-expect (desired-letter DD "f") DD)

(define (desired-letter ets ke)
  (cond
    [(and (string=? AA ets) (string=? "a" ke)) BB]
    [(and (string=? BB ets) (string=? "b" ke)) BB]
    [(and (string=? BB ets) (string=? "c" ke)) BB]
    [(and (string=? BB ets) (string=? "d" ke)) DD]
    [(string=? DD ets) DD]
    [else ER]))



(main AA)
