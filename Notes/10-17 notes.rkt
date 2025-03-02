;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname |10-17 notes|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; local:

;; Vocabulary: local
;; Grammar:
;; (local [def ...]
;;     body-expression_
;; def means (define (f ...) ...) or (define CONST ...) or even (define-struct ...)
;; Semantics:
;;    the defintions are evaluted first and then substituted into body expression

;; Digression on scope

;; if youu had a function f(x) = x + 7 in algebra
;; does this have meaning: f(10) + x



;; number->string-all : [ListOf Number] -> [ListOf String]
;; converts all numbers to strings
(check-expect (number->string-all (list 1 2 3)) (list "1" "2" "3"))
(define (number->string-all l)
  (do-to-all number->string l))

; do-to-all : (X Y) [X -> Y] [ListOf X] -> [ListOf Y]
; does operation to all
(define (do-to-all operation l)
  (cond [(empty? l) '()]
        [(cons? l) (cons (operation (first l))
                         (do-to-all operation (rest l)))]))

;; hello : String -> String
;; adds "Hello " before the input
(check-expect (hello "Class") "Hello Class")
(define (hello s)
  (string-append "Hello " s))

;; hello-everyone : [ListOf String] -> [ListOf String]
;; adds "Hello " before every string
(check-expect (hello-everyone (list "Alice" "Bob"))
              (list "Hello Alice"
                    "Hello Bob"))
(define (hello-everyone l)
  (do-to-all hello l))

; add-10 : Number -> Number
; adds 10 to input
(check-expect (add-10 0) 10)
(check-expect (add-10 -20) -10)
(define (add-10 n)
  (+ 10 n))

; add-10-all : [ListOf Number] -> [ListOf Number]
; adds 10 to each number
(check-expect (add-10-all (list)) (list))
(check-expect (add-10-all (list 1 2 3)) (list 11 12 13))
(define (add-10-all l)
  (do-to-all add-10 l))



;; short? : String -> Boolean
;; returns #true if input is less than 14 characters
(check-expect (short? "") #t)
(check-expect (short? "hello") #t)
(check-expect (short? "Fundies is my favorite class ever") #f)
(define (short? s)
  (< (string-length s) 14))

;; short-msgs : [ListOf String] -> [ListOf String]
;; returns only those strings less than 14 letters long
(check-expect (short-msgs '()) '())
(check-expect (short-msgs (list "hello" "there")) (list "hello" "there"))
(check-expect (short-msgs (list "hello" "there" "Fundies is my favorite class ever"))
              (list "hello" "there"))
(define (short-msgs l)
  (keep-if short? l)
  #;(cond [(empty? l) '()]
        [(cons? l) (if (short? (first l))
                       (cons (first l) (short-msgs (rest l)))
                       (short-msgs (rest l)))]))


(define POLITE "dear")
;; polite? : String -> Boolean
;; returns #true if string begins with "dear", #false otherwise
(check-expect (polite? "") #f)
(check-expect (polite? "hello") #f)
(check-expect (polite? "dear") #t)
(check-expect (polite? "dear fundies") #t)
(define (polite? s)
  (and (>= (string-length s) (string-length POLITE))
       (string=? (substring s 0 (string-length POLITE))
                 POLITE)))

;; polite-msgs : [ListOf String] -> [ListOf String]
;; return only those strings that begin with "dear"
(check-expect (polite-msgs '()) '())
(check-expect (polite-msgs (list "hi" "there")) '())
(check-expect (polite-msgs (list "dear hello" "there")) (list "dear hello"))
(check-expect (polite-msgs (list "dear hello" "there" "dearfundies"))
              (list "dear hello" "dearfundies"))
(define (polite-msgs l)
  (keep-if polite? l)
  #;(cond [(empty? l) '()]
        [(cons? l) (if (polite? (first l))
                       (cons (first l) (polite-msgs (rest l)))
                       (polite-msgs (rest l)))]))


;; keep-if : (X) [X -> Boolean] [ListOf X] -> [ListOf X]
;; return only those strings that satisfy predicate
(define (keep-if pred? l)
  (cond [(empty? l) '()]
        [(cons? l) (if (pred? (first l))
                       (cons (first l) (keep-if pred? (rest l)))
                       (keep-if pred? (rest l)))]))


;; A [ListOf X] is one of:
;; - '()
;; - (cons X [ListOf X])
;; Interpetation: a list of elements of type X
(define LX0 '())
(define LX1 (list 1 2 3)) ;; [ListOf Number]
(define LX2 (list "hello" "there")) ;; [ListOf String]
(define (list-temp l)
  (cond [(empty? l) ...]
        [(cons? l) (... (x-temp (first l))
                        ... (list-temp (rest l)) ...) ]))


;; find-sum : [ListOf Number] -> Number       
;; returns sum (adds) of input                
(check-expect (find-sum '()) 0)
(check-expect (find-sum (list 1 2 3)) 6)
(define (find-sum l)
  (collapse 0 + l)
  #;(cond [(empty? l) 0]
        [(cons? l) (+ (first l)
                      (find-sum (rest l)))]))



;; find-product : [ListOf Number] -> Number
;; returns product (multiplies) input
(check-expect (find-product '()) 1)
(check-expect (find-product (list 2 3 4)) 24)
(define (find-product l)
  (collapse 1 * l)
  #;(cond [(empty? l) 1]
        [(cons? l) (* (first l)
                      (find-producet (rest l)))]))

;; collapse : (X) X [X X -> X] [ListOf X] -> X
;; applies operation pairwise to all numbers in list, starting with basecase
(define (collapse base op l)
  (cond [(empty? l) base]
        [(cons? l) (op (first l)
                       (collapse base op (rest l)))]))

;; e.g.,
(collapse "" string-append (list "hello" "fundies" "1"))

;; But what about?

;; add-string-to-sum : String Number -> Number
(define (add-string-to-sum str num)
  (+ (string-length str) num))

(collapse 0 add-string-to-sum (list "hello" "fundies" "1"))

;; causes us to generalize signature to
;; collapse : (X Y) Y [X Y -> Y] [ListOf X] -> Y


;; do-to-all is actually called map
;; keep-if is actually called filter
;; collapse is actually called foldr