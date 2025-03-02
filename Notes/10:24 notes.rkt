;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |10:24 notes|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; string-concat : [Listof String] -> String
;; appends all the strings together
(check-expect (string-concat (list "a" "b" "c")) "abc")
; string-append "a" (string-append "b" (string-append "c" "")))
(define (string-concat l)
  (cond [(empty? l) ""]
        [(cons? l) (string-append (first l)
                                  (string-concat (rest l)))])
  #;(foldr string-append "" l))

;; (string-concat (list "a" "b" "c"))
;; --> (string-append "a" (string-concat (list "b" "c")))
;; --> (string-append "a" (string-concat "b" (string-concat (list "c"))))
;; --> (string-append "a" (string-concat "b" (string-append "c" (string-concat "")))
;; --> (string-append "a" (string-concat "b" (list "b" "c")))

;; exercise: create a list with the first 10 squares
;; as in 0, 1, 4, 9, 16, ...

(build-list 20 sqr)
(build-list 20 (lambda (n) (sqr (+ n 2))))
