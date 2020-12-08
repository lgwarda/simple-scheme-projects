;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex-069-draw-box) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(define-struct movie [title producer year])
#|
 ___________________________________[movie]
[title     |producer                |year]
["The Drop"|"Big Screen Productions"|2014]
|#

(define-struct person [name hair eyes phone])

#|
 ______________________________________[person]
[name   |hair      |eyes         |phone
["Nadia"|"brunette"| "dark brown"|  "776-1009"] 
|#

(define-struct pet [name number])

#|
_____________[pet]
[name  |number  ]
["Roco"| 3334447]
|#

(define-struct CD [artist title price])

#|
___________________________________[CD]
[artist         |title          |price]
["Robert DeLong"|"Just Movement"|14.99]
|#

(define-struct sweater [material size producer])

#|
_____________________[sweater]
[material |size | producer   ]
["wool"   | "L" | "Patagonia"]
|#