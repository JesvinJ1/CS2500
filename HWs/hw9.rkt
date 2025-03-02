;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |HW9 NEW|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
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

;;! HW9

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; New Instructions                                                           ;;
;; 1. You must use list abstractions to receive credit. Do not write directly ;;
;;    recursive functions.                                                    ;;
;; 2. You may use `lambda` if you wish.                                       ;;
;; 3. Many problems have provided signatures and purpose statements that you  ;;
;;    should not modify.                                                      ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; This homework refers to the following data definitions.

;;! A Category is one of:
;;! - "Personal"
;;! - "Work"
;;! - "Academic"
;;! Interpretation: a category of tasks in a task list.
(define PERSONAL "Personal")
(define WORK "Work")
(define ACADEMIC "Academic")

(define (category-template cat)
  (cond
    [(string=? cat PERSONAL) ...]
    [(string=? cat WORK) ...]
    [(string=? cat ACADEMIC) ...]))

(define-struct task [category description priority])
;; A Task is (make-task Category String Number)
;; Interpretation: A task in a task list, with its category, description, and
;; priority. Lower numbers are more urgent.
(define EX-ASSIGNMENT (make-task ACADEMIC "Finish HW9" 0))
(define EX-ASSIGNMENT2 (make-task ACADEMIC "Finish HW9" 5))
(define EX-LIBRARY (make-task WORK "Finishing shelving books in Snell" 10))
(define EX-LIBRARY2 (make-task WORK "Finishing shelving books in Snell" 15))
(define EX-LIBRARY3 (make-task WORK "Taking away books in Snell" 15))
(define EX-PERSONAL (make-task PERSONAL "Do laundry this time" 20))
(define EX-PERSONAL2 (make-task PERSONAL "Do laundry this time" 50))

(define (task-template t)
  (... (task-category t) ... (task-description t) ... (task-priority t) ...))

;;! Problem 1

;; Design a function called priority-zero that consumes a list of tasks and
;; only produces those with priority 0.

;;! priority-zero : [List-of Task] -> [List-of Task]
;;! Produces a list of tasks with priority 0.

;;!! IMPORTANT: Write your response BELOW this line:
;; Tests:
(check-expect (priority-zero (list EX-ASSIGNMENT)) (list EX-ASSIGNMENT))
(check-expect (priority-zero (list EX-ASSIGNMENT EX-LIBRARY)) (list EX-ASSIGNMENT))
(check-expect (priority-zero (list EX-ASSIGNMENT EX-LIBRARY EX-PERSONAL)) (list EX-ASSIGNMENT))
;; Code:
(define (priority-zero lot)
  (filter (lambda (x)
            (= (task-priority x) 0)) lot))

;;! Problem 2

;; Design a function called priority<= that consumes a priority number and
;; a list of tasks and produces only those with priority less than or equal
;; to the given number.

;;! priority<= : Number [List-of Task] -> [List-of Task]
;;! Produces a list of tasks with priority less than or equal to the given
;;! number.

;;!! IMPORTANT: Write your response BELOW this line:
;; Tests:
(check-expect (priority<= 0 (list EX-ASSIGNMENT EX-LIBRARY EX-PERSONAL)) (list (make-task "Academic" "Finish HW9" 0)))
(check-expect (priority<= 15 (list EX-ASSIGNMENT EX-LIBRARY EX-PERSONAL)) (list (make-task "Academic" "Finish HW9" 0)
                                                                                (make-task "Work" "Finishing shelving books in Snell" 10)))
(check-expect (priority<= 30 (list EX-ASSIGNMENT EX-LIBRARY EX-PERSONAL)) (list (make-task "Academic" "Finish HW9" 0)
                                                                                (make-task "Work" "Finishing shelving books in Snell" 10)
                                                                                (make-task "Personal" "Do laundry this time" 20)))
;; Code:
(define (priority<= num lot)
  (filter (lambda (x)
            (<= (task-priority x) num)) lot))

;;! Problem 3

;;! Part A
;; Design a function called prioritize that consumes a category and a list of
;; tasks, and sets the priority of all tasks in the given category to 0. The
;; produced list should contain all tasks in the original list.

