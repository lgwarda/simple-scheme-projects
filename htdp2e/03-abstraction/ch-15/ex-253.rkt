;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname ex-253) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))

; [Number -> Boolean]
; the class of all functions | consume a Number and yield a String
(define (fb n) #f)

; [Boolean String -> Boolean]
; the class of all functions | consume a Boolean and a String and yield a Boolean
(define (fb2 b s) #t)

; [Number Number Number -> Number]
; the class of all functions | consume a N and a N and N and yield a N
(define (fn n1 n2 n3) 0)

; [Number -> [List-of Number]]
; the class of all functions | consume a Number and yield a Listof Number
(deifne (fn2 n) empty)

; [[List-of Number] -> Boolean]
; the class of all functions | consume a Listof Number and  yield a Boolean
(define (fl lon) #f)
