;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex-027-give-name-to-constans) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; constans:
(define AVG-ATTENDENCE 120) 
(define BASE-TICKET-PRICE 5.0)
(define ATTENDEE-SWING 15)
(define PRICE-VARIANCE 0.1)
(define FIXED-COSTS 180.0)
(define VARIABLE-COSTS 0.04)

; the number of attendees depends on the ticket price
(define (attendees ticket-price)
  (- AVG-ATTENDENCE
     (* (- ticket-price BASE-TICKET-PRICE)
        (/ ATTENDEE-SWING PRICE-VARIANCE))))

; revenue depends on ticket sales 
(define (revenue ticket-price)
  (* ticket-price (attendees ticket-price)))

(define (cost ticket-price)
  (+ FIXED-COSTS (* VARIABLE-COSTS (attendees ticket-price))))

(define (profit ticket-price)
  (- (revenue ticket-price)
     (cost ticket-price)))