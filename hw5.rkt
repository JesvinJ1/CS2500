;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname hw5) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;; Purpose: Practice with self-referential data.

;; Instructions
;; 1. Do not create, modify or delete any line that begins with ";;!". These are
;;    markers that we use to segment your file into parts to facilitate grading.
;; 2. You must follow the design recipe for every problem. In particular,
;;    every function you define must have at least three check-expects (and
;;    more if needed).
;; 3. You must follow the Style Guide:
;;    https://pages.github.khoury.northeastern.edu/2500/2024F/style.html
;; 4. You must submit working code. In DrRacket, ensure you get no errors
;;    when you click Run. After you submit on Gradescope, you'll get instant
;;    feedback on whether Gradescope can run your code, and your code must
;;    run on Gradescope to receive credit from the autograder.
;; 5. On some problems, you can get automated feedback on your in-progress work
;;    from FeedBot, a system developed by the course staff. When you submit your
;;    assignment, you will see a link to the FeedBot report along with the autograder
;;    feedback. Only a certain number of submissions will get this, and submissions
;;    close together will not receive the feedback.


;;! Problem 1

;; We want to track student diversity by recording age and racial data for an incoming class
;; of first-year students. Consider the following data definitions:

;; Demographic is one of:
;; - "International"
;; - "American Indian or Alaska Native"
;; - "Asian"
;; - "Black or African American"
;; - "Hispanic or Latinx"
;; - "Native Hawaiian or Pacific Islander"
;; - "Two or More Races"
;; - "White"
;; - "Race and Ethnicity Unknown"
;; which represents responses to a mutltiple-choice question about citizenship, ethnicity,
;; and race at Northeastern: https://diversity.northeastern.edu/resources/data/our-demographics/

(define (demo-template r)
  (cond
    [(string=? r "International") ...]
    [(string=? r "American Indian or Alaska Native") ...]
    [(string=? r "Asian") ...]
    [(string=? r "Black or African American") ...]
    [(string=? r "Hispanic or Latinx") ...]
    [(string=? r "Native Hawaiian or Pacific Islander") ...]
    [(string=? r "Two or More Races") ...]
    [(string=? r "White") ...]
    [(string=? r "Race and Ethnicity Unknown") ...]))

(define-struct student [name age demographic legacy? next])
;;! A Responses is one of:
;;! - "end of responses"
;;! - (make-student String Integer Demographic Boolean Responses)
;;! Interpretation: Student responses to a demographic survey.

