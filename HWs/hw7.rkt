;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname hw7) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

;; Instructions
;; 1. Do not create, modify or delete any line that begins with ";;!". These are
;;    markers that we use to segment your file into parts to facilitate grading.
;; 2. You must follow the _design recipe_ for every problem. In particular,
;;    every function you define must have at least three check-expects (and
;;    more if needed).
;; 3. You must follow the Style Guide:
;;    https://pages.github.khoury.northeastern.edu/2500/2024F/style.html
;; 4. You must submit working code. In DrRacket, ensure you get on errors
;;    when you click Run. After you submit on Gradescope, you'll get instant
;;    feedback on whether or Gradescope can run your code, and your code must
;;    run on Gradescope to receive credit from the autograder.
;; 5. On some problems, you can get automated feedback on your in-progress work
;;    from FeedBot, a system developed by the course staff. When you submit your
;;    assignment, you will see a link to the FeedBot report along with the autograder
;;    feedback. Only a certain number of submissions will get this, and submissions
;;    close together will not receive the feedback.

;;! Problem 1

;; The objective in this problem is to define the following functions.
;; We have given their signatures, purpose statements, and check-expects.

(define-struct pair [first second])
;; A [Pair X] is a (make-pair X X) representing a pair of values of type X
;; - first is the first item in the pair
;; - second is the second item in the pair

;; strings-or-odds : [List-of [Pair Number]] -> [List-of [Pair String]]
;; For each pair converts the first item to a string and the second to "odd".
(check-expect (strings-or-odds (list (make-pair 53 23) (make-pair 40 11)))
              (list (make-pair "53" "odd") (make-pair "40" "odd")))
(check-expect (strings-or-odds (list (make-pair 20 30) (make-pair 0 1) (make-pair 3 4)))
              (list (make-pair "20" "odd") (make-pair "0" "odd") (make-pair "3" "odd")))
