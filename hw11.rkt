;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |hw11 new|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
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

;;! HW11

;; In the era of the Internet of Things (IoT), smart home systems play an important role
;; in enhancing convenience, security, and energy efficiency. Efficient data processing
;; and algorithms are essential for optimizing device performance, as they ensure user
;; satisfaction and maintain system security. As a software developer working
;; on smart home systems, you are tasked with implementing algorithms that handle large
;; datasets, perform real-time data analysis, and maintain system performance.

;; Consider the following data definition for a SmartHomeDevice:

(define-struct device [name energy-consumption])
;; A SmartHomeDevice is a (make-device String Number)
;; Representing a smart home device
;; - name is the name of the device
;; - energy-consumption is the energy consumption of the device in watts

(define D1 (make-device "Thermostat" 150))
(define D2 (make-device "Light Bulb" 60))
(define D3 (make-device "Security Camera" 100))
(define D4 (make-device "Broken Security Camera" 0))
(define D5 (make-device "Broken Light Bulb" 0))
(define D6 (make-device "Broken Thermostat" 0))

(define (device-temp d)
  (... (device-name d) ... (device-energy-consumption d) ...))

;;! Problem 1

;; Implement a function `devices-possible` that takes a list of devices and a
;; total power budget (in watts) and returns a prefix of the list whose total
;; power usage is as close to the power budget as possible without exceeding it.

