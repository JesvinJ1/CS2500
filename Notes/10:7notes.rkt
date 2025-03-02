;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 10:7notes) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; A Students is one of:
;; - "no more students"
;; - (make-student String Students)
;; ...
;(define S0 "no more students")
;(define S1 (make-student "John" S0))
;(define S2 (make-student "Jane" S1))

;; Redine using built-in list:

;; A Students is one of:
;; - '()
;; - (cons String Students)
;; Interpretation: a list of student names
(define SN0 '())
(define SN1 (cons "John" SN0))
(define SN2 (cons "Jane" SN1))

(define (sn-temp sn)
  (cond [(empty? sn) ...]
        [(cons? sn) (... (first sn) ... (sn-temp (rest sn)) ...)]))

;; first is the accessor function for first field of cons
;; rest is the accessor function for the rest field of cons

;; cons? identifies if you have a (cons ...)
;; empty? identifies if you have a '()

;; EXERCEISE: Design a fucntion contains-jane? that determines if "Jane" is
;; in the StudentNames
;; contains-jane? : StudentNames -> boolean
;; Purpose Statement: determines if "Jane" is in the StudentNames
;; Tests:
(check-expect (contains-jane? SN0) #f)
(check-expect (contains-jane? SN1) #f)
(check-expect (contains-jane? SN2) #t)

;; Code:
(define (contains-jane? sn)
  (cond [(empty? sn) #f]
        [(cons? sn) (if (string=? (first sn) "Jane")
                        #true
                                  (contains-jane? (rest sn)))]))

;; Design a function sum-lengths that takes a StudentNames and
;; returns the cumulative length of all names

;; sum-length : StudentNames -> Number
;; Purpose Statement: returns the cumulative length of all names
;; Tests:
(check-expect (sum-lengths SN0) 0)
(check-expect (sum-lengths SN1) 4)
(check-expect (sum-lengths SN2) 8)
;; Code:
(define (sum-lengths sn)
  (cond [(empty? sn) 0]
        [(cons? sn) (+
                      (string-length (first sn))
                          (sum-lengths (rest sn)))]))

;; A ListofNumbers (LoN) is one of:
;; - '()
;; - (cons Number LoN)
;; Interpretation: a list of numbers
(define L0 '())
(define L1 (cons 10 L0))
(define L2 (cons -3 L1))
(define L3 (cons 0 L1))
(define (lon-temp lon)
  (cond [(empty? lon) ...]
        [(cons? lon) (... (first lon) ... (lon-temp (rest lon)) ...)]))

;; Design function add-ten-to-all that dds ten to each number in a ListofNumbers

;; add-ten-to-all : LoN -> LoN
;; adss ten to each number in a ListofNumbers
;; Tests:
(check-expect (add-ten-to-all L0) L0)
(check-expect (add-ten-to-all L1) (cons 20 L0))
(check-expect (add-ten-to-all L2) (cons 7 (cons 20 L0)))
;; Code:
(define (add-ten-to-all lon)
  (cond [(empty? lon) L0]
        [(cons? lon) (cons (+ (first lon) 10)
                          (add-ten-to-all (rest lon)))]))

;; Design a function only-evens that removes all the odd numbers form the ListofNumbers

;; only-evens : LoN -> LoN
;; Purpose Statement: removes all the odd numbers form the ListofNumbers
;; Tests:
(check-expect (only-evens L0) L0)
(check-expect (only-evens L1) L1)
(check-expect (only-evens L2) L1)
;; Code:
(define (only-evens lon)
   (cond [(empty? lon) L0]
         [(cons? lon) (if (even? (first lon))
                           (cons (first lon) (only-evens (rest lon)))
                           (only-evens (rest lon)))]))


            