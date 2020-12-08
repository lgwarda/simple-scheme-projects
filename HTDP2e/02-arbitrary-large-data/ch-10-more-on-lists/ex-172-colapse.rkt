;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex-172-colapse) (read-case-sensitive #t) (teachpacks ((lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
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


#;
(write-file "ttt.dat"
            (collapse (read-words/line "ttt.txt")))

