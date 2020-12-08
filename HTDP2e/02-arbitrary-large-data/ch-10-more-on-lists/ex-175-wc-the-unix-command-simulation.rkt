;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex-175-wc-the-unix-command-simulation) (read-case-sensitive #t) (teachpacks ((lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
(define-struct cr [ln wd ch])
; A CountResult is a structure:
; (make-cr Natural Natural Natural)
; and represents the line, word, and 1String counts ln wd ch
(define CR0 (make-cr 0 0 0))

; An LLS is one of: 
; – '()
; – (cons Los LLS)
; interpretation a list of lines, each is a list of Strings
 
(define line0 (cons "hello" (cons "world" '())))
(define line1 '())
 
(define lls0 '())
(define lls1 (cons line0 (cons line1 '())))

; File -> CR
; produces a value that consists of three numbers
(define (wc f)
  (count (read-words/line f)))

; LLS -> CR
; counts ln, wd and ch in the given list
(check-expect (count lls0) (make-cr 0 0 0))
(check-expect (count lls1) (make-cr 2 2 10))
(define (count lls)
  (make-cr
   (lines lls) (words lls) (chars lls)))

; LLS -> Natural
; counts lns in the given list
(check-expect (lines '()) 0)
(check-expect (lines lls1) 2)
(define (lines lls)
  (length lls))

; LLS -> Natural
; counds wds in the given list
(check-expect (words '()) 0)
(check-expect (words lls1) 2)

(define (words lls)
  (cond
    [(empty? lls) 0]
    [else
     (+ (words-in-line (first lls))
        (words (rest lls)))]))

; LLS -> String
; couts words in the given line
(check-expect (words-in-line line1) 0)
(check-expect (words-in-line line0) 2)

(define (words-in-line l)
  (length l))

; LLS -> Natural
; counts chs in the given line
(check-expect (chars lls1)10)
(check-expect (chars lls0) 0)
(define (chars lls) 
  (cond
    [(empty? lls) 0]
    [else
     (+ (chars-in-line (first lls))
        (chars (rest lls)))]))

; LLS -> Natural
; counts all characters in the given line
(check-expect (chars-in-line line0) 10)
(check-expect (chars-in-line line1) 0)

(define (chars-in-line lls)
  (cond
    [(empty? lls) 0]
    [else (+ (chars-in-word (first lls)) (chars-in-line (rest lls)))]))

; String -> Natural
; counts characters of the given w
(check-expect (chars-in-word "cat") 3)
(define (chars-in-word w)
 (length (explode w)))




