;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname hw2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Purpose: An introduction to data design (enumerations) and the design recipe.

(require 2htdp/image)

;;! Instructions:
;;! 1. Read the contents of this file, and fill in [TODO] items that appear
;;!    below.
;;! 2. Do not create, modify or delete any line that begins with ";;!", such
;;!    as these lines. These are markers that we use to segment your file into
;;!    parts to facilitate grading.
;;! 3. You must follow the _design recipe_ for every problem. In particular,
;;!    every function you define must have at least three check-expects (and
;;!    more if needed).

;;! Problem 1

;; The weather is cooling down in Boston, but over the summer, you noticed a lot
;; of kids selling lemonade at little stands. You noticed two that were next to
;; each other that had different pricing and different materials. You were
;; curious which strategy would work better, so in this problem you will model
;; both stands.

;;! Part A

;; The first stand was getting 16 fluid ounce bottles of lemonade from a shop
;; right around the corner, for $2/each, and was selling 4 fluid ounce cups for
;; $1/each. For simplicity, we'll ignore the cost of the cups, refridgeration,
;; etc, and you can assume the corner shop never runs out of 16 fluid ounce bottles.
;;
;; Define a function "lemonade-stand-1" that takes a number of cups sold as
;; input and returns the total profit. Be sure to take into account that the 16
;; fluid ounce bottles cannot be purchased in part, so there may be extra left
;; over! Hint: the functions `remainder` or `modulo` may be useful.

;; [TODO] Function definition
;; Signature: lemonade-stand-1 : Cups -> Integer
;; Purpose Statement: The function determines the total profit that is made from the lemonade stand
;; Tests:
(check-expect (lemonade-stand-1 1) -1)
(check-expect (lemonade-stand-1 2) 0)
(check-expect (lemonade-stand-1 4) 2)
(check-expect (lemonade-stand-1 8) 4)
(check-expect (lemonade-stand-1 12) 6)
(check-expect (lemonade-stand-1 0) 0)

;; Code
(define (lemonade-stand-1 cups)
  (if (< cups 1)
      0
  (- (* cups 1) (* 2 (ceiling (/ (* (/ (* cups 4) 16) 2) 2))))))

;;! Part B

;; The second stand decided to buy the lemonade in bulk, getting a gigantic 5
;; gallon (640 fluid ounce) container for $20. To try to undercut the other
;; stand, they decided to sell their 4 fluid ounce cups for $0.75 each. But,
;; since they bought their lemonade from a store that is far from home, when
;; they run out, they will stop being able to sell lemonade.
;;
;; Define a function "lemonade-stand-2" that takes a number of cups (attempted
;; to be) sold as input and returns the total profit. Note that this input may
;; be any positive integer, so if it exceeds their capacity, the function should
;; simply return their profit before they closed the stand. Note that if they
;; sell the entirety of their lemonade, there is no penalty for being unable to
;; sell additional cups. As before, we aren't considering cost of cups,
;; refridgeration, etc.


;; [TODO] Function definition
;; Signature: lemonade-stand-2 : Cups -> Integer
;; Purpose Statement: The function determines the total profit that is made from the lemonade stand 2
(check-expect (lemonade-stand-2 10) -12.5)
(check-expect (lemonade-stand-2 25) -1.25)
(check-expect (lemonade-stand-2 50) 17.5)
(check-expect (lemonade-stand-2 103) 57.25)
(check-expect (lemonade-stand-2 170) 100)

(define (lemonade-stand-2 cups)
  (if (> cups 160)
      100
      (- (* cups 0.75) 20)))

;;! Part C

;; Now, you'd like to define a function `which-stand-better` that, given a
;; number of cups sold, returns the number 1 if lemonade stand 1 would make more
;; money at that number of cups, or 2 if lemonade stand 2 would make more money
;; with that number of cups sold. If they are tied, return 0.

;; [TODO] Function definition
;; Signature: which-stand-better : Cups -> 0,1,2
;; Purpose Statement: The function determines which lemonade stand returns a greater profit at a certain amount of cups
(check-expect (which-stand-better 1) 1)
(check-expect (which-stand-better 27) 1)
(check-expect (which-stand-better 30) 1)
(check-expect (which-stand-better 50) 1)
(check-expect (which-stand-better 80) 0)
(check-expect (which-stand-better 100) 2)

