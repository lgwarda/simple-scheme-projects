;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname lab-1-the-basics) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; multiple-of-5? : Number -> Boolean
; produce #t, if the given # is a multiplle of 5
(check-expect (multiple-of-5? 0) #f)
(check-expect (multiple-of-5? 5) #t)
(define (multiple-of-5? n)
  (if (and (= (modulo n 5) 0) (> n 0))
      #t
      #f))

; wreck-it : Number -> Number
; produce the # of windows to go
; given 1, expect 4
; given 5, expect 20
(define (wreck-it m)
  (* m 4))

(check-expect (wreck-it 0) 0)
(check-expect (wreck-it 1) 4)
(check-expect (wreck-it 5) 20)

(define GREETING "Hi, ")

; greet : String -> String
; appends the name to the GREETING
; given: "Luke" , expect: "Hi, Luke"
(define (greet name)
  (string-append GREETING name))

(check-expect (greet "Tania") "Hi, Tania")
(check-expect (greet "Luke") "Hi, Luke")

; (multiple-of-5? "cat") == modulo: expects an integer as 1st argument, given "cat"
; (greet #t) == string-append: expects a string as 2nd argument, given #true

; times-itself : Number -> Number
; Multiply a number by itself
(check-expect (times-itself 0) 0)
(check-expect (times-itself 2) 4)
(check-expect (times-itself 3) 9)
#;
(define (times-itself n)
  (+ n n))

(define (times-itself n)
  (* n n))

; test function with at least one odd #

; absolute: Number -> Number
; produce the absolute value of the given #
(check-expect (absolute -1) 1)
(check-expect (absolute 0)  0)
(check-expect (absolute 2)  2)
(define (absolute x)
  (cond [(>= x 0) x]
        [(< x 0)  (- x)]))

; num-tvs : Number -> Number
; produce a # of TV you can buy
(check-expect (num-tvs 140) 1)
(check-expect (num-tvs 240) 2)
(check-expect (num-tvs 19500) 300)
(check-expect (num-tvs 10000) 71)
(check-expect (num-tvs 50000000) 769230)
(define (num-tvs num)
  (cond [(>= num  (* 300 65)) (floor (/ num 65))]
        [else (round (/ num 140))]))



; procent-remembered : Number  Boolean -> Number
; produce the % of the material person will remember after took notes
; #f means the person took hand-writen notes, othrwise using laptop
(check-expect (procent-remembered 24 #t) 80)
(check-expect (procent-remembered 23 #t) 80)
(check-expect (procent-remembered 25 #t) 40)
(check-expect (procent-remembered 24 #f) 70)
(check-expect (procent-remembered 25 #f) 70)
(define (procent-remembered num notes?)
  (cond [(and (> num 24) notes?) 40]
        [(and (<= num 24) notes?) 80]
        [else 70]))






(define HAUSE (square 50 "solid" "red"))
(define ROOF (triangle 60 "solid" "brown"))
(define DOOR (rectangle 20 40 "solid" "brown"))
(define HANDLE (circle 2 "solid" "gold"))
(define WINDOW (rectangle 10 20 "solid" "blue"))
(overlay/align "center" "bottom"
               (overlay/align "left" "center" HANDLE DOOR)
               (above ROOF HAUSE))


                  
 (overlay/align "center" "bottom"
               (overlay/align "left" "center" HANDLE DOOR)
               (above ROOF
                      (overlay/align "left" "center" WINDOW
                                     (overlay/align "right" "center" WINDOW HAUSE))))

(define MTS (empty-scene 50 50))

; scene : Natutal -> Image
; produce the circle of the radiuse max 20 at the center on MTS
(check-expect (scene 10) (place-image (circle (modulo 10 20) "solid" "black") 25 25 MTS))
(check-expect (scene 20) (place-image (circle (modulo 20 20)"solid" "black") 25 25 MTS))
(check-expect (scene 21) (place-image (circle (modulo 21 20) "solid" "black") 25 25 MTS))

(define (scene natural)
  (place-image (circle (modulo natural 20) "solid" "black")
               (/(image-width MTS)  2)
               (/(image-height MTS) 2)
               MTS))

(animate scene)

;Pixar Whomst?
;
;Goals: Use math (gasp) and conditional programming to make the animation better.
;
;Exercise 19 Use cond (or if if you’re feeling cheeky)
;to make the circle grow and shrink in a loop instead of
;grow and suddenly dissapear and grow again.
;Since computing the radius is now a somewhat complex computation,
;it makes sense to write a seperate helper function which only computes the radius that scene calls.
;Hint: quotient, even?.