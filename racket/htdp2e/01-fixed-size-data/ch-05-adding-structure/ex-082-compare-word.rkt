;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex-082-compare-word) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; data definitions:

; Letter is one of:
; 1String [a,z]
; #false
; interp. lower case letters [a,z] or no letter

(define l0 #f)
(define l1 "a")
(define l2 "g")

(define-struct 3lw [l1 l2 l3])
; A ThreeLetterWord (in short 3lw) is a structure:
;  (make-3lw Letter Letter Letter)
; interp. l1, l2, l3 are the lower case letter from "a" to "z"
;         #f means no letter

(define W0 (make-3lw "d" "o" #f))
(define W1 (make-3lw "d" "o" "g"))
(define W2 (make-3lw "d" "o" "m"))

; Functions:

; compare-word: 3lw 3lw -> 3lw
; returm a word that indicates where the given ones agree or disagree
(check-expect (compare-word (make-3lw "d" "o" "g") (make-3lw "d" "o" "g"))
              (make-3lw "d" "o" "g"))
(check-expect (compare-word (make-3lw "d" "o" "g") (make-3lw "c" "a" "t"))
              (make-3lw #f #f #f))
(check-expect (compare-word (make-3lw "d" "o" "g") (make-3lw "d" "o" "m"))
              (make-3lw "d" "o" #f))

(define (compare-word w1 w2)
  (make-3lw (compare-letter (3lw-l1 w1) (3lw-l1 w2))
            (compare-letter (3lw-l2 w1 ) (3lw-l2 w2 ))
            (compare-letter (3lw-l3 w1) (3lw-l3 w2))))

; compare-letter: Letter Letter -> Letter
; return a letter that indicates where the given ones match or #f if not
(check-expect (compare-letter "a" "a") "a")
(check-expect (compare-letter "a" "b") #f)
(check-expect (compare-letter #f   #f) #f)

(define (compare-letter l1 l2)
  (cond [(and (string? l1) (string<=? "a" l1 "z")
              (string? l2) (string<=? "a" l2 "z"))
         (cond [(string=? l1 l2) l1]
               [else #f])]
        [else #f]))
