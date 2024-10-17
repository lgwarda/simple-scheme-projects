;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex-058-tax-land) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; constans

(define NON-RATE 0)
(define LOW-RATE 0.05)
(define LUXURY-RATE 0.08)

; data definition

; A Price falls into one of three intervals: 
; — 0 through 1000
; — 1000 through 10000
; — 10000 and above.
; interpretation the price of an item

; functions

; Price -> Number
; computes the amount of tax charged for p
(check-expect (sales-tax 0) (* NON-RATE 0))
(check-expect (sales-tax 537) (* NON-RATE 537))
(check-expect (sales-tax 1000) (* LOW-RATE 1000))
(check-expect (sales-tax 1282) (* LOW-RATE 1282))
(check-expect (sales-tax 10000) (* LUXURY-RATE 10000))
(check-expect (sales-tax 12017) (* LUXURY-RATE 12017))

(define (sales-tax p)
  (cond [(and (<= 0 p) (< p 1000)) (* NON-RATE p)]
        [(and (<= 1000 p) (< p 10000)) (* LOW-RATE p)]
        [(>= p 1000) (* LUXURY-RATE p)]))

