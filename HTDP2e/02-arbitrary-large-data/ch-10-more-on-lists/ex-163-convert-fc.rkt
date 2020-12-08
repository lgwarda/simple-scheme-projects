;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex-163-convert-fc) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp")) #f)))
(define LOWEST-C-TEMP -274)
(define MASSAGE "Error: the lowest possible temperature is exceeded")

; List-of-messurement -> List-of-messurement
; yields list of from temp in Celcius
(check-expect (convertFC '()) '())
(check-expect (convertFC (cons 32 '())) (cons 0 '()))
(check-expect (convertFC (cons 120 (cons 100 (cons 32 '())))) (cons 49 (cons 38 (cons 0 '()))))
(check-error (convertFC (cons -300 (cons -400 (cons -500 (cons -555 '()))))))

(define (convertFC lom)
  (cond [(empty? lom) '()]
        [else
         (if(lowestC? (F2C (first lom)))
            (error MASSAGE)
            (cons (F2C (first lom))
                  (convertFC (rest lom))))]))

; Number -> Number
; convert the temperature from Fahrenheit to Celcius
(check-expect (F2C 32) 0)
(define (F2C f)
  (round (* (- f 32) 5/9)))

; Numner -> Boolean
; if the given c is larger than the lowest possible temp in Celcius
(check-expect (lowestC? -274) #f)
(check-expect (lowestC? -275) #t)

(define (lowestC? c)
  (> LOWEST-C-TEMP c))