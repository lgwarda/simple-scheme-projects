;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |ex-007-boolean-expression |) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(define sunny #true)
(define friday #false)


(or (not sunny) friday)

; there can be 4 combinations of Booleans associetis w/ sunny and friday
; since there are only two kinds of Boolean values: #true and #false
; (expt 2 n):
; 2 stands for Boolean values
; n stands for sunny and friday in this case
; so n is 2
; (expt 2 2) == 4

(or sunny friday)
(or sunny (not friday))
(or (not sunny) (not friday))