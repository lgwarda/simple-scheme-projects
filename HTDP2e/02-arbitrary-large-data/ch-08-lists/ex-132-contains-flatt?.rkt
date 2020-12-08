;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex-132-contains-flatt?) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; List-of-names -> Boolean
; determines whether "Flatt" is on a-list-of-names
(check-expect
 (contains-flatt?
  '()) #f)
(check-expect
 (contains-flatt?
  (cons "Felleisen" '())) #f)
(check-expect
 (contains-flatt?
  (cons "Flatt" '())) #t)
(check-expect
 (contains-flatt?
  (cons "Felleisen" (cons "Flatt" '()))) #t)
(check-expect
  (contains-flatt?
    (cons "A" (cons "Find" (cons "C" '()))) #f)

(check-expect
 (contains-flatt?
               (cons "Fagan"
                     (cons "Findler"
                           (cons "Fisler"
                                 (cons "Flanagan"
                                       (cons "Flatt"
                                             (cons "Felleisen"
                                                   (cons "Friedman" '()))))))))
              #t)

(define (contains-flatt? alon)
  (cond [(empty? alon) #f]
        [(cons? alon)
         (or (string=? (first alon) "Flatt")
              (contains-flatt? (rest alon)))]))

