;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex-234) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Constans :
(define one-list
  '("Asia: Heat of the Moment"
    "U2: One"
    "The White Stripes: Seven Nation Army"))

; ranking : List-of-string -> ... nested list ...
; produce a list of ranked song titles
(define (ranking los)
  (reverse (add-ranks (reverse los))))

(check-expect (ranking '("Asia: Heat of the Moment"))
              (list (list 1 "Asia: Heat of the Moment")))
(check-expect (ranking '("Asia: Heat of the Moment" "U2: One"))
              (list (list 1 "Asia: Heat of the Moment")
                    (list 2 "U2: One")))

; add-ranks : List-of-strings -> ... nested list ...
; add ranked song title to the given list
(define (add-ranks los)
  (cond
    [(empty? los) '()]
    [else (cons (list (length los) (first los))
                (add-ranks (rest los)))]))

(check-expect (add-ranks '()) '())
(check-expect (add-ranks '("Asia: Heat of the Moment"))
              (list '(1 "Asia: Heat of the Moment")))
(check-expect (add-ranks one-list)
              (list (list 3 "Asia: Heat of the Moment")
                    (list 2 "U2: One")
                    (list 1 "The White Stripes: Seven Nation Army")))

; make-ranking : List-of-strings -> ... nested list ...
; produces a list representation of an HTML table
(define (make-ranking los)
  `(table ,@(make-row (ranking los))))

(check-expect (make-ranking one-list)
              (list
               'table
               (list 'tr (list 'td 1) (list 'td "Asia: Heat of the Moment"))
               (list 'tr (list 'td 2) (list 'td "U2: One"))
               (list 'tr (list 'td 3) (list 'td "The White Stripes: Seven Nation Army"))))

; List-of-strings -> ... nested list ...
(define (make-row los)
  (cond [(empty? los) '()]
        [else (cons `(tr ,@(make-cell (first los)))
                    (make-row (rest los)))]))
(check-expect (make-row '()) '())
(check-expect (make-row '(("1" "GBV: Adverse Wind")
                          ("2" "Gin Blossoms: Hey Jealousy")))
              (list
               (list 'tr (list 'td "1") (list 'td "GBV: Adverse Wind"))
               (list 'tr (list 'td "2") (list 'td "Gin Blossoms: Hey Jealousy"))))
              

; List-of-strings -> ... nested list ...
(define (make-cell los)
  (cond [(empty? los) '()]
        [else (cons (list 'td (first los))
                    (make-cell (rest los)))]))

(check-expect (make-cell '()) '())
(check-expect (make-cell '("2" "U2: One"))'((td "2") (td "U2: One")))




