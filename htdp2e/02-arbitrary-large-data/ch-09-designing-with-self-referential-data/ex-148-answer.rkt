;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex-148-answer) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp")) #f)))
#|Compare the function definitions from this section(sum, how-many, all-true, one-true)
 with the corresponding function definitions from the preceding sections. Is it better to
 work with data definitions that accommodate empty lists as opposed to definitions for
non-empty lists? Why? Why not?|#

; I think it's easier to work with lists that can be empty. The templates are
; simpler and the base case and the combining funtions are much easier to
; reason about.