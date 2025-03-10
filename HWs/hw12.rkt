;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname hw12) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

;; Usual Instructions:
;; 1. Do not create, modify or delete any line that begins with ";;!". These are
;;    markers that we use to segment your file into parts to facilitate grading.
;; 2. You must follow the _design recipe_ for every problem. In particular,
;;    every function you define must have at least three check-expects (and
;;    more if needed).
;; 3. You must follow the Style Guide:
;;    https://pages.github.khoury.northeastern.edu/2500/2024F/style.html
;; 4. You must submit working code. In DrRacket, ensure you get no errors
;;    when you click Run. After you submit on Gradescope, you'll get instant
;;    feedback on whether or not Gradescope can run your code, and your code must
;;    run on Gradescope to receive credit from the autograder.
;; 5. On some problems, you can get automated feedback on your in-progress work
;;    from FeedBot, a system developed by the course staff. When you submit your
;;    assignment, you will see a link to the FeedBot report along with the autograder
;;    feedback. Only a certain number of submissions will get this, and submissions
;;    close together will not receive the feedback.

;;! HW12

;; In this assignment, you'll be writing a big-bang program that requests information
;; from a server in order to display information about the happiness of neighborhoods
;; based on interviews conducted with residents. A user will be able to interact with
;; the final project by moving forwards and backwards in time to see how subjective
;; metrics of happiness have changed over the years.

;; The following resources may be helpful:
;; - Client-Server Architecture
;; https://www.youtube.com/watch?v=ggp5C1q0gNA

;; - The World is Not Enough
;; https://docs.racket-lang.org/teachpack/2htdpuniverse.html#(part._universe._world2)

;; Our concept of happiness in this assignment is based on the World Happiness Report,
;; a global partnership between Gallup, Oxford Wellbeing Research Centre, UN Sustainable
;; Development Solutions Network, and the WHR’s Editorial Board that uses observed data
;; on six variables to explain the differences in life evaluations (happiness) across
;; regions. You can find more information about the World Happiness Report here:
;; https://worldhappiness.report/

;; Since we want to communicate with a server to request data, this big-bang
;; program will behave a bit differently than big-bang programs you've seen before.
;; You've seen before that big-bang accepts handlers that describe how the state
;; changes over time (on-tick) and that describe how the change changes
;; with user input. These functions take in the current state and produce a new
;; one.
;;
;; In this HW, we similarly define handlers that describe how the state
;; changes, but since we'd like to additionally communicate with the server to
;; request data, the signatures of the handlers are a bit different, as to allow
;; the handlers to say "I'd like to update the state, but also please send this message
;; to the server". This gives us the ability to send messages to the server, but we'd
;; also like to update the state when we eventually receive responses: we can use
;; the big-bang `on-receive` handler for this purpose.

;;! Problem 1

;; First, we'll need a world state to contain the information we'll need to keep
;; track of for this assignment. In Problem 2D, you will create an updated data definition, but
;; to start, we'll keep it simple by tracking just the number of years into the
;; future we are currently displaying. The "base year" for this assignment is 2020.

;; A ClientWorld is a (make-cw Integer)
(define-struct cw [yearsahead])

;; A ClientWorld represents the current state of the happiness simulation.
;; It contains the following information:
;; - yearsahead: the current number of years after 2020 being rendered

(define (cw-temp cw)
  (... (cw-yearsahead cw) ...))

;; You will also need the following simplified data definition of a Neighborhood.
;; The examples and template have been emitted for brevity.

;; A Neighborhood is one of:
;; - "Allston"
;; - "Back Bay"
;; - "Bay Village"
;; - "Beacon Hill"
;; - "Brighton"
;; - "Charlestown"
;; - "Chinatown"
;; - "Dorchester"
;; - "Downtown"
;; - "East Boston"
;; - "Fenway-Kenmore"
;; - "Hyde Park"
;; - "Jamaica Plain"
;; - "Mattapan"
;; - "Mission Hill"
;; - "North End"
;; - "Roslindale"
;; - "Roxbury"
;; - "South Boston"
;; - "South End"
;; - "West End"
;; - "West Roxbury"
;; - "Wharf District"
;; Interpretation: represents one of the 23 neighborhoods in Boston

