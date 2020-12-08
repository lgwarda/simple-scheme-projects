;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex-128-bsl-tests) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp")) #f)))
(check-member-of "green" "red" "yellow" "grey")
; "green" differs from all given members in "red" "yellow" "gray"

(check-within (make-posn #i1.0 #i1.1)
              (make-posn #i0.9 #i1.2)  0.01)
; (make-posn #i1.0 #i1.1) is not in within 1/100

(check-range #i0.9 #i0.6 #i0.8)
; #i0.9 is not between (#i0.6 #i0.8)

(check-random (make-posn (random 3) (random 9))
              (make-posn (random 9) (random 3)))
; the order of values in the second expresion is wrong


(check-satisfied 4 odd?)
; 4 in not odd #
