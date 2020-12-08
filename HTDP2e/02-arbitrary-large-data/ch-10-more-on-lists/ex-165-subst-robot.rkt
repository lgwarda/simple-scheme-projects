;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex-165-subst-robot) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp")) #f)))

; subst-robot: List-of-strings -> List-of-strings
; replaces all occurrences of "robot" with "r2d2"; all other descriptions remain the same
(check-expect (subst-robot '()) '())
(check-expect (subst-robot (cons "robot" '())) (cons "R2D2" '()))
(check-expect (subst-robot (cons "Yoda" (cons "robot" '())))
              (cons "Yoda" (cons "R2D2" '())))
(check-expect (subst-robot (cons "Yoda" (cons "Darth Vader" '())))
              (cons "Yoda" (cons  "Darth Vader" '())))

(define (subst-robot los)
  (cond [(empty? los) '()]
        [else
         (if (string=? "robot" (first los))
             (cons "R2D2" (subst-robot (rest los)))
             (cons (first los)(subst-robot (rest los))))]))

; substitute: List-of-Strings String String -> List-of-srrings
; produces a new list of strings by substituting all occurrences of old with new
(check-expect (substitute '() "robot" "R2D2") '())
(check-expect (substitute (cons "Yoda" (cons "robot" '())) "robot" "R2D2")
              (cons "Yoda" (cons "R2D2" '())))
(check-expect (substitute (cons "Yoda" (cons "Darth Vader" '())) "robot" "R2D2")
              (cons "Yoda" (cons "Darth Vader" '())))
(check-expect (substitute (cons "Yoda" (cons "Darth Vader" (cons "robot" '()))) "robot" "R2D2")
              (cons "Yoda" (cons "Darth Vader" (cons "R2D2"'()))))

(define (substitute los old new)
  (cond [(empty? los) '()]
        [else
         (cons
          (if (string=? old (first los))
              new
              (first los))
          (substitute (rest los) old new))]))


