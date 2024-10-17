;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex-164-convert-euro) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp")) #f)))
(define CURRENT-RATE 0.88) ; exchange rate: U.S. dollar = 0.881475096 Euros for 2018-11-09 07:12 UTC

; Number -> Number
; convert a US$ to a Euro ammount with a given CURRENT-RATE
(check-expect (convert-euro 0) 0)
(check-expect (convert-euro 1) CURRENT-RATE)
(check-expect (convert-euro 10) (* 10 CURRENT-RATE))
(define (convert-euro $)
  (* $ CURRENT-RATE))


; converts-euro*: List-of-amounts -> List-of-amounts
; produce a list of € converted from US$
(check-expect (convert-euro* '()) '())
(check-expect (convert-euro* (cons 1 '())) (cons (* 1 CURRENT-RATE)'()))
(check-expect (convert-euro* (cons 1 (cons 10 (cons 100 '()))))
              (cons (convert-euro 1)
                    (cons (convert-euro 10)
                          (cons (convert-euro 100) '()))))

(define (convert-euro* loa)
  (cond [(empty? loa) '()]
        [else
         (cons (convert-euro (first loa))
              (convert-euro* (rest loa)))]))
