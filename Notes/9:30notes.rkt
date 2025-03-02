;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 9:30notes) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

;; A Silly is one of:
;; - Number
;; - (make-posn String Image)

;; Skip interpretation
;; Skip examples

;; Template:

(define (silly-temp s)
  (cond [(number? s) (... s ...)]
        [(posn? s) (... (posn-x s) ... (posn-y s) ...)]))

;; A Bar is one of:
;; - "hello"
;; - PositiveInteger

;; Skip: interpretation, examples

;; Template:
(define (bar-temp s)
  (cond [(string? s) ...]
        [(number? s) (... s ...)]))

(define-struct blah [ab cd])
;; A Foo is a (make-blah Number Bar)

;; Skip interpretation, examples

;; Template:
(define (foo-temp f)
  (... (blah-ab f) ...
       (bar-temp (blah-cd f)) ...))

;; Design a function foo->number that
;; extracts out the number represented by
;; the Foo, adding if there are multiple
;; numbers inside.

(check-expect (bar->number "hello") 0)
(check-expet (bar->number 20)20)
;; bar->number : Bar -> Number

;; Signautre: foo->number : foo -> Number
;; Tests:
(check-expect (make-blah 10 "hello") 10)
(check-expect (make-blah 10 20) 30)

;; Code:
(define (foo->number f)
  (+ (blah-ab f)
       (bar->number (blah-cd f))))