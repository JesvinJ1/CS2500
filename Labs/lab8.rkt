;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname lab8) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;;! Problem 1
;;
;; Design a data definition CallInfo that is either a phone number (represented as a
;; number), or the string "do not call"; this data represents information
;; collected by a marketing company.
;;
;; Estimated Portion of Lab: 20%
(define-struct callInfo [number dnc])
;; Call info is a struct that represents a phone number or a do not call string that
;; was collected from a marketing company
;; number - is the first item that is a number and is a phone number 
;; dnc - is the second item that is a string that says "do not call"

(define Call1 (make-callInfo #f "do not call"))
(define Call2 (make-callInfo 123456789 #f))


;;! Problem 2
;;
;; Consider the following data definition:

(define-struct person (name next))
;; A Names is one of:
;; - "end"
;; - (make-person String Names)
;; Interpretation: a sequence of names
(define N0 "end")
(define N1 (make-person "Alan" N0))
(define N2 (make-person "Zoe" N1))
(define N3 (make-person "Bill" N2))

(define (names-temp n)
  (cond [(string? n) ...]
        [(person? n) (... (person-name n)
                          ... (names-temp (person-next n)) ...)]))

;; Consider the following two functions:

;; count-anames : Names -> Number
;; count how many names start with "A"
(check-expect (count-anames N0) 0)
(check-expect (count-anames N1) 1)
(check-expect (count-anames N3) 1)
(define (count-anames n)
  (local (; a? : String -> Boolean
          ; does the string start with "A"
          (define (a? s)
            (and (> (string-length s) 0)
                 (string=? (substring s 0 1) "A"))))
    (cond [(string? n) 0]
          [(person? n) (if (a? (person-name n))
                           (+ 1 (count-anames (person-next n)))
                           (count-anames (person-next n)))])))


;; count-znames : Names -> Number
;; count how many names start with "Z"
(check-expect (count-znames N0) 0)
(check-expect (count-znames N1) 0)
(check-expect (count-znames N3) 1)
(define (count-znames n)
  (local (; z? : String -> Boolean
          ; does the string start with "Z"
          (define (z? s)
            (and (> (string-length s) 0)
                 (string=? (substring s 0 1) "Z"))))
    (cond [(string? n) 0]
          [(person? n) (if (z? (person-name n))
                           (+ 1 (count-znames (person-next n)))
                           (count-znames (person-next n)))])))


;; Design an abstraction called `count-names` (you can skip purpose statement & tests) that uses the
;; names template, then create new versions of the above functions (with the same signature)
;; that use the abstraction, named `count-anames/v2` and `count-znames/v2`.

;; Estimated Portion of Lab: 35%
;; Signature: count-names : Names -> Number
;; Code:
(define (count-names pred n)
  (cond [(string? n) 0]
        [(person? n) (if (pred (person-name n))
                         (+ 1 (count-names pred (person-next n)))
                         (count-names pred (person-next n)))]))

(define (count-anames/v2 n)
  (local (; a? : String -> Boolean
          ; does the string start with "A"
          (define (a? s)
            (and (> (string-length s) 0)
                 (string=? (substring s 0 1) "A"))))
    (count-names a? n)))

(define (count-znamesv/2 n)
  (local (; z? : String -> Boolean
          ; does the string start with "Z"
          (define (z? s)
            (and (> (string-length s) 0)
                 (string=? (substring s 0 1) "Z"))))
    (count-names z? n)))

;;! Problem 3
;;
;; Design a function `total-distance`, that takes a [ListOf Posn] as input and
;; returns the sum of all individual distances to the origin (i.e., (make-posn 0
;; 0)) of each of the Posns.
;;
;; Note that the distance between two points (x1,y1)
;; and (x2,y2) is sqrt((x2-x1)^2 + (y2-y1)^2).
;;
;; If the input list is empty, this should be 0. You may use a list
;; abstraction, but do not have to. We have provided signature, purpose, and
;; tests:
;;
;; Estimated Portion of Lab: 25%

;; total-distance : [ListOf Posn] -> Number
;; returns sum of all distances to the origin
(check-expect (total-distance '()) 0)
(check-expect (total-distance (list (make-posn 3 4))) 5)
(check-expect (total-distance (list (make-posn 3 4) (make-posn 5 12))) 18)

(define (distance-to-helper posn)
  (sqrt (+ (sqr (posn-x posn))
                (sqr (posn-y posn)))))

(define (total-distance LoP)
 (cond [(empty? LoP) 0]
       [(posn? (first LoP)) ;; first element of the list is a posn
        (+ (distance-to-helper (first LoP))
                       (total-distance (rest LoP)))]))

;;! Problem 4
;;
;; Design a function, `non-zeros`, that takes a [ListOf Number] and returns only
;; those numbers that are non-zero. Note: you must use a list abstraction!
;; Hint: the `zero?` function might be helpful.
;;
;; Estimated Portion of Lab: 20%
;; Signature: non-zeros
;; Purpose Statements:
;; Tests:
(check-expect (non-zeros '(0 1 2 0 3 0)) '(1 2 3))
(check-expect (non-zeros '(0 0 0)) '())
(check-expect (non-zeros '(1 2 3)) '(1 2 3))
;; Code:
(define (non-zero? x)
  (not (zero? x)))
;; Signature: non-zeros :[ListOf Numbers] -> [ListOf Numbers]
;; Purpose Statements: the function returns all of the numbers in a list if it is not a 0 using the helper function and filter function
;; Tests:
(define (non-zeros lst)
  (filter non-zero? lst)) ;; filter auto creates list & only adds items if the boolean returns #t
