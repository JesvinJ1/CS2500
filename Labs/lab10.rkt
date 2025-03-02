;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname lab10) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Lab 10

;;! Part A

;; Design the function pay-rates which, given a list of names as strings
;; and a list of hourly rates as numbers, produces a list of strings
;; in order which describes how much money each person makes.

;; The list of names will be the same size or longer than the list of
;; rates; people with no corresponding wage are paid $15/hour (minimum
;; wage in Boston in 2024). Two tests are provided for clarity.

(check-expect
 (pay-rates
  (list "Archer" "Bella" "Charlie")
  (list 30 20 19))
 (list "Archer is paid $30/hour"
       "Bella is paid $20/hour"
       "Charlie is paid $19/hour"))

(check-expect
 (pay-rates (list "Alex" "Robin") (list 25))
 (list "Alex is paid $25/hour" "Robin is paid $15/hour"))

;; Signature: pay-rates : LoN LoH -> LoS
;; Purpose Statement: the functiont takes in a list of names and a list of hourly rates
;; and returns a list with both of those together
;; Code:
(define (pay-rates names rates)
  (cond [(empty? names) '()]
        [(empty? rates)
         (cons
          (string-append (first names) " is paid $15/hour")
          (pay-rates (rest names) rates))]
        [else
         (cons (string-append (first names) " is paid $" (number->string (first rates)) "/hour")
               (pay-rates (rest names) (rest rates)))]))    

;; STOP AND SWITCH WHO IS TYPING. CODE WALKS WILL BEGIN NOW!

;;! Part B

;; INTERPRETIVE QUESTION
;;
;; "Wage disparity", "pay disparity", or a "pay gap" all refer to a phenomenon
;; where people are paid different amounts for doing the same work. It is a
;; serious issue in many industries, and explicitly prohibited by executive
;; order for US Government contractors
;; https://www.dol.gov/agencies/ofccp/about/executive-order-11246-history. In
;; particular, this can show up systemically as women being paid less than men
;; for similar work (a gender pay gap), people of color being paid less than
;; white people (a racial pay gap), etc.
;;
;; Critically, not all wage *differences* are wage *disparities*. Those words,
;; examples of moral language, convey important meaning. Different wages may
;; be justified -- for example, if someone is doing a job that requires more training, expertise, or
;; experience, or they have a higher level of responsibility. With only the
;; information in Part A, it would be impossible to assess if there are any
;; wage *disparities*, since all we know are names and wages.
;;
;; If you were to be tasked with reviewing wages for *disparities*, what
;; additional information would you like to have for each person? Please include
;; at least two additional fields, and justify why they would be useful. Keep
;; your response to 2-3 sentences. Longer responses may not receive full credit.

;; The first additional field you should include is the gender of the person.
;; As what was stated, wage disparity has occurred when genders were paid
;; different rates. Another field that you should include is the ethnicity/race
;; of the person because, again as stated before, people of different ethnicity
;; have been paid less which is considered a wage disparity. 


;;! Part C

;; Design the function `map-func` which, given a function and a list,
;; returns a new list containing the results of applying the function to each element of the list.
;; The implementation must exclusively use the `foldr` list abstraction.
;; Some tests have been supplied for clarity.

(check-expect (map-func add1 '()) '())
(check-expect (map-func add1 (list 1 2 3)) (list 2 3 4))
(check-expect (map-func string-upcase (list "a" "b" "c")) (list "A" "B" "C"))

;; Signature: map-func : function LoA -> LoA
;; Purpose Statement: returns a new list containing the results of applying the function to each element of the list
(define (map-func function list)
  (foldr (lambda (fn lst)
           (cons (function fn) lst)) '()
                                     list))

;;! Part D
;;
;; Design the function `prefix`, which takes a list `lp` of prefixes (each
;; prefix is a string) and a list `l` of strings.
;; It produces a list of lists of strings. Each list of strings in
;; the output is obtained by using one of the given prefixes and inserting
;; them as the first element into `l`. We've provided one test case for clarity:

(check-expect (prefix (list "p1" "p2") (list "A" "B" "C"))
              (list (list "p1" "A" "B" "C")
                    (list "p2" "A" "B" "C")))

;; Signature: prefix : LoP LoS -> Los
;; Purpose Statement: It produces a list of lists of strings. Each list of strings in
;; the output is obtained by using one of the given prefixes and inserting
;; them as the first element into `l`
;; Code:
(define (prefix pf LoS)
  (map (lambda (x)
         (cons x LoS))
       pf))

;;! Part E
;;
;; Design a function `intersect`, which, given two lists and an equality predicate, produces
;; a new list that computes the intersection of two lists.
;; The intersection should consist of all elements from the first list that appear in the second,
;; as determined by the equality predicate.
;; The equality predicate defines what it means for an element from the first list to be "the same"
;; as an element from the second list. This is the notion of sameness your intersection function
;; should use to determine whether an element in one list appears in the other.

(check-expect (intersect (list 1 2 3 4) (list 3 4 5 6) =) (list 3 4))
(check-expect (intersect (list "apple" "banana" "apple") (list "apple" "cherry") string=?)
              (list "apple" "apple"))
(check-expect (intersect (list "APPLE" "banana" "cherry" "OrAnGe") (list "apple" "banana" "orange")
                         (lambda (s1 s2) (string=? (string-downcase s1) (string-downcase s2))))
              (list "APPLE" "banana" "OrAnGe"))

;; Signature: intersect : LoA LoA Predicate -> LoA
;; Purpose Statement: produces a new list that computes the intersection of two lists
;; Code:
(define (intersect LoA LoA2 pred)
  (filter (lambda (x)
            (ormap (lambda (y)
                     (pred x y))
                   LoA2)) LoA))
            