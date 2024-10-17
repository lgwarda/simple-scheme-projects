;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex-194-connect-dots) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))
; Constans:

; a plain background image 
(define MT (empty-scene 50 50))

; Data definitions

; a Polygon is one of: 
; – (cons Posn (cons Posn (cons Posn '()))) 
; – (cons Posn Polygon)

; An NELoP is one of: 
; – (cons Posn '())
; – (cons Posn NELoP)

(define triangle-p
  (list
   (make-posn 20 0)
   (make-posn 10 10)
   (make-posn 30 10)))

(define square-p
  (list
   (make-posn 10 10)
   (make-posn 20 10)
   (make-posn 20 20)
   (make-posn 10 20)))

; Functions:

(check-expect (render-poly.v4 MT triangle-p)
              (scene+line
               (scene+line
                (scene+line MT 20 0 10 10 "red")
                10 10 30 10 "red")
               30 10 20 0 "red"))

(check-expect (render-poly.v4 MT square-p)
              (scene+line
               (scene+line
                (scene+line
                 (scene+line MT 10 10 20 10 "red")
                 20 10 20 20 "red")
                20 20 10 20 "red")
               10 20 10 10 "red"))

(define (render-poly.v4 img p)
  (connect-dots.v2 img p (first p)))

; Image Posn Posn -> Image 
; renders a line from p to q into img
(check-expect (render-line MT
                           (make-posn 10 10)
                           (make-posn 20 20))
              (scene+line MT 10 10 20 20 "red"))
(define (render-line img p q)
  (scene+line
   img (posn-x p) (posn-y p) (posn-x q) (posn-y q) "red"))


; Image NELoP Posn -> Image 
; connects the dots in p by rendering lines in img
(check-expect (connect-dots.v2 MT triangle-p (first triangle-p))
              (scene+line
               (scene+line
                (scene+line MT 20 0 10 10 "red")
                10 10 30 10 "red")
               30 10 20 0 "red"))

(check-expect (connect-dots.v2 MT square-p (first square-p))
              (scene+line
               (scene+line
                (scene+line
                 (scene+line MT 10 10 20 10 "red")
                 20 10 20 20 "red")
                20 20 10 20 "red")
               10 20 10 10 "red"))

(define (connect-dots.v2 img p posn)
  (cond
    [(empty? (rest p)) (render-line img (first p) posn)]
    [else (render-line (connect-dots.v2 img (rest p) posn)
                       (first p)
                       (second p))]))
