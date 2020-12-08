;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex-088-data-def-for-vcat) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(define-struct vcat [x h])
; A VCat is a structure:
;   (make-vcat Number Number)
; interp. x means a x-coordinate of a VCat
;         h means a level of VCat's happyiess

(define C0 (make-vcat 0 100))
(define C1 (make-vcat 10 89))
(define C3 (make-vcat 90 43))
#;
(define (fn-for-vcat vc)
  (... (... (vcat-x vc))
       (... (vcat-h vc))))