;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex-103-data-for-zoo-animal) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; An Animals is (make-animals spider elephant boa-constricor armadillo)
(define-struct animals [spider elephant boa-constrictor armadillo])
; and represents zoo animals

; A Spider is (make-spider Number Number)
(define-struct spider [legs space])
; and represent remainng legs and the amountn of space in m3 (short for qubick meter)
; spider needs in case of tarnsprt

; fn-for-spider : Spider -> ?
(define (fn-for-spider s)
  (... (spider-legs s)
       (spider-space s)))

; An Elephant is a space
(define-struct elephant [space])
; and represent the amount of space in m3 an elephant needs for transport

; fn-for-elephant: Elephant -> ?
(define (fn-for-elephant e)
  (... (elephant-space e)))

; A BoaConstrictor (make-boa Number Number)
(define-struct boa-constrictor [length grith])
; and represents a snake with langth and grith

; fn-for-boa: BoaConstrictor -> ?
(define (fn-for-boa b)
  (... (boa-consrictor-length b)
       (boa-constrictor grith b)))

; An Armadillo is (make-armodillo Number Number Boolean]
(define-struct armadillo [length weigt space female?])
; represents armodillo w length in cm, weight in kg, space need for transport, and
; determine if, it's female



(define ORB-WEAVER (make-spider 7 0.01))
(define JUMBO (make-elephant 3))
(define B0 (make-boa-constrictor 123 30))
(define ARM0 (make-armadillo 75 25 1.4 #F))

(define A0 (make-animals ORB-WEAVER JUMBO B0 ARM0))

; fn-for-animals: ZooAnimals -> ?
(define (fn-for-animals za)
  (... (fn-for-spider (spider-legs za)
                      (spider-space za))
       (fn-for-elephant (spider-space za))
       (fn-for-boa-constrictor (boa-constrictor-length za)
                               (boa-constrictor-grith za))
       (fn-for-armadillo (armadillo-length za)
                         (armadillo-weight za)
                         (armadillo-space za)
                         (armadillo-female? za))))

; fits? : ZooAnimal Number -> Boolean
; return true, if the given cage's volume fits the animal
(check-expect (fits? ORB-WEAVER 0.2) #t)
(check-expect (fits? ORB-WEAVER 0.002) #f)
(check-expect (fits? JUMBO 0.2) #f)
(check-expect (fits? JUMBO  3.5) #t)
(check-expect (fits? B0 0.2) #f)
(check-expect (fits? B0 0) #f)
(check-expect (fits? ARM0 1.5) #t)
(check-expect (fits? ARM0 1.2) #f)
(define (fits? za n)
  (cond [(spider? za) (< (spider-space za) n)]
        [(elephant? za) (< (elephant-space za) n)]
        [(armadillo? za) (< (armadillo-space za) n)]
        [else #f]))