;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname hw3) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Purpose: Design Recipe practice, now with structured data.

(require 2htdp/image)
(require 2htdp/universe)

;;! Instructions
;;! 1. Do not create, modify or delete any line that begins with ";;!", such
;;!    as these lines. These are markers that we use to segment your file into
;;!    parts to facilitate grading.
;;! 2. You must follow the _design recipe_ for every problem. In particular,
;;!    every function you define must have at least three check-expects (and
;;!    more if needed).
;;! 3. You must follow the Style Guide:
;;!    https://pages.github.khoury.northeastern.edu/2500/2024F/style.html
;;! 4. You must submit working code. In DrRacket, ensure you get on errors
;;!    when you click Run. After you submit on Gradescope, you'll get instant
;;!    feedback on whether or Gradescope can run your code, and your code must
;;!    run on Gradescope to receive credit from the autograder. Any problems
;;!    reported by the autograder can be corrected and you can resubmit as many
;;!    times as you want before the deadline.

;;! Problem 1

;; Consider the following data definition and interpretation.

(define-struct time (hours minutes seconds))
;;! A Time is a (make-time Number Number Number)
;;! Represents the time of day where:
;;! – hours is between 0 and 23
;;! – minutes is between 0 and 59
;;! – seconds is between 0 and 59

;;! Part A
;; Complete the two remaining parts of the data design for Time.
;; Examples:
(define TIME1 (make-time 9 10 25))
(define TIME2 (make-time 7 32 19))
(define TIME3 (make-time 12 32 54))
  
;; Template:
(define (time-temp t)
  (cond [(time-hours t) ...]
       [(time-minutes t) ...]
       [(time-seconds t) ...]))

;;! Part B
;; Design a function called tick that adds one second to a Time.

;; Signature: tick : Numbers -> Time
;; Purpose Statement: The purpose of this function is that it adds one second to the time which in turn could change the minute or hour
;; Tests:
(check-expect (tick (make-time 1 30 32)) (make-time 1 30 33))
(check-expect (tick (make-time 23 59 59)) (make-time 0 0 0))
(check-expect (tick (make-time 1 59 59)) (make-time 2 0 0))
(check-expect (tick (make-time 1 30 59)) (make-time 1 31 0)) 
;; Code:
(define (tick t)
  (cond [(< (time-seconds t) 59)
         (make-time (time-hours t) (time-minutes t) (+ 1 (time-seconds t)))]
        [(< (time-minutes t) 59)
         (make-time (time-hours t) (+ 1 (time-minutes t)) 0)]
        [(< (time-hours t) 23)
         (make-time (+ 1 (time-hours t)) 0 0)]
        [else
         (make-time 0 0 0)]))

;;! Part C

;; Design a function called time->image that draws an analog clock face with
;; three hands. (The hour hand is shortest and the minute and second hand should
;; be different.)
;;
;; See the link below for a refresher on how an analog clock works
;; https://en.wikipedia.org/wiki/Clock_face
;; Note: The hour hand does not need to base it's position on the minute hand
;; for this assignment

;; Signature: time->image : Time -> Image
;; Purpose Statement: display a clock that represents a time that is inputed in
;; Tests:
(check-expect (time->image (make-time 0 0 0))
              (overlay
               (SET-CLOCK-SECOND 0)       
               (SET-CLOCK-MINUTE 0)        
               (SET-CLOCK-HOUR 0)          
               (circle CLOCK-SIZE "outline" "black")))
(check-expect (time->image (make-time 12 0 0))
              (overlay
               (SET-CLOCK-SECOND 0)
               (SET-CLOCK-MINUTE 0)
               (SET-CLOCK-HOUR 12)
               (circle CLOCK-SIZE "outline" "black")))
(check-expect (time->image (make-time 9 59 59))
              (overlay
               (SET-CLOCK-SECOND 59)
               (SET-CLOCK-MINUTE 59)
               (SET-CLOCK-HOUR 9)
               (circle CLOCK-SIZE "outline" "black")))
