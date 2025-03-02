;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname hw8) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

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


;; In this assignment, you are going to build upon the work you did in HW6 to
;; build an interactive game that simulates atmospheric CO2 into the future,
;; based on converting commuters to public transit and planting eelgrass. You
;; will do this by extending your existing neighborhood data definitions to
;; store total emissions in each neighborhood, which will then be modified by
;; converting commuters & planting eelgrass.

;; Eelgrass is part of the Blue Carbon coastal ecosystem that sequester significant
;; amounts of CO2, and there is current research on how effective it is in Massachusetts.
;; See, e.g., https://oceanservice.noaa.gov/ecosystems/coastal-blue-carbon/
;; and https://seagrant.mit.edu/2023/10/19/mapping-blue-carbon-new-report-highlights-coastal-ecosystem-benefits/

;; An estimate from the latter is that, in Massachusetts, 218,222 acres sequester
;; a collective 7.5 million metric tonnes of carbon, or around 34 tonnes per
;; acre.

;;! Problem 1

;;! Part A

;; In this problem, you will refine and add to your neighborhood definitions from
;; previous assignment(s).

;; 1. First, copy your existing BostonCommuters data definition from HW6, along with all
;;    the definitions it relies upon.

;; 2. After copying your definitions, please fix any issues identified in the
;;    feedback you got on your HW6 submission.

;; 3. For reference, you should have the following data definitions:
;;    - Neighborhood: Represents one of 5 neighborhoods in Boston
;;    - NeighborhoodCommuters: A data definition with three fields:
;;      - the Neighborhood
;;      - the number of public transit commuters in that Neighborhood
;;      - the total number of commuters in that Neighborhood
;;    - BostonCommuters: Represents a collection (list) of NeighborhoodCommuters.

;; 4. Now for this problem, modify the NeighborhoodCommuters data definition to
;;    include a field that holds the total carbon emitted, **IN METRIC TONNES**,
;;    for that Neighborhood. This means the struct should now have four fields.

;;!! IMPORTANT: Write your response BELOW this line:
(define-struct NeighborhoodCommuters [neighborhood pt-commuters total-commuters total-carbon])
;; neighborhood - string that represents the neighborhood name
;; commuters - number that represents the numbner of public transit commuters in that neighborhood
;; total-commuters - number that represents the total number of commuters in that neighborhood
;; total-carbon - total amount of carbon that is emitted in metric tonnes
;; Examples:
(define BACK-BAY (make-NeighborhoodCommuters "Back Bay" 2600 3000 250000))
(define DORCHESTER (make-NeighborhoodCommuters "Dorchester" 22294 33976 1000000))
(define FENWAY (make-NeighborhoodCommuters "Fenway" 4050 5931 340000))
(define MATTAPAN (make-NeighborhoodCommuters "Mattapan" 3755 7483 400000))
(define NORTH-END (make-NeighborhoodCommuters "North End" 1793 8421 500000))

;; Template:
(define (NeighborhoodCommuters-temp n)
  (cond
    [... (NeighborhoodCommuters-neighborhood n)]
    [... (NeighborhoodCommuters-pt-commuters n)]
    [... (NeighborhoodCommuters-total-commuters n)]
    [... (NeighborhoodCommuters-total-carbon n)]))

;; BostonCommuters - list of NeighborhoodCommuters
;; '()
; (cons NeughborhoodCommuters BostonCommuters)
;; Interpretation: A list that represents data for multiple neighborhoods
;; Examples:
(define BostonCommuters
  (list BACK-BAY
        DORCHESTER
        FENWAY
        MATTAPAN
        NORTH-END))
