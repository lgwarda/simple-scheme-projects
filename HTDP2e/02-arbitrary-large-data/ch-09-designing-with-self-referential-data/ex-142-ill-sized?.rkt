;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex-142-ill-sized?) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))
; constans:
(define S05 (rectangle  5 5  "solid" "red"))
(define S10 (rectangle 10 10 "solid" "green"))
(define R20 (rectangle 20 15 "solid" "blue"))

; A List-of-image is one of:
; - '()
; - (cons Image List-of-image)

(define LOI0 '())
(define LOI1 (cons S05 '()))


; ImageOrFalse is one of:
; – Image
; – #false

; ill-sized?: LOI PositiveNumber -> ImageOrFalse
; produces the first image on loi that is not an n by n square, otherwise #f
(check-expect (ill-sized? LOI0 5) #f)
(check-expect (ill-sized? LOI1 5) #f)
(check-expect (ill-sized? (cons S05 '()) 20) S05)
(check-expect (ill-sized? (cons R20 '()) 20) R20)
(check-expect (ill-sized? (cons R20 (cons S10 '())) 10) R20)
(check-expect (ill-sized? (cons S10 (cons R20 (cons S05 '()))) 10) R20)
(check-expect (ill-sized? (cons S10 (cons S05 (cons R20 '())))  5) S10)

(define (ill-sized? l n)
  (cond [(empty? l)  #f]
        [else
         (if (not (n-by-n? (first l) n))
             (first l)
             (ill-sized? (rest l) n))]))

; n-by-n?: Image Number -> Boolean
; produce #t, if the given i is an n by n square
(check-expect (n-by-n? S05 5) #t)
(check-expect (n-by-n? R20 20) #f)
(check-expect (n-by-n? (circle 3 "solid" "red") 3) #f)

(define (n-by-n? i n )
 (and
  (= (image-width i) n)
  (= (image-height i) n)))