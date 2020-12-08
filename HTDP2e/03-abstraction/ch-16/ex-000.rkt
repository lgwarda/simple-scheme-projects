;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname ex-000) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))
(define (contains? s l)
  (cond [(empty? l) #f]
        [else (or (string=? (first l) s)
                   (contains? s (rest l)))]))


(define (atom? l)
  (contains? "atom" l))


(define (zoo? l)
  (contains? "zoo"  l))



(define (basic? l)
  (contains? "basic"  l))


(zoo? '("zoo"))
(atom?  '())
(atom?  '("basic" "zoo" "atom"))
(basic? '("zoo" "elephant" "lion" "monkey"))