;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex-153-1968-style-eu-student-riot) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp")) #f)))
; constans:
(define SQR (square 10 "outline" "black"))
(define BALLOON (circle 3 "solid" "red"))

(define COLS 10)
(define ROWS 20)
(define MTS
  (empty-scene (* COLS (image-width SQR))
               (* ROWS (image-width SQR))))

; data definition:

; A List-of-position is one of:
; - '()
; - (cons Posn List-of-posns)

(define LOP3
(cons
 (make-posn 10 20)
 (cons
  (make-posn 20 40)
  (cons
   (make-posn 30 60)
   (cons
    (make-posn 40 80)
    (cons
     (make-posn 50 100)
     (cons
      (make-posn 60 120)
      (cons
       (make-posn 70 140)
       (cons
        (make-posn 80 160)
        (cons
         (make-posn 90 180)
         '()))))))))))

; functions:


; col: N Image -> Image
; produce a vertical arrangement—of n copies of img
(check-expect (col 0 SQR) empty-image)
(check-expect (col 4 SQR) (above SQR SQR SQR SQR))
(define (col n img)
  (cond [(zero? n) empty-image]
        [else (above  img (col (sub1 n) img))]))

; row: N Image -> Image
; a horizontal arrangement—of n copies of img
(check-expect (row 0 SQR) empty-image)
(check-expect (row 3 SQR) (beside SQR SQR SQR))

(define (row n img)
  (cond [(zero? n) empty-image]
        [else (beside img (row (sub1 n) img))]))


(define LECTURE-HALL
  (overlay (col ROWS (row COLS SQR))
           MTS))

; add-balloons: List-of-positions -> Image
; place the BALLOONs specified by the given posn on the LECTURE-HALL
(check-expect (add-balloons '()) LECTURE-HALL)
(check-expect (add-balloons (cons (make-posn 20 30) (cons (make-posn 68 28)'())))
              (place-image BALLOON 20 30
                           (place-image  BALLOON 68 28
                                         LECTURE-HALL)))

(define (add-balloons l)
  (cond [(empty? l) LECTURE-HALL]
        [else
         (place-image BALLOON
                      (posn-x (first l))
                      (posn-y (first l))
                      (add-balloons (rest l)))]))

(add-balloons '())
(add-balloons (cons (make-posn 0 0) '())) ; the 10th is on top left corner 
(add-balloons (cons (make-posn 20 30) (cons (make-posn 70 25) '())))
(add-balloons LOP3)

