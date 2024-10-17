;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex-127-predicates) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp")) #f)))
(define-struct ball [x y speed-x speed-y])

;1
(number? (make-ball 1 2 3 4)) ; #false
;2
(ball-speed-y (make-ball (+ 1 2) (+ 3 3) 2 3)) ; 3
;3
(ball-y (make-ball (+ 1 2) (+ 3 3) 2 3)) ; 6

; Both 4. (ball-x (make-posn 1 2)) and 5. (ball-speed-y 5) == expects a ball, given... 