;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex-81-time-to-sec) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(define-struct time [hours minutes seconds])
; timet is a (make-time Number Number Number))
; interp. a point in time having hours, minutes, seconds

(define T1 (make-time 07 39 00))  ; 07:39


; time->seconds: Time -> Number
; produce the # of seconds that have passed since midnight
(check-expect (time->seconds (make-time 0 0 0)) 0)
(check-expect (time->seconds T1) 27540)
(check-expect (time->seconds (make-time 12 30 2)) 45002)

(define (time->seconds t)
  (+ (* 3600 (time-hours t))
     (* 60 (time-minutes t))
     (time-seconds t)))

