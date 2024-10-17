;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex-189-search-sorted) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))
; Number List-of-numbers -> Boolean
(define (search n alon)
  (cond
    [(empty? alon) #false]
    [else (or (= (first alon) n)
              (search n (rest alon)))]))

(check-expect (search 0 '()) #f)
(check-expect (search 1 (list 1 2 3)) #t)
(check-expect (search 2 (list 3 2 1)) #t)
(check-expect (search 0 (list 1 2 3)) #f)

; Number List-of-numbers -> Boolean
; produce #t if n occurs in the given alon (arranged in ascending order)
(check-expect (search-sorted 0 '()) #f)
(check-expect (search-sorted 0 (list 1)) #f)
(check-expect (search-sorted 0 (list 1 2 3)) #f)
(check-expect (search-sorted 1 (list 1 2 3)) #t)
(check-expect (search-sorted 4 (list 1 2 3)) #f)


(define (search-sorted n alon)
  (cond
    [(empty? alon) #f]
    [(< n (first alon)) #f] 
    [else (or (= (first alon) n)
              (search-sorted n (rest alon)))]))

