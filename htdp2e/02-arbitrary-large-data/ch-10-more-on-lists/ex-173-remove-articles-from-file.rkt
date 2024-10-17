;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex-173-remove-articles-from-file) (read-case-sensitive #t) (teachpacks ((lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; Constans:
(define ARTICLES
  (cons "a"
        (cons "A"
              (cons "an"
                    (cons "An"
                          (cons "the"
                                (cons "The"'())))))))

; An LLS is one of: 
; – '()
; – (cons Los LLS)
; interpretation a list of lines, each is a list of Strings
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


; File -> File
; produces a new file with all articles removed from text
(check-expect (remove-articles-from-file "ttt.txt") "no-articles-ttt.txt")
(define (remove-articles-from-file n)
  (write-file (string-append "no-articles-" n)
              (collapse (read-words/line n))))

; LLS -> String
; converts a list of lines into a string
(check-expect (collapse LLS0) "")
(check-expect (collapse LLS1) "Put up in place\nwhere it's easy to see\n")

(define (collapse lls)
  (cond [(empty? lls) ""]
        [else
         (string-append
          (process-los (first lls))
          "\n"
          (collapse (rest lls)))]))

; Los -> String
; produces string separated by blank space and without articles
(check-expect (process-los '()) "")
(check-expect (process-los LOS1) "Put up in place")
(check-expect (process-los (cons "The" (cons "grass" (cons "is" (cons "green" '())))))
              "grass is green")

(define (process-los los)
  (cond [(empty? los) ""]
   [else (string-append
           (if (member? (first los) ARTICLES) "" (first los))
           (if (or (= 1 (length los)) (member? (first los) ARTICLES))
               ""
               " ")
           (process-los (rest los)))]))








(remove-articles-from-file "ttt.txt")