;;!! IMPORTANT: Write your response BELOW this line:
;; Signature: devices-possible : [ListOf Devices] Number -> [ListOf Devices]
;; Purpose Statement: the function takes a list of devices and total power and
;; returns a list with total power usage as close to as the budget without exceeding it
;; Tests:
(check-expect (devices-possible (list D1 D2 D3) 150) (list D1))
(check-expect (devices-possible (list D2 D3) 80) (list D2))
(check-expect (devices-possible (list D1 D3) 80) '())

;; Code:
(define (devices-possible lod pwr)
  (cond [(empty? lod) '()]
        [(cons? lod)
         (if (<= (device-energy-consumption (first lod)) pwr)
             (cons (first lod)
                   (devices-possible (rest lod) (- pwr (device-energy-consumption (first lod)))))
             '())]))

;;! Problem 2

;; Design a function total-energy, that returns the total energy consumed by a
;; list of devices. If 3 of the devices have an energy consumption of 0
;; (indicating the devices are inactive), the entire function should immediately
;; return the total energy consumption up to the point where the 3rd inactive device was encountered.

;;!! IMPORTANT: Write your response BELOW this line:
;; Signature: total-energy : [ListOf Devices] -> Number
;; Purpose Statement: the function takes in a list of devices and returns the total energy consumed by
;; the devices. If 3 of the devices have 0 consumption it returns the consumption upto the 3rd inactive device
;; Tests:
(check-expect (total-energy (list D1 D2 D3)) 310)
(check-expect (total-energy (list D1 D4 D5 D6)) 150)
(check-expect (total-energy (list D2 D4 D5 D1 D6 D1)) 210)
;; Code:
(define (total-energy lod)
  (cond [(empty? lod) 0]
        [(cons? lod)
         (if (= (device-energy-consumption (first lod)) 0
             (+ (device-energy-consumption (first lod)) ( (rest lod))))]))

;; Signature: total-energy-helper : [ListOf Devices] Number -> Number
;; Purpose Statement: the function keeps track of the amount of occurances
;; of a 0 energy consumption device in additon to the total from a list of
;; devices
;; Tests:
(check-expect (total-energy-helper (list D1 D2 D3) 2 0))
;; Code:
(define (total-energy-helper lod  total)
  (cond [(empty? lod) total]
        [(cons? lod)
         (if (=
             (if (= (device-energy-consumption (first lod)) 0)

                
;;! Problem 3

;;! Part A

;; Design the data definition Circuit that can represent either outlets, wires
;; (that lead to another Circuit, indicated with an arrow in diagram), junctions
;; (that have three Circuits coming out of them), or a dead end.

;; An example that you would want to be able to represent is (wire abbreviated w
;; in places):

;; --- wire ---> |junction|
;;                /  |  \
;;               w   w   w
;;              /    |    \
;;             \/    |    \/
;;          outlet   |   outlet
;;                  \|/
;;                deadend

;;!! IMPORTANT: Write your response BELOW this line:
(define-struct wire [w])
(define-struct junction [left middle right])

;; A Circuit is one of:
;; - outlet - represents an outlet
;; - deadend - represents a deadend
;; - (make-wire Circuit) - a wire leading to another circuit
;; - (make-junction Circuit Circuit Circuit) - a junction leading to 3 other circuits
;; Interpretation: a circuit tree of values of wires where there are outlets
;; which have a wire and deadend which has a wire.

;; Examples:
(define C1 (make-wire "outlet"))
(define C2 (make-wire "deadend"))
(define C3 (make-junction (make-wire C1)
                          (make-wire C2)
                          (make-wire C1)))
(define C4 (make-wire (make-junction (make-wire C1)
                                     (make-wire C2)
                                     (make-wire C1))))
(define C5 (make-junction
            (make-wire "outlet")                  
            (make-wire (make-wire "outlet"))       
            (make-wire (make-wire (make-wire "outlet")))))

;; Template:
(define (circuit-template c)
  (cond [(wire? c) (... (wire-w c) ...)]
        [(junction? c) (... (circuit-template (junction-left c))
                            (circuit-template (junction-middle c))
                            (circuit-template (junction-right c)))]))

;;! Part B

;; Define an interesting example of your data definition, as the constant `CIRCUIT-EX`.
;; NOTE: The autograder for Problem 4 will fail if you submit without defining `CIRCUIT-EX`.

;;!! IMPORTANT: Write your response BELOW this line:
(define CIRCUIT-EX (make-junction (make-wire "outlet")
                                  (make-junction
                                   (make-wire "outlet")
                                   (make-wire "deadend")
                                   (make-wire "outlet"))
                                  (make-wire "deadend")))

;;! Problem 4

;; Design a function, length-to-wires, that given a Circuit, returns a list of
;; numbers that represent the length, in number of wires, to each of the outlets
;; in the Circuit.

;;!! IMPORTANT: Write your response BELOW this line:
;; Signature: length-to-wires : Circuit -> [ListOf Numbers]
;; Purpose Statement: the function returns the number of wires to each outlet
;; in a circuit
;; Tests:
(check-expect (length-to-wires C2) '())
(check-expect (length-to-wires C3) (list 2 2))
(check-expect (length-to-wires C4) (list 3 3))
(check-expect (length-to-wires C5) (list 1 2 3))
;; Code:
(define (length-to-wires c)
  (cond
    [(wire? c) (... (length-to-wires (wire-w c)))]
    [(junction? c) (... (length-to-wires (junction-left c))
                           (length-to-wires (junction-middle c))
                           (length-to-wires (junction-right c)))]
    [(string? c) (if (string=? c "outlet") (list 0) empty)]))
 
;;! Problem 5
;; INTERPRETIVE QUESTION
;;
;; While smart home devices are often sold because they can either increase
;; convenience or sometimes decrease total energy use by "intelligently" turning
;; off, there are several new challenges introduced by their use:
;;
;; 1. Privacy / surveillance concerns. Many devices transmit their data to
;; centralized data centers, and if those are compromised, anything from the
;; voice recordings from smart speakers to videos from baby monitors could be
;; made available. This has been the subject of federal law in the United States,
;; with Internet of Things Cybersecurity Improvement Act of 2020 setting minimum
;; security standards for such devices if used by the federal government.
;;
;; 2. Increase of "electronic waste" or e-waste: many devices only work when in
;; contact with software running on remote servers, and if the company changes
;; the software or goes out of business, the device could stop working or need
;; to be replaced, potentially much more quickly than a non-smart version would
;; have. Many have advocated, and in some places passed, so called "Right to
;; repair" laws that ensure consumers have access to the ability to fix or keep
;; running devices: one of the first in the US was actually for cars, where a
;; law in Massachussetts guaranteed owners the same access to repair information
;; as car dealers.
;;
;; FIRST TASK: Please identify which privacy concerns you think are most
;; important for smart home devices. Write no more than 2-3 sentences.
;;
;; SECOND TASK: Please identify which "right to repair" principles are most
;; important for smart home devices. Write no more than 2-3 sentences.

;;!! IMPORTANT: Write your response BELOW this line:
;; I would say the most important privacy concerns for smart home devices are
;; the collection of your data and how it is being stored. As mentioned, data
;; of all sorts of types can be collected by these devices and stored in these
;; 'secured' servers yet the worst could happen and your data could get leaked
;; which may contain private information.

;; The right to repair princple that is most important for smart home devices
;; is ensuring that if the company changes, updates its policies, or shuts down
;; that users still have the ability to use that device as it was intended. This
;; allows for increased lifetime of the product, reduces e-waste, and allows people
;; to fix their device instead of replacing it. 

;;! Problem 6
;;
;; Design a function `remove-devices` that, given a list of devices, removes
;; some of them according to the following strategy, and returns the remaining
;; ones:
;;
;; - The first device should be kept.
;; - If the first one has energy-consumption n, then the next m devices should be removed, until
;;   the total energy of the m devices adds to n or greater (or the end of the list is reached).
;; - This should then repeat with the next device being treated like the first one.
;;
;;
;; One test is provided as an example:
(check-expect (remove-devices (list (make-device "A" 100)
                                    (make-device "B" 60)
                                    (make-device "C" 50)
                                    (make-device "D" 30)
                                    (make-device "E" 100)
                                    (make-device "F" 10)))
              (list (make-device "A" 100)
                    (make-device "D" 30)
                    (make-device "F" 10)))

;;!! IMPORTANT: Write your response BELOW this line:
;; Signature: remove-devices : [ListOf Devices] -> [ListOf Devices]
;; Purpose Statement: the function removes devices, with the first device being kept
;; and based on the energy consumption of the first device, the next m devices will be
;; removed based on their consumption being added, looking to be greater than or equal to
;; the original device's energy consumption. 
;; Tests:

;; Code:
(define (remove-devices lod)
   (cond
     [(empty? lod) '()]
     [(cons? lod)
      (if (> (device-energy-consumption (first lod)) 0)
          (append 
