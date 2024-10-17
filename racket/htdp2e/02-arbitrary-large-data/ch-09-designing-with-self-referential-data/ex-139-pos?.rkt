;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex-139-pos?) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; A List-of-amounts is one of: 
; – '()
; – (cons PositiveNumber List-of-amounts)

; A List-of-numbers is one of: 
; – '()
; – (cons Number List-of-numbers)

(define L0 '())
(define L1 (cons 1 '()))
(define L2 (cons 1 (cons 2 (cons 3 '()))))
(define L3 (cons -1 (cons -2 (cons -3 (cons -4 '())))))
(define L4 (cons 2 (cons 1 (cons 7.5 '()))))
(define L5 (cons -1 (cons 1 (cons 2 '()))))



; process-l: L -> ...
(define (process-l l)
  (cond [(empty? l) ...]
        [else
         (... (first l) ...
              ... (process-l (rest l)) ...)]))

; sum: List-of-amounts -> PositiveNumber
; produce sum of the amounts
(check-expect (sum L0) 0)
(check-expect (sum L1) 1)
(check-expect (sum L4) (+ 2 1 7.5))

(define (sum l)
  (cond [(empty? l) 0]
        [else
         (+ (first l)
            (sum (rest l)))]))

(sum (cons 1 (cons 2 (cons 3 (cons 4 '()))))) ; == 10

; pos?: LON -> Boolean
; produce #t, if and only if the given list contains positive numbers
(check-expect (pos? L0) #f)
(check-expect (pos? L2) #t)
(check-expect (pos? L3) #f)
(check-expect (pos? L5) #t)
(check-expect (pos? (cons 4 (cons 2 (cons 1 (cons -3 (cons -5 '())))))) #t)
; (define (pos? l) #f)
(define (pos? l)
  (cond [(empty? l) #f]
        [else
         (if (> (first l) 0)
             #t
             (pos? (rest l)))]))

(pos? (cons 5 '()))  ; == #t

(pos? (cons -1 '())) ; == #f

; checked-sum: LON -> PositiveNumber
; produce sum if the input also belongs to List-of-amounts; otherwise it signals an error
(check-expect (checked-sum L0) 0)
(check-expect (checked-sum L2) (+ 1 2 3))
(check-error (checked-sum L3) (error "expect positive #"))
; (define (checked-sum l) 0)
(define (checked-sum l)
  (cond [(empty? l) 0]
        [(not (pos? l)) (error "expect positive #")]
        [else
         (if (> (first l) 0)
             (sum l)
             (checked-sum (rest l)))]))