(define (which-stand-better cups)
  (cond
    ((> (lemonade-stand-1 cups) (lemonade-stand-2 cups)) 1)
    ((< (lemonade-stand-1 cups) (lemonade-stand-2 cups)) 2)
    (else 0)))
         
;;! Part D

;; Now use `which-stand-better` (and your other two functions) to investigate
;; the two strategies. Describe, in words, how the two compare. Is one strictly
;; better than the other? Does it depend on something?

;; [TODO] Prose explanation
;; The stand that is better is determined based on how many cups are sold. When there is a low quantity
;; of cups being sold stand 1 is the better choice because you have a greater control of your upfront
;; costs in the sense that you can purchase less lemonade. That being said, when a higher quantity is being
;; sold as in when 77 and more cups are being sold that is when stand 2 generates a greater profit than stand 1

;;! Problem 2

;;! Part A

;; Boston has 23 named neighborhoods, as described on this web page:
;; https://en.wikipedia.org/wiki/Neighborhoods_in_Boston
;; Please choose 5 of them and design a data definition called Neighborhood
;; that can represent any of the 5 neighborhoods that you have chosen.
;; Note: name your template neighborhood-template.

;; [TODO]
;; neighborhood-template is a neighborhood/town in Boston such as:
;; Back Bay
;; Dorchester
;; Fenway
;; Mission Hill
;; Beacon Hill
   
;; Interpretation: There are 5 different neighborhoods being looked at in Boston
;; Examples:
(define BACK-BAY 3)
(define DORCHESTER 16)
(define FENWAY 1)
(define MISSION-HILL 8)
(define BEACON-HILL 4)

;; Template:
(define (neighborhood-temp n)
  (... n ...))

;;! Part B

;; One way to classify neighborhoods is using statistical information. The city
;; collects information about residents in each neighborhood and publishes it
;; at https://data.boston.gov/dataset/neighborhood-demographics/resource/7154cc09-55c4-4acd-99a5-3a233d11e699
;; We want to focus on the 2000 data set. Note that the neighborhood list has slightly
;; changed since then, so if any of your five chosen neighborhoods don't appear in this list,
;; or appear under different names, please update your data definition to include only
;; neighborhoods from this list.

;; Design a predicate, `family-friendly?`, that returns #t if
;; the percentage of people under 9 years old is above 10% -- as those are the
;; neighborhoods with lots of families with small kids.

