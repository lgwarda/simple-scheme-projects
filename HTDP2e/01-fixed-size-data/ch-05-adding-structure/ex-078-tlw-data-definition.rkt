;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex-78-tlw-data-definition) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; L is one of:
; 1String [a,z]
; #false
; interp. lower case letters [a,z] or no letter

(define-struct 3lw [l1 l2 l3])
; A ThreeLetterWord (in short 3lw) is a structure:
;  (make-3lw L L L)
; interp. l1, l2, l3 are the lower case letter from "a" to "z"
;         #f means no letter
     