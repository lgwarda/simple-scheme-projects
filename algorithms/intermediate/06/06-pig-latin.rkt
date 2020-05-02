#lang racket

; String -> String
; translates the given str from English to Pig Latin
(define (pig-latin str)
   (cond [(starts-vowel? str) (vowel-rule str)]
         [(not (has-vowel? str)) (string-append str "ay")]
         [else (consonant-rule str)]))


; String -> Boolean
; produces #t if the give string begin with vowel
(define (starts-vowel? str)
  (or (string-prefix? str "a")
      (string-prefix? str "e")
      (string-prefix? str "i")
      (string-prefix? str "o")
      (string-prefix? str "u")))

; String -> String
; conacatinates "way" to the end of the given str
(define (vowel-rule str)
 (string-append str "way"))

; String -> Boolean
(define (has-vowel? str)
  (or (string-contains? str "a")
      (string-contains? str "e")
      (string-contains? str "i")
      (string-contains? str "o")
      (string-contains? str "u")))

; String -> String
; conacatinates  first character of the given str and suffix "ay" to the str
(define (consonant-rule str) 
  (letrec [(f (lambda (str)
                (if (starts-vowel? str)
                    (string-append  str "ay") 
                    (f (string-append (substring str 1)
                                      (substring str 0 1))))))]
    (f str)))




      
;                                        
;                                        
;                                        
;                                        
;                                        
;  ;;;;;;;;;                             
;  ;   ;   ;              ;              
;      ;                  ;              
;      ;      ;;;    ;;; ;;;;;  ;;;   ;  
;      ;     ;   ;  ;  ;  ;    ;  ;   ;  
;      ;     ;;;;;  ;     ;    ;         
;      ;     ;       ;;   ;     ;;       
;      ;     ;      ;  ;  ;    ;  ;      
;      ;     ;;  ;  ;  ;  ;    ;  ;   ;  
;     ;;;     ;;;;  ;;;;  ;;;; ;;;;   ;  
;                                        
;                                        
;                                        
;                                        


(pig-latin "california") ;"aliforniacay"
(pig-latin "paragraphs") ;"aragraphspay"
(pig-latin "glove")      ;"oveglay"
(pig-latin "eight")      ;"eightway"
(pig-latin "algorithm")  ;"algorithmway"
(pig-latin "schwartz")   ; "artzschway"
(pig-latin "rythm")      ; "rythmwy"
(pig-latin "tryptyk")    ; "tryptykay"