(define BOSTON-COMMUTER-1 '())
(define BOSTON-COMMUTER-2 (list BACK-BAY DORCHESTER))
;; Template:
(define (boston-commuters-temp commuters)
  (cond
    [(empty? commuters) ...]
    [else
     (... (NeighborhoodCommuters-temp (first commuters))
          (boston-commuters-temp (rest commuters)))]))

;;! Part B

;; Define an example of your data definition, that is suitable for showing your graphics, as:
;; the constant `BC-EX`.

;;!! IMPORTANT: Write your response BELOW this line:
(define BC-EX (list BACK-BAY DORCHESTER FENWAY MATTAPAN NORTH-END))

;;! Part C

;; In HW6, you wrote a function, `simulate-emissions`, that calculated the
;; emissions caused by non-public transit commuters a given number of years into
;; the future. If it did not assume that everyone who does not use public
;; transit drives a car, we'd like you to fix that calculation for the sake of
;; the game -- while this certainly rules out other important commuting
;; categories (biking, walking), this will more easily allow the game to work.

;; We'd like you to, based on your existing function, design a new function
;; `add-emissions-one-year` that takes a NeighborhoodCommuters and returns an
;; updated version, where **one year** of emissions have been added to the new
;; field of total carbon emitted, based on the existing number of commuters who
;; drive (which should be all who do not use public transit). You can either use
;; your existing helper (passing 1 as the number of years) or you can use the
;; existing calculation when designing this new function.

;; Ensure the units of your emissions are in METRIC TONNES. If you used grams,
;; divide by 1000000.

;;!! IMPORTANT: Write your response BELOW this line:
;; Signature: add-emissions-one-year : NeighborhoodCommuters -> NeighborhoodCommuters
;; Purpose Statement: the function takes a neighborhoodcommuters and returns an update version where one year of emissions
;; is based on the total number of commuters who drive, not including public transportation. This amount of CO2 is represented in
;; metric tonnes. 
;; Tests:
(check-expect (add-emissions-one-year BACK-BAY) (make-NeighborhoodCommuters "Back Bay" 2600 3000 252336))
(check-expect (add-emissions-one-year FENWAY) (make-NeighborhoodCommuters "Fenway" 4050 5931 350985.04))
(check-expect (add-emissions-one-year DORCHESTER) (make-NeighborhoodCommuters "Dorchester" 22294 33976 1068222.88))
;; Code:
(define (add-emissions-one-year nc)
  (make-NeighborhoodCommuters
   (NeighborhoodCommuters-neighborhood nc)
   (NeighborhoodCommuters-pt-commuters nc)
   (NeighborhoodCommuters-total-commuters nc)
   (+ (NeighborhoodCommuters-total-carbon nc)
      (/ (* (- (NeighborhoodCommuters-total-commuters nc)
            (NeighborhoodCommuters-pt-commuters nc))
         20 2 400 365) 1000000))))

;;! Part D

;; In order to draw the game, we need to copy your `draw-boston-emissions`
;; function from HW6, and all its helpers. If you received feedback in HW6,
;; (e.g., about how the neighborhoods were positioned) please apply corrections
;; first.
;;
;; However -- in order to be able to be passed to `big-bang`, the only argument
;; to it must be `BostonCommuters`, so remove the `scale` argument. Instead,
;; pass a fixed scale to the helpers. The other change you should make is in
;; your function to draw a single neighborhood: since the carbon emissions are
;; now stored in a field, use that field to determine the color, rather than
;; calling `simulate-emissions`.
;;
;; Ensure that your coloring makes it clear how carbon is increasing in
;; neighborhoods: we would suggest some sort of rainbow, perhaps ending with a
;; lighter color when total CO2 in a neighborhood reaches 0 (which will correspond
;; to winning the game!).

;;!! IMPORTANT: Write your response BELOW this line:
;; Signature: map-color-helper : NeighborhoodCommuters-commuters -> String
;; Purpose Statement: the function determines the color that should be used to represent the amount of pollution
;; for the image based on the amount of commuters. Green represents less than 300000 of CO2
;; yellow represents a range of, and including, 350000 through 550000. Red includes eveything else, in this case
;; greater than 550001
;; Tests:
(check-expect (map-color-helper (NeighborhoodCommuters-total-carbon BACK-BAY)) "green")
(check-expect (map-color-helper (NeighborhoodCommuters-total-carbon DORCHESTER)) "red")
(check-expect (map-color-helper (NeighborhoodCommuters-total-carbon NORTH-END)) "orange")
;; Code:
(define (map-color-helper CO2)
  (cond
    [(= CO2 0) "lightgreen"]          
    [(< CO2 300000) "green"]          
    [(and (>= CO2 300000) (<= CO2 350000)) "yellowgreen"] 
    [(and (>= CO2 350001) (<= CO2 450000)) "yellow"]
    [(and (>= CO2 450001) (<= CO2 550000)) "orange"]
    [else "red"]))

;; Signature: draw-neighborhood : neighborhood-data number number -> Image
;; Purpose Statement: This function calls the helper function in order to determine the color
;; and draws a representation of the neighborhood commuters based on the years and scale that is inputted. 
;; Tests:
(check-expect (draw-neighborhood BACK-BAY)
              (place-image
               (rectangle (* 250 0.5) (* 250 0.5) "solid"
                          (map-color-helper (NeighborhoodCommuters-total-carbon BACK-BAY)))
               (/ 250 2)
               (/ 250 2)
               (empty-scene 250 250)))

(check-expect (draw-neighborhood DORCHESTER)
              (place-image
               (rectangle (* 250 0.5) (* 250 0.5) "solid"
                          (map-color-helper (NeighborhoodCommuters-total-carbon DORCHESTER)))
               (/ 250 2)
               (/ 250 2)
               (empty-scene 250 250)))
(check-expect (draw-neighborhood FENWAY)
              (place-image
               (rectangle (* 250 0.5) (* 250 0.5) "solid"
                          (map-color-helper (NeighborhoodCommuters-total-carbon FENWAY)))
               (/ 250 2)
               (/ 250 2)
               (empty-scene 250 250)))
;; Code:
(define (draw-neighborhood neighborhood-data)
  (place-image
   (rectangle (* 250 0.5) (* 250 0.5) "solid"
              (map-color-helper (NeighborhoodCommuters-total-carbon neighborhood-data)))
   (/ 250 2)
   (/ 250 2)
   (empty-scene 250 250)))

;; Signature: draw-boston-emissions : BostonCommuters number number -> Image
;; Purpose Statement: the function uses BostonCommuters list and draws all of the neighborhoods
;; based on the amount of pollution that is released, shown by the color. 
;; Tests:
(check-expect (draw-boston-emissions BostonCommuters)
              (beside 
               (draw-neighborhood BACK-BAY)
               (beside
                (draw-neighborhood DORCHESTER)
                (beside
                 (draw-neighborhood FENWAY)
                 (beside
                  (draw-neighborhood MATTAPAN)
                  (draw-neighborhood NORTH-END))))))
(check-expect (draw-boston-emissions BostonCommuters)
              (beside 
               (draw-neighborhood BACK-BAY)
               (beside
                (draw-neighborhood DORCHESTER)
                (beside
                 (draw-neighborhood FENWAY)
                 (beside
                  (draw-neighborhood MATTAPAN)
                  (draw-neighborhood NORTH-END))))))
(check-expect (draw-boston-emissions BostonCommuters)
              (beside 
               (draw-neighborhood BACK-BAY)
               (beside
                (draw-neighborhood DORCHESTER)
                (beside
                 (draw-neighborhood FENWAY)
                 (beside
                  (draw-neighborhood MATTAPAN)
                  (draw-neighborhood NORTH-END))))))
;; Code:
(define (draw-boston-emissions boston-commuters)
  (cond
    [(empty? boston-commuters) (empty-scene 0 0)]
    [(cons? boston-commuters)
     (beside (draw-neighborhood (first boston-commuters))
             (draw-boston-emissions (rest boston-commuters)))]))

;;! Part E

;; Now that we can draw, we can design a function `tick-boston-emissions`, which
;; takes a `BostonCommuters` and returns a new one, where one year has
;; passed. Use the helper you defined in Part C, and consider if there are any
;; useful list abstractions you can use.

;;!! IMPORTANT: Write your response BELOW this line:
;; Signature: tick-boston-emissions : BostonCommuters -> BostonCommuters
;; Purpose Statement: the function thats in a BostonCommuters and returns a new one where
;; one year has passed 
;; Tests:
(check-expect (tick-boston-emissions '())'())
(check-expect (tick-boston-emissions (list BACK-BAY)) (list (add-emissions-one-year BACK-BAY)))
(check-expect (tick-boston-emissions BostonCommuters)
              (list
               (add-emissions-one-year BACK-BAY)
               (add-emissions-one-year DORCHESTER)
               (add-emissions-one-year FENWAY)
               (add-emissions-one-year MATTAPAN)
               (add-emissions-one-year NORTH-END)))
;; Code:
(define (tick-boston-emissions bc)
  (map add-emissions-one-year bc))

;;! Part F

;; While with tick & draw, we could run the simulation, to make this a game, we
;; want to add two elements that allow the player to **decrease** CO2.
;;
;; First, we want to make it so that if the user presses any key, it causes a
;; constant number of acres of eelgrass to be planted (the constant is provided;
;; you can tweak it to alter the gameplay, though the default should work).
;;
;; Design a function `key-boston-emissions` that does exactly that. Note that,
;; based on the intro, one acre eelgrass results in 34 metric tonnes of carbon
;; removed; we will simplify and assume the effect is split evenly across each
;; of the 23 neighborhoods, so you should **remove 1.5 metric tonnes of carbon per
;; neighborhood per keypress**.

(define ACRES-PLANTED-PER-PRESS 500)

;;!! IMPORTANT: Write your response BELOW this line:
(define CO2-TO-BE-REMOVED (* 1.5 ACRES-PLANTED-PER-PRESS))

;; Signature: key-boston-emissions : BostonCommuters Number -> BostonCommuters
;; Purpose Statement: the function decreases the amount of total CO2 across all the
;; neighborhoods by 1.5 metric tonnes per each neighborhood per keypress
;; Tests:
(check-expect (key-boston-emissions BOSTON-COMMUTER-1 "F") '())
(check-expect (key-boston-emissions BOSTON-COMMUTER-2 "F") (list (make-NeighborhoodCommuters "Back Bay" 2600 3000 249250) (make-NeighborhoodCommuters "Dorchester" 22294 33976 999250)))
(check-expect (key-boston-emissions BostonCommuters "F")
              (list
               (make-NeighborhoodCommuters "Back Bay" 2600 3000 249250)
               (make-NeighborhoodCommuters "Dorchester" 22294 33976 999250)
               (make-NeighborhoodCommuters "Fenway" 4050 5931 339250)
               (make-NeighborhoodCommuters "Mattapan" 3755 7483 399250)
               (make-NeighborhoodCommuters "North End" 1793 8421 499250)))
;; Code:
(define (key-boston-emissions bc ke)
  (local [
          (define (update-carbon-total n) ;; update-carbon-total : NeighborhoodCommuters -> NeighborhoodCommuters
            ;; the function updates the total carbon by subtracting 1.5 metric tonnes per acre per each neighborhood
            (make-NeighborhoodCommuters (NeighborhoodCommuters-neighborhood n)
                                        (NeighborhoodCommuters-pt-commuters n)
                                        (NeighborhoodCommuters-total-commuters n)
                                        (- (NeighborhoodCommuters-total-carbon n) CO2-TO-BE-REMOVED)))]
    (map update-carbon-total bc)))

;;! Part G

;; We want there to be a second mechanism for the game: clicking the mouse
;; should convert a constant number of commuters from driving to using public
;; transit in each neighborhood (provided below), assuming there are any left.
;;
;; Design this function, which should be called `mouse-boston-emissions`, as
;; well.

(define CONVERTERS-PER-CLICK 300)

;;!! IMPORTANT: Write your response BELOW this line:
;; Signature: car-commuters : NeighborhoodCommuters -> Number
;; Purpose Statement: the function finds the total amount of commuters who are car commuters
;; in which in this case is the total commuters take away public transit commuters
;; Tests:
(check-expect (car-commuters BACK-BAY) 400)
(check-expect (car-commuters DORCHESTER) 11682)
(check-expect (car-commuters FENWAY) 1881)
;; Code:
(define (car-commuters nc)
  (- (NeighborhoodCommuters-total-commuters nc)
     (NeighborhoodCommuters-pt-commuters nc)))

;; Signature: mouse-boston-emissions : BostonCommuters Number Number MouseEvent -> BostonCommuters
;; Purpose Statement: the function converts the number of commuters from driving to
;; to those using public transportation and it does it 300 per click
;; Tests:
(check-expect (mouse-boston-emissions BOSTON-COMMUTER-1 1 1 "button-down") '())
(check-expect (mouse-boston-emissions BOSTON-COMMUTER-2 100 100 "button-down")
              (list (make-NeighborhoodCommuters "Back Bay" 2900 3000 250000) (make-NeighborhoodCommuters "Dorchester" 22594 33976 1000000)))
(check-expect (mouse-boston-emissions BostonCommuters 10 10 "button-down") (list
                                                                            (make-NeighborhoodCommuters "Back Bay" 2900 3000 250000)
                                                                            (make-NeighborhoodCommuters "Dorchester" 22594 33976 1000000)
                                                                            (make-NeighborhoodCommuters "Fenway" 4350 5931 340000)
                                                                            (make-NeighborhoodCommuters "Mattapan" 4055 7483 400000)
                                                                            (make-NeighborhoodCommuters "North End" 2093 8421 500000)))
;; Code:
(define (mouse-boston-emissions bc x y ke)
  (local [
          (define (update-commuters-total n)
            (if (>= (car-commuters n) CONVERTERS-PER-CLICK)
                (make-NeighborhoodCommuters (NeighborhoodCommuters-neighborhood n)
                                            (+ (NeighborhoodCommuters-pt-commuters n)
                                               CONVERTERS-PER-CLICK)
                                            (NeighborhoodCommuters-total-commuters n)
                                            (NeighborhoodCommuters-total-carbon n))
                (make-NeighborhoodCommuters (NeighborhoodCommuters-neighborhood n)
                                            (+ (NeighborhoodCommuters-pt-commuters n)
                                               (car-commuters n))
                                            (NeighborhoodCommuters-total-commuters n)
                                            (NeighborhoodCommuters-total-carbon n))))]
    (if (string=? ke "button-down")
        (map update-commuters-total bc)
        bc)))

;;! Part H

;; Also, we'd like to be able to win the game! Define a helper function
;; `win?` that, given a BostonCommuters, returns #true if any of the
;; neighborhoods have reached 0 carbon.

;;!! IMPORTANT: Write your response BELOW this line:
;; Signature: win? : BostonCommuters -> Boolean
;; Purpose Statement: the function returns a boolean that is either true or false
;; if the carbon of a neighborhood is equal to 0
;; Tests:
(check-expect (win? BOSTON-COMMUTER-1) #false)
(check-expect (win? BOSTON-COMMUTER-2) #false)
(check-expect (win? (list (make-NeighborhoodCommuters "Back Bay" 2900 2700 0)
                          (make-NeighborhoodCommuters "Dorchester" 22594 33676 1000000))) 
              #true)
;; Code:
(define (win? bc)
  (ormap (lambda (c)
           (= (NeighborhoodCommuters-total-carbon c) 0))
         bc))

;;! Part I

;; The final helper we'd like to define is a function, `draw-win`, to display a "You win!"
;; message. It should take the game state (BostonCommuters) and return an image
;; that represents a winning game. We'd suggest text overlaying the existing map.

;;!! IMPORTANT: Write your response BELOW this line:
;; Signature: draw-win -> BostonCommuters -> Image
;; Purpose Statement: the function returns an image of the message "You Win!"
;; Tests:
(check-expect (draw-win BOSTON-COMMUTER-1)
              (place-image
               (text "You win!" 50 "blue")
               150 150                      
               (empty-scene 300 300)))
(check-expect (draw-win BOSTON-COMMUTER-2)
              (place-image
               (text "You win!" 50 "blue")
               150 150                      
               (empty-scene 300 300)))
(check-expect (draw-win BostonCommuters)
              (place-image
               (text "You win!" 50 "blue")
               150 150                      
               (empty-scene 300 300)))

;; Code:
(define (draw-win bc)
  (place-image
   (text "You win!" 50 "blue")
   150 150                      
   (empty-scene 300 300)))    

;;! Part J

;; Now design a function `play-game`, that takes an initial `BostonCommuters`
;; and invokes `big-bang` with the handlers designed in part D, E, F, G, H, I.
;; When run, it should allow you to try to keep ahead of the carbon by either
;; planting eelgrass or convincing people to take public transit, and if they
;; win (get one neighborhood to 0), it should display the winning message (if
;; you haven't already, consult the documentation for the `stop-when` clause of
;; big-bang). To make the game playable, slow it down so that each year
;; (represented by one tick) occurs per second (i.e. `[on-tick
;; tick-boston-emissions 1]`).
;;
;; In order to not have your initial state immediately be a "win" (as no carbon
;; will be recorded as having been emitted yet), we suggest that rather than
;; passing the argument as the initial state to `big-bang`, instead pass
;; `(tick-boston-emissions bc)` -- i.e., begin the game after 1 year.

;;!! IMPORTANT: Write your response BELOW this line:
;; Signature: play-game : BostonCommuters -> big-bang
;; Purpose Statement: the function puts together all the handlers made before and emulates the game
;; simulating atmospheric CO2 into the future
;; Code:
(define (play-game bc)
  (big-bang bc
    [to-draw (lambda (bc)
               (draw-boston-emissions bc))]
    [on-tick tick-boston-emissions 1]
    [on-key key-boston-emissions]
    [on-mouse mouse-boston-emissions]))