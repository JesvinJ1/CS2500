;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 9:19notes) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

;; A posn is a (make-posn Number Number)
;; Interpretation: a coordinate on the cartesian (xy) plane
(define C0 (make-posn 0 0))
(define C1 (make-posn -2 5))
(define C2 (make-posn 10 5))
(define (posn-temp p)
  (... (posn-x p) ... (posn-y p)))

;; World State will be a Posn

;; silly-eclipse : Posn -> Posn
;; moon moves randomly around the sky
(define (silly-eclipse initial-posn)
  (big-bang initial-posn
    [to-draw move-moon]
    [on-tick move-moon]))

(define SKY (rectangle 600 300 "solid" "dark blue"))
(define MOON (circle 30 "solid" "gray"))

; draw-moon : Posn -> Image
; draws the moon at the given position in the sky
(check-expect (draw-moon (make-posn 50 50))
              (place-image MOON
                           50
                           50
                           SKY))
(check-expect (draw-moon (make-posn 50 100))
              (place-image MOON
                           50
                           100
                           SKY))
(define (draw-moon p)
  (place-image MOON
               (posn-x p)
               (posn-y p)
               SKY))

;; Vocab: check-random
;; Grammar: (check-random expression expected-expression)
;; Semantics: evaluate both expression and
;; expected-expression with the exact same sequence of
;; "random" numbers, and then behave like check-expect

;; move-move : Posn -> Posn
;; move the moon by up to 1 in x and up to 1 in y directions
(check-random (move-moon (make-posn 50 50))
              (make-posn (+ (sub1 (random 3)) 50)
                         (+ (sub1 (random 3)) 50)))
(check-random (move-moon (make-posn 50 100))
              (make-posn (+ (sub1 (random 3)) 50)
                         (+ (sub1 (random 3)) 100)))
(define (move-moon p)
  (make-posn (+ (sub1 (random 3)) (posn-x p))
             (+ (sub1 (random 3)) (posn-y p))))

;; Goal have a bouncing moon and a bouncing sun

;; World State: 

;; A SunMoonPosition is a (make-posn Posn Posn)
;; Interpretation: the locations of the moon (x field) & sun (y field)
(define SMP1 (make-posn (make-posn 50 50)
                        (make-posn 100 100)))
(define SMP2 (make-posn (make-posn 60 100)
                        (make-posn 200 100)))
(define (smp-temp smp)
  (... (posn-x (posn-x smp))
       ... (posn-y (posn-x smp))
       ... (posn-x (posn-y smp))
       ... (posn-y (posn-y smp))))

;; Vocab: define-struct
;; Grammar:
;; (define-struct name-of-struct [field 1 field 2 ...])
;; Semantics:
;; create a new value, which is constructed with
;; (make-name-of-struct expression1 expression2 ...)
;; We also get projection / accessor functions:
;; name-of-struct-field1, name-of-struct-field2, etc
;; And: name-of-struct? to recognize value of the struct

;; (define-struct posn [x,y])

(define-struct student [givenname familyname nuid])
;; A Student is a (make-student String String Natural)
;; Interpretation: a student at Northeastern where:
;; - givenname is their first name
;; - familyname is their last name
;; - nuid is their NUID

(define STUDENT1 (make-student "Alice" "Doe" 1234))

(define (student-temp s)
  (... (student-givenname s)
   ... (student-familyname s)
   ... (student-nuid s) ...))

;; Design a function called letter-header that takes a student
;; and produces the opening line of a letter to them,
;; e.g., "Dear Alice,"

;; letter-header : Student -> String
;; Purpose: produces an opening line of a letter to a specific student name
;; Checks:
#;(check-expect (letter-header STUDENT1) "Dear Alice,")

;; Code:
#;(define (letter-header student)
  (define (letter-header s)
  (string-append "Dear " (student-givenname s) ","))) ; Alice



