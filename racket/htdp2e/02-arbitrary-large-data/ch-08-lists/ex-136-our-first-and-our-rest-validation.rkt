;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex-136-our-first-and-our-rest-validation) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define-struct pair [left right])


; A ConsOrEmpty is one of:
; – '()
; – (cons Any ConsOrEmpty)
; interpretation ConsOrEmpty is the class of all lists

; Any ConsOrEmpty -> ConsOrEmpty
(define (our-cons a-value a-list)
  (cond
    [(empty? a-list) (make-pair a-value a-list)]
    [(pair? a-list) (make-pair a-value a-list)]
    [else (error "cons: second argument ...")]))

; ConsOrEmpty -> Any
; extracts the left part of the given pair
(define (our-first a-list)
  (if (empty? a-list)
      (error 'our-first "...")
      (pair-left a-list)))

; ConsOrEmpty -> ConsOrEmpty
; extracts the right part of a from the given pair
(define (our-rest a-list)
  (if (empty? a-list)
      (error 'our-first "...")
      (pair-right a-list)))

(our-first (our-cons "a" '()))
; == "a"
(our-first
 (cond [(empty? '()) (make-pair "a" '())]
       [(pair? '()) (make-pair "a" '())]
       [else (error "cons: second argument ...")]))
; == "a"
(our-first
 (cond [#true (make-pair "a" '())]
       [(pair? '()) (make-pair "a" '())]
       [else (error "cons: second argument ...")]))
; == "a"
(our-first (make-pair "a" '()))
; == "a"
(if (empty?  (make-pair "a" '()))
    (error 'our-first "...")
    (pair-left  (make-pair "a" '())))
; == "a"
(if #f
    (error 'our-first "...")
    (pair-left  (make-pair "a" '())))
; == "a"
(pair-left  (make-pair "a" '()))
; == "a"
"a"

(our-rest (our-cons "a" '()))  ; == '()