;; Code:
(define CLOCK-SIZE 100)
(define CLOCK-HOUR-LENGTH 55)
(define CLOCK-MINUTE-LENGTH 75)
(define CLOCK-SECOND-LENGTH 85)

(define (SET-CLOCK-HOUR hours)
  (cond [(= hours 0) (line 0 CLOCK-HOUR-LENGTH "black")]
        [(= hours 1) (rotate -30 (line 0 CLOCK-HOUR-LENGTH "black"))]
        [(= hours 2) (rotate -60 (line 0 CLOCK-HOUR-LENGTH "black"))]
        [(= hours 3) (rotate -90 (line 0 CLOCK-HOUR-LENGTH "black"))]
        [(= hours 4) (rotate -120 (line 0 CLOCK-HOUR-LENGTH "black"))]
        [(= hours 5) (rotate -150 (line 0 CLOCK-HOUR-LENGTH "black"))]
        [(= hours 6) (rotate -180 (line 0 CLOCK-HOUR-LENGTH "black"))]
        [(= hours 7) (rotate -210 (line 0 CLOCK-HOUR-LENGTH "black"))]
        [(= hours 8) (rotate -240 (line 0 CLOCK-HOUR-LENGTH "black"))]
        [(= hours 9) (rotate -270 (line 0 CLOCK-HOUR-LENGTH "black"))]
        [(= hours 10) (rotate -300 (line 0 CLOCK-HOUR-LENGTH "black"))]
        [(= hours 11) (rotate -330 (line 0 CLOCK-HOUR-LENGTH "black"))]
        [(= hours 12) (rotate -360 (line 0 CLOCK-HOUR-LENGTH "black"))]
        [else (line 0 CLOCK-HOUR-LENGTH "black")]))

