;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex-160-set+) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp")) #f)))
; A Son.L is one of:
; – empty
; – (cons Number Son.L)
;
; Son is used when it
; applies to Son.L and Son.R

; A Son.R is one of:
; – empty
; – (cons Number Son.R)
;
; Constraint If s is a Son.R,
; no number occurs twice in s.

; Son
; empty set
(define es '())

; Number Son -> Son
; is x in s
(define (in? x s)
  (member? x s))

; Number Son.L -> Son.L
; remove x from s
(define s1.L
  (cons 1 (cons 1 '())))

(check-expect
 (set-.L 1 s1.L) es)

(define (set-.L x s)
  (remove-all x s))

; Number Son.R -> Son.R
; remove x from s
(define s1.R
  (cons 1 '()))

(check-expect
 (set-.R 1 s1.R) es)

(define (set-.R x s)
  (remove x s))

(define A (cons 1 (cons 2 '())))

; set+.L: Number Set.L -> Set.L
; add x to the given set A
(check-expect (set+.L 3 A) (cons 3 (cons 1 (cons 2 '()))))
(check-expect (set+.L 1 A) (cons 1 (cons 1 (cons 2 '()))))

(define (set+.L x s)
  (append (cons x '()) s))

; set+.R: Number Set.R -> Set.R
; add x to the given set A
(check-expect (set+.R 1 A) (cons 1 (cons 2 '())))
(check-expect (set+.R 3 A) (cons 3 (cons 1 (cons 2 '()))))

(define (set+.R x s)
  (cond [(member? x s) s]
        [else (set+.L x s)]))