;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex-131-lob) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp")) #f)))
; A List-of-boolean is one of:
; - '()
; - (cons Boolean List-of-Boolean
; interpretation a list of boolean values

(define LOB0 '())
(define LOB1 (cons #t '()))
(define LOB2 (cons #f (cons #t '())))
  
  