(define (SET-CLOCK-MINUTE minutes)
  (cond [(= minutes 0) (rotate 0 (line 0 CLOCK-MINUTE-LENGTH "blue"))]
        [(= minutes 1) (rotate -6 (line 0 CLOCK-MINUTE-LENGTH "blue"))]
        [(= minutes 2) (rotate -12 (line 0 CLOCK-MINUTE-LENGTH "blue"))]
        [(= minutes 3) (rotate -18 (line 0 CLOCK-MINUTE-LENGTH "blue"))]
        [(= minutes 4) (rotate -24 (line 0 CLOCK-MINUTE-LENGTH "blue"))]
        [(= minutes 5) (rotate -30 (line 0 CLOCK-MINUTE-LENGTH "blue"))]
        [(= minutes 6) (rotate -36 (line 0 CLOCK-MINUTE-LENGTH "blue"))]
        [(= minutes 7) (rotate -42 (line 0 CLOCK-MINUTE-LENGTH "blue"))]
        [(= minutes 8) (rotate -48 (line 0 CLOCK-MINUTE-LENGTH "blue"))]
        [(= minutes 9) (rotate -54 (line 0 CLOCK-MINUTE-LENGTH "blue"))]
        [(= minutes 10) (rotate -60 (line 0 CLOCK-MINUTE-LENGTH "blue"))]
        [(= minutes 11) (rotate -66 (line 0 CLOCK-MINUTE-LENGTH "blue"))]
        [(= minutes 12) (rotate -72 (line 0 CLOCK-MINUTE-LENGTH "blue"))]
        [(= minutes 13) (rotate -78 (line 0 CLOCK-MINUTE-LENGTH "blue"))]
        [(= minutes 14) (rotate -84 (line 0 CLOCK-MINUTE-LENGTH "blue"))]
        [(= minutes 15) (rotate -90 (line 0 CLOCK-MINUTE-LENGTH "blue"))]
        [(= minutes 16) (rotate -96 (line 0 CLOCK-MINUTE-LENGTH "blue"))]
        [(= minutes 17) (rotate -102 (line 0 CLOCK-MINUTE-LENGTH "blue"))]
        [(= minutes 18) (rotate -108 (line 0 CLOCK-MINUTE-LENGTH "blue"))]
        [(= minutes 19) (rotate -114 (line 0 CLOCK-MINUTE-LENGTH "blue"))]
        [(= minutes 20) (rotate -120 (line 0 CLOCK-MINUTE-LENGTH "blue"))]
        [(= minutes 21) (rotate -126 (line 0 CLOCK-MINUTE-LENGTH "blue"))]
        [(= minutes 22) (rotate -132 (line 0 CLOCK-MINUTE-LENGTH "blue"))]
        [(= minutes 23) (rotate -138 (line 0 CLOCK-MINUTE-LENGTH "blue"))]
        [(= minutes 24) (rotate -144 (line 0 CLOCK-MINUTE-LENGTH "blue"))]
        [(= minutes 25) (rotate -150 (line 0 CLOCK-MINUTE-LENGTH "blue"))]
        [(= minutes 26) (rotate -156 (line 0 CLOCK-MINUTE-LENGTH "blue"))]
        [(= minutes 27) (rotate -162 (line 0 CLOCK-MINUTE-LENGTH "blue"))]
        [(= minutes 28) (rotate -168 (line 0 CLOCK-MINUTE-LENGTH "blue"))]
        [(= minutes 29) (rotate -174 (line 0 CLOCK-MINUTE-LENGTH "blue"))]
        [(= minutes 30) (rotate -180 (line 0 CLOCK-MINUTE-LENGTH "blue"))]
        [(= minutes 31) (rotate -186 (line 0 CLOCK-MINUTE-LENGTH "blue"))]
        [(= minutes 32) (rotate -192 (line 0 CLOCK-MINUTE-LENGTH "blue"))]
        [(= minutes 33) (rotate -198 (line 0 CLOCK-MINUTE-LENGTH "blue"))]
        [(= minutes 34) (rotate -204 (line 0 CLOCK-MINUTE-LENGTH "blue"))]
        [(= minutes 35) (rotate -210 (line 0 CLOCK-MINUTE-LENGTH "blue"))]
        [(= minutes 36) (rotate -216 (line 0 CLOCK-MINUTE-LENGTH "blue"))]
        [(= minutes 37) (rotate -222 (line 0 CLOCK-MINUTE-LENGTH "blue"))]
        [(= minutes 38) (rotate -228 (line 0 CLOCK-MINUTE-LENGTH "blue"))]
        [(= minutes 39) (rotate -234 (line 0 CLOCK-MINUTE-LENGTH "blue"))]
        [(= minutes 40) (rotate -240 (line 0 CLOCK-MINUTE-LENGTH "blue"))]
        [(= minutes 41) (rotate -246 (line 0 CLOCK-MINUTE-LENGTH "blue"))]
        [(= minutes 42) (rotate -252 (line 0 CLOCK-MINUTE-LENGTH "blue"))]
        [(= minutes 43) (rotate -258 (line 0 CLOCK-MINUTE-LENGTH "blue"))]
        [(= minutes 44) (rotate -264 (line 0 CLOCK-MINUTE-LENGTH "blue"))]
        [(= minutes 45) (rotate -270 (line 0 CLOCK-MINUTE-LENGTH "blue"))]
        [(= minutes 46) (rotate -276 (line 0 CLOCK-MINUTE-LENGTH "blue"))]
        [(= minutes 47) (rotate -282 (line 0 CLOCK-MINUTE-LENGTH "blue"))]
        [(= minutes 48) (rotate -288 (line 0 CLOCK-MINUTE-LENGTH "blue"))]
        [(= minutes 49) (rotate -294 (line 0 CLOCK-MINUTE-LENGTH "blue"))]
        [(= minutes 50) (rotate -300 (line 0 CLOCK-MINUTE-LENGTH "blue"))]
        [(= minutes 51) (rotate -306 (line 0 CLOCK-MINUTE-LENGTH "blue"))]
        [(= minutes 52) (rotate -312 (line 0 CLOCK-MINUTE-LENGTH "blue"))]
        [(= minutes 53) (rotate -318 (line 0 CLOCK-MINUTE-LENGTH "blue"))]
        [(= minutes 54) (rotate -324 (line 0 CLOCK-MINUTE-LENGTH "blue"))]
        [(= minutes 55) (rotate -330 (line 0 CLOCK-MINUTE-LENGTH "blue"))]
        [(= minutes 56) (rotate -336 (line 0 CLOCK-MINUTE-LENGTH "blue"))]
        [(= minutes 57) (rotate -342 (line 0 CLOCK-MINUTE-LENGTH "blue"))]
        [(= minutes 58) (rotate -348 (line 0 CLOCK-MINUTE-LENGTH "blue"))]
        [(= minutes 59) (rotate -354 (line 0 CLOCK-MINUTE-LENGTH "blue"))]
        [(= minutes 60) (rotate -360 (line 0 CLOCK-MINUTE-LENGTH "blue"))]))
     
