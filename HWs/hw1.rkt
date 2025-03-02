;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname hw1) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;;! Purpose: An introduction to programming with simple function definitions.

;;! Instructions:
;;! 1. Read the contents of this file, and fill in [TODO] items that appear
;;!    below.
;;! 2. Do not create, modify or delete any line that begins with ";;!", such
;;!    as these lines. These are markers that we use to segment your file into
;;!    parts to facilitate feedback & grading.
;;! 3. When you submit to Gradescope, please:
;;!    A. Check that what you submitted is what you intended. Submitting the wrong
;;!       version will not be a valid excuse to submit late.
;;!    B. Check the results of the autograders that run immediately and correct any
;;!       issues. You can submit as many times as you want until the deadline; however,
;;!       when enabled, FeedBot will only run on a fixed number of submissions.

(require 2htdp/image)

;;! Problem 1

;;! Part A 

;; Consider the following function:
(define (mystery x y z)
  (string-append (substring x 0 z)
                 (substring y z)
                 (substring y 0 z)
                 (substring x z)))

;; Describe the value that mystery produces when you apply it to two identical
;; arguments for x and y.

;; [TODO] Prose description as a comment.
;; The result would just be the same thing repeated twice for x and y. 


;;! Part B

;; Define appropriately named constants for:
;; - an image of a red circle with radius 10 on top of a blue square with side length 40
;; - the string "WELCOME TO FUNDIES 1!"
;; - your favorite number

;; [TODO] Constant definitions
(define IMAGE
 (overlay/align "center" "center"
                (circle 10 "solid" "red")
                (rectangle 40 40 "solid" "blue")))
(define MESSAGE "WELCOME TO FUNDIES 1!")
(define FAV-NUM 891)

;;! Part C

;; Define a function `greet` that takes as an argument a person's name and returns a string
;; with a greeting to that person.

;; [TODO] Function definition
(define (greet name)
  (string-append "What's up " name ))

;;(greet "Jesvin")

;;! Part D

;; Interest rates are percentages of money that are paid by banks and other
;; institutions, as a benefit of holding some money. They can be expressed as
;; decimal numbers above 1, i.e., 1.1 could represent an interest rate of 10%.
;;
;; Define a function, `apply-interest` that takes a balance, a yearly interest
;; rate, and returns the balance after a single year.
(define (apply-interest balance yearlyint)
  (* balance yearlyint))


;;! Part E

;; Now define a second function, `apply-interest-5` that takes a balance, a
;; yearly interest rate, and returns the balance after 5 years.
(define (apply-interest-5 balance yearlyint)
  (* balance (expt yearlyint 5)))

;;! Problem 2

;; In western classical music, tones are typically placed on a scale called
;; the twelve-tone scale. We use non-negative integers to refer to each tone.
;; For example 60 refers to the tone called "C" (or the "do" in "do-re-mi")
;; near the middle of a piano, whereas 61 refers to the tone one unit higher.
;; We consider two tones with a gap of a multiple of 12 units between them as
;; equivalent. For example, the tones 0, 60 and 84 are all equivalent: they are
;; all the tone "C". However, tones 60 and 67 are not equivalent.

;;! Part A

;; Define a function called tone-class which consumes a single tone as an
;; argument, and produces its *class*,  which is the smallest non-negative
;; integer that is equivalent to the tone. For example, the class of 60 is 0,
;; the class of 61 is 1, and the class of 0 is 0 itself.

;; Hint: Since there are 12 classes starting with zero, you can calculate the
;; class as the remainder. Try looking for relevant functions in the DrRacket
;; Help Desk.

;; [TODO] Function definition
(define (tone-class singletone)
  (remainder singletone 12)
  )

;;! Part B

;; The distance between two tones is how far apart they are, while keeping
;; equivalence in mind. Since there are 12 tone classes, the maximum distance
;; between any pair of tones is 12. However, there are two distances you can
;; produce, depending on which tone you consider first:

;; - The distance between tones 60 and 63 is either 3 (counting up) or 9
;;   (counting down).
;; - The distance between 60 and 75 is also either 3 or 9.
;; - The distance between 63 and 70 is 5 or 7.

;; Write a function called tone-distance which consumes two tones as arguments,
;; and produces their distance (either distance), as defined above.

;; [TODO] Function definition
(define (tone-distance tone1 tone2)
  (abs (remainder (- tone1 tone2) 12))
  )

;;! Part C

;; On a piano keyboard, each class of twelve tones (a.k.a., an octave) are
;; placed in a standard pattern of eight white and five black keys. If you are
;; not familiar with this pattern, here is a picture of a piano keyboard:

;; https://en.wikipedia.org/wiki/Musical_keyboard#/media/File:Klaviatur-3-en.svg

;; Write a function called keyboard that consumes the height and width
;; of the white keys, and produces an image that looks like a piano octave.
;; The black keys are roughly half the width and about 3/4 the length of the
;; white keys.

;; Note: The picture linked above labels the white keys. Your image does not
;; have to do so.

;; Hint 1: The overlay/align function may be very helpful.

;; Hint 2: You can use "transparent" as a color for a rectangle.

;; [TODO] Function definition
(define (keyboard width height)
  (overlay/align "center" "top"
                 (beside (rectangle (* 1 width) (* 0.75 height) "solid" "transparent")
                         (rectangle (* 0.6 width) (* 0.75 height) "solid" "black")
                         (rectangle (* 0.4 width) (* 0.75 height) "solid" "transparent")
                         (rectangle (* 0.6 width) (* 0.75 height) "solid" "black")
                         (rectangle (* 0.6 width) (* 0.75 height) "solid" "transparent")
                         (rectangle (* 0.6 width) (* 0.75 height) "solid" "transparent")
                         (rectangle (* 0.2 width) (* 0.75 height) "solid" "transparent")
                         (rectangle (* 0.6 width) (* 0.75 height) "solid" "black")
                         (rectangle (* 0.1 width) (* 0.75 height) "solid" "transparent")
                         (rectangle (* 0.2 width) (* 0.75 height) "solid" "transparent")
                         (rectangle (* 0.6 width) (* 0.75 height) "solid" "black")
                         (rectangle (* 0.3 width) (* 0.75 height) "solid" "transparent")
                         (rectangle (* 0.6 width) (* 0.75 height) "solid" "black")
                         (rectangle (* 1.4 width) (* 0.75 height) "solid" "transparent")
                         (rectangle (* 0.6 width) (* 0.75 height) "solid" "transparent"))
                 (beside (rectangle width height "outline" "black")
                         (rectangle width height "outline" "black")
                         (rectangle width height "outline" "black")
                         (rectangle width height "outline" "black")
                         (rectangle width height "outline" "black")
                         (rectangle width height "outline" "black")
                         (rectangle width height "outline" "black")
                         (rectangle width height "outline" "black"))))

(keyboard 25 75)