;;! Part A

;; Define a constant, `EX-CW`, that represents a ClientWorld 5 years in the future.

;;!! IMPORTANT: Write your response BELOW this line:
(define EX-CW (make-cw 5))

;;! Part B

;; To communicate with the server, your client will send and recieve messages in
;; a specific format. Requests from the client to the server are called packages
;; (https://docs.racket-lang.org/teachpack/2htdpuniverse.html#%28def._universe._%28%28lib._2htdp%2Funiverse..rkt%29._make-package%29%29),
;; and consist of two fields:
;; - the WorldState of the client (in the Racket documentation, `w`)
;; - an S-Expression (see below) representing the message (in the Racket documentation, `m`)

;; An S-Expression is one of:
;; - Number
;; - String
;; - [ListOf S-Expression]
;; S-Expressions are a data format that can include numbers, strings, lists,
;; and arbitrarily nested combinations of these.

(define EX-SEXP1 2020)
(define EX-SEXP2 "Hello, World!")
(define EX-SEXP3 (list 1 2 3))
(define EX-SEXP4 (list EX-SEXP2 EX-SEXP3 (list 2 3)))

;; sexp-temp : S-Expression -> ???
#;(define (sexp-temp sexp)
    (cond
      [(number? sexp) ... sexp ...]
      [(string? sexp) ... sexp ...]
      [(list? sexp) (... (list-temp sexp) ...)]))

;; The requests our client will make for this program are very simple: they are numbers,
;; representing the year that the client wants to request data from. Note that this
;; value is absolute, in contrast to the `yearsahead` field (which is relative to 2020).
;; Using your ClientWorld (`EX-CW`) from Part A, define three Package constants `PACKAGE-2025`, `PACKAGE-2035`,
;; and `PACKAGE-2040` that represent requests for happiness data from 2025, 2035, and 2040 respectively.

;;!! IMPORTANT: Write your response BELOW this line:
(define PACKAGE-2025 (make-package EX-CW 2025))
(define PACKAGE-2035 (make-package EX-CW 2035))
(define PACKAGE-2040 (make-package EX-CW 2040))


;;! Part C

;; Now, design a key handler that handles arrow key presses by incrementing or
;; decrementing the ClientWorld's current year by `YEAR-INCR`. When the year is
;; incremented, the key handler should return a package requesting happiness data
;; for the new year. The year should only be increment up to `MAXYEAR`, or decremented
;; to `BASEYEAR`. If the correct key is not pressed, or the next year would be out
;; of bounds, this function should simply return the current world state.

;; Write the implementation and tests for `key-handler`. The signature and purpose statement
;; have been given. The `|` indicates that the function returns a package _or_ a ClientWorld.

(define BASEYEAR 2020)
(define MAXYEAR 3000)

(define YEAR-INCR 10)

;; key-handler : ClientWorld KeyEvent -> Package | ClientWorld
;; If right/left arrow key is pressed, updates the state with a new year and returns
;; a package requesting new data. Otherwise, returns the current world state.

;;!! IMPORTANT: Write your response BELOW this line:
;; Tests:
(check-expect (key-handler (make-cw 0) "right")
              (make-package (make-cw 10) 2030))
(check-expect (key-handler (make-cw 10) "left")
              (make-package (make-cw 0) 2020))
(check-expect (key-handler (make-cw 0) "up") (make-cw 0))
(check-expect (key-handler (make-cw (- MAXYEAR BASEYEAR)) "right")
              (make-cw (- MAXYEAR BASEYEAR)))
(check-expect (key-handler (make-cw 0) "left") (make-cw 0))
;; Code:
(define (key-handler cw key)
  (cond
    [(and (string=? key "right")
          (<= (+ BASEYEAR (cw-yearsahead cw) YEAR-INCR) (add1 MAXYEAR)))
     (make-package (make-cw (+ (cw-yearsahead cw) YEAR-INCR))
                   (+ BASEYEAR (cw-yearsahead cw) YEAR-INCR))]
    [(and (string=? key "left")
          (>= (+ BASEYEAR (cw-yearsahead cw) (- YEAR-INCR)) BASEYEAR))
     (make-package (make-cw (- (cw-yearsahead cw) YEAR-INCR))
                   (+ BASEYEAR (cw-yearsahead cw) (- YEAR-INCR)))]
    [else cw]))

