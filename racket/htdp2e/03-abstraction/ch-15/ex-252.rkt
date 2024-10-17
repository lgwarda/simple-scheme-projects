;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname ex-252) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))
; [List-of Number] -> Number
(check-expect (product '()) 1)
(check-expect (product (list 1 2 3)) 6)
(define (product l)
  (fold2 * 1 l))
  
; [List-of Posn] -> Image
(check-expect (image* '()) emt)
(check-expect (image* (list (make-posn 2 2)))
                      (place-dot (make-posn 2 2) emt))
(define (image* l)
  (fold2 place-dot emt l))
 
; Posn Image -> Image 
(define (place-dot p img)
  (place-image
   dot
   (posn-x p) (posn-y p)
   img))
 
; graphical constants:    
(define emt
  (empty-scene 100 100))
(define dot
  (circle 3 "solid" "red"))


(define (fold2 fn base l)
  (cond
    [(empty? l) base]
    [else
     (fn (first l)
         (fold2 fn base
          (rest l)))]))