(check-expect (strings-or-odds '()) '())

;; alternate-case : [List-of [Pair String]] -> [List-of [Pair String]]
;; Uppercase the first item of each pair. Leaves the second item unchanged.
(check-expect (alternate-case (list (make-pair "hello" "world") (make-pair "this" "Is")))
              (list (make-pair "HELLO" "world") (make-pair "THIS" "Is")))
(check-expect
 (alternate-case (list (make-pair "one" "two") (make-pair "three" "FOUR") (make-pair "five" "six")))
 (list (make-pair "ONE" "two") (make-pair "THREE" "FOUR") (make-pair "FIVE" "six")))
(check-expect (alternate-case (list (make-pair "apple" "banana")))
              (list (make-pair "APPLE" "banana")))

;; flip-or-keep-boolean : [List-of [Pair Boolean]] -> [List-of [Pair Boolean]]
;; Flip the first item of each pair, keep the second unchanged.
(check-expect (flip-or-keep-boolean (list (make-pair #true #true) (make-pair #true #true)))
              (list (make-pair #false #true) (make-pair #false #true)))
(check-expect (flip-or-keep-boolean (list (make-pair #false #false) (make-pair #false #false)))
              (list (make-pair #true #false) (make-pair #true #false)))
(check-expect (flip-or-keep-boolean (list (make-pair #true #false) (make-pair #false #true)))
              (list (make-pair #false #false) (make-pair #true #true)))

;; However, you must not directly use the list template when you define them!
;;
;; Instead, first design a list abstraction (following the list template), then
;; use that abstraction to design the three functions.

;;!! IMPORTANT: Write your response BELOW this line:
;; Signature: new-pair-list : ([Pair X -> Pair Y] [List-of [Pair X]]) -> [List-of [Pair Y]]
;; Purpose Statement: the function takes in a new function and a list of pairs and then it will apply the function that was inputted
;; to each pair of the list
;; Tests:
(check-expect (new-pair-list to-strings-or-odds (list (make-pair 1 2))) (list (make-pair "1" "odd")))
(check-expect (new-pair-list to-alternate-case (list (make-pair "Jesvin" "Jerry"))) (list (make-pair "JESVIN" "Jerry")))
(check-expect (new-pair-list to-flip-or-keep-boolean (list (make-pair #t #f))) (list (make-pair #f #f)))
;; Code:
(define (new-pair-list x list)
  (cond
    [(empty? list) '()]
    [(cons? list)
     (cons (x (first list))
           (new-pair-list x (rest list)))]))

;; Signature: to-strings-or-odds : [Pair Number Number] -> [Pair String String]
;; Purpose Statement: this function converts the first item of the pair into a string
;; and the second item to "odd"
;; Tests:
(check-expect (to-strings-or-odds (make-pair 2 3)) (make-pair "2" "odd"))
(check-expect (to-strings-or-odds (make-pair 5 6)) (make-pair "5" "odd"))
(check-expect (to-strings-or-odds (make-pair 12 1)) (make-pair "12" "odd"))
;; Code:
(define (to-strings-or-odds x)
  (make-pair (number->string (pair-first x)) "odd"))

;; Signature: strings-or-odds : [List-of [Pair Number]] -> [List-of [Pair String]]
;; Purpose Statement: this uses the to-strings-or-odds function and applies it to each pair in the list
;; Tests:
(check-expect (strings-or-odds (list (make-pair 1 2))) (list (make-pair "1" "odd")))
(check-expect (strings-or-odds (list (make-pair 2 1) (make-pair 3 1))) (list (make-pair "2" "odd") (make-pair "3" "odd")))
(check-expect (strings-or-odds (list (make-pair 2 1) (make-pair 3 1) (make-pair 5 1))) (list (make-pair "2" "odd") (make-pair "3" "odd") (make-pair "5" "odd")))
;; Code:
(define (strings-or-odds list)
  (new-pair-list to-strings-or-odds list))

;; Signature: to-alternate-case : [Pair String] -> [Pair String]
;; Purpose Statement: this function upcases the first item of the pair
;; and doesn't change anything about the second item, leaves it as is
;; Tests:
(check-expect (to-alternate-case (make-pair "Jesvin" "Jerry")) (make-pair "JESVIN" "Jerry"))
(check-expect (to-alternate-case (make-pair "Fundies" "1")) (make-pair "FUNDIES" "1"))
(check-expect (to-alternate-case (make-pair "CLASS" "WORK")) (make-pair "CLASS" "WORK"))
;; Code:
(define (to-alternate-case x)
  (make-pair (string-upcase (pair-first x)) (pair-second x)))

;; Signature: alternate-case : [List-of [Pair String]] -> [List-of [Pair String]]
;; Purpose Statement: this uses the to-alternate-case function and applies it to each pair in the list
;; Tests:
(check-expect (alternate-case (list (make-pair "test" "one"))) (list (make-pair "TEST" "one")))
(check-expect (alternate-case (list (make-pair "test" "one") (make-pair "one" "test"))) (list (make-pair "TEST" "one") (make-pair "ONE" "test")))
(check-expect (alternate-case (list (make-pair "TESTING" "one") (make-pair "ONE" "test"))) (list (make-pair "TESTING" "one") (make-pair "ONE" "test")))
;; Code:
(define (alternate-case list)
  (new-pair-list to-alternate-case list))

;; Signature: to-flip-or-keep-boolean : [Pair Boolean] -> [Pair Boolean]
;; Purpose Statement: this function thats the first boolean and inverts it and
;; keeps the second boolean of the pair unchanged
;; Tests:
(check-expect (to-flip-or-keep-boolean (make-pair #f #t)) (make-pair #t #t))
(check-expect (to-flip-or-keep-boolean (make-pair #t #f)) (make-pair #f #f))
(check-expect (to-flip-or-keep-boolean (make-pair #f #f)) (make-pair #t #f))
;; Code:
(define (to-flip-or-keep-boolean x)
  (make-pair (not (pair-first x)) (pair-second x)))

;; Signature: flip-or-keep-boolean : [List-of [Pair Boolean]] -> [List-of [Pair Boolean]]
;; Purpose Statement: this functions uses the to-flip-or-keep-boolean function to invert the first boolean
;; and this will run it through the entire list
;; Tests:
(check-expect (flip-or-keep-boolean (list (make-pair #f #t))) (list (make-pair #t #t)))
(check-expect (flip-or-keep-boolean (list (make-pair #f #t) (make-pair #t #f))) (list (make-pair #t #t) (make-pair #f #f)))
(check-expect (flip-or-keep-boolean (list (make-pair #f #t) (make-pair #t #f) (make-pair #f #f))) (list (make-pair #t #t) (make-pair #f #f) (make-pair #t #f)))
;; Code:
(define (flip-or-keep-boolean list)
  (new-pair-list to-flip-or-keep-boolean list))

;;! Problem 2

;; Recall our student demographic survey from HW5:

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

;; In this problem, you will be asked to update this data definition. You should create
;; new versions of the relevant structs/functions by naming them `.../v2`, `.../v3`, etc.

;;! Part A

;; The university has decided that the nested responses have become too unwieldy
;; to parse. Replace the definition with a new data structure that represents an
;; arbitrary number of survey results using a list. Consider how the definition
;; of a student should change.

;;!! IMPORTANT: Write your response BELOW this line:
(define-struct student/v2 [name age demographic legacy?])
;; student/v2 is a struct:
;; (make-student/v2 String Integer Demographic Boolean)
;; - represents a students name, age, demographic, and if they are a legacy
;; name - string representing the name of the student
;; age - number that represents the age of the student
;; demographic - string that represents the demographic background of the student
;; legacy? - boolean that states whether or not a student is a legacy
;; Interpretation: Student responses to a demographic survey

;; ResponsesV2 - list of student/v2 structs, student responses to a demographic survey (name, age, demographic, and legacy status)
;; - '()
;; - (cons LoS)
(define RESPONSES-V2-EX-1 '())
(define RESPONSES-V2-EX-2 (list (make-student/v2 "Alice" 18 "International" #false)))
(define RESPONSES-V2-EX-3 (list (make-student/v2 "Alice" 18 "International" #false) (make-student/v2 "Bob" 19 "Two or More Races" #true)))

;; Template:
(define (responses/v2-temp r)
  (cond
    [(empty? r) '()]
    [(cons? r) ...]
    (cons (list (student/v2-name (first r))
                (student/v2-age (first r))
                (student/v2-demographic (first r))
                (student/v2-legacy? (first r))
          (responses/v2-temp (rest r))))))

;;! Part B

;; Given our concerns about accuracy from HW 5, the university has decided to
;; further modify the survey so students can select multiple options of
;; Demographic in response to the question about citizenship, ethnicity, and
;; race. Revise the Student and Responses data definitions accordingly, providing `.../v3` versions.

;;!! IMPORTANT: Write your response BELOW this line:
(define-struct student/v3 [name age demographics legacy?])
;; student/v3 is a struct:
;; (make-student String Integer (listof String) Boolean)
;; - represents a students name, age, demographic, and if they are a legacy
;; name - string representing the name of the student
;; age - number that represents the age of the student
;; demographics - a list of strings that represents the demographic backgrounds of the student (multiple)
;; legacy? - boolean that states whether or not a student is a legacy
;; Interpretation: Student responses to a demographic survey. Name represents the name of the student (string),
;; age is the age in years/num, demographics is a list that represents backgrounds of the student, and legacy
;; is a boolean that states whether or not a student is a legacy

;; (ResponsesV3 is a list of student/v3 structs) (containing name, age, list of demographics, and legacy status)
(define RESPONSES-V3-EX-1 '())
(define RESPONSES-V3-EX-2 (list (make-student/v3 "Alice" 18 (list "Two or More Races" "White") #false)))
(define RESPONSES-V3-EX-3 (list (make-student/v3 "Alice" 18 (list "Two or More Races" "White") #false) (make-student/v3 "Bob" 19 (list "International" "Asian") #true)))

;; (list of student/v3)
;; Template:
(define (responses/v3-temp r)
  (cond
    [(empty? r) '()]
    [(cons? r) ...]
    (cons (list (student/v3-name (first r))
                (student/v3-age (first r))
                (student/v3-demographics (first r))
                (student/v3-legacy? (first r))
          (responses/v3-temp (rest r))))))

;;! Part C (PART 1)
;; INTERPRETIVE QUESTIONS
;;
;; When collecting demographic data, we want to strike an effective balance
;; between allowing for accurate self-expression from respondents and collecting
;; data in a way that allows for meaningful analysis. In an effort to enhance
;; students' abilities to self-express, we're considering adding an "Other"
;; option, in which students can submit a free text response to self-identify.

;; -- Universities track student demographic data (in part) to evaluate how
;; their efforts to support a diverse student body have been effective or
;; ineffective over time. In 1-2 sentences, explain how adding the "Other"
;; option might complicate analysis.

;;!! IMPORTANT: Write your response BELOW this line:
;; By adding a "Other" section it leads to free interpretation from the respondent.
;; Because of this, the type of information that you get from other would vary
;; across every student and because of this would cause it to become more complicated
;; to sort out the information that is gained from the other section. It would
;; lead to all sorts of different data that might not be able to be catagorized
;; across the board. 

;;! Part C (PART 2)
;; -- In 2-3 sentences, how might adding the "Other" option benefit students?
;; How might it benefit the university?

;;!! IMPORTANT: Write your response BELOW this line:
;; By adding the "Other" option it can benefit the students in the sense that they can add something,
;; such as a characteristic about themselves, that the survey didn't allow for intially. In addition
;; to this, it would benefit the university in the sense that they can obtain data that they may have
;; intially have thought to be absolute but with the students input they could see that it is actually
;; important or a key aspect of a large sum of students. In essence, it would allow the university to
;; gain new information they previously haven't thought of. 

;;! Part D

;; You've been tasked to identify how many students put down "Race and Ethnicity
;; Unknown", as that might indicate students didn't feel the existing options
;; allowed them to express their identity. Design a function
;; `count-unknown-students` that returns the number of such students, given the
;; latest version of your data definition as input. Consider which list
;; abstraction(s) would be useful here (you are not required to use one, but
;; may).

;;!! IMPORTANT: Write your response BELOW this line:
;; Signature: contains-unknown? : ListOfString -> Boolean
;; Purpose Statement: helper function to determine whether "Race and Ethnicity Unknown" is in a list
;; Tests:
(check-expect (contains-unknown? '()) #f)
(check-expect (contains-unknown? (list "International" "Two or More Races")) #f)
(check-expect (contains-unknown? (list "Race and Ethnicity Unknown")) #true)
;; Code:
(define (contains-unknown? list)
  (cond
    [(empty? list) #false]
    [(string=? "Race and Ethnicity Unknown" (first list)) #true]
    [else (contains-unknown? (rest list))]))

;; Signature: count-unknown-students : ListOfStudent -> Number
;; Purpose Statement: the function returns the amount of students that mark
;; themselves as "Race and Ethnicity Unknown" from a list of students
;; Tests:
(check-expect (count-unknown-students '()) 0)
(check-expect (count-unknown-students (list (make-student/v3 "Alice" 18 (list "International") #false))) 0)
(check-expect (count-unknown-students (list (make-student/v3 "Alice" 18 (list "Two or More Races" "Race and Ethnicity Unknown") #false))) 1)
;; Code:
(define (count-unknown-students c)
  (cond
    [(empty? c) 0]
    [(cons? c)
     (if (contains-unknown? (student/v3-demographics (first c)))
         (+ 1 (count-unknown-students (rest c)))
         (count-unknown-students (rest c)))]))

;;! Part E
;; INTERPRETIVE QUESTION
;;
;; Read the following article: https://tinyurl.com/bdza4nt7
;;
;; Imagine you're working for a real estate company, and your boss wants to
;; target advertisements using the demographic data collected above. Write a 2-3
;; sentence memo to your boss explaining why you can't advertise on the basis of
;; racial demographic data, referring to the article in your answer. Explain why
;; the advertisements your boss proposed have the potential to violate the
;; provisions of the Fair Housing Act. Offer an alternative to your boss's
;; proposal.

;;!! IMPORTANT: Write your response BELOW this line:
;; You cannot advertise on the basis of racial demographic data beacuse of the fact that
;; the housing act states that it "prohibits discrimination in housing-related transactions...
;; based on race, color..." This means essentially what it says, you cannot create targeted
;; advertisements using the demographic data that is collected. The propostion by my boss
;; straight up violates the the idea of discrimination in housing related transactions. An
;; alternative to this would be to focus on factors that are non discriminatory like the
;; prefernce of the location and what it has to offer. 

;;! Part F

;; Since this personal racial data is sensitive and the university only needs
;; the demographic data in aggregate, the university has decided they would like
;; to anonymize the data for privacy purposes. Design a data definition for a
;; student response that does not include the student's name. Then write a
;; function, `anonymize`, that converts from a series of responses containing
;; student names to your new data definition.

;;!! IMPORTANT: Write your response BELOW this line:
(define-struct student/v4 [age demographics legacy?])
;; student/v4 is a struct:
;; (make-student Integer Demographic Boolean)
;; - represents a students age, demographic, and if they are a legacy
;; age - number that represents the age of the student
;; demographics - a list of strings that represents the demographic backgrounds of the student (multiple)
;; legacy? - boolean that states whether or not a student is a legacy
;; Interpretation: Student responses to a demographic survey

;; ResponsesV4 - list student responses to a demographic survey
;; - '()
;; - (cons LoS)
(define RESPONSES-V4-EX-1 '())
(define RESPONSES-V4-EX-2 (list (make-student/v4 18 (list "Two or More Races" "White") #false)))
(define RESPONSES-V4-EX-3 (list (make-student/v4 18 (list "Two or More Races" "White") #false) (make-student/v4 19 (list "International" "Asian") #true)))

;; Template:
(define (responses/v4-temp r)
  (cond
    [(empty? r) '()]
    [(cons? r) ...]
    (cons (list (student/v4-age (first r))
                (student/v4-demographics (first r))
                (student/v4-legacy? (first r))
          (responses/v4-temp (rest r))))))

;; Signature: make-student-anonymous-helper : student/v3 -> student/v4
;; Purpose Statement: this helper function takes in a student/v3 and turns it into a student/v4
;; in addition to removing the name of the student
;; Tests:
(check-expect (make-student-anonymous-helper (make-student/v3 "Alice" 18 (list "International" "White") #false)) (make-student/v4 18 (list "International" "White") #false))
(check-expect (make-student-anonymous-helper (make-student/v3 "John" 18 (list "Two or More Races" "Black") #false)) (make-student/v4 18 (list "Two or More Races" "Black") #false))
(check-expect (make-student-anonymous-helper (make-student/v3 "Bill" 22 (list "Asian" "White") #true)) (make-student/v4 22 (list "Asian" "White") #true))
;; Code:
(define (make-student-anonymous-helper s)
  (make-student/v4 (student/v3-age s)
                   (student/v3-demographics s)
                   (student/v3-legacy? s)))

;; Signature: anonymize : [ListOf student/v3] -> [ListOf student/v4]
;; Purpose Statement: the function takes in a list of students that contains their name
;; and turns it into a list of students without their name, while retaining all other parts
;; of the data
;; Tests:
(check-expect (anonymize RESPONSES-V3-EX-1) '())
(check-expect (anonymize RESPONSES-V3-EX-2) (list (make-student/v4 18 (list "Two or More Races" "White") #false)))
(check-expect (anonymize RESPONSES-V3-EX-3) (list (make-student/v4 18 (list "Two or More Races" "White") #false) (make-student/v4 19 (list "International" "Asian") #true)))
;; Code:
(define (anonymize a)
  (map make-student-anonymous-helper a))
 