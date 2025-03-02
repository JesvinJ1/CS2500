;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname lab4) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;;! Instructions:
;;! 1. Read the contents of this file, and carry out the tasks within
;;!    below.
;;! 2. Do not create, modify or delete any line that begins with ";;!!", such
;;!    as these lines. These are markers that we use to segment your file into
;;!    parts to facilitate grading.

(require 2htdp/image)
(require 2htdp/universe)

;;! Problem 1
;;
;; Design a data definition for a WritingImplement that is either a pen, pencil, or quill.
;;
;; Estimated Portion of Lab: 15%
;; Data Defintion:
(define-struct WritingImplement [pen pencil quill])
;; WritingImplement will choose between the a pen, pencil, or quill as the writing tool. 
;; Interpretation: 
;; The writing implement would have either a pen, pencil, or quill.
;; Examples:
(define PEN (make-WritingImplement "Pen" "" ""))
(define PENCIL (make-WritingImplement "" "Pencil" ""))
(define QUILL (make-WritingImplement "" "" "Quill"))

;; Template:
(define (WritingImplement-temp t)
( ... (WritingImplement-temp t) ... (WritingImplement-temp t) ...))

;;! Problem 2
;;
;; Design a function maybe-duplicate-string that takes in a String and a Boolean.
;; The function should return a String with two copies of the original String when the input Boolean is #true.
;; If the input Boolean is #false, the function should return the original String unchanged.
;;
;; Estimated Portion of Lab: 25%
;; Signature: maybe-duplicate-string : String Boolean -> String
;; Purpose Statement: The user will enter a string and if they set the boolean to true it will duplicate the string and if it's set to false
;; it will just print the string once.
;; Tests:
(check-expect (maybe-duplicate-string "Hello" #true) "HelloHello")
(check-expect (maybe-duplicate-string "CS" #false) "CS")
(check-expect (maybe-duplicate-string "" #false) "")
(check-expect (maybe-duplicate-string "" #true) "")
;; Code:
(define (maybe-duplicate-string String Boolean)
  (if Boolean
      (string-append String String)
      String))

;;! Problem 3
;;
;; Design a data definition for an Address that includes a street number, street & city.
;;
;; Estimated Portion of Lab: 35%

;; Data Defintion:
(define-struct Address [street-number street city])
;; The address represents an address to a building, house, apartment, etc. 
;; Interpretation:
;; - street-number : represents the number of the address
;; - street : represents the name of the street
;; - city : represents the name of the city
;; Examples:
(define ADDRESS1 (make-Address "123" "Tremont St" "Boston"))
(define ADDRESS2 (make-Address "452" "Northeastern Ave" "Boston"))
(define ADDRESS3 (make-Address "108" "Springfield Road" "Springfield"))
;; Template:
(define (Address-temp a)
  (... (Address-street-number a)
       ... (Address-steet a)
       ... (Address-city a) ...))

;;! Problem 4
;;
;; Consider the following data definition for Weight:
;;
(define-struct weight [pounds ounces])
;; A Weight is a (make-weight Number Number[0-15])
;; Interpretation: a weight in imperial measure, where:
;; - pounds is the number of pounds
;; - ounces is the number of ounces, which should never be over 15 since 16 ounces are 1 pound
(define WEIGHT0 (make-weight 0 0))
(define WEIGHT1 (make-weight 0 15))
(define WEIGHT2 (make-weight 12 4))

(define (weight-temp w)
  (... (weight-pounds w) ... (weight-ounces w) ...))

;; Design a function total-ounces that takes as input a Weight and returns the
;; total number of ounces it represents (as just a number).
;;
;; Estimated Portion of Lab: 25%
;; Signature: total-ounces : weight -> number
;; Purpose Statement: The function converts ther weight of pounds and ounces to just ounces
;; Tests:
(check-expect (total-ounces WEIGHT0) 0)
(check-expect (total-ounces WEIGHT1) 15)
(check-expect (total-ounces WEIGHT2) 196)

(define (total-ounces weight)
  (+ (* 16 (weight-pounds weight)) (weight-ounces weight)))