;;! Problem 2

;; The server contains information gathered from surveys about the self-reported happiness
;; of residents in each neighborhood in Boston. The survey asks questions on the
;; following topics:

;; 1. Social Support
;; If you were in trouble, do you have relatives or friends you can count on
;; to help you whenever you need them, or not?
;; Possible responses: "Yes" or "No"

;; 2. Freedom to Make Life Choices
;; Are you satisfied or dissatisfied with your freedom to choose what you
;; do with your life?
;; Possible responses: "S" or "D"

;; 3. Positive Affect
;; Did you smile or laugh a lot yesterday?
;; Did you experience enjoyment during the majority of the day yesterday?
;; Did you learn or do something interesting yesterday?
;; Range of responses: an integer aggregating responses to the above questions ranging 0-10

;; For each neighborhood, the server returns a collection of survey information
;; in the following form:

#;(list "Allston"
        (list (list "Yes" "Yes" "No" "Yes" "No" "No" "Yes" "No")
              (list "S" "S" "D" "S" "D" "D" "S" "D")
              (list 8 7 9 6 4 5 7 6)))

;;! Part A

;; Collecting data such as this is important to understand the mental
;; well-being of people in different neighborhoods, and it could be used
;; effectively to decide where to, e.g., deploy more public resources that may
;; at least partly contribute positively towards these metrics (e.g., more
;; parks, better social services, etc).
;;
;; However, it is also possible that the data could also contribute negatively
;; to existing stereotypes that certain neighborhoods are "less happy" than
;; others. This is a problem because while "happiness" sounds like an internal,
;; innate property, many of the actual metrics might actually be caused by
;; external circumstances.
;;
;; Please give an example of a external circumstance that could contribute to someone
;; reporting a low or negative score on one of the metrics below, but that is
;; out of the control of the person.
;;
;;
;;!! IMPORTANT: Write your response BELOW this line:
;; An external factor that could contribute to someone reporting low or a negative score
;; could be the amount of money that they have available to them. This could be in terms of
;; economic inequality. An example of this could be someone living in an area with high levels of poverty
;; or with high levels of unemployment could lead to this. 

;;! Part B

;; Consider the following data definition:

(define-struct hi [neighborhood support freedom affect])
;; A HappinessIndex is a (make-hi Neighborhood [List-of String] [List-of String] [List-of Integer])
;; Interpretation: represents responses to a survey about the subjective wellbeing of residents
;; in a neighborhood.

(define (hi-temp hi)
  (... (hi-neighborhood hi) ...
       (list-temp (hi-support hi)) ...
       (list-temp (hi-freedom hi)) ...
       (list-temp (hi-affect hi)) ...))

;; Define a constant, `HI-ALLSTON` that represents the given survey data for
;; Allston (provided above as an example) as a HappinessIndex. Then, design a
;; function, `survey->happiness-index`, that accepts a list of responses to the
;; survey questions (as an S-Expression) and returns a HappinessIndex.

