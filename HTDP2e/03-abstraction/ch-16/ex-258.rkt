;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname ex-258) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))
; Constant:
(define MT (empty-scene 100 100))

; Data definitions:

; a Polygon is one of:
; - (list Posn Posn Posn)
; - (cons Posn Polygon)

; Image Polygon -> Image 
; adds an image of p to MT
(define (render-polygon.v2 img p)
  (local [(define (connect-dots img p)
            (cond
              [(empty? (rest p)) MT]
              [else (render-line (connect-dots img (rest p))
                                 (first p)
                                 (second p))]))
          ; extracts the last item from p
          (define (last p)
            (cond
              [(empty? (rest (rest (rest p)))) (third p)]
              [else (last (rest p))]))
          ; Image Posn Posn -> Image 
          ; draws a red line from Posn p to Posn q into im
          (define (render-line im p q)
            (scene+line im (posn-x p) (posn-y p) (posn-x q) (posn-y q) "red"))]
    (render-line (connect-dots img p) (first p) (last p))))






; produce upsidedown trapezoid
(render-polygon.v2 MT (list (make-posn 10 20)  
                            (make-posn 40 60)
                            (make-posn 80 60)
                            (make-posn 90 20)))
