;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname ex-250) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Number -> [List-of Number]
; tabulates sin between n 
; and 0 (incl.) in a list
(define (tab-sin n)
  (tabulete sin n))
  
; Number -> [List-of Number]
; tabulates sqrt between n 
; and 0 (incl.) in a list
(define (tab-sqrt n)
  (tabulete sqr n))

(define (tabulete fn n)
  (cond
    [(= n 0) (list (fn 0))]
    [else
     (cons
      (fn n)
      (tabulete fn (sub1 n)))]))

(tabulete sqr 2) ; produce (list 4 1 0)
(tabulete tan 0) ; produce (list 0)