;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex-170-replace) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp")) #f)))
(define-struct phone [area switch four])
; A Phone is a structure: 
;   (make-phone Three Three Four)
; A Three is a Number between 100 and 999. 
; A Four is a Number between 1000 and 9999.
(define P1 (make-phone 100 999 9999))

; A List-of-Phones is:
; - '()
; - (cons Phones List-of-phones)
; a list of phones # 

; List-of-Phones -> List-of-Phones
; porduce list with the correct area code
(check-expect (replace '()) '())
(check-expect (replace (cons (make-phone 113 000 7600) '())) (cons (make-phone 113 000 7600) '()))
(check-expect (replace (cons (make-phone 713 067 7601) '())) (cons (make-phone 281 067 7601) '()))
(check-expect (replace (cons (make-phone 281 067 7602) '())) (cons (make-phone 281 067 7602) '()))
(check-expect (replace (cons (make-phone 113 067 7600) (cons (make-phone  713 067 7601) '())))
              (cons (make-phone 113 067 7600) (cons (make-phone  281 067 7601) '())))


(define (replace lop)
  (cond [(empty? lop) '()]
        [else
             (cons (filter-area (first lop))
                   (replace (rest lop)))]))

; Phone -> Phone
; replaces all occurrence of area code 713 with 281
(check-expect (filter-area P1) P1)
(check-expect (filter-area (make-phone 713 000 8999)) (make-phone 281 000 8999))

(define (filter-area p)
  (if (= (phone-area p) 713)
      (make-phone 281 (phone-switch p) (phone-four p))
      p))
