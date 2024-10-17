;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex-134-contains?) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; contains?: String List-of-strings -> Boolean
; determines whether given srtring occurs on a given alos
(check-expect (contains? "a" '()) #f)
(check-expect (contains? "a" (cons "b" '())) #f)
(check-expect (contains? "Flatt" (cons "Flatt" (cons "c" '()))) #t)
(check-expect (contains? "Flatt" (cons "a" (cons "b" (cons "c" (cons "Flatt" '()))))) #t)
(check-expect (contains? "Flatt" (cons "a" (cons "b" (cons "c" (cons "FLATT" '()))))) #f)

(define (contains? str alos)
  (cond [(empty? alos) #f]
        [(cons? alos)
         (or (string=? (first alos) str)
             (contains? str (rest alos)))]))