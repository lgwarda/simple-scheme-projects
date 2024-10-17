;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex-152-col-and-row) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp")) #f)))
(define IMG (square 10 "outline" "black"))

; col: N Image -> Image
; produce a vertical arrangement—of n copies of img
(check-expect (col 0 IMG) empty-image)
(check-expect (col 4 IMG) (above IMG IMG IMG IMG))
(define (col n img)
  (cond [(zero? n) empty-image]
        [else (above  img (col (sub1 n) img))]))

; row: N Image -> Image
; a horizontal arrangement—of n copies of img
(check-expect (row 0 IMG) empty-image)
(check-expect (row 3 IMG) (beside IMG IMG IMG))

(define (row n img)
  (cond [(zero? n) empty-image]
        [else (beside img (row (sub1 n) img))]))