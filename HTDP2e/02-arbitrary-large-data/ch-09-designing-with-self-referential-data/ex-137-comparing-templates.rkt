;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex-137-comparing-templates) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Exercise 137. Compare the template for contains-flatt? with the one for how-many.
;Ignoring the function name, they are the same. Explain the similarity.
(define (contains-flatt? alon)
  (cond
    [(empty? alon) ...]
    [(cons? alon)
     (... (string=? (first alon) "Flatt")
      ... (cintains-flatt? (rest alon)) ...)]))

(define (fun-for-los alos)
  (cond
    [(empty? alos) ...]
    [else
      (... (first alos) ...
       ... (fun-for-los (rest alos)) ...)]))

