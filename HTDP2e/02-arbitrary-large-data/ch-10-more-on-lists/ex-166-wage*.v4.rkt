;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex-166-wage*.v4) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp")) #f)))
; Data definitions:

(define-struct employee [name number])
(define-struct paychecks [name amount])
(define-struct work [employee rate hours])

; An Employee is a structue:
;    (make-employee String Name)
; and represents employees name and #

; A (piece of) Work is a structure: 
;   (make-work Employee Number Number)
; interpretation (make-work n r h) combines the name 
; with the pay rate r and the number of hours h

; A Paycheck is a structure:
;    (make-paychecks Employee Number)
; and combines the enployee's name, number and chacks ammount is US$

; Low (short for list of works) is one of: 
; – '()
; – (cons Work Low)
; interpretation an instance of Low represents the 
; hours worked for a number of employees

(define W0 '())
(define W1 (cons (make-work (make-employee "Robby" 001) 11.95 39)
                 '()))
(define W2 (cons (make-work (make-employee "Matthew" 002) 12.95 45)
                 (cons (make-work (make-employee "Robby" 001) 11.95 39)
                       '())))

; Work -> ???
; a template for processing elements of Work
(define (for-work w)
  (... (work-employee w) ...
       ... (work-rate w) ...
       ... (work-hours w) ...))

; Low -> ???
; a template for processing elements of Low
(define (for-low low)
  (cond [(empty? low) ...]
        [else
         (... (first low) ...
              ... (for-low (rest-low)) ...)]))

; Paychecks -> ???
; a template for processing elements of Paychecks
(define (for-paychecks p)
  (... (paychecks-name p)
  (... (paychecks-amount p))))

; Employee -> ???
; a template for processing elemnts of Employee
(define (for-employee e)
  (... (employee-name e)
  (... (employee-number e))))

; Functions:

; Low -> Lop
; computes the weekly wages for the given records

; Low -> Lop
; computes a list of paychecks, one per record
(check-expect (wage*.v4 '()) '())
(check-expect (wage*.v4 W1) (cons (make-paychecks (make-employee "Robby" 001) (* 11.95 39)) '()))
(check-expect (wage*.v4 W2)
              (cons (make-paychecks (make-employee "Matthew" 2) (* 12.95 45))
                    (cons (make-paychecks (make-employee "Robby" 1) (* 11.95 39))
                          '())))

(define (wage*.v4 low)
  (cond [(empty? low) '()]
        [else
         (cons (wage.v4 (first low))
               (wage*.v4 (rest low)))]))

; Work -> Paychecks
; computes the ammount for the paychecks
(check-expect (wage.v4 (make-work (make-employee "Steve" 005) 11.95 100))
              (make-paychecks (make-employee "Steve" 005) 1195))

(define (wage.v4 w)
  (make-paychecks (work-employee w) (* (work-rate w) (work-hours w))))