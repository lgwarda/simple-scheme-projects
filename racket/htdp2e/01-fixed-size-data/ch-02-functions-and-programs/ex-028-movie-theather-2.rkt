;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex-028-movie-theather-2) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
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

; cost depends on a fixed part and a variable part based on the number of attendees
(define (cost ticket-price)
  (+ FIXED-COSTS (* VARIABLE-COSTS (attendees ticket-price))))

; profit
(define (profit ticket-price)
  (- (revenue ticket-price)
     (cost ticket-price)))



(profit 1.0) ;511.2
(profit 2.0) ;937.2
(profit 3.0) ;1063.2
(profit 4.0) ;889.2
(profit 5.0) ;415.2

; an alterative version of the same programe, given as a single function definition:
(define (profit-2 price)
  (- (* (+ 120
           (* (/ 15 0.1)
              (- 5.0 price)))
        price)
     (+ 180
        (* 0.04
           (+ 120
              (* (/ 15 0.1)
                 (- 5.0 price)))))))
(profit-2 1.0) ;511.2
(profit-2 2.0) ;937.2
(profit-2 3.0) ;1063.2
(profit-2 4.0) ;889.2
(profit-2 5.0) ;415.2