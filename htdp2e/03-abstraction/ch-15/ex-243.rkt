;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname ex-243) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define (f x) x)

; Identify the values among the following expressions:

(cons f '())

; since a function is a value, it can be on a list

(f f)

; another valid function value, my assumption is that it will work like function composition

(cons f (cons 10 (cons (f 10) '())))
; (f 10) certainly evaluates to a value, and 10 is clearly a value.
; If what I said above is true and functions-as-values can be list items,
; then this must be a value, too
; Explain why they are (not) values.



