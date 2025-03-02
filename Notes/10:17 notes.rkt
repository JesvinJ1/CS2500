;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname |10:17 notes|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; short-msgs : [ListOf String] -> [ListOf String]
;; Purpose Statement: returns only those strings less than 14 letters long
;; Tests
(check-expect (short-msgs '()) '())
(check-expect (short-msgs '("test" "fdsjfkhdklfjehwkfe" "fdsfds")) '("test" "fdsfds"))
(check-expect (short-msgs '("test" "fdsjfkhdklfjehwkfe" "fundies")) '("test" "fundies"))
(check-expect (short-msgs '("testtesttesttest" "fdsjfkhdklfjehwkfe" "fundies")) '("fundies"))
;; Code:
(define (short-msgs l)
  (cond [(empty? l) '()]
        [(cons? l) (if (< (string-length (first l)) 14)
              (cons (first l) (short-msgs (rest l)))
              (short-msgs (rest l)))]))

(define POLITE "dear")

;; polite? : String -> Boolean
;; Purpose Statement: returns #t if the string begins with "dear" false otherwise
;; Tests:
(check-expect (polite? "") #f)
(check-expect (polite? "hello") #f)
(check-expect (polite? "dear") #t)
(check-expect (polite? "dear fundies") #t)
;; Code:
(define (polite? s)
  (and (>= (string-length s) (string-length POLITE))
       (string=? (substring s 0 (string-length POLITE)) POLITE)))

;; polite-mgs : [ListOf String] -> [ListOf String]
;; Purpose Statement: return only those strings that begin with "dear"
;; Tests:
(check-expect (polite-msgs '()) '())
(check-expect (polite-msgs '("hello" "there")) '())
(check-expect (polite-msgs '("dear hello" "there")) '("dear hello"))
;; Code:
(define (polite-msgs l)
  (cond [(empty? l) '()]
        [(cons? l) (if (polite? (first l))
                    (cons (first l) (polite-msgs (rest l)))
                    (polite-msgs (rest l)))]))

;; find-sum : [ListOf Number] -> Number
;; returns sum of input
;; Tests:
(check-expect (find-sum '()) 0)
;; Code:
(define (find-sum l)
  (collapse 0 + l)
  #;(cond [(empty? l) 0]
        [(cons? l) (+ (first l)
                      (find-sum (rest l)))]))

(define (find-product l)
  (collapse 1 * l)
  #;(cond [(empty? l) 1]
        [(cons? l) (* (first l)
                      (find-product (rest l)))]))

(define (collapse base op l)
  (cond [(empty? l) base]
        [(cons? l) (op (first l)
                       (collapse base op (rest l)))]))

;; do to all is called map
;; keep it is called filter
;; collapse is called foldr