;;! prioritize : Category [List-of Task] -> [List-of Task]
;;! Produces a list of tasks where the priority of every task that matches the category given, is set to 0

;;!! IMPORTANT: Write your response BELOW this line:
(define LIST1 (list EX-ASSIGNMENT EX-LIBRARY EX-PERSONAL))
(define LIST2 (list EX-ASSIGNMENT2 EX-LIBRARY2 EX-PERSONAL2))
(define LIST3 (list EX-ASSIGNMENT EX-LIBRARY EX-PERSONAL EX-ASSIGNMENT2 EX-LIBRARY2 EX-PERSONAL2))
(define LIST4 (list EX-LIBRARY EX-LIBRARY3))
;; Tests:
(check-expect (prioritize WORK LIST1)
              (list (make-task "Academic" "Finish HW9" 0)
                    (make-task "Work" "Finishing shelving books in Snell" 0)
                    (make-task "Personal" "Do laundry this time" 20)))
(check-expect (prioritize PERSONAL LIST2)
              (list (make-task "Academic" "Finish HW9" 5)
                    (make-task "Work" "Finishing shelving books in Snell" 15)
                    (make-task "Personal" "Do laundry this time" 0)))
(check-expect (prioritize ACADEMIC LIST3)
              (list
               (make-task "Academic" "Finish HW9" 0)
               (make-task "Work" "Finishing shelving books in Snell" 10)
               (make-task "Personal" "Do laundry this time" 20)
               (make-task "Academic" "Finish HW9" 0)
               (make-task "Work" "Finishing shelving books in Snell" 15)
               (make-task "Personal" "Do laundry this time" 50)))
;; Code:
(define (prioritize ctg lot)
  (map (lambda (x)
         (if (string=? (task-category x) ctg)
             (make-task (task-category x) (task-description x) 0)
             x))
       lot))

;;! Part B
;;
;; INTERPRETIVE QUESTION
;;
;; The data definition provided had a numeric score for Priority. It is quite common
;; for software systems to use numeric scores for things like this, though it comes at
;; a risk of losing information that a more nuanced representation could capture.
;;
;; One approach is, rather than storing a single numeric score, to store scores
;; for various attributes, and then combine them via a formula. For example,
;; when thinking of tasks, you might have separate scores for:
;;
;; - Duration: a low score task is short, a high score task is long
;; - Urgency: a low score task needs to be done soon, a high score task can be done later
;; - Enjoyment: a low score task is very enjoyable, a high score task is unpleasant.
;;
;; This will allow users to more accurately describe the attributes that might
;; contribute to the priority, and might enable different filtering (i.e., I
;; could ask for only short tasks, or only tasks that would be very enjoyable).
;; But, often this separation also requires us to determine what weighting we
;; give, by default, to the separate aspects.
;;
;; Your FIRST task is to assign "weights" to each of the three aspects above: they
;; should be percentages that sum to 100 (or fractions that sum to 1). Explain
;; how you determined the weights in a few sentances.
;;
;; Your SECOND task is to propose another scoring criterion that could
;; contribute to priority. You do not need to alter your weights, but you do
;; need to justify why having a score for your proposed criteria could be useful
;; when determining task priority.


;;!! IMPORTANT: Write your response BELOW this line:
;; I would say the duration should be 30% because the time is considered
;; an important factor but not the most important. This is in the sense that
;; a long task would take a while which means it would be hard to find a time
;; for it. In the same context if the task is urgent or more enjoyable, it could
;; have greater priority but take not as long. Urgency would be 50% because tasks
;; that need to be done sooner should be first on the list/higher up. Enjoyment,
;; I would give 20% only because the enjoyment you get out of it is only really
;; a motivation factor in getting you to do the work, but it doesn't have anything
;; to do with the priority in which it should be done.

;; Another criteria I would put in is how complex the task is (complexity).
;; This would be very useful in determining the task priority because if the task
;; is more complex then it would most likely correlate with requiring more time
;; and more resources so it should be done sooner.

;;! Problem 4

;; Design a predicate called any-work? that determines if any task in a list
;; is a Work task.

;;! any-work? : [List-of Task] -> Boolean
;;! Determines if any task in the given list is a work task.

