;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname lab2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;;! Instructions:
;;! 1. Read the contents of this file, and fill in [TODO] items that appear
;;!    below.
;;! 2. Do not create, modify or delete any line that begins with ";;!", such
;;!    as these lines. These are markers that we use to segment your file into
;;!    parts to facilitate grading.


(require 2htdp/image)
(require 2htdp/universe)

;;! Problem 1

;; For any word of at least one character that starts with a letter,
;; let’s say that its "bingo word" is the uppercase version of the
;; first letter, followed by a space, and then followed by the number
;; of characters in the word. For example, the bingo word of "bingo"
;; is "B 5" and the bingo word of "Win" is "W 3".
;
;; TODO: Write a function, bingo-word, that takes a string as an argument
;; and returns its bingo word. You may assume that the argument is a valid
;; word as described above.

(define (bingo-word word)
  (string-append (substring word 0 1) " " (number->string (string-length word)))
  )

;;! Problem 2

;;! Part A

;; TODO: use the circle, triangle, square, rectangle, above, and overlay/align
;; functions to define a constant FACE that is an image with two eyes, a nose, and a mouth
;; (and some hair if you're feeling bold). Be creative :)

(define FACE-WIDTH 75)
(define FACE-HEIGHT 75)

(define NOSE (triangle 25 "solid" "yellow"))
(define MOUTH (rectangle 50 10 "solid" "light red"))
(define FACE (rectangle FACE-WIDTH FACE-HEIGHT "solid" "light gray"))
(define EYE1 (circle 10 "solid" "brown"))
(define EYE2 (circle 10 "solid" "brown"))

(define (draw-face x-mouth)
  (place-image
   MOUTH
   x-mouth
   68
   (place-image NOSE
                (/ FACE-WIDTH 2)
                (/ FACE-HEIGHT 1.5)
                (place-image EYE1
                             (/ FACE-WIDTH 3)
                             (/ FACE-HEIGHT 3)
                             (place-image EYE2
                                          (* 2 (/ FACE-WIDTH 3))
                                          (/ FACE-HEIGHT 3)
                                          FACE)))))

;;! Part B

;; TODO: define a constant EAR and place two of them on your face,
;; defining a new constant FACE-WITH-EARS. Note how in using a constant we only have to
;; draw it once and get to use it twice!



;;! Part C

;; TODO: define a function hat-color which, given the amount of time since the
;; program began, produces a color for a color-changing hat that goes from black
;; to blue and back to black again. Colors in DrRacket can either defined via a name
;; (like "blue" and "red"), or by numbers, representing the amount of red,
;; green, and blue (each a number from 0-255) using the color function (color
;; red-val green-val blue-val).
;;
;; Your function should always use 0's for red and green, but differ in the amount
;; of blue according to the following steps...
;; 1. Divide the time by 510 and take the remainder (using the remainder function);
;;    this allows the hat color to "loop" back to 0 when time gets bigger than 510.
;; 2. Subtract 255 from that result, and then take the absolute value
;;
;; If it helps to see it in math notation...
;; |(t remainder 510) - 255|

;; Here's a link to show how the amount of blue in the color will change over time...
;; https://www.desmos.com/calculator/ntq43wwjpg

;; hat-color : Number -> Color
;; Cycles the amount of blue in
;; the color from 255 -> 0 -> 255


;;
;; Interpretive question: imagine your face was adopted as the main reaction for
;; Apple's iMessage (in addition to ‼, 👍, 👎, ♥, and "haha!"). Please explain,
;; in 2-3 sentences, whether you should be worried about allocative or
;; representation harm from the decision.

;; In my opinon if my emjoi/face was adopted up an extent it would create some sort of allocative harm becuase it doesn't accurately represent everyone
;; yet alone myself. If it were to be adopted it would have to make sure it includes a good majoirty of what people look like because it would not include what other people look like.
;; In addition to this, these images can possibly mispresent what certan races look like if they are not speific enough. 
