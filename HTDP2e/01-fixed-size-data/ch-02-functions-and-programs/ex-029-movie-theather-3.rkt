;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex-029-movie-theather-3) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; constans:
(define AVG-ATTENDENCE 120) 
(define BASE-TICKET-PRICE 5.0)
(define ATTENDEE-SWING 15)
(define PRICE-VARIANCE 0.1)
(define VARIABLE-COSTS 1.5)

; the number of attendees depends on the ticket price
(define (attendees ticket-price)
  (- AVG-ATTENDENCE
     (* (- ticket-price BASE-TICKET-PRICE)
        (/ ATTENDEE-SWING PRICE-VARIANCE))))

; revenue depends on ticket sales 
(define (revenue ticket-price)
  (* ticket-price (attendees ticket-price)))

; cost depends on a fixed part and a variable part based on the number of attendees
(define (cost ticket-price)
  (* VARIABLE-COSTS (attendees ticket-price)))

; profit
(define (profit ticket-price)
  (- (revenue ticket-price)
     (cost ticket-price)))


(profit 3.0) ;630
(profit 4.0) ;675
(profit 5.0) ;420

; profit-2, given as a single function definition:
(define (profit-2 price)
  (- (* (+ 120
           (* (/ 15 0.1)
              (- 5.0 price)))
        price)
        (* 1.5
           (+ 120
              (* (/ 15 0.1)
                 (- 5.0 price))))))

(profit-2 3.0) ;630
(profit-2 4.0) ;675
(profit-2 5.0) ;420
