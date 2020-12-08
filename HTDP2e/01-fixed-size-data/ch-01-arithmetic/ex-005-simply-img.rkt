;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex-005-simply-img) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(define CROWN-SIZE 30)
(define TREE-CROWN (circle CROWN-SIZE "solid" "green"))
(define TRUNK-WIDTH 5)
(define TRUNK-HEIGHT 20)
(define TRUNK-OF-TREE (rectangle TRUNK-WIDTH TRUNK-HEIGHT "solid" "brown"))

(define TREE (above
              TREE-CROWN
              TRUNK-OF-TREE))
  
 