(define (SET-CLOCK-SECOND seconds)
  (rotate (* -6 seconds) (line 0 CLOCK-SECOND-LENGTH "red")))

(define (time->image time)
  (overlay
   (SET-CLOCK-SECOND (time-seconds time))
   (SET-CLOCK-MINUTE (time-minutes time))
   (SET-CLOCK-HOUR (time-hours time))
   (circle CLOCK-SIZE "outline" "black")))

;;! Problem 2

;;! Part A

;; You are designing a registration system for a competition. Design a data definition
;; called Attendee that represents a person attending the competition. An Attendee
;; should have a name, gender, email, NUID, and whether they are competing (rather than just
;; observing).

;; Data Defintion:
(define-struct Attendee [name gender email NUID competing])
;; A Attendee is someone that is particpating in a competition
;; They have values representing them such as:
;; - Name
;; - Gender
;; - Email
;; - NUID
;; - If they are attending/observing
;; Interpretation: An attendee has these values to their name representing various aspects of them
;; and whether they are attending or not
;; Examples:
(define ATTENDEE1 (make-Attendee "John" "Male" "john@northeastern.edu" "001234567" #false))
(define ATTENDEE2 (make-Attendee "Jaime" "Female" "jaime@noreastern.edu" "007654321" "Observing"))
(define ATTENDEE3 (make-Attendee "Jerry" "Male" "jerry@northeast.edu" "002567216" "Observing"))

;; Template:
(define (Attendee-temp a)
  (... (Attendee-name a)
   ... (Attendee-gender a)
   ... (Attendee-email a)
   ... (Attendee-NUID a)
   ... (Attendee-competing) ...))

;;! Part B

;; Design a function called is-nu-email? that takes an Attendee and returns true if
;; the email ends with `@northeastern.edu`.

;; Signature: is-nu-email? : Attendee -> Boolean
;; Purpose Statement: Check whether the attendees email contains "@northeastern.edu"
;; Tests:
(check-expect (is-nu-email? ATTENDEE1) #t)
(check-expect (is-nu-email? ATTENDEE2) #f)
(check-expect (is-nu-email? ATTENDEE3) #f)
;; Code:
(define (is-nu-email? Attendee)
  (string-contains? "@northeastern.edu"
                  (Attendee-email Attendee)))

;;! Part C

;; Design a function called mark-competing that takes an Attendee and marks them
;; as competing. This should only work if `is-nu-email?` returns true,
;; otherwise, leave the field unchanged.

;; Signature: mark-competing : Attendee -> make-Attendee
;; Purpose Statement: The purpose is to mark the Attendee as true if they have a proper NU email
;; otherwise leave that section the way it is.
;; Tests:
(check-expect (mark-competing ATTENDEE1) (make-Attendee "John" "Male" "john@northeastern.edu" "001234567" #true))
(check-expect (mark-competing ATTENDEE2) (make-Attendee "Jaime" "Female" "jaime@noreastern.edu" "007654321" "Observing"))
(check-expect (mark-competing ATTENDEE3) (make-Attendee "Jerry" "Male" "jerry@northeast.edu" "002567216" "Observing"))
;; Code:
(define (mark-competing Attendee)
  (if (is-nu-email? Attendee)
      (make-Attendee (Attendee-name Attendee)
                     (Attendee-gender Attendee)
                     (Attendee-email Attendee)
                     (Attendee-NUID Attendee)
                     #true)
      Attendee))

;;! Part D
;;
;; In the next problem, you will have to _print_ a badge -- i.e., turn an
;; Attendee into an Image. In this problem, we will consider privacy, and
;; whether there is any information that we put it the Attendee data definition
;; that is not necessary. A core privacy principle is to collect as little
;; personal data as possible, focusing on the information directly needed for
;; the task at hand. In minimizing data collection, we reduce the risk of
;; privacy violations or data leaks, since if we do not have data, we cannot
;; accidentally leak it.
;;
;; With these data principles in mind, design a new data definition called
;; Attendee2 that stores less personal data. Compared to the original data
;; definition, the new data definition should *eliminate* at least one field and
;; *modify* at least one field to make it more precise.
;;
;; You new definiton will need to be used for badge printing, so think carefully
;; about what you remove.

;; Design a new data definition that eliminates at least one field from the previous
;; definition and modifies at least one other field.

;; Data Defintion:
(define-struct Attendee2 [first-name last-inital])
;; They have values representing them such as:
;; - First Name
;; - Last Inital

;; Interpretation: An attendee2 has their first name and last inital as their representation 
;; and whether they are attending or not

;; Examples:
(define ATTENDEE2.1 (make-Attendee2 "John" "J"))
(define ATTENDEE2.2 (make-Attendee2 "Ava" "L"))
(define ATTENDEE2.3 (make-Attendee2 "Sean" "M"))

;; Template:
(define (Attendee2-temp a)
  (... (Attendee2-first-name a)
   ... (Attendee2-last-inital a) ...))

;;! Part E

;; In order to answer this question, please watch this short (5min) video:
;; https://northeastern.hosted.panopto.com/Panopto/Pages/Viewer.aspx?id=55828b6f-b114-4320-8a7c-b1f000c2d848

;; Write a short email memo to the other members of the conference team explaining
;; each change you made and justifying each change with a reason for why
;; your version is better (one to two sentences per change). At least one
;; of the justifications should reference a privacy concept from the video
;; (privacy as ability to control information; intimate privacy; privacy
;; as a social good; and privacy as minimizing information collection).

;; The version that I have changed to offers better privacy across the board.
;; The first step I did was remove the collection of the students NUID. By doing so,
;; we can preverse privacy while minimizing data collection in the sense that if a leak
;; were to occur a crucial number, NUID, would not be leaked and cause a loss of personal
;; information. In addition email was removed because if emails were to be leaked it can be
;; sold to other companies and can create spam for the user. On top of this gender was removed
;; and replaced with their last intial because again if gender was still in place it could be used
;; alongside their email and can create targeted ads for the person. Finally, attending was removed
;; because if this were leaked it could possibly allow someone to determine that they are competeing,
;; and at X location. 

;;! Part F
;;
;; Design a function `print-badge` that takes, as input an Attendee2 and returns
;; an Image. It should display information that you would want to show on a
;; printed badge for a competition.

;; Signature: print-badge : Attendee2 -> Image
;; Purpose Statement: The function takes in an Attendee2 and outputs a picture of a badge
;; that displays information for a competition.
;; Tests:
(check-expect (print-badge (make-Attendee2 "John" "J"))
              (overlay/align "center" "center"
                             (text "John J" WORD-SIZE WORD-COLOR)
                             BADGE-BACKGROUND))
(check-expect (print-badge (make-Attendee2 "Sean" "M"))
              (overlay/align "center" "center"
                             (text "Sean M" WORD-SIZE WORD-COLOR)
                             BADGE-BACKGROUND))
(check-expect (print-badge (make-Attendee2 "Ava" "L"))
              (overlay/align "center" "center"
                             (text "Ava L" WORD-SIZE WORD-COLOR)
                             BADGE-BACKGROUND))
;; Code:
(define BADGE-BACKGROUND (rectangle 200 200 "solid" "black"))
(define WORD-SIZE 20)
(define WORD-COLOR "white")

(define (print-badge Attendee2)
  (overlay/align "center" "center"
                 (text (string-append (Attendee2-first-name Attendee2) " " (Attendee2-last-inital Attendee2))
                       WORD-SIZE
                       WORD-COLOR)
                 BADGE-BACKGROUND))
               