;; Note: The server's database contains all of the survey information in the correct
;; form, but it is still important to check the data before going from a semistructured
;; format to a structured one, especially when dealing with data structures like
;; S-Expressions. If the given S-Expression is not formatted correctly, the function
;; should raise an error (https://docs.racket-lang.org/htdp-langs/intermediate-lam.html#(def._htdp-intermediate-lambda._((lib._lang%2Fhtdp-intermediate-lambda..rkt)._error)))
;; indicating that something went wrong. You can use the following function to check
;; if an given S-Expression is well-formed:

;; well-formed-responses? : S-Expression -> Boolean
;; checks if the given S-Expression is a correctly formatted series of survey responses
(define (well-formed-responses? sexpr)
  (and (list? sexpr)
       (= (length sexpr) 2)
       (string? (first sexpr))
       (list? (second sexpr))
       (= (length (second sexpr)) 3)
       (list? (first (second sexpr)))
       (list? (second (second sexpr)))
       (list? (third (second sexpr)))))

;; Test that checks that `survey->happiness-index` raises an error when
;; its given a malformed message.
(check-error (survey->happiness-index "BAD MESSAGE"))

;;!! IMPORTANT: Write your response BELOW this line:
(define HI-ALLSTON
  (make-hi "Allston"
           (list "Yes" "Yes" "No" "Yes" "No" "No" "Yes" "No")
           (list "S" "S" "D" "S" "D" "D" "S" "D")
           (list 8 7 9 6 4 5 7 6)))
;; Signature: survey->happiness-index : S-Expression -> HappinessIndex
;; Purpose Statement: it converts a list of survey responses (S-Expression)
;; into a HappinessIndex and if it is not in the correct form it returns
;; and error
;; Tests:
(check-error (survey->happiness-index "BAD MESSAGE"))
(check-expect
 (survey->happiness-index
  (list "Fenway"
        (list (list "No" "Yes" "Yes" "No" "Yes" "No" "Yes" "Yes")
              (list "D" "S" "S" "D" "S" "D" "S" "S")
              (list 7 8 9 5 6 7 8 9))))
 (make-hi "Fenway"
          (list "No" "Yes" "Yes" "No" "Yes" "No" "Yes" "Yes")
          (list "D" "S" "S" "D" "S" "D" "S" "S")
          (list 7 8 9 5 6 7 8 9)))
(check-error
 (survey->happiness-index
  (list "Allston"
        (list "Incorrect Type"
              (list "S" "S" "D" "S" "D" "D" "S" "D")
              (list 8 7 9 6 4 5 7 6)))))
;; Code:
(define (survey->happiness-index sexpr)
  (if (well-formed-responses? sexpr)
      (make-hi (first sexpr)
               (first (second sexpr)) 
               (second (second sexpr)) 
               (third (second sexpr)))
      (error "Malformed S-Expression")))

;;! Part C

;; The server stores data for all 23 neighborhoods in Boston. When you request the
;; happiness survey data for a given year, server will respond with an S-Expression message
;; containing data for _all_ of the neighborhoods in Boston for the requested year.
;; An example is provided:

#;(list (list "Allston" ...)
        (list "Back Bay" ...)
        (list "Bay Village" ...)
        (list "Beacon Hill" ...)
        (list "Brighton" ...)
        (list "Charlestown" ...)
        (list "Chinatown" ...)
        (list "Dorchester" ...)
        (list "Downtown" ...)
        (list "East Boston" ...)
        (list "Fenway-Kenmore" ...)
        (list "Hyde Park" ...)
        (list "Jamaica Plain" ...)
        (list "Mattapan" ...)
        (list "Mission Hill" ...)
        (list "North End" ...)
        (list "Roslindale" ...)
        (list "Roxbury" ...)
        (list "South Boston" ...)
        (list "South End" ...)
        (list "West End" ...)
        (list "West Roxbury" ...)
        (list "Wharf District" ...))

;; Design a function, `parse-happiness-msg`, that accepts a message from the
;; server of the above type and returns a list of HappinessIndex structs.
;; Your function should make use of list abstractions and previous work.

;; You should only include the neighborhoods in the resulting list that you care
;; about rendering. If you have named your neighborhoods differently, you should
;; adjust your names to fit the above format.

;; Additionally, define the constant `NEIGHBORHOODS` as the list of `Neighborhood`s that
;; you care about rendering.
;; NOTE: The autograder for other problems may fail if you submit without defining `NEIGHBORHOODS`.

;;!! IMPORTANT: Write your response BELOW this line:
;; Signature: parse-happiness-msg : S-Expression -> [ListOf HappinessIndex]
;; Purpose Statement: accepts a message from the server and returns a list of HappinessIndex
;; structs
;; Tests:
(check-expect
 (parse-happiness-msg
  (list (list "Allston"
              (list (list "Yes" "Yes" "No")
                    (list "S" "S" "D")
                    (list 8 7 9)))
        (list "Back Bay"
              (list (list "No" "Yes" "Yes")
                    (list "D" "S" "S")
                    (list 6 7 8)))
        (list "Beacon Hill"
              (list (list "Yes" "No" "No")
                    (list "S" "D" "D")
                    (list 9 5 4)))
        (list "Fenway-Kenmore"
              (list (list "No" "Yes" "Yes")
                    (list "D" "S" "S")
                    (list 7 8 9)))))
 (list (make-hi "Allston"
                (list "Yes" "Yes" "No")
                (list "S" "S" "D")
                (list 8 7 9))
       (make-hi "Back Bay"
                (list "No" "Yes" "Yes")
                (list "D" "S" "S")
                (list 6 7 8))
       (make-hi "Fenway-Kenmore"
                (list "No" "Yes" "Yes")
                (list "D" "S" "S")
                (list 7 8 9))))
