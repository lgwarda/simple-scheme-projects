;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex-179-fn-for-editor) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; Constans

(define HEIGHT 20) ; the height of the editor 
(define WIDTH 200) ; its width 
(define FONT-SIZE 16) ; the font size 
(define FONT-COLOR "black") ; the font color 
 
(define MT (empty-scene WIDTH HEIGHT))
(define CURSOR (rectangle 1 HEIGHT "solid" "red"))

; Data definitions:

(define-struct editor [pre post])
; An Editor is a structure:
;   (make-editor Lo1S Lo1S) 
; An Lo1S is one of: 
; – '()
; – (cons 1String Lo1S)

(define good
  (cons "g" (cons "o" (cons "o" (cons "d" '())))))
(define all
  (cons "a" (cons "l" (cons "l" '()))))
(define lla
  (cons "l" (cons "l" (cons "a" '()))))
 
; data example 1: 
(define DE1 (make-editor all good))
; data example 2:
(define DE2 (make-editor lla good))

; Functions:

; main : String -> Editor
; launches the editor given some initial string 
(define (main s)
  (big-bang (create-editor s "")
    [on-key editor-kh]
    [to-draw editor-render]))

; Lo1s -> Lo1s 
; produces a reverse version of the given list 
 
(check-expect
 (rev (cons "a" (cons "b" (cons "c" '()))))
 (cons "c" (cons "b" (cons "a" '()))))
(check-expect
 (rev good)
 (cons "d" (cons "o" (cons "o" (cons "g" '())))))
 
(define (rev l)
  (cond
    [(empty? l) '()]
    [else (add-at-end (rev (rest l)) (first l))]))

; Lo1s 1String -> Lo1s
; creates a new list by adding s to the end of l
(check-expect (add-at-end '() "a") (cons "a" '()))
(check-expect
 (add-at-end (cons "c" (cons "b" '())) "a")
 (cons "c" (cons "b" (cons "a" '()))))
 
(define (add-at-end l s)
  (cond
    [(empty? l) (cons s '())]
    [else (cons (first l)
                (add-at-end (rest l) s))]))

; String String -> Editor
; return editor
(check-expect (create-editor "good" "all")
              (make-editor(cons "d"
                                (cons "o"
                                      (cons"o"
                                           (cons "g"
                                                 '())))) all))
(define (create-editor pre post)
  (make-editor (reverse (explode pre))
               (explode post)))

; Editor -> Image
; renders an editor as an image of the two texts 
; separated by the cursor
(check-expect (editor-render (create-editor "pre" "post"))
              (place-image/align
  (beside (text "pre" FONT-SIZE FONT-COLOR)
          CURSOR
          (text "post" FONT-SIZE FONT-COLOR))
  1 1
  "left" "top"
  MT))

(define (editor-render e)
  (place-image/align
    (beside (editor-text (rev (editor-pre e)))
            CURSOR
            (editor-text (editor-post e)))
    1 1
    "left" "top"
    MT))

; Lo1s -> Image
; renders a list of 1Strings as a text image
(check-expect (editor-text '())
              (text "" FONT-SIZE FONT-COLOR))
(check-expect
  (editor-text
   (cons "p" (cons "o" (cons "s" (cons "t" '())))))
  (text "post" FONT-SIZE FONT-COLOR))


(define (editor-text s)
  (text (implode s) FONT-SIZE FONT-COLOR))

 
; Editor KeyEvent -> Editor
; deals with a key event, given some editor
(check-expect (editor-kh (create-editor "" "") "e")
              (create-editor "e" ""))
(check-expect
 (editor-kh (create-editor "cd" "fgh") "e")
 (create-editor "cde" "fgh"))

(check-expect
 (editor-kh (create-editor "cd" "fgh") "\b")
 (create-editor "c" "fgh"))

(check-expect
 (editor-kh (create-editor "cd" "fgh") "right")
 (create-editor "cdf" "gh"))

(check-expect
 (editor-kh (create-editor "cd" "") "right")
 (create-editor "cd" ""))


(check-expect
 (editor-kh (create-editor "cd" "fgh") "left")
 (create-editor "c" "dfgh"))

(check-expect
 (editor-kh (create-editor "" "fgh") "left")
 (create-editor "" "fgh"))
(check-expect
 (editor-kh (create-editor "" "fgh") "\t")
 (create-editor "" "fgh"))
(check-expect
 (editor-kh (create-editor "" "fgh") "up")
 (create-editor "" "fgh"))


(define (editor-kh ed k)
  (cond
    [(key=? k "left") (editor-lft ed)]
    [(key=? k "right") (editor-rgt ed)]
    [(key=? k "\b") (editor-del ed)]
    [(key=? k "\t") ed]
    [(key=? k "\r") ed]
    [(= (string-length k) 1) (editor-ins ed k)]
    [else ed]))

; insert the 1String k between pre and post
(check-expect
 (editor-ins (make-editor '() '()) "e")
 (make-editor (cons "e" '()) '()))
 
(check-expect
 (editor-ins
  (make-editor (cons "d" '())
               (cons "f" (cons "g" '())))
  "e")
 (make-editor (cons "e" (cons "d" '()))
              (cons "f" (cons "g" '()))))

(define (editor-ins ed k)
  (make-editor (cons k (editor-pre ed))
               (editor-post ed)))

; Editor -> Editor
; moves the cursor position one 1String left, 
; if possible
(check-expect (editor-lft (create-editor "" "fgh"))
              (create-editor "" "fgh"))
(check-expect
 (editor-lft (create-editor "cd" "fgh"))
 (create-editor "c" "dfgh"))


(define (editor-lft ed)
  (cond [(empty? (editor-pre ed)) ed]
        [else (make-editor (rest (editor-pre ed))
                           (cons (first (editor-pre ed))
                                 (editor-post ed)))]))
 
; Editor -> Editor
; moves the cursor position one 1String right, 
; if possible
(check-expect (editor-rgt (create-editor "cde" ""))
              (create-editor "cde" ""))
(check-expect
  (editor-rgt (create-editor "cd" "fgh"))
  (create-editor "cdf" "gh"))

(define (editor-rgt ed)
  (cond [(empty? (editor-post ed)) ed]
        [else
         (make-editor (cons (first (editor-post ed))
                            (editor-pre ed))
                      (rest (editor-post ed)))]))
 
; Editor -> Editor
; deletes a 1String to the left of the cursor,
; if possible
(check-expect (editor-del (create-editor "" "fgh"))
              (create-editor "" "fgh"))
(check-expect
  (editor-del (create-editor "cd" "fgh"))
  (create-editor "c" "fgh"))

(define (editor-del ed)
 (cond [(empty? (editor-pre ed)) ed]
       [else (make-editor (rest (editor-pre ed))
                          (editor-post ed))]))