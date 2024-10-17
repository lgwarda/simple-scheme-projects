;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex-15-sunny-and-friday) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; ==>: Boolean Boolean -> Boolean
; produce always #true if sunny is fales or friday is true
(check-expect (==> #t #t) #t)
(check-expect (==> #t #f) #f)
(check-expect (==> #f #t) #t)
(check-expect (==> #f #f) #t)

(define (==> sunny friday)
  (or (not sunny) friday))