(define RESPONSES-EX-1 "end of responses")
(define RESPONSES-EX-2 (make-student "Alice" 18 "International" #false "end of responses"))
(define RESPONSES-EX-3
  (make-student "Alice"
                18
                "International"
                #false
                (make-student "Bob" 19 "Two or More Races" #true "end of responses")))
(define RESPONSES-EX-4
  (make-student "Alice"
                18
                "International"
                #false
                (make-student "Bob" 19 "Two or More Races" #true
                              (make-student "Waldo" 21 "Two or More Races" #true "end of responses"))))

;;! Part A

;; Write the template for Responses.

;;!! IMPORTANT: Write your response BELOW this line:
(define (responses-temp r)
  (cond [(string? r) ...]
        [(student? r) (... (student-name r)
                           (student-age r)
                           (student-demographic r)
                           (student-legacy? r)
                           (responses-temp (student-next r)) ...)]))

;;! Part B
;; INTERPRETIVE QUESTION
;;
;; In order to meaningfully track student diversity, it's important that our
;; data allow students to accurately share the demographic information with
;; which they identify. Consider the structure of our data definition. In 2-3
;; sentences, describe how using a single-picklist (i.e., Demographic is exactly
;; one of the options above) might undermine a student's ability to accurately
;; self-identify. Why might a student want to choose more than one?

;;!! IMPORTANT: Write your response BELOW this line:
;; By having the ability to only choose one demographic limits the student
;; in picking all the demographic catagories that represents them. With this
;; being the case students will not be able to accurately represents the various
;; racial or ethnic groups they are a part of. This can cause a lack of information
;; about student diversity.

;;! Part C
;; Design a function called count-over-twenty that counts the number
;; of students over the age of twenty in a series of Responses.

;;!! IMPORTANT: Write your response BELOW this line:
;; Signature: count-over-twenty : student -> number
;; Purpose Statement: the function counts the amount of students that are over the age of 20 within the responses
;; Tests:
(check-expect (count-over-twenty RESPONSES-EX-1) 0)
(check-expect (count-over-twenty RESPONSES-EX-2) 0)
(check-expect (count-over-twenty RESPONSES-EX-3) 0)
(check-expect (count-over-twenty RESPONSES-EX-4) 1)
;; Code:
(define (count-over-twenty s)
  (cond
    [(string? s) 0]
    [(student? s)
     (+ (if (> (student-age s) 20) 1 0)
                       (count-over-twenty (student-next s)))]))

;;! Part D

;; Design a predicate called waldo-responded? that determines if a student named
;; "Waldo" is in a series of Responses.

;;!! IMPORTANT: Write your response BELOW this line:
;; Signature: waldo-respnded? : student -> boolean
;; Purpose Statement: the function checks the students name and if it is "Waldo" it will return true
;; otherwise it will return false
;; Tests:
(check-expect (waldo-responded? RESPONSES-EX-1) #f)
(check-expect (waldo-responded? RESPONSES-EX-2) #f)
(check-expect (waldo-responded? RESPONSES-EX-3) #f)
(check-expect (waldo-responded? RESPONSES-EX-4) #t)
;; Code:
(define (waldo-responded? w)
  (cond
    [(string? w) #false]
    [(student? w)
     (if (string=? (student-name w) "Waldo") 
         #true
         (waldo-responded? (student-next w)))]))

;;! Part E

;; Design a function, `legacy-students`, that takes in a Response and produces a Response
;; containing only the legacy students.

;;!! IMPORTANT: Write your response BELOW this line:
;; Signature: legacy-students : Response -> Response
;; Purpose Statement: this function takes in a response and returns all the students that are legacy students
;; Tests:
(check-expect (legacy-students RESPONSES-EX-1) "end of responses")
(check-expect (legacy-students RESPONSES-EX-2) "end of responses")
(check-expect (legacy-students RESPONSES-EX-3) (make-student "Bob" 19 "Two or More Races" #true "end of responses"))
(check-expect (legacy-students RESPONSES-EX-4) (make-student "Bob" 19 "Two or More Races" #true (make-student "Waldo" 21 "Two or More Races" #true "end of responses")))
;; Code:
(define (legacy-students l)
  (cond
    [(string? l) "end of responses"]
    [(student? l)
     (if (student-legacy? l)
         (make-student (student-name l)
                       (student-age l)
                       (student-demographic l)
                       (student-legacy? l)
                       (legacy-students (student-next l)))
         ;; else statement
         (legacy-students (student-next l)))]))

;;! Problem 2

;; This problem has a partially-completed data definition that represents a
;; workout sequence.

(define-struct cardio [rest])
(define-struct strength [rest])
(define-struct flexibility [rest])
;;! A Workout is one of:
;;! - (make-cardio Workout)
;;! - (make-strength Workout)
;;! - (make-flexibility Workout)
;;! - "done"
;;! Interpretation: A list of exercises in a long workout.

;;! Part A

;; Give three examples of Workouts.

;;!! IMPORTANT: Write your response BELOW this line:


;;! Part B

;; Write the template for Workouts.

;;!! IMPORTANT: Write your response BELOW this line:


;;! Part C

;; Design a function called recovery-sequence that generates a "recovery" sequence for a
;; given Workout. In the recovery sequence, cardio exercises become flexibility exercises,
;; strength exercises become cardio exercises, and flexibility exercises become strength
;; exercises. If you are "done", the recovery sequence ends.

;;!! IMPORTANT: Write your response BELOW this line:

