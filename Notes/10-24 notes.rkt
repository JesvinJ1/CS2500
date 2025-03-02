;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname L21-915) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))



;; string-concat : [ListOf String] -> String
;; appends all the strings together
(check-expect (string-concat (list "a" "b" "c")) "abc")
; (string-append "a" (string-append "b" (string-append "c" "")))
(define (string-concat l)
  (cond [(empty? l) ""]
        [(cons? l) (string-append (first l)
                                  (string-concat (rest l)))])
  #;(foldr string-append "" l))

;; (foldr f base (list x-1 ... x-n)) = (f x-1 ... (f x-n base))
;; (foldr string-append "" (list x-1 ... x-n)) = (string-append x-1 ... (string-append x-n ""))

;; (string-concat (list "a" "b" "c"))
;; --> (string-append "a" (string-concat (list "b" "c")))
;; --> (string-append "a" (string-append "b" (string-concat (list "c"))))
;; --> (string-append "a" (string-append "b" (string-append "c" (string-concat "")))
;; --> (string-append "a" (string-append "b" (string-append "c" "")))
;; --> (string-append "a" (string-append "b"  "c"))
;; --> (string-append "a" "bc")
;; --> "abc"


;; (foldl f base (list x-1 ... x-n)) = (f x-n ... (f x-1 base))
;; (foldr string-append "" (list x-1 ... x-n)) == (string-append "c" ... (string-append "a" ""))

;; string-concat-backwards : [ListOf String] -> String
;; appends all the strings together in reverse
(check-expect (string-concat-backwards (list "a" "b" "c")) "cba")
(define (string-concat-backwards l)
  (foldl string-append "" l))

; signature of foldr:
; f : (X Y -> Y)
; base : Y
; l : (listof X)

;; add-even-numbers : [ListOf Number] -> Number
;; adds up only the even numbers, excluding all others
(check-expect (add-even-numbers '()) 0)
(check-expect (add-even-numbers (list 1 2 3 4 5)) 6)
(define (add-even-numbers l)
  (foldr + 0 (filter even? l))
  #;(foldr (lambda (n sum) (if (even? n) (+ n sum) sum)) 0 l))

;; Exercise: define every other list abstraction using foldr



;; sort-numbers : [ListOf Number] -> [ListOf Number]
;; sort numbers in ascending order
(check-expect (sort-numbers '()) '())
(check-expect (sort-numbers (list 1 2 5 3 4)) (list 1 2 3 4 5))
#;(define (sort-numbers l)
  (sort l <))

;; Actually defined as:
(define sort-numbers (lambda (l)
  (sort l <)))



;; sort-strings-by-length : [ListOf String] -> [ListOf String]
;; sort strings by length
(check-expect (sort-strings-by-length (list "abc" "a" "hello"))
              (list "a" "abc" "hello"))
(define (sort-strings-by-length l)
  (sort l (lambda (s1 s2)
            (< (string-length s1)
               (string-length s2))))
  #;(local [; len<? : String String -> Boolean
          ; compare strings by length
          (define (len<? s1 s2)
            (< (string-length s1)
               (string-length s2)))]
    (sort l len<?)))


((lambda (f) (f 10)) (lambda (x) (+ x 10)))

;; build-list

;; BAD:
;; constant-7 : Any -> Number
;; always returns 7
(check-expect (constant-7 0) 7)
(define (constant-7 n) 7)

(build-list 10 identity)
(build-list 10 (lambda (n) 7))

;; can do local, but more verbose:
(local [; constant-7 : ...
        (define (constant-7 n)
          7)]
  (build-list 10 constant-7))

;; exercise: create a list with the first 20 squares
;; as in, 4, 9, 16...
(build-list 20 (lambda (n) (sqr (+ n 2))))
