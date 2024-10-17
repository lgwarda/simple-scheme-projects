;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |ex-159-riot68-animation |) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp")) #f)))
; In 1968 a small group of students meets to make paint-filled balloons,
; enters some lecture hall, and randomly throws the balloons at the attendees.
; The Riot68 displays how the balloons color the seats in the lecture hall.

; Constans:

(define SQR (square 10 "outline" "black"))
(define BALLOON (circle 3 "solid" "red"))

(define COLS 10)
(define ROWS 20)

(define RC (* 5 (random COLS)))
(define RR (* 5 (random ROWS)))

(define MTS
  (empty-scene (* COLS (image-width SQR))
               (* ROWS (image-width SQR))))

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

; Data definitions:

(define-struct pair [balloon# lob])
; A Pair is a structure (make-pair N List-of-posns)
; A List-of-posns is one of: 
; – '()
; – (cons Posn List-of-posns)
; interpretation (make-pair n lob) means n balloons 
; must yet be thrown and added to lob

(define P1 (make-pair 0 '()))
(define P2 (make-pair 1 (cons (make-posn 19 68) '())))
(define P3 (make-pair 3 (cons (make-posn 30 60)
                              (cons (make-posn 40 80)
                                    (cons (make-posn 50 100)
                                          '())))))

; Functions:

; riot: Pair -> Pair
; start Riot with (riot P3)
(define (riot p)
  (big-bang p
    (on-tick next-balloon)
    (to-draw add-balloons)))


; next-balloon: Pair -> PAIR
; produce random # of balloons droping one ofter another at rate of one per second
;

(check-random (next-balloon P1) P1)
(check-random (next-balloon P2)
              (make-pair 0 (cons (make-posn RC RR)
                                 (cons (make-posn 19 68) '()))))
(define (next-balloon p)
  (throw-balloon p RC RR))

; throw-balloon: Pair Number Number -> Pair
(check-expect (throw-balloon (make-pair 0 '()) 19 68) (make-pair 0 '()))
(check-expect (throw-balloon (make-pair 1 (cons (make-posn 10 20) '())) 19 68)
              (make-pair 0 (cons (make-posn 19 68) (cons (make-posn 10 20) '()))))

(define (throw-balloon p x y)
  (cond [(zero? (pair-balloon# p)) p]
        [else
         (make-pair (sub1 (pair-balloon# p))
                    (cons (make-posn x y) (pair-lob p)))]))

; add-balloons: Pair -> Image
; place the images of BALLOONs on LECTURE-HALL
(check-expect (add-balloons P1) LECTURE-HALL)
(check-expect (add-balloons P2) (place-image BALLOON 19 68 LECTURE-HALL))
(check-expect (add-balloons P3) (place-image
                                 BALLOON 30 60
                                 (place-image
                                  BALLOON 40 80
                                  (place-image
                                   BALLOON 50 100
                                   LECTURE-HALL))))

(define (add-balloons p)
  (cond [(empty? (pair-lob p)) LECTURE-HALL]
        [else
         (place-image BALLOON
                      (posn-x (first (pair-lob p)))
                      (posn-y (first (pair-lob p)))
                      (add-balloons (make-pair(pair-balloon# p)
                                              (rest (pair-lob p)))))]))


(riot P3)