;;!! IMPORTANT: Write your response BELOW this line:
;; Tests:
(check-expect (any-work? LIST2) #t)
(check-expect (any-work? (list EX-PERSONAL EX-ASSIGNMENT)) #f)
(check-expect (any-work? (list EX-PERSONAL EX-ASSIGNMENT EX-LIBRARY)) #t)
;; Code:
(define (any-work? lot)
  (ormap (lambda (x)
           (string=? (task-category x) WORK))
         lot))

;;! Problem 5

;; Design a function called search-work that consumes a string and a list of tasks
;; and produces the descriptions of the Work tasks that contain the given string.

;;! search-work : String [List-of Task] -> [List-of String]
;;! Produces the list of descriptions of Work tasks that contain the given string.

;;!! IMPORTANT: Write your response BELOW this line:
;; Tests:
(check-expect (search-work "Finishing shelving books in sneel" LIST1) '())
(check-expect (search-work "Taking away books in Snell" LIST4)
              (list "Taking away books in Snell"))
(check-expect (search-work "Finishing shelving books in Snell" LIST3)
              (list "Finishing shelving books in Snell" "Finishing shelving books in Snell"))
;; Code:
(define (search-work str lot)
  (map task-description
       (filter (lambda (x)
                 (and (string=? (task-category x) WORK)
                      (string-contains-ci? str (task-description x))))
               lot)))
                

;;! Problem 6

;; Design a function called average-priority that consumes a list of tasks and
;; produces the average priority of all tasks in the given list.

;;! average-priority : [List-of Task] -> Number
;;! Produces the average priority of all tasks in the given list.

;;!! IMPORTANT: Write your response BELOW this line:
;; Tests:
;; **SIDE NOTE** Had to use quotient instead of / becuase when I
;; got a repeating decimal it broke the autograder/file
(check-expect (average-priority LIST1) 10)
(check-expect (average-priority LIST2) 23)
(check-expect (average-priority LIST3) 16)
;; Code:
(define (average-priority lot)
  (cond
    [(empty? lot) 0]
    [(cons? lot) (quotient
                  (foldr (lambda (x total)
                  (+ (task-priority x) total)) 0 lot)
         (length lot))]))
  
;;! Problem 7

;; Design a function called group-tasks-by-category that consumes a list of
;; tasks and groups them into sublists based on their category. The produced
;; list should contain three sublists corresponding to the categories "Personal",
;; "Work", and "Academic". Each sublist should contain all tasks that belong
;; to its respective category. If there are no tasks in a particular category,
;; the corresponding sublist should be empty. The order of the
;; list of categories is provided below.

;;! group-tasks-by-category : [List-of Task] -> [List-of [List-of Task]]
;;! Groups tasks into sublists based on their category.

(define CATEGORIES (list PERSONAL WORK ACADEMIC))

;;!! IMPORTANT: Write your response BELOW this line:
;; Tests:
(check-expect (group-tasks-by-category LIST1)
              (list (list (make-task "Personal" "Do laundry this time" 20))
                    (list (make-task "Work" "Finishing shelving books in Snell" 10))
                    (list (make-task "Academic" "Finish HW9" 0))))
(check-expect (group-tasks-by-category LIST2)
              (list (list (make-task "Personal" "Do laundry this time" 50))
                    (list (make-task "Work" "Finishing shelving books in Snell" 15))
                    (list (make-task "Academic" "Finish HW9" 5))))
(check-expect (group-tasks-by-category LIST3)
              (list
               (list (make-task "Personal" "Do laundry this time" 20) (make-task "Personal" "Do laundry this time" 50))
               (list (make-task "Work" "Finishing shelving books in Snell" 10) (make-task "Work" "Finishing shelving books in Snell" 15))
               (list (make-task "Academic" "Finish HW9" 0) (make-task "Academic" "Finish HW9" 5))))
              
;; Code:
(define (group-tasks-by-category lot)
  (list
   (filter (lambda (x) (string=? (task-category x) PERSONAL)) lot)
   (filter (lambda (x) (string=? (task-category x) WORK)) lot)
   (filter (lambda (x) (string=? (task-category x) ACADEMIC)) lot)))
