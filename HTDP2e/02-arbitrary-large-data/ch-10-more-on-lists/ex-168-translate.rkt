;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex-168-translate) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp")) #f)))
; List-of-posns -> List-of-posns
; produce a list of positions
(check-expect (translate '()) '())
(check-expect (translate (cons (make-posn 1 1) '())) (cons (make-posn 1 (+ 1 1)) '()))
(check-expect (translate (cons (make-posn 2 2)
                               (cons (make-posn 5 7)
                                     '())))
              (cons (make-posn 2 3)
                    (cons (make-posn 5 8)
                          '())))
(define (translate lop)
  (cond [(empty? lop) '()]
        [else
         (cons (make-posn
                (posn-x (first lop))
                (+ (posn-y (first lop)) 1))
                (translate (rest lop)))]))