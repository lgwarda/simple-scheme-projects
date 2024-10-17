;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ass8) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 1

; List-of-string -> String
; concatenates all strings in l into one long string
(check-expect (cat '()) "")
(check-expect (cat (cons "a" (cons "b" '()))) "ab")
(check-expect
 (cat (cons "ab" (cons "cd" (cons "ef" '()))))
 "abcdef")
; (cons "a" (cons "b" '()))
; (first l)          == "a"
; (rest l)           == (cons "b" '())
; (cat (rest l)      == "b" 
; (cat l)            == "ab"
(define (cat l)
  (cond
    [(empty? l) ""]
    [else (string-append (first l)
                         (cat (rest l)))]))

(cat (cons "a" (cons "b" '())))
; exercise 2

#|
We could dub this fn concatenate insted of cat, then fn name would by preatty self-explanatory.
I'm no quiet sure if I answer the question corectly. Good night!!
|#

; em: Number -> Number
; calulate the em from px, 1 em is 16px
(define (em x)
  (* x 16))

(check-expect (em 1) 16)
(check-expect (em 2.5) (* 2.5 16))

; px -> em
(define (px x)
  (/ x 16))

(check-expect (px 16) 1)
(check-expect (px 40) 2.5)


; root-the-squares: [list-of Num] -> [list-of Num]
; returns a list of the square roots of all the perfect square
; given: '(1 4 9 16 25 36 49 64 81 100), expect ;'(1 2 3 4 5 6 7 8 9 10)
(define (root-the-squares lon)
  (cond [(empty? lon) '()]
        [else (cons (sqrt (first lon))
                    (root-the-squares (rest lon)))]))
(check-expect (root-the-squares '()) '())
(check-expect (root-the-squares  '(4 9)) '(2 3))

