;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 9:18notes) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

;; Design a word processor (sort of)

;; World state: string

;; word-processor : String -> String
;; a simplified word processor that displays what the user types
(define (word-processor initial-word)
  (big-bang initial-word
    [to-draw draw-word] ; String -> Image
    [on-key key-word])) ; String KeyEvent -> String

(define WINDOW (rectangle 600 100 "solid" "yellow"))
(define WORD-SIZE 24)
(define WORD-COLOR "indigo")

;; draw-word : String -> Image
;; renders the letters to an image
(check-expect (draw-word "hello")
              (overlay (text "hello" WORD-SIZE WORD-COLOR)
                       WINDOW))
(check-expect (draw-word "")
              (overlay (text "" WORD-SIZE WORD-COLOR)
                       WINDOW))
(define (draw-word word)
  (overlay (text word WORD-SIZE WORD-COLOR)
                       WINDOW))

;; key-word : String KeyEvent -> String
;; add the letter pressed to the letters typed so far
(check-expect (key-word "" "q") "q")
(check-expect (key-word "hello" "q") "helloq")
(define (key-word word ke)
  (string-append word ke))


;; Goal: eclipse program where both x & y are changing at once

;; If x & y are both changing, what is the world state?

;; Need new feature of BSL:

;; Vocab: make-posn
;; Grammar:
;; (make-posn expression expression)
;; Semantics: make-posn "creates" a value that contains the result
;; of evaluating the two expressions inside

(define P0 (make-posn 3 4))
(define P1 (make-posn (+ 1 2) (* 3 4)))

;; Vocab: posn-x, posn-y
;; Grammar: (posn-x expression), (posn-y expression)
;; Semantics: return the first or second (respectively) field of
;; the posn that expression should evaluate to; eorrors if expression
;; does not evaluate to a make-posn

(posn-x P0)

;; Vocab: posn?
;; Grammar: (posn? expression)
;; Semantics: returns #true if expression evaluates to a
;; (make-posn value value), #false in all other cases

(posn? P0)
(posn? 10)

(make-posn "foo" #true)
(make-posn "foo" (make-posn #true (circle 10 "solid" "red")))

;; A Posn is a (make-posn Number Number)
;; Interpretation: a coordinate on the cartesian (xy) plane
(define C0 (make-posn 0 0))
(define C1 (make-posn -2 5))
(define C2 (make-posn 10 5))
(define (posn-temp p)
  (... (posn-x p) ... (posn-y p)))

;; Design a function, x-greater-than-y? that returns whether the
;; x coordinate is larger than the y coordinate.

;; x-greater-than-y? : Posn -> Boolean
;; returns whether the x coordinate is larger than the y coordinate
(check-expect (x-greater-than-y? C0) #false)
(check-expect (x-greater-than-y? C1) #false)
(check-expect (x-greater-than-y? C2) #true)
(define (x-greater-than-y? p)
  (> (posn-x p) (posn-y p)))

;; A Student is a (make-posn String Number)
;; Interpretation: represents a Student is CS2500, where:
;; -x field is their name
;; -y field is their NUID
(define S0 (make-posn "Alice" 1234))
(define S1 (make-posn "Bob" 3456))
(define (student-temp s)
  (... (posn-x s) ... (posn-y s)))

;; greet-student : Student -> String
;; greets a student
(check-expect (greet-student S0) "Hi Alice!")
(check-expect (greet-student S1) "Hi Bob!")
(define (student-temp s)
  (string-append "Hi " (posn-x s) "!"))