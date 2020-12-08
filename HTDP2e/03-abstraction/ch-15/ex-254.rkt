;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname ex-254) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))
;Exercise 254. Formulate signatures for the following functions:

; sort-n, which consumes a list of numbers and a function that consumes
; two numbers (from the list) and produces a Boolean
; sort-n produces a sorted list of numbers.

; sort-n : [List-of Number] [Number Number -> Boolean] -> [List-of Number]

; sort-s, which consumes a list of strings and a function that consumes
; two strings (from the list) and produces a Boolean
; sort-s produces a sorted list of strings.

; sort-s : [List-of String] [String String -> Boolean] -> [List-of String] 

; Then abstract over the two signatures, following the above steps.
; Also show that the generalized signature can be instantiated to describe
; the signature of a sort function for lists of IRs.


; sort-n : [List-of Number] [Number Number -> Boolean] -> [List-of Number]
; sort-s : [List-of String] [String String -> Boolean] -> [List-of String]

         ; [List-of X] [X Y -> Boolean] -> [List-of X] 