;; Signature: family-friendly? : n -> boolean
;; Purpose Statement: The function returns whether or not a neighborhood is considered family friendly depending on the percentage of people under 9 years of age.
(check-expect (family-friendly? BACK-BAY) #f)
(check-expect (family-friendly? DORCHESTER) #t)
(check-expect (family-friendly? FENWAY) #f)
(check-expect (family-friendly? MISSION-HILL) #f)
(check-expect (family-friendly? BEACON-HILL) #f)

(define (family-friendly? n)
  (if (< n 10)
      #f
      #t))

;;! Part C
;;
;; INTERPRETIVE QUESTION:
;;
;; While this predicate captures neighborhoods that have _many_ children, mere
;; numbers do not necessarily convey how "friendly" a neighborhood is to
;; families. Write 2-3 sentences about factors that, as the City, you might want
;; to include if you were to publish a list of "family friendly neighborhoods"
;; beyond just the percentage used above.

;; [TODO]
;; Factors that you would want to include in determining if a city is safe would be some sort of crime rate scale.
;; This could be some kind of ratio that compares the amount of crime that occurs in X amount of area. Another factor
;; that should be included is the number of police officers that are present per X amount of people. In addition to this,
;; another factor could include air and water quality conditons in that area to provide information on enviornmental conditions.

;;! Part D

;; How should you draw a Neighborhood? Design a function `draw-neighborhood` that takes
;; a Neighborhood and returns an Image representation of it. As is often the case, we need
;; to understand how the result may be used before we can figure out how to design this.
;; Does it need to be geographically accurate? If it will be used for mapping, and we were
;; planning on adding streets, etc, then clearly yes! But if we were planning, instead, to use
;; the result for data visualization, simple abstractions might be okay. Another question
;; you should ask: should the sizes be correct relative to one another? Some neighborhoods are
;; much bigger than others: does the image need to convey this scale accurately? Perhaps the
;; size of a neighborhood will be something that the user should be able to control, as
;; certain visualizations may display neighborhoods scaled to convey information.
;;
;; We would like you to make some decisions, reflected in your purpose
;; statements. Define a purpose and use case for 'draw-neighborhood'.
;; Each decision you make should be justified with a reason why that relates
;; to the purpose of the function. You are welcome to use simplified drawings, but justify why.

;; [TODO]
;; Signature: draw-neighborhood : Neighborhood -> Image
;; Purpose Statement: The function takes in a string input of a neighborhood name and returns an image
;; depiction of that neighborhood.
;; Check Expects:
;; Not sure if these are right
;; (check-expect (draw-neighborhood "Back-Bay") "Back-Bay"))
;; (check-expect (draw-neighborhood "Dorchester") "Dorchester"))
;; (check-expect (draw-neighborhood "Fenway") "Fenway"))

(define MAP-WIDTH 250)
(define MAP-HEIGHT 250)

(define HOUSE (triangle 40 "solid" "yellow"))
(define ROAD (rectangle 315 40 "solid" "black"))
(define ROADMARKING (rectangle 30 10 "solid" "white"))
(define MAPBKG (rectangle MAP-WIDTH MAP-HEIGHT "solid" "light green"))
(define STORE1 (circle 25 "solid" "light cyan"))
(define STORE2 (circle 25 "solid" "light gray"))
(define x-ROAD 100)

(define BACK-BAY-BKG (rectangle MAP-WIDTH MAP-HEIGHT "solid" "light green"))
(define DORCHESTER-BKG (rectangle MAP-WIDTH MAP-HEIGHT "solid" "light blue"))
(define FENWAY-BKG (rectangle MAP-WIDTH MAP-HEIGHT "solid" "light pink"))

(define (draw-neighborhood Neighborhood)
  (cond
    [(string=? Neighborhood "Back-Bay")
(place-image ROADMARKING
             (- (/ MAP-WIDTH 3) 42)
             (+ (/ MAP-HEIGHT 4) 87)
             (place-image ROADMARKING
             (- (/ MAP-WIDTH 3) -12)
             (+ (/ MAP-HEIGHT 4) 87)
             (place-image ROADMARKING
             (- (/ MAP-WIDTH 3) -65)
             (+ (/ MAP-HEIGHT 4) 87)
               (place-image ROADMARKING
             (- (/ MAP-WIDTH 3) -115)
             (+ (/ MAP-HEIGHT 4) 87)
             (place-image
              ROAD
              x-ROAD
              150
              (place-image HOUSE
                (- (/ MAP-WIDTH 2) 100)
                (- (/ MAP-HEIGHT 1.5) 65)
                (place-image HOUSE
                             (- (/ MAP-WIDTH 2) 50)
                             (- (/ MAP-HEIGHT 1.5) 65)
                             (place-image STORE1
                                          (- (/ MAP-WIDTH 3) 50)
                                          (+ (/ MAP-HEIGHT 3) 120)
                                          (place-image STORE2
                                                       (- (/ MAP-WIDTH 3) -10)
                                                       (+ (/ MAP-HEIGHT 3) 120)        
                                          BACK-BAY-BKG)))))))))]
    [(string=? Neighborhood "Dorchester")
  (place-image ROADMARKING
             (- (/ MAP-WIDTH 3) 42)
             (+ (/ MAP-HEIGHT 4) 87)
             (place-image ROADMARKING
             (- (/ MAP-WIDTH 3) -12)
             (+ (/ MAP-HEIGHT 4) 87)
             (place-image ROADMARKING
             (- (/ MAP-WIDTH 3) -65)
             (+ (/ MAP-HEIGHT 4) 87)
               (place-image ROADMARKING
             (- (/ MAP-WIDTH 3) -115)
             (+ (/ MAP-HEIGHT 4) 87)
             (place-image
              ROAD
              x-ROAD
              150
              (place-image HOUSE
                (- (/ MAP-WIDTH 2) 0)
                (- (/ MAP-HEIGHT 1.5) 65)
                (place-image HOUSE
                             (- (/ MAP-WIDTH 2) 50)
                             (- (/ MAP-HEIGHT 1.5) 65)
                             (place-image HOUSE
                                          (- (/ MAP-WIDTH 2) 100)
                                          (- (/ MAP-HEIGHT 1.5) 65)
                                          (place-image STORE1
                                                       (- (/ MAP-WIDTH 3) 50)
                                                       (+ (/ MAP-HEIGHT 3) 120)
                                                       (place-image STORE1
                                                                    (+ (/ MAP-WIDTH 3) 75)
                                                                    (+ (/ MAP-HEIGHT 3) 120)
                                                                    (place-image STORE2
                                                                                 (- (/ MAP-WIDTH 3) -10)
                                                                                 (+ (/ MAP-HEIGHT 3) 120)        
                                                                    DORCHESTER-BKG)))))))))))]
[(string=? Neighborhood "Fenway")
  (place-image ROADMARKING
             (- (/ MAP-WIDTH 3) 42)
             (+ (/ MAP-HEIGHT 4) 87)
             (place-image ROADMARKING
             (- (/ MAP-WIDTH 3) -12)
             (+ (/ MAP-HEIGHT 4) 87)
             (place-image ROADMARKING
             (- (/ MAP-WIDTH 3) -65)
             (+ (/ MAP-HEIGHT 4) 87)
               (place-image ROADMARKING
             (- (/ MAP-WIDTH 3) -115)
             (+ (/ MAP-HEIGHT 4) 87)
             (place-image
              ROAD
              x-ROAD
              150
              (place-image HOUSE
                (- (/ MAP-WIDTH 2) 0)
                (- (/ MAP-HEIGHT 1.5) 65)
                (place-image HOUSE
                             (- (/ MAP-WIDTH 2) 50)
                             (- (/ MAP-HEIGHT 1.5) 65)
                              (place-image HOUSE
                                           (- (/ MAP-WIDTH 2) 100)
                                           (- (/ MAP-HEIGHT 1.5) 65)
                                            (place-image HOUSE
                                                         (+ (/ MAP-WIDTH 2) 50)
                                                         (- (/ MAP-HEIGHT 1.5) 65)
                                                         (place-image HOUSE
                                                                      (+ (/ MAP-WIDTH 2) 50)
                                                                      (- (/ MAP-HEIGHT 1.5) 140)
                                                                      (place-image HOUSE
                                                                                   (- (/ MAP-WIDTH 2) 0)
                                                                                   (- (/ MAP-HEIGHT 1.5) 140)
                                                                                   (place-image STORE1
                                                                                                (- (/ MAP-WIDTH 3) 50)
                                                                                                (+ (/ MAP-HEIGHT 3) 120)
                                                                                                (place-image STORE2
                                                                                                             (- (/ MAP-WIDTH 3) -10)
                                                                                                             (+ (/ MAP-HEIGHT 3) 120)
                                                                                                             (place-image STORE1
                                                                                                                          (+ (/ MAP-WIDTH 3) 70)
                                                                                                                          (+ (/ MAP-HEIGHT 3) 120)
                                                                                                                          (place-image STORE2
                                                                                                                                       (+ (/ MAP-WIDTH 3) 130)
                                                                                                                                       (+ (/ MAP-HEIGHT 3) 120)
                                          FENWAY-BKG)))))))))))))))]
    ))

;;! Part E

;; Now we can draw single neighborhoods, but individually, these images don't tell us much. Design
;; a function `draw-three-neighborhoods` that takes three neighborhoods and returns an image
;; of all three in relation to one another. Use color to distinguish the three neighborhoods.
;; Consider how it would be helpful to use or revise previous functions.

;; [TODO]
;; Signature: draw-three-neighborhoods : n1 n2 n3 -> Image
;; Purpose Statement: The function returns a combination of three neighborhoods with different color backgrounds that are merged together
;; Check Expects:
;; Not sure if this is right
;; (check-expect (draw-three-neighborhoods ("Fenway" "Dorchester" "Back-Bay") "Fenway" "Dorchester" "Back-Bay"))
;; (check-expect (draw-three-neighborhoods ("Dorchester" "Fenway" "Back-Bay") "Dorchester" "Fenway" "Back-Bay"))
;; (check-expect (draw-three-neighborhoods ("Back-Bay" "Dorchester" "Fenway") "Back-Bay" "Dorchester" "Fenway"))

(define (draw-three-neighborhoods n1 n2 n3)
  (beside (draw-neighborhood n1)
          (draw-neighborhood n2)
          (draw-neighborhood n3)))