;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex-113-design-predicate) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp")) #f)))
; A UFO is a Posn. 
; interpretation (make-posn x y) is the UFO's location 
; (using the top-down, left-to-right convention)
 
(define-struct tank [loc vel])
; A Tank is a structure:
;   (make-tank Number Number). 
; interpretation (make-tank x dx) specifies the position:
; (x, HEIGHT) and the tank's speed: dx pixels/tick 
 
; A Missile is a Posn. 
; interpretation (make-posn x y) is the missile's place

(define-struct aim [ufo tank ])
(define-struct fired [ufo tank missle])
; A SIGS is one of:
; – (make-aim UFO Tank)
; – (make-fired UFO Tank Missile)
; interpretation represents the complete state of a
; space invader game



; sigs?: Any -> Boolean
; is a an element of the SIGS collection
(check-expect (sigs? (make-aim (make-posn 20 10) (make-tank 28 -3))) #t)
(check-expect (sigs? (make-fired (make-posn 20 100)
                                 (make-tank 100 3)
                                 (make-posn 22 103))) #t)
(check-expect (sigs? "(make-aim (make-posn 20 10) (make-tank 28 -3))") #f)
(check-expect (sigs? (circle 3 "solid" "red"))  #f)
(check-expect (sigs? (make-tank 20 10)) #f)
(check-expect (sigs? #f) #f)
(check-expect (sigs? #t) #f)
(check-expect (sigs? 2)  #f)

(define (sigs? a)
    (or (aim? a) (fired? a)))
       

(define-struct coordinate [ y x posn])
; A Coordinate is one of:
; – a NegativeNumber 
; interpretation on the y axis, distance from top
; – a PositiveNumber 
; interpretation on the x axis, distance from left
; – a Posn
; interpretation an ordinary Cartesian point

; coord?: Any -> Boolean
; is a an element of the coord? collection
(check-expect (coord? -1) #t)
(check-expect (coord?  1) #t)
(check-expect (coord? (make-posn 1 -1)) #t)
(check-expect (coord? "an ordinary Cartesian point") #f)
(check-expect (coord? #t) #f)
(check-expect (coord? #f) #f)
(check-expect (coord? (circle 3 "solid" "red")) #f)

(define (coord? a)
  (or (number? a) (posn? a)))




(define-struct vcat [x-cat h])
; A VCat is a structure:
;   (make-vcat Number Number)
; interp. x-cat means a x-coordinate of a VCat
;         h means a level of VCat's happyness


(define-struct vcham [x-cham h c])
; A VCham is a struct like:
;   (make-vcham Natural Number[0, 100] String)
; interp. x-cham is center of a VCham and position, in pixels
;         h is the level of happiness between 0 and 100
;         c is a color, red or green or blue

; A VAnimal is either
; – a VCat
; – a VCham
; interp.  A VAnimal is one of two kinds of animals

; vanimal?: Any -> Boolean
; is a an element of the VAnimal collection
(check-expect (vanimal? (make-vcat 100 50)) #t)
(check-expect (vanimal? (make-vcham 100 50 "green")) #t)
(check-expect (vanimal? -10050) #f)
(check-expect (vanimal? "green") #f)
(check-expect (vanimal? (empty-scene 100 50)) #f)
(check-expect (vanimal? #t) #f)
(check-expect (vanimal? #f) #f)
(check-expect (vanimal? (make-posn 100 50)) #f)

(define (vanimal? a)
  (or (vcat? a) (vcham? a)))
