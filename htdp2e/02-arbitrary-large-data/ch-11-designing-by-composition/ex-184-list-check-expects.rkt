;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex184-evaluation) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))
(check-expect (list (string=? "a" "b") #false)
              (list #f #f))
(check-expect (list (+ 10 20) (* 10 20) (/ 10 20))
              (list 30 200 0.5))
(check-expect (list "dana" "jane" "mary" "laura")
              (list "dana" "jane" "mary" "laura"))
