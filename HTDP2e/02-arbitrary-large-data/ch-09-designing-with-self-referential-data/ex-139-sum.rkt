;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex-139-sum) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; A List-of-amounts is one of: 
; – '()
; – (cons PositiveNumber List-of-amounts)

(define L0 '())
(define L1 (cons 1 '()))
(define L2 (cons 2 (cons 1 (cons 7.5 '()))))

; process-los: LOA -> ...
(define (process-loa l)
  (cond [(empty? l) ...]
        [else
         (... (first l)
              (process-loa (rest l)) ...)]))
; sum: List-of-amounts -> PositiveNumber
; produce sum of the amounts
(check-expect (sum L0) 0)
(check-expect (sum L1) 1)
(check-expect (sum L2) (+ 2 1 7.5))

(define (sum l) 0)
