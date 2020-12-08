;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex-174-encode-text-file) (read-case-sensitive #t) (teachpacks ((lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; Constans:

(define LOS1 (cons "Put"
                   (cons "up"
                         (cons "in"
                               (cons "a"
                                     (cons "place" '()))))))
(define LOS2 (cons "where"
                   (cons "it's"
                         (cons "easy"
                               (cons "to"
                                     (cons "see" '()))))))
(define LLS0 '())
(define LLS1 (cons LOS1 (cons LOS2 '())))

; Functions

; File -> File
; produces a file with each letter encoded as a
; numeric three-letter string with value between 0 and 256
(check-expect (encode-file "ttt.txt") "encoded-ttt.txt")

(define (encode-file f)
  (write-file (string-append "encoded-" f)
              (collapse (encode (read-words/line f)))))

; LLS -> String
; converts a list of lines into a string
(check-expect (collapse LLS0) "")
(check-expect (collapse LLS1) "Put up in a place\nwhere it's easy to see\n")
(define (collapse lls)
  (cond [(empty? lls) ""]
        [else
         (string-append
          (process-los (first lls))
          "\n"
          (collapse (rest lls)))]))

; Los -> String
; produces string separated by blank space
(check-expect (process-los '()) "")
(check-expect (process-los LOS1) "Put up in a place")
(define (process-los los)
  (cond [(empty? los) ""]
        [else
         (if (= (length (rest los)) 0)
             (first los)
             (string-append
              (first los)
              " "
              (process-los (rest los))))]))


; LLS -> String
; produces encoded line by line
(define (encode lls)
  (cond [(empty? lls) '()]
        [else
         (cons (encode-line (first lls))
               (encode (rest lls)))]))


; Los -> Los
; encode a Los
(check-expect (encode-line '()) '())
(check-expect (encode-line (cons "aa" (cons "bb" '())))
              (cons "097097" (cons "098098" '())))

(define (encode-line los)
  (cond [(empty? los) '()]
        [else
         (cons (encode-word (explode (first los)))
               (encode-line (rest los)))]))

; List-of-1String -> String
; encodes a String into 3 char ascii representation
(check-expect (encode-word '()) "")
(check-expect (encode-word (cons "a" (cons "b" '()))) "097098")

(define (encode-word los)
  (cond [(empty? los) ""]
        [else
         (string-append (encode-letter (first los))
                        (encode-word (rest los)))]))

; 1String -> String
; converts the given 1String to a 3-letter numeric String

(check-expect (encode-letter "z") (code1 "z"))
(check-expect (encode-letter "\t")
              (string-append "00" (code1 "\t")))
(check-expect (encode-letter "a")
              (string-append "0" (code1 "a")))

(define (encode-letter s)
  (cond
    [(>= (string->int s) 100) (code1 s)]
    [(< (string->int s) 10)
     (string-append "00" (code1 s))]
    [(< (string->int s) 100)
     (string-append "0" (code1 s))]))

; 1String -> String
; converts the given 1String into a String
 
(check-expect (code1 "z") "122")
 
(define (code1 c)
  (number->string (string->int c)))