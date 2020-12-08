;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname ex-244) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; (define (f x) (x 10))
; It is legal since x itself can be a function that's called on 10 by f

; (define (f x) (x f))
; This seems legal if x and f are functions which can summon each other recursively


(define (f x y) (x 'a y 'b))
; Yes, this function can apply other functions to some lists
