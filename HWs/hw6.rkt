;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname hw6) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/image)
(require 2htdp/universe)

;; Instructions
;; 1. Do not create, modify or delete any line that begins with ";;!". These are
;;    markers that we use to segment your file into parts to facilitate grading.
;; 2. You must follow the _design recipe_ for every problem. In particular,
;;    every function you define must have at least three check-expects (and
;;    more if needed).
;; 3. You must follow the Style Guide:
;;    https://pages.github.khoury.northeastern.edu/2500/2023F/style.html
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

;; Consider the three functions below (we have deliberately omitted tests and purpose
;; statements):

;; flip: [List-of Boolean] -> [List-of Boolean]
(define (flip lob)
  (cond
    [(empty? lob) '()]
    [(cons? lob) (cons (not (first lob)) (flip (rest lob)))]))

;; until-zero: [List-of Number] -> [List-of Number]
(define (until-zero lon)
  (cond
    [(empty? lon) '()]
    [(cons? lon) (if (= (first lon) 0) '() (cons (first lon) (until-zero (rest lon))))]))

;; words-until-period: [List-of String] -> [List-of String]
(define (words-until-period los)
  (cond
    [(empty? los) '()]
    [(cons? los)
     (if (string=? (first los) ".") '() (cons (first los) (words-until-period (rest los))))]))

;;! Part A

;; It is possible to design a list abstraction that can be used to simplify two
;; of the three functions defined above. Define that list abstraction. NOTE: you
;; do not need to include a signature, or tests for this. While a purpose isn't
;; required, thinking about it may be helpful.

;;!! IMPORTANT: Write your response BELOW this line:
;;;
(define (go-until p los)
  (cond
    [(empty? los) '()] 
    [(cons? los) 
    [if (p (first los)) '() (cons (first los) (go-until p (rest los)))]]))

;;! Part B

;; Use the list abstraction you designed in Part A to rewrite the functions
;; above that you can. Do not modify the code above. Instead, write your
;; functions here and call them flip/v2, until-zero/v2, or
;; words-until-period/v2. Follow the full design recipe.

;;!! IMPORTANT: Write your response BELOW this line:
;; Signature: is-it-zero? : number -> boolean
;; Purpose Statement: helper function to determine if a number is 0
;; Tests:
(check-expect (is-it-zero? 0) #t)
(check-expect (is-it-zero? 1) #f)
(check-expect (is-it-zero? 3) #f)
;; Code:
(define (is-it-zero? x)
  (= x 0))

;; Signature: until-zero/v2 : ListofNumbers -> ListofNumbers
;; Purpose Statement: the function looks through a list and adds items to a list until it hits 0 and then stops
;; Tests:
(check-expect (until-zero/v2 '(1 2 3 4 0 5)) '(1 2 3 4))
(check-expect (until-zero/v2 '(1 0 3 4 0 5)) '(1))
(check-expect (until-zero/v2 '(1 4 1 47 0 6)) '(1 4 1 47))
;; Code:
(define (until-zero/v2 l)
  (go-until is-it-zero? l))

;; Signature: is-it-period? : string -> boolean
;; Purpose Statement: helper function to determine if a string has a "."
;; Tests:
(check-expect (is-it-period? "test") #f)
(check-expect (is-it-period? ".") #t)
(check-expect (is-it-period? "...") #f)
;; Code:
(define (is-it-period? d)
  (string=? d "."))

;; Signature: words-until-period/v2 : ListofStrings -> ListofStrings
;; Purpose Statement: the function looks at a list of strings and adds items to a list and it stops when it hits a period
;; Tests:
(check-expect (words-until-period/v2 '("This " "is " "a" "." "test")) '("This " "is " "a"))
(check-expect (words-until-period/v2 '("This " "is " "." "." "test")) '("This " "is "))
(check-expect (words-until-period/v2 '("." "is " "." "." "test")) '())
;; Code:
(define (words-until-period/v2 l)
  (go-until is-it-period? l))

;;! Problem 2

;; In HW4, you designed a data definition that combined a Neighborhood with a
;; count of people who used public transit in that neighborhood. In this
;; problem, we are going to use a very similar data definition: this time add
;; the total number of commuters of your neighborhood, not just the number who
;; commute via public transit. We'll use this to build a simulation that can
;; infer future information about a neighborhood based on its known data.

;;! Part A

;; Please copy your data definition from HW4, adjusting it if necessary based on
;; feedback you received, and adding a field for the total _number_ of
;; commuters. Adjust examples appropriately, looking up accurate numbers for
;; your chosen neighborhoods.
;;
;; Name (or rename) your data definition NeighborhoodCommuters

;;!! IMPORTANT: Write your response BELOW this line:
;; neighborhood-template is a neighborhood/town in Boston such as:
;; Back Bay
;; Dorchester
;; Fenway
;; Mattapan
;; North End
   
;; Interpretation: There are 5 different neighborhoods being looked at in Boston
(define-struct NeighborhoodCommuters [neighborhood commuters total-commuters])
;; neighborhood - string that represents the neighborhood name
;; commuters - number that represents the number of public transit commuters in that neighborhood
;; total-commuters - number that represents the total number of commuters in that neighborhood
;; Examples:
(define BACK-BAY (make-NeighborhoodCommuters "Back Bay" 2600 3000))
(define DORCHESTER (make-NeighborhoodCommuters "Dorchester" 22294 33976))
(define FENWAY (make-NeighborhoodCommuters "Fenway" 4050 5931))
(define MATTAPAN (make-NeighborhoodCommuters "Mattapan" 3755 7483))
(define NORTH-END (make-NeighborhoodCommuters "North End" 1793 8421))

;; Template:
(define (NeighborhoodCommuters-temp n)
  (cond
    [... (NeighborhoodCommuters-neighborhood n)]
    [... (NeighborhoodCommuters-commuters n)]
    [... (NeighborhoodCommuters-total-commuters n)]))

;;! Part B

;; Define a constant named _exactly_ `MY-NC-EXAMPLE` that has an example of your
;; data definition. You should have more than one example above; this one can
;; just be defined as a synonym of one of the above.

;;!! IMPORTANT: Write your response BELOW this line:
(define MY-NC-EXAMPLE BACK-BAY)

;;! Part C

;; We now want to represent multiple neighborhoods. Define a data definition for
;; a collection of NeighborhoodCommuters called BostonCommuters. Note: use a
;; list!

;;!! IMPORTANT: Write your response BELOW this line:
;; BostonCommuters - list of NeighborhoodCommuters
;; Interpretation: A list that represents data for multiple neighborhoods
;; Examples:
(define BostonCommuters
  (list BACK-BAY
        DORCHESTER
        FENWAY
        MATTAPAN
        NORTH-END))
;; Template:
(define (boston-commuters-temp commuters)
  (cond
    [(empty? commuters) ...]
    [else
     (... (NeighborhoodCommuters-neighborhood (first commuters))
          (NeighborhoodCommuters-commuters (first commuters))
          (NeighborhoodCommuters-total-commuters (first commuters))
          (boston-commuters-temp (rest commuters)))]))
           
;;! Part D

;; Define a constant named _exactly_ `MY-BC-EXAMPLE` that has an example of your
;; data definition. You should have more than one example above; this one can
;; just be defined as a synonym of the above.

;;!! IMPORTANT: Write your response BELOW this line:
(define MY-BC-EXAMPLE BostonCommuters)

;;! Part E

;; We want to use the known information about commuters who take public transportation
;; in a neighborhood to derive the aggregate CO2 emissions at 10, 25, and 40 years
;; into the future.

;; Design a function `simulate-emissions` that takes a NeighborhoodCommuters and
;; a number (representing years into the future) and returns the total amount of CO2
;; emissions after the specified number of years _caused by commuting_. You are
;; welcome to use the following simplified notes / assumptions:
;;
;; - You can consider all people who do not commute via public transit to
;;   commute via car. If one of your neighborhoods is Longwood, perhaps choose a
;;   different one!
;;
;; - A report from a few years ago stated the average commute time _by car_
;;   in the Boston area was 40 mins, and another report we found said the average
;;   distance of such commutes was 20 miles.
;;
;; - The average car emmits 400g of CO2 per mile driven. Feel free to ignore the
;;   (likely) improvement of this average over time, due to electrification.
;;
;; - You can ignore change in population over time for your simulation. Just assume
;;   the value you calculate for the first year is the same for the subsequent ones.
;;
;; - You can assume commuters go to work every day!

;;!! IMPORTANT: Write your response BELOW this line:
;; Signature: simulate-emissions : NeighborhoodCommuters Number -> Number
;; Purpose Statement: the function determines the amount of emissions that are predicted to be caused after x amount of years
;; Tests:
(check-expect (simulate-emissions BACK-BAY 10) 23360000000)
(check-expect (simulate-emissions DORCHESTER 25) 1705572000000)
(check-expect (simulate-emissions MATTAPAN 45) 979718400000)
(check-expect (simulate-emissions FENWAY 30) 329551200000)
;; Code:             
(define (simulate-emissions NeighborhoodCommuters years)
  (* (- (NeighborhoodCommuters-total-commuters NeighborhoodCommuters)
        (NeighborhoodCommuters-commuters NeighborhoodCommuters))
        20 2 400 365 years))

;;! Part F

;; INTERPRETIVE QUESTION
;;
;; Imagine we're members of the Environmental Justice, Resiliency, and Parks committee
;; (https://www.boston.gov/departments/city-council/environmental-justice-resiliency-and-parks)
;; in Boston's city council. We want to fund the electrification of buses to
;; communities who are most harmed by air pollution from gas buses. We need to
;; find where pollutants are distributed.
;;
;; Our data currently tracks what percentage of neighborhood commuters take
;; public transportation (for this question, let's assume they're all taking
;; gas-powered buses).
;;
;; In 2-3 sentences, explain why our data does not track where air pollutants
;; from buses are distributed. What sort of information would we need to
;; estimate where gas buses spread air pollutants?

;;!! IMPORTANT: Write your response BELOW this line:
;; The problem with the data that we are collecting and calculating is that it only tracks
;; the number of public transit commuters in a neighborhood but it doesn't tell you where the buses
;; go for their routes or where the pollutants are being released to. In order to calculate this, you would need
;; to use data which includes the bus routes, how long they spend in these neighborhoods, etc. 

;;! Part G

;; Now, design a new draw function, `draw-boston-emissions`, that takes
;; a BostonCommuters, a scale (0-1), and a number of years into the future and
;; draws all of the neighborhoods colored-coded by the amount of CO2 emissions
;; at that time caused by commuting.

;; Hint: You will need to design a helper function that associates a color with the amount of
;; CO2 emissions in a specific neighborhood, and should re-use past drawing functions you've implemented.

;;!! IMPORTANT: Write your response BELOW this line:

;; Signature: map-color-helper : NeighborhoodCommuters-commuters -> String
;; Purpose Statement: the function determines the color that should be used to represent the amount of pollution
;; for the image based on the amount of commuters. Green represents less than 20000000000 of CO2
;; yellow represents a range of, and including, 20000000000 through 30000000000. Red includes eveything else, in this case
;; greater than 30000000001
;; Tests:
(check-expect (map-color-helper (NeighborhoodCommuters-commuters BACK-BAY)) "green")
(check-expect (map-color-helper (NeighborhoodCommuters-commuters DORCHESTER)) "green")
(check-expect (map-color-helper (NeighborhoodCommuters-commuters NORTH-END)) "green")
;; Code:
(define (map-color-helper CO2)
  (cond [(< CO2 20000000000) "green"]
        [(and (>= CO2 20000000000) (<= CO2 30000000000)) "yellow"]
        [else "red"]))

;; Signature: draw-neighborhood : neighborhood-data number number -> Image
;; Purpose Statement: This function calls the helper function in order to determine the color
;; and draws a representation of the neighborhood commuters based on the years and scale that is inputted. 
;; Tests:
(check-expect (draw-neighborhood BACK-BAY 4 0.5)
              (place-image
               (rectangle (* 250 0.5) (* 250 0.5) "solid"
                          (map-color-helper (simulate-emissions BACK-BAY 4)))
               (/ 250 2)
               (/ 250 2)
               (empty-scene 250 250)))

(check-expect (draw-neighborhood DORCHESTER 3 0.2)
              (place-image
               (rectangle (* 250 0.2) (* 250 0.2) "solid"
                          (map-color-helper (simulate-emissions DORCHESTER 3)))
               (/ 250 2)
               (/ 250 2)
               (empty-scene 250 250)))
(check-expect (draw-neighborhood FENWAY 20 0.7)
              (place-image
               (rectangle (* 250 0.7) (* 250 0.7) "solid"
                          (map-color-helper (simulate-emissions FENWAY 20)))
               (/ 250 2)
               (/ 250 2)
               (empty-scene 250 250)))
;; Code:
(define (draw-neighborhood neighborhood-data years scale)
  (place-image
   (rectangle (* 250 scale) (* 250 scale) "solid"
              (map-color-helper (simulate-emissions neighborhood-data years)))
   (/ 250 2)
   (/ 250 2)
   (empty-scene 250 250)))

;; Signature: draw-boston-emissions : BostonCommuters number number -> Image
;; Purpose Statement: the function uses BostonCommuters list and draws all of the neighborhoods
;; based on the amount of pollution that is released, shown by the color. 
;; Tests:
(check-expect (draw-boston-emissions BostonCommuters 2 0.5)
 (beside 
   (draw-neighborhood BACK-BAY 2 0.5)
   (beside
     (draw-neighborhood DORCHESTER 2 0.5)
     (beside
       (draw-neighborhood FENWAY 2 0.5)
       (beside
         (draw-neighborhood MATTAPAN 2 0.5)
         (draw-neighborhood NORTH-END 2 0.5))))))
(check-expect (draw-boston-emissions BostonCommuters 1 0.2)
 (beside 
   (draw-neighborhood BACK-BAY 1 0.2)
   (beside
     (draw-neighborhood DORCHESTER 1 0.2)
     (beside
       (draw-neighborhood FENWAY 1 0.2)
       (beside
         (draw-neighborhood MATTAPAN 1 0.2)
         (draw-neighborhood NORTH-END 1 0.2))))))
(check-expect (draw-boston-emissions BostonCommuters 4 0.1)
 (beside 
   (draw-neighborhood BACK-BAY 4 0.1)
   (beside
     (draw-neighborhood DORCHESTER 4 0.1)
     (beside
       (draw-neighborhood FENWAY 4 0.1)
       (beside
         (draw-neighborhood MATTAPAN 4 0.1)
         (draw-neighborhood NORTH-END 4 0.1))))))
;; Code:
(define (draw-boston-emissions boston-commuters years scale)
  (cond
    [(empty? boston-commuters) (empty-scene 0 0)]
    [else
     (beside (draw-neighborhood (first boston-commuters) years scale)
             (draw-boston-emissions (rest boston-commuters) years scale))]))

;;! Part H

;; INTERPRETIVE QUESTION

;; Our estimate of commuters' CO2 emissions is based on public transportation
;; data. However, public transportation commuters on average produce less than
;; half as much CO2 compared to other commuters.
;; (https://www.transit.dot.gov/sites/fta.dot.gov/files/docs/PublicTransportationsRoleInRespondingToClimateChange2010.pdf)
;;
;; In 2-3 sentences, identify which commuters we're leaving out of our
;; calculation. If we were to rank neighborhoods by total carbon emissions, how
;; might our calculation give an incomplete picture?

;;!! IMPORTANT: Write your response BELOW this line:
;; We are leaving out the commuters that travel by car, motorcycle, or any other kind of CO2 emitting vehicle.
;; Our calculation is giving out an incomplete picture because of the fact that it only includes public transportation.
;; The problem with this is that some neighborhoods might have better public transit system in place which can help reduce
;; the emissions in that neighborhood. On top of this, the neighborhoods that have weaker system would most likely have a higher
;; reliance on other modes of transportation, such as driving, which could cause a spike in CO2 emissions in that area. 

;;! Part I

;; Finally, let's visualize these changes over time. Design a function
;; `visualize-boston-emissions` that takes a single argument--a number of years in the
;; future--and draws a collection of neighborhoods of your choice, colored according to
;; the amount of emissions.
;;
;; NOTE: in the Interactions window, you can use `animate` from 2htdp/universe
;; to run this function, but do not put it in the file as it may cause the
;; autograder not to run.

;;!! IMPORTANT: Write your response BELOW this line:
;; Signature: visualize-boston-emissions : number -> image
;; Purpose Statement: the function takes a number of years and then draws the neighborhoods from
;; BostonCommuters with the representation of emissions based on the years
;; Tests:
(check-expect (visualize-boston-emissions 10)
              (draw-boston-emissions BostonCommuters 10 1))
(check-expect (visualize-boston-emissions 20) 
              (draw-boston-emissions BostonCommuters 20 1))
(check-expect (visualize-boston-emissions 50)
              (draw-boston-emissions BostonCommuters 50 1))
;; Code:
(define (visualize-boston-emissions years)
  (draw-boston-emissions BostonCommuters years 1))
  