(check-expect
 (parse-happiness-msg
  (list (list "Beacon Hill"
              (list (list "Yes" "No" "No")
                    (list "S" "D" "D")
                    (list 9 5 4)))
        (list "South Boston"
              (list (list "No" "No" "Yes")
                    (list "D" "D" "S")
                    (list 4 3 6)))))
 '())
(check-expect (parse-happiness-msg
  (list (list "Allston"
              (list (list "Yes")
                    (list "S")
                    (list 8)))
        (list "Dorchester"
              (list (list "No")
                    (list "D")
                    (list 6)))
        (list "Fenway-Kenmore"
              (list (list "Yes")
                    (list "S")
                    (list 9)))))
              (list (make-hi "Allston"
                             (list "Yes") (list "S") (list 8))
                    (make-hi "Fenway-Kenmore" (list "Yes") (list "S") (list 9))))
;; Code:
(define NEIGHBORHOODS
  (list "Allston" "Fenway-Kenmore" "Back Bay" "Roxbury"))

(define (parse-happiness-msg msg)
  (map
   (lambda (x)
     (make-hi (first x)
              (first (second x))
              (second (second x))
              (third (second x))))
   (filter
    (lambda (x)
      (ormap (lambda (n) (string=? (first x) n)) NEIGHBORHOODS))
    msg)))

;;! Part D

;; In addition to the current year being displayed, the world state should also keep track
;; of the current happiness data for each neighborhood. Define a data definition called
;; `ClientWorld2` that includes a list of HappinessIndex structs.

;; Define a constant, `EX-CW-2`, that represents a ClientWorld2 30 years in the future with
;; some interesting happiness index data.
;; NOTE: The autograder for other problems may fail if you submit without defining `EX-CW-2`.

;; Then, define a new key-handler, `key-handler/v2`, that uses this new data definition but still
;; has the same behavior of moving the current year forward and backward.

;;!! IMPORTANT: Write your response BELOW this line:
;; A ClientWorld2 is a:
;; (make-ClientWorld2 Number [ListOf HappinessIndex]
(define-struct ClientWorld2 [year happiness-data])
;; Interpretation:
;; - year: current year
;; - happiness-data: a list of HappinessIndex structs representing the happiness data
;; for each neighborhood

(define EX-CW-2 (make-ClientWorld2 2054
   (list (make-hi "Allston"
                  (list "Yes" "No" "Yes")
                  (list "S" "D" "S")
                  (list 8 7 9))
         (make-hi "Fenway-Kenmore"
                  (list "No" "Yes" "Yes")
                  (list "D" "S" "S")
                  (list 6 8 9)))))

;; Signature: key-handler/v2 : ClientWorld2 KeyEvent -> ClientWorld2
;; Purpose Statement: adjusts the current year forward or backward dependent
;; on the key event
;; Tests:
(check-expect (key-handler/v2 EX-CW-2 "up")
              (make-ClientWorld2 2055
                        (list (make-hi "Allston"
                                       (list "Yes" "No" "Yes")
                                       (list "S" "D" "S")
                                       (list 8 7 9))
                              (make-hi "Fenway-Kenmore"
                                       (list "No" "Yes" "Yes")
                                       (list "D" "S" "S")
                                       (list 6 8 9)))))

(check-expect (key-handler/v2 EX-CW-2 "down")
              (make-ClientWorld2 2053
                        (list (make-hi "Allston"
                                       (list "Yes" "No" "Yes")
                                       (list "S" "D" "S")
                                       (list 8 7 9))
                              (make-hi "Fenway-Kenmore"
                                       (list "No" "Yes" "Yes")
                                       (list "D" "S" "S")
                                       (list 6 8 9)))))

(check-expect (key-handler/v2 EX-CW-2 "left") EX-CW-2)
;; Code:
(define (key-handler/v2 cw ke)
  (cond
    [(key=? ke "up")
     (let ([new-year (+ 1 (ClientWorld2-year cw))])
       (if (> new-year MAXYEAR)
           cw
           (make-ClientWorld2 new-year (ClientWorld2-happiness-data cw))))]
    [(key=? ke "down")
     (make-ClientWorld2 (max 2024 (- (ClientWorld2-year cw) 1))
                         (ClientWorld2-happiness-data cw))]
    [else cw]))


;;! Problem 3

;;! Part A

;; We want to convert a Neighborhood's happiness data into a percentage in
;; order to visualize and compare each Neighborhood's responses. Design a function,
;; `hi->percent`, that accepts a HappinessIndex and returns a percentage
;; based on the average of the following components:

;; 1. The percentage of respondents who have relatives or friends they
;;    can count on in trouble
;; 2. The percentage of respondents who are satisfied with their freedom
;;    to choose what they do with their lives
;; 3. The average positive affect score among respondents multiplied by 10

;;!! IMPORTANT: Write your response BELOW this line:
;; Signature: hi->percent : HappinessIndex -> Number
;; Purpose Statement: converts a HappinessIndex into a percentage which represents
;; the overall happiness score
;; Tests:
(check-within
  (hi->percent (make-hi "Allston"
                        (list "Yes" "Yes" "No")
                        (list "S" "S" "D")
                        (list 8 7 9)))
  70 71)

(define HI-ANOTHER
  (make-hi "Another Neighborhood"
           (list "Yes" "No" "No" "Yes" "Yes")
           (list "D" "S" "S" "D" "S")
           (list 5 6 7 8 9)))

(check-within (hi->percent HI-ANOTHER) 63 64)
;; Code:
(define (hi->percent hi)
  (/ (+ 
       (* 100 (/ (length (filter (lambda (x) (string=? x "Yes")) (hi-support hi)))
                 (length (hi-support hi))))
       (* 100 (/ (length (filter (lambda (x) (string=? x "S")) (hi-freedom hi)))
                 (length (hi-freedom hi))))
       (* 10 (/ (foldl + 0 (hi-affect hi)) (length (hi-affect hi)))))
     3))

;;! Part B

;; Now, write a function, `percent->color`, that accepts a percentage and returns
;; a color based on the following rules:

;; - Percentages of 30% or lower should be colored 'Red'
;; - Percentages of 70% or higher should be colored 'Green'
;; - Percentages between 30% and 70% should be evenly grouped into
;;   'Chocolate', 'Orange', 'Yellow', and 'Green Yellow' (in this order).

;;!! IMPORTANT: Write your response BELOW this line:
;; Signature: percent->color : Number -> String
;; Purpose Statement: returns a color based on a set of rules in ranges
;; of percentages
;; Tests:
(check-expect (percent->color 20) "Red")         
(check-expect (percent->color 75) "Green")        
(check-expect (percent->color 40) "Chocolate")
;; Code:
(define (percent->color percentage)
  (cond
    [(<= percentage 30) "Red"]
    [(>= percentage 70) "Green"]
    [else
     (cond
       [(<= percentage 40) "Chocolate"]
       [(<= percentage 55) "Orange"]
       [(<= percentage 65) "Yellow"]
       [else "Green Yellow"])]))

;;! Part C

;; Design a draw function, 'draw-cw2', that accepts a ClientWorld2 and draws the
;; happiness data for each neighborhood. Each Neighborhood should be colored according
;; to the percentage of happiness data for that Neighborhood.

;; Hint: You can reuse your `draw-neighborhood` implementations from previous homeworks,
;; but be sure to modify it for the given Neighborhood data definition.

;;!! IMPORTANT: Write your response BELOW this line:
(define-struct neighborhood [name happiness-percent position size])
;; Signature: draw-cw2 : ClientWorld2 -> Image
;; Purpose Statement: draws the happiness data for each neighborhood, with the coloring according
;; to the percentage
;; Tests:
(define neighborhood1 (make-neighborhood "Downtown" 20 (make-posn 50 50) 30))
(define neighborhood2 (make-neighborhood "Beacon Hill" 45 (make-posn 150 50) 30)) 
(define neighborhood3 (make-neighborhood "Back Bay" 75 (make-posn 100 100) 30)) 

(define client-world2 (list neighborhood1 neighborhood2 neighborhood3))

(check-expect
 (draw-cw2 client-world2)
 (foldr
  (lambda (neighborhood acc-image)
    (place-image
     (draw-neighborhood neighborhood)
     (posn-x (neighborhood-position neighborhood))
     (posn-y (neighborhood-position neighborhood))
     acc-image))
  (empty-scene 400 400)
  client-world2))

;; Code:
(define (draw-cw2 client-world2)
  (foldr
   (lambda (neighborhood img)
     (place-image
      (draw-neighborhood neighborhood)
      (posn-x (neighborhood-position neighborhood))
      (posn-y (neighborhood-position neighborhood))
      img))
   (empty-scene 400 400)
   client-world2))

;; Signature: draw-neighborhood : Neighborhood -> Image
;; Purpose Statement: using a neighborhood it draws an image representation
;; with color being determined by the happiness percentage and displays its name
;; Tests:
(check-expect
 (draw-neighborhood (make-neighborhood "Downtown" 20 (make-posn 50 50) 30))
 (place-image
  (overlay
   (circle 30 "solid" "Red")       
   (text "Downtown" 12 "black"))
  50
  50
  (empty-scene 400 400)))
;; Code:
(define (draw-neighborhood neighborhood)
  (place-image
   (overlay 
    (circle (neighborhood-size neighborhood) "solid"
            (percent->color (neighborhood-happiness-percent neighborhood)))
    (text (neighborhood-name neighborhood) 12 "black"))
   (posn-x (neighborhood-position neighborhood))
   (posn-y (neighborhood-position neighborhood))
   (empty-scene 400 400)))

;;! Problem 4

;; Design a function `on-receive-cw2` that parses messages (responses) fromcant  the server and
;; updates the world state accordingly. This function should take the current world state
;; and a message as input and should produce the new world state.

;; This function shouldn't _request_ server messages - your on key handler is already
;; doing that! It will only be called when a response (to one of your messages) is
;; received from the server.

;; The server will respond with an error message if data for a year not found
;; in the database is requested. In this case, the world state should not be updated.
;; The provided function can be used to check if an incoming message is an error.

;; is-error? : Any -> Boolean
;; is the incoming message from the server an error?
(define (is-error? msg)
  (and (cons? msg) (string? (first msg)) (string=? (first msg) "error")))

;;!! IMPORTANT: Write your response BELOW this line:
;; Signature: on-receive-cw2 : ClientWorld2 -> ClientWorld2
;; Purpose Statement: updates the world based on the server
;; Tests:
(check-expect (on-receive-cw2 '() '("error" "Data not found")) '())
(check-expect (on-receive-cw2 '() '("success" "Updated data")) '("Updated data"))
(check-expect (on-receive-cw2 '("Initial data") '("error" "Invalid year")) '("Initial data"))
;; Code:
(define (on-receive-cw2 world-state msg)
  (if (is-error? msg)
      world-state 
      (cons (second msg) world-state)))

;;! Problem 5

;; Time to put it all together and connect to the server! Run the following program by
;; calling `main` with an initial world state.

;; main : ClientWorld2 -> ClientWorld2
;; runs the happiness simulation beginning with the given ClientWorld
#;(define (main initial-cw2)
    (big-bang initial-cw2
      [to-draw draw-cw2]
      [on-key key-handler/v2]
      [on-receive on-receive-cw2]
      [port 64140]
      [register "mapiness.dbp.io"]))

;;!! IMPORTANT: Write your response BELOW this line:
(define (main initial-cw2)
  (big-bang initial-cw2
    [to-draw draw-cw2]
    [on-key key-handler/v2]
    [on-receive on-receive-cw2]
    [port 64140]
    [register "mapiness.dbp.io"]))
