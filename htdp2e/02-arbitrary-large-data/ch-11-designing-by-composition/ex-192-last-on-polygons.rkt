;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex-192-last-on-polygons) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))
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
 

; Image Polygon -> Image 
; adds an image of p to img
(check-expect
  (render-poly MT triangle-p)
  (scene+line
    (scene+line
      (scene+line MT 20 0 10 10 "red")
      10 10 30 10 "red")
    30 10 20 0 "red"))

(check-expect
  (render-poly MT square-p)
  (scene+line
    (scene+line
      (scene+line
        (scene+line MT 10 10 20 10 "red")
        20 10 20 20 "red")
      20 20 10 20 "red")
    10 20 10 10 "red"))

(define (render-poly img p)
  (render-line (connect-dots img p) (first p) (last p)))

; Image Posn Posn -> Image 
; renders a line from p to q into img
(check-expect (render-line MT
               (make-posn 10 10)
               (make-posn 20 20))
              (scene+line MT 10 10 20 20 "red"))
(define (render-line img p q)
  (scene+line
    img (posn-x p) (posn-y p) (posn-x q) (posn-y q) "red"))


; Image NELoP -> Image 
; connects the dots in p by rendering lines in img
(check-expect (connect-dots MT triangle-p)
              (scene+line
               (scene+line MT 20 0 10 10 "red")
               10 10 30 10 "red"))

; Solution to 191:
(check-expect (connect-dots MT square-p)
              (scene+line
               (scene+line
                (scene+line MT 10 10 20 10 "red")
                20 10 20 20 "red")
               20 20 10 20 "red"))


(define (connect-dots img p)
  (cond
    [(empty? (rest p)) MT]
    [else (render-line (connect-dots img (rest p))
                       (first p)
                       (second p))]))
; NELoP -> Posn
; extracts the last item from p
(check-expect (last triangle-p) (make-posn 30 10))
(check-expect (last square-p)   (make-posn 10 20))

(define (last p)
  (cond
    [(empty? (rest (rest (rest p)))) (third p)]
    [else (last (rest p))]))

; Polygons requaiers at least three Posns, so we can use last on them.
; In both cases there is always an item to extract. We can adopt the template for
; to last since both of them  deal with NELoPs