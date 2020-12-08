;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex-176-matrix) (read-case-sensitive #t) (teachpacks ((lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; A Matrix is one of: 
;  – (cons Row '())
;  – (cons Row Matrix)
; constraint all rows in matrix are of the same length
 
; A Row is one of: 
;  – '() 
;  – (cons Number Row)

(define R0 '())
(define R1 (cons 11 (cons 12 '())))
(define R2 (cons 21 (cons 22 '())))

(define M0 (cons R1 '()))
(define M1 (cons R1 (cons R2 '())))

(define row1 (cons 11 (cons 12 '())))
(define row2 (cons 21 (cons 22 '())))
(define mat1 (cons row1 (cons row2 '())))


; Matrix -> Matrix
; transposes the given matrix along the diagonal 
 
(define wor1 (cons 11 (cons 21 '())))
(define wor2 (cons 12 (cons 22 '())))
(define tam1 (cons wor1 (cons wor2 '())))

(check-expect (transpose mat1) tam1)
 
(define (transpose lln)
  (cond
    [(empty? (first lln)) '()]
    [else (cons (first* lln) (transpose (rest* lln)))]))

; Matrix -> Lon
; produces the first column as a list of numbers
(check-expect (first* '()) '())
(check-expect (first* M1) (cons 11 (cons 21 '())))

(define (first* m)
  (cond [(empty? m)'()]
        [else
         (cons (first (first m))
                (first* (rest m)))]))

; Matrix -> Matrix
; removes the first column
(check-expect (rest* '()) '())
(check-expect (rest* M1)
              (cons (cons 12 '())
                    (cons (cons 22 '())
                          '())))
(define (rest* m) 
  (cond [(empty? m) '()]
        [else
         (cons (rest (first m))
               (rest* (rest m)))]))