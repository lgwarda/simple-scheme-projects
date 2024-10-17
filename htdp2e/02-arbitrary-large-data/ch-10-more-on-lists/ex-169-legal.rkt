;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex-169-legal) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp")) #f)))
; List-of-posns -> List-of-posns
; produce a list of positions where:
; - x-coordinates (0,100),
; - y-coordinates (0,200)
(check-expect (legal '()) '())
(check-expect (legal (cons (make-posn -10 -15)
                           (cons (make-posn 0 0)
                                 (cons (make-posn 5 99)
                                       (cons (make-posn 50 150)
                                             (cons (make-posn 99 199)
                                                   (cons (make-posn 100 200)
                                                                    '())))))))
              (cons (make-posn 5 99)
                    (cons (make-posn 50 150)
                          (cons (make-posn 99 199) '()))))

(define (legal lop)
  (cond [(empty? lop) '()]
        [else
         (if (legal? (first lop))
             (cons (first lop) (legal (rest lop)))
             (legal (rest lop)))]))

; Posn -> Boolean
; produce #t, if the x-coordinate between  the given range
; x = (0,100) and  y = (0,200)
(check-expect (legal? (make-posn -100  -200)) #f)
(check-expect (legal? (make-posn    0     0)) #f)
(check-expect (legal? (make-posn   10    20)) #t)
(check-expect (legal? (make-posn   99   100)) #t)
(check-expect (legal? (make-posn   99   199)) #t)
(check-expect (legal? (make-posn  100   200)) #f)
(check-expect (legal? (make-posn  200   100)) #f)


(define (legal? p)
  (and (< 0 (posn-x p) 100)
       (< 0 (posn-y p) 200)))