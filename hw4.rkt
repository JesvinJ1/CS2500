;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname hw4) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Purpose: Design recipe practice, now with unions and self-referential data definitions.

(require 2htdp/image)
(require 2htdp/universe)

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

;;! Problem 1

;; Consider the following structure definitions:
(define-struct blender [brand wattage crushes-ice?])
(define-struct microwave [brand wattage])
(define-struct kettle [brand wattage capacity])

;;! Part A

;; Complete three data designs for each structure called Blender, Microwave,
;; and Kettle.

;;!! IMPORTANT: Write your response BELOW this line:

;; Blender:
;; A Blender is representing a blender model with specific specifications including whether or not it can crush ice
;; It contains three values: brand, wattage, crushes-ice?
;; - brand : the brand of the blender
;; - wattage : the amount of watts it uses
;; - crushes-ice? : if it it capable of crushing ice or not
;; Interpretation: a blender is reprsenting various different values in terms of brand,
;; the amount of watts it outputs and whether or not if it can crush ice
;; Examples:
(define BLENDER1 (make-blender "Ninja" 250 #true))
(define BLENDER2 (make-blender "Vitamix" 500 #true))
(define BLENDER3 (make-blender "NutriBullet" 125 #false))
;; Template:
(define (blender-temp b)
  (cond
    [... (blender-brand b)]
    [... (blender-wattage b)]
    [... (blender-crushes-ice? b)]))

;; Microwave:
;; A Microwave is a microwave that heats up food and has a certain amount of wattage and a brand name
;; It contains two values: brand & wattage
;; - brand : the brand of the microwave
;; - wattage: the amount of watts it uses
;; Interpretation: a microwave is representing the amount of watts it uses and the name of the brand
;; Examples:
(define MICROWAVE1 (make-microwave "GE" 1250))
(define MICROWAVE2 (make-microwave "LG" 1000))
(define MICROWAVE3 (make-microwave "Samsung" 1500))
;; Template:
(define (microwave-temp m)
  (cond
    [... (microwave-brand m)]
    [... (microwave-wattage m)]))  

;; Kettle:
;; A Kettle is a product that heats up water and has a brand name, wattage, and total liquid capacity
;; It contains three values: brand, wattage, capacity
;; - brand : the name of the company
;; - wattage : the amount of watts it uses
;; - capacity : the amount of water it can hold
;; Interpretation: a kettle heats up water and it represents a brand name,
;; the amount of watts it produces, and the capacity of water it can hold.
;; Examples:
(define KETTLE1 (make-kettle "BRAND1" 250 10))
(define KETTLE2 (make-kettle "BRAND2" 350 12))
(define KETTLE3 (make-kettle "BRAND3" 450 18))
;; Template
(define (kettle-temp k)
  (cond
   [... (kettle-brand k)]
   [... (kettle-wattage k)]
   [...(kettle-capacity k)]))
                 
;;! Part B

;; Complete a data design called Appliance, which can represent any appliance
;; listed above.

;;!! IMPORTANT: Write your response BELOW this line:
;; An Appliance is representing one of the three appliances that were listed before
;; - kettle
;; - microwave
;; - blender
;; Interpretation: a kettle heats up water, a microwave heats up food, and a blender blends into a liquid
;; Examples:
(define APPLIANCE1 (make-blender "Ninja" 250 #true))
(define APPLIANCE2 (make-microwave "LG" 1000))
(define APPLIANCE3 (make-kettle "BRAND3" 2550 18))
(define APPLIANCE4 (make-microwave "GE" 2250))
(define APPLIANCE5 (make-microwave "Samsung" 1250))
(define APPLIANCE6 (make-blender "Beast" 1250 #true))
(define APPLIANCE7 (make-blender "Beast2.0" 1000 #true))
;; Template:
(define (appliance-temp a)
  (cond
    [(blender? a) (... (blender-temp a))]
    [(microwave? a) (... (microwave-temp a))]
    [(kettle? a) (... (kettle-temp a))]))

;;! Part C

;; Design a function called `power-up-appliance` that takes an Appliance and produces another Appliance
;; that is identical, except that if it is a Microwave, its wattage is increased by 50 watts.

;; Note: for full credit, a helper is required in this problem.

;;!! IMPORTANT: Write your response BELOW this line:
;; Signature: microwave-helper : Appliance -> Appliance
;; Purpose Statement: it's a helper function that increases the wattage by 50 for microwaves
;; Tests:
(check-expect (microwave-helper APPLIANCE2) (make-microwave (microwave-brand APPLIANCE2) (+ (microwave-wattage APPLIANCE2) 50)))
(check-expect (microwave-helper APPLIANCE4) (make-microwave (microwave-brand APPLIANCE4) (+ (microwave-wattage APPLIANCE4) 50)))
(check-expect (microwave-helper APPLIANCE5) (make-microwave (microwave-brand APPLIANCE5) (+ (microwave-wattage APPLIANCE5) 50)))
;; Code:
(define (microwave-helper m)
  (make-microwave (microwave-brand m)
                  (+ (microwave-wattage m) 50)))

;; Signature: power-up-appliance : Appliance -> Appliance
;; Purpose Statement: it takes in an appliance and creates another appliance that is the same, but
;; if its a microwave it increases the wattage by 50 watts
;; Tests:
(check-expect (power-up-appliance APPLIANCE1) APPLIANCE1)
(check-expect (power-up-appliance APPLIANCE2) (make-microwave (microwave-brand APPLIANCE2) (+ (microwave-wattage APPLIANCE2) 50)))
(check-expect (power-up-appliance APPLIANCE3) APPLIANCE3)
;; Code:
(define (power-up-appliance a)
  (cond
    [(microwave? a) (microwave-helper a)]
    [else a]))

;;! Part D

;; Design a function `is-high-power??` that takes an Appliance and returns #true
;; if it is "high power". A high-power blender is at least 1000 watts, whereas
;; any other appliance must be at least 2000 watts.
;;
;; Note: you _need_ to write helper functions in order to solve this problem for
;; full credit.

;;!! IMPORTANT: Write your response BELOW this line:

;; Signature: blender-high-power? : Appliance -> boolean
;; Purpose Statement: the helper function determines whether or not the blender is a high wattage
;; Tests:
(check-expect (blender-high-power? APPLIANCE1) #false)
(check-expect (blender-high-power? APPLIANCE6) #true)
(check-expect (blender-high-power? APPLIANCE7) #true) 
;; Code:
(define (blender-high-power? b)
      (>= (blender-wattage b) 1000))

;; Signature: appliance-wattage : Appliance -> boolean
;; Purpose Statement: the helper function determines whether or not an appliance is considered high wattage
;; Tests:
(check-expect (appliance-wattage APPLIANCE2) #false)
(check-expect (appliance-wattage APPLIANCE3) #true)
(check-expect (appliance-wattage APPLIANCE5) #false)
;; Code:
(define (appliance-wattage a)
  (>= (cond
        [(microwave? a) (microwave-wattage a)]
        [(kettle? a) (kettle-wattage a)])
      2000))
                        
;; Signature: is-high-power? : Appliance -> boolean
;; Purpose Statement: the function takes into account all 3 appliances and returns whether its a high wattage
;; Tests:
(check-expect (is-high-power? APPLIANCE1) #false)
(check-expect (is-high-power? APPLIANCE2) #false)
(check-expect (is-high-power? APPLIANCE3) #true)
(check-expect (is-high-power? APPLIANCE4) #true)
(check-expect (is-high-power? APPLIANCE5) #false)
(check-expect (is-high-power? APPLIANCE6) #true)
(check-expect (is-high-power? APPLIANCE7) #true)
;; Code:
(define (is-high-power? h)
  (cond
    [(microwave? h) (appliance-wattage h)]
    [(kettle? h) (appliance-wattage h)]
    [(blender? h) (blender-high-power? h)]))

;;! Problem 2

;;! Part A

;; Last week, you designed data to represent a neighborhood in Boston. But this
;; definition didn't include any interesting information about the neighborhoods
;; besides its name. We want to design a data definition that associates some
;; additional information, in this case, the number of commuters that take
;; public transit:
;;
;; https://bpda-research.shinyapps.io/neighborhood-change/
;; (navigate to the Neighborhoods tab and select Commute Mode from the
;; dropdown).
;;

;; Design a data definition that combines a Neighborhood with a number of
;; commuters who take public transit. Please use the same five neighborhoods as
;; you used in HW2. Make sure to copy (and fix, if necessary) your Neighborhood
;; data design from HW2.

;;!! IMPORTANT: Write your response BELOW this line:
;; neighborhood-template is a neighborhood/town in Boston such as:
;; Back Bay
;; Dorchester
;; Fenway
;; Mattapan
;; North End
   
;; Interpretation: There are 5 different neighborhoods being looked at in Boston
(define-struct neighborhood-commuters [neighborhood commuters])
;; Examples:
(define back-bay-commuters (make-neighborhood-commuters "Back Bay" 2503))
(define dorchester-commuters (make-neighborhood-commuters "Dorchester" 22294))
(define fenway-commuters (make-neighborhood-commuters "Fenway" 4050))
(define mattapan-commuters (make-neighborhood-commuters "Mattapan" 3755))
(define north-end-commuters (make-neighborhood-commuters "North End" 1793))

;; Template:
(define (neighborhood-commuters-temp n)
  (cond
    [... (neighborhood-commuters-neighborhood n)]
    [... (neighborhood-commuters-commuters n)]))

;;! Part B

;; INTERPRETIVE QUESTION: The way we store information can make it more or less
;; useful for future purposes. While part A asked you to record a "number" of
;; commuters, there are two different common numeric representations:
;; percentages and raw counts. Imagine the city is trying to decide where to
;; allocate a grant to support public transit. They want to pilot it in a
;; place where they know lots of people use public transit, based
;; on the 2020 data.

;; One researcher says we should allocate the grant funding to East Boston,
;; since 55% of its residents use public transit, the highest in the city.
;; Another says the grant should be allocated to public transit in Dorcester,
;; even though only 37% of its residents use public transit.

;; Based on the data you have, why might the second researcher be right? Please
;; explain in 2-3 sentences, providing reasons for your answer. Include a
;; description of what kind of data you would need to store in your data
;; definition to allow researchers to make this decision. (NOTE: you do not need
;; to update you data definition, just describe changes).

;;!! IMPORTANT: Write your response BELOW this line:
;; The second research is right in this case because even though East Boston has a higher percentage, Dorchester
;; might have the highter total population which means that the number of public transit users could be higher
;; even if the percentage is lower. In order to store this data you would need to store both the percentage
;; of residents using public transit and the total population of each area. Using this allows you to calculate
;; the number of users of public transportation, which in turn determines the demand. 

;;! Part C

;; Now that we have more interesting data, let's update our draw function! This
;; time, in addition to the neighborhood input (which now includes commuter
;; counts), we also want your draw function to take a numeric scale between 0
;; and 1 (written Decimal(0,1]) and adjust the size of the drawn neighborhood
;; according to it: at scale 1, the neighborhood should be large, but fit in a
;; reasonably sized window; smaller scales should result in smaller images.
;;
;; Design a function called `draw-neighborhood-commuters` that takes two inputs:
;; 1. your new data definition and 2. a numeric scale between 0 (exclusive) & 1
;; (inclusive). It should produces an image of the neighborhood. The function
;; should vary the color of the neighborhood based on the number of commuters,
;; and the size according to the scale. How you choose to color the neighborhood
;; based on the percentage is up to you, but include some explanation in your
;; purpose statement.

;;!! IMPORTANT: Write your response BELOW this line:
;; Signature: map-color-helper : commuters -> String
;; Purpose Statement: the function determines the color that should be used
;; for the image based on the amount of commuters. Red represents less than 2000 commuters
;; yellow represents a range of, and including, 2000 through 5000. Green includes eveything else, in this case
;; greater than 50000
;; Tests:
(check-expect (map-color-helper (neighborhood-commuters-commuters back-bay-commuters)) "yellow")
(check-expect (map-color-helper (neighborhood-commuters-commuters dorchester-commuters)) "green")
(check-expect (map-color-helper (neighborhood-commuters-commuters north-end-commuters)) "red")
;; Code:
(define (map-color-helper commuters)
  (cond [(< commuters 2000) "red"]
        [(and (>= commuters 2000) (<= commuters 5000)) "yellow"]
        [else "green"]))

;; Signature: draw-neighborhood-commuters : neighborhood-data scale -> Image
;; Purpose Statement: This function calls the helper function in order to determine the color
;; and draws a representation of the neighborhood commuters. 
;; Tests:
(check-expect (draw-neighborhood-commuters dorchester-commuters 0.5)
              (place-image
               (rectangle (* 250 0.5) (* 250 0.5) "solid"
                          (map-color-helper (neighborhood-commuters-commuters dorchester-commuters)))
               (/ 250 2)
               (/ 250 2)
               (empty-scene 250 250)))
(check-expect (draw-neighborhood-commuters back-bay-commuters 0.8)
              (place-image
               (rectangle (* 250 0.8) (* 250 0.8) "solid"
                          (map-color-helper (neighborhood-commuters-commuters back-bay-commuters)))
               (/ 250 2)
               (/ 250 2)
               (empty-scene 250 250)))
(check-expect (draw-neighborhood-commuters fenway-commuters 0.3)
              (place-image
               (rectangle (* 250 0.3) (* 250 0.3) "solid"
                          (map-color-helper (neighborhood-commuters-commuters fenway-commuters)))
               (/ 250 2)
               (/ 250 2)
               (empty-scene 250 250)))
;; Code:
(define (draw-neighborhood-commuters neighborhood-data scale)
  (place-image
   (rectangle (* 250 scale) (* 250 scale) "solid"
              (map-color-helper (neighborhood-commuters-commuters neighborhood-data)))
   (/ 250 2)
   (/ 250 2)
   (empty-scene 250 250)))
