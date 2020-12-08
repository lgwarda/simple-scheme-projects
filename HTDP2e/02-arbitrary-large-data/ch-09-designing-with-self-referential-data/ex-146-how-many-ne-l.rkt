;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex-146-how-many-ne-l) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))
; An NEList-of-temperatures is one of: 
; – (cons CTemperature '())
; – (cons CTemperature NEList-of-temperatures)
; interpretation non-empty lists of Celsius temperatures 



; NEList-of-temperatures -> Number
; computes the average temperature 
(check-expect (average (cons 1 (cons 2 (cons 3 '()))))
              2)
 
(define (average ne-l)
  (/ (sum ne-l)
     (how-many ne-l)))


; NEList-of-temperatures -> Number 
; adds up the temperatures on the given list
(check-expect
  (sum (cons 1 (cons 2 (cons 3 '())))) 6)

(define (sum ne-l)
  (cond
    [(empty? (rest ne-l)) (first ne-l)]
    [else (+ (first ne-l) (sum (rest ne-l)))]))

 ; NEList-of-temperatures -> Number 
; counts the temperatures on the given list
(check-expect (how-many (cons 100 '())) 1)
(check-expect (how-many (cons 1 (cons 2 (cons 3 '())))) 3)


(define (how-many ne-l)
  (cond [(empty? (rest ne-l)) 1]
        [else  (+ (how-many (rest ne-l)) 1)]))

