;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex-086-editor-2) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; Constans:

(define WIDTH 200)
(define HEIGHT 20)

(define MTS (empty-scene WIDTH HEIGHT))

(define CURSOR (rectangle 1 20 "solid" "red"))

(define TEXT-SIZE 16)
(define TEXT-COLOR "black")

; Data definition:

(define-struct editor [pre post])
; An Editor is a structure:
;   (make-editor String String)
; interpretation (make-editor s t) describes an editor
; whose visible text is (string-append s t) with 
; the cursor displayed between s and t

(define E0 (make-editor "" ""))
(define E1 (make-editor "" "helloworld"))
(define E2 (make-editor "hello" "world"))
(define E3 (make-editor "hel" "lo world"))


; Functions:

; render: Editor -> Image
; place the given text and the cursor on MTS
(check-expect (render E0)
              (overlay/align "left" "center"
                             (beside (text "" 16 "")
                                     CURSOR
                                     (text "" 16 ""))
                             MTS))
(check-expect (render (make-editor "" "helloworld"))
              (overlay/align "left" "center"
                             (beside (text "" 16 "balck")
                                     CURSOR
                                     (text "helloworld" 16 "black"))
                             MTS))
(check-expect (render E2)
              (overlay/align "left" "center"
                             (beside (text "hello" 16 "black")
                                     CURSOR
                                     (text "world" 16 "black"))
                             MTS))


(define (render ed)
  (overlay/align "left" "center"
                 (beside (text (editor-pre ed) TEXT-SIZE TEXT-COLOR)
                         CURSOR
                         (text (editor-post ed) TEXT-SIZE TEXT-COLOR))
  MTS))

; edit: Editor KeyEvent -> Editor
; add or delete a char and move the cursor for one and the other side

(check-expect (edit (make-editor "hel" "lo") "left")
              (make-editor "he" "llo"))
(check-expect (edit (make-editor "" "hello") "left")
              (make-editor "" "hello"))

(check-expect (edit (make-editor "hel" "lo") "right")
              (make-editor "hell" "o"))
(check-expect (edit (make-editor "hello" "") "right")
              (make-editor "hello" ""))

(check-expect (edit (make-editor "hel" "lo") "a")
              (make-editor "hela" "lo"))

(check-expect (edit (make-editor "hel" "lo") "\b")
              (make-editor "he" "lo"))
(check-expect (edit (make-editor "\b" "hello") "\b")
              (make-editor "" "hello"))

(check-expect (edit (make-editor "hello " "world") "\t")
              (make-editor "hello " "world"))
(check-expect (edit (make-editor "hello " "world") "\r")
              (make-editor "hello " "world"))

(check-expect (edit (make-editor "hello " "world") "up")
              (make-editor "hello " "world"))

(define (edit ed ke)
  (cond[(key=? ke "left") (cursor-l ed)]
       [(key=? ke "right") (cursor-r ed)]
       [(key=? ke "\b") (delete-l ed)]
       [(key=? ke "\r") ed]
       [(key=? ke "\t") ed]
       [(equal? (string-length ke) 1)
        (insert-char-limit ed ke)]
       [else ed]))
      

; cursor-l : Editor -> Editor
; move the cursor left 
(check-expect
 (cursor-l (make-editor "hello" "world"))
 (make-editor "hell" "oworld"))

(define (cursor-l ed)
  (cond [(string=? (editor-pre ed) "") ed]
        [else
         (make-editor (string-remove-last (editor-pre ed))
                      (string-append (string-last (editor-pre ed))
                                     (editor-post ed)))]))
; string-last: String -> String
; produce the last character from the given str
(check-expect (string-last "hello") "o")

(define (string-last str)
  (substring str (- (string-length str) 1)))


; cursor-r : Editor -> Editor
; move the cursor right
(check-expect
 (cursor-r (make-editor "hello" "world"))
 (make-editor "hellow" "orld"))

(define (cursor-r ed)
  (cond [(string=? (editor-post ed) "") ed]
        [else
         (make-editor (string-append (editor-pre ed)
                                     (string-first (editor-post ed)))
                      (string-rest (editor-post ed)))]))

; string-first: String -> 1-String
; produce the first character from the given str
(check-expect (string-first "hello") "h")

(define (string-first str)
  (substring str 0 1))

; string-rest: String -> String
; produce the given a str without the 1st character from the non empty str
(check-expect (string-rest "hello") "ello")

(define (string-rest s)
  (substring s 1 (string-length s)))

; delete-l: Editor -> Editor
; delete character to the left
(check-expect (delete-l (make-editor "" "world")) (make-editor "" "world"))
(check-expect (delete-l (make-editor "hello" "world")) (make-editor "hell" "world"))

(define (delete-l ed)
  (cond [(string=? (editor-pre ed) "")  ed]
        [else
         (make-editor (string-remove-last (editor-pre ed))
                      (editor-post ed))]))

; string-remove-last: String -> String
; remove the last char from the given non empty string
(check-expect (string-remove-last "hello!") "hello")

(define (string-remove-last str)
  (substring str 0 (sub1 (string-length str))))

; insert-char: Editor 1Srting -> Editor
; add 1String to the right of the Cursor
(check-expect (insert-char (make-editor "" "ello") "h")
              (make-editor "h" "ello"))
(check-expect (insert-char (make-editor "he" "lo") "l")
              (make-editor "hel" "lo"))

(define (insert-char ed char)
  (make-editor (string-append (editor-pre ed) char) (editor-post ed)))

(define (add-right ed c)
  (make-editor (string-append (editor-pre ed) c) (editor-post ed)))

; Editor 1String -> Editor
; add 1String to String until buffer limit

(define (insert-char-limit ed c)
  (cond
    [(> (image-width (render (insert-char ed c))) WIDTH) ed]
    [else (insert-char ed c)]))


; run: Editor -> Editor
; start with: (run (make-editor "" "")
(define (run ed)
  (big-bang ed                 
    (to-draw   render)   
    (on-key    edit)))   

(run (make-editor "hello cham!" ""))