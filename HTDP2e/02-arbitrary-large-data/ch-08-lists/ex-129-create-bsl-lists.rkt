;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex-129-create-bsl-lists) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp")) #f)))
; a list of the planets in our solar system:
(cons "Mercury"
      (cons "Venus"
            (cons "Earth"
                  (cons "Mars"
                        (cons "Jupiter"
                              (cons "Saturn"
                                    (cons "Uranus"
                                          (cons "Neptune" '()))))))))
; a list of item for a meal:
(cons "steak"
      (cons "french frise"
            (cons "beans"
                  (cons "bread"
                        (cons "water"
                              (cons "Brie"
                                    (cons "cheese"
                                          (cons "ice cream" '()))))))))


; a list of 3 colors:

(cons "red"
      (cons "green"
            (cons "blue" '())))

; Sketch some box representations of these lists, similar to those in figures 44 and 45.
; Which of the sketches do you like better? 