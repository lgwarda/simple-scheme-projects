;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex-120-discriminate-senteces) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp")) #f)))
; Both 1 and 2 are ilegal sentences. 1. is a single variable surrounded by parentheses,
; 2 mixed two opperands. "1" belongs to class of numbers and "not" belongs to class of boolean. 
; The last one is legal expression with the syntax (primitive expr expr expr).
; Since the last misses the leading keyward "define" it belongs to the category of expr