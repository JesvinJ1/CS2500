;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname hw10) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

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

;;! HW10
;; Consider the following data definition for binary trees:

(define-struct leaf [val])
(define-struct node [left right])

;; A [BinTree-of X] is one of:
;; - (make-leaf X)
;; - (make-node [BinTree-of X] [BinTree-of X])
;; Interpretation - a binary tree of values of type X which is either:
;; - a leaf containing a value
;; - or a node containing two binary trees

;; The goal of this homework will be to write abstractions for working with
;; binary trees, similar to the list abstractions you are familiar with.

;;! Problem 1

;;! Part A
;; Finish the data design for BinTree by writing examples and a template.

;;!! IMPORTANT: Write your response BELOW this line:
;; Examples:
(define BT0 (make-leaf "Jesvin"))
(define BT1 (make-leaf "Jerry"))
(define BT2 (make-node BT0 BT1))
(define BT3 (make-leaf 1))
(define BT4 (make-leaf 2))
(define BT5 (make-node BT3 BT4))

;; Template:
(define (bt-temp bt)
  (cond [(leaf? bt) (... (leaf-val bt) ...)]
        [(node? bt) (... (bt-temp (node-left bt))
                         (bt-temp (node-right bt)))]))

;;! Part B
;;
;; Design a function called tree-zero that takes a binary tree and replaces all
;; leaf values with 0; the structure of the tree should remain the same.

;;!! IMPORTANT: Write your response BELOW this line:
;; Signature: tree-zero : [BinTree-of X] -> [BinTree-of Number]
;; Purpose Statement: the function takes in a binary tree and replaces all the leaf
;; values with 0, maintaining the structure of the tree
;; Tests:
(check-expect (tree-zero (make-leaf 5)) (make-leaf 0))
(check-expect (tree-zero BT5) (make-node (make-leaf 0) (make-leaf 0)))
(check-expect (tree-zero BT2) (make-node (make-leaf 0) (make-leaf 0)))
;; Code:
(define (tree-zero bt)
  (cond [(leaf? bt) (make-leaf 0)]
        [(node? bt) (make-node (tree-zero (node-left bt))
                               (tree-zero (node-right bt)))]))

;;! Part C
;;
;; Design a function tree-contains? that takes a String and a [BinTree-of
;; String] that returns whether the String exists as a leaf.

;;!! IMPORTANT: Write your response BELOW this line:
;; Signature: tree-contains? : String [BinTree-of String] -> Boolean
;; Purpose Statement: the function takes a string and checks to see if
;; that string is contained as a leaf
;; Tests:
(check-expect (tree-contains? "FUNDIES" (make-node (make-leaf "fund") (make-leaf "FUNDIES"))) #t)
(check-expect (tree-contains? "Jesvin" BT2) #t)
(check-expect (tree-contains? "JJerry" BT2) #f)

;; Code:
(define (tree-contains? str bts)
  (cond [(leaf? bts) (string=? (leaf-val bts) str)]
        [(node? bts) (or (tree-contains? str (node-left bts))
                         (tree-contains? str (node-right bts)))]))

;;! Part D
;;
;; Design a function tree-sum that takes a [BinTree-of Number] and returns the
;; sum of all the numbers in the tree.


;;!! IMPORTANT: Write your response BELOW this line:
;; Signature: tree-sum : [BinTree-of Number] -> Number
;; Purpose Statement: the function takes in a binary tree of number
;; and then returns the sum of all the numbers in the tree. 
;; Tests:
(check-expect (tree-sum BT5) 3)
(check-expect (tree-sum (make-node (make-leaf 21) (make-leaf 20))) 41)
(check-expect (tree-sum (make-node (make-leaf 21)
                                   (make-node (make-leaf 15) (make-leaf 15)))) 51)
;; Code:
(define (tree-sum btn)
  (cond [(leaf? btn) (leaf-val btn)]
        [(node? btn) (+ (tree-sum (node-left btn))
                        (tree-sum (node-right btn)))]))

;;! Part E
;;
;; While trees have more structure, like lists, they still contain elements. To
;; demonstrate this similarity, design a function called tree-flatten that takes
;; a binary tree and converts it into a list. When flattening a node, the resulting list
;; should contain all leaves on the left side of the node before the leaves
;; on the right side of the node.

;; For example, the flattening the tree below should result in `(list 1 2 3 4 5 6)`:
;;           *
;;          / \
;;         *   6
;;        / \
;;       1   *
;;          / \
;;         *   5
;;        / \
;;       *   4
;;      / \
;;     2   3

;;!! IMPORTANT: Write your response BELOW this line:
;; Signature: tree-flatten : [BinTree-of X] -> ListOf X
;; Purpose Statement: the function takes a binary tree and then converts it
;; into a list, with the left side nodes coming before the right in the list
;; Tests:
(check-expect (tree-flatten (make-leaf 5)) (list 5))
(check-expect (tree-flatten (make-node (make-leaf 21)
                                       (make-node (make-leaf 15) (make-leaf 16)))) (list 21 15 16))
(check-expect (tree-flatten (make-node
                             (make-node (make-leaf 21) (make-leaf 30))
                             (make-node (make-leaf 15) (make-leaf 16)))) (list 21 30 15 16))
;; Code:
(define (tree-flatten bt)
  (cond [(leaf? bt) (list (leaf-val bt))]
        [(node? bt) (append (tree-flatten (node-left bt))
                            (tree-flatten (node-right bt)))]))

;;! Part F

;; INTERPRETIVE QUESTION
;;
;; In some families -- maybe including yours -- people want to be able to
;; understand who their ancestors are and how they're related to their them.
;;
;; Family trees can be useful for that purpose. Family trees represent familial
;; relationships in certain ways. For example, a node represents a parent, and a
;; child represents... well, a child.
;;
;; Often, but not always, family trees represent (a) legally-recognized
;; relationships and (b) relationships in which the children are directly
;; genetically related to their parents. That means that children (or parents!)
;; resulting from any sort of relationship that doesn't meet both conditions (a)
;; and (b) might not be included in a family tree.
;;
;; Over time, ideas about what a "family" is, and about which familial relations
;; should be openly acknowledged and documented have changed. That means that a
;; family tree is both a "biological" record and a cultural one. Determining
;; citizenship (who is a citizen of a nation? who can apply for citizenship
;; based on family relationships?), finances (whose debts are you responsible
;; for paying?), medical decision-making authority (what decisions can someone
;; make on someone else's behalf?), and inheritance (who will automatically
;; inherit if there is no will?) all depend on definitions of who counts as
;; "family" or "relatives".
;;
;; As a result, decisions about who is a member of a family doesn't have only
;; emotional and psychological consequences; it also has political and legal
;; ones. Someone might be subjected to harms or eligible for benefits depending
;; on whether a law or policy considers them to be part of "the same family" as
;; someone else. What our language means, therefore, is quite important.
;;
;; If you had to design a data definition for a family tree, what kinds of
;; relation do you think it should represent? In other words, what counts as
;; "being part of the same family"? Please include a justification of your
;; answer in 2 - 3 sentences.

;; In order to create a data defintion for a family tree I would include
;; biological relationships, like the parents child and siblings, and I would
;; include offical legal relationships, such as adopting. The reason for this is because
;; it would make sure that the genetic ties of the family are represented in addition
;; to the actual legally tied ones. As mentioned this is what is important when it comes
;; to future legal matters or such. 


;;! Problem 2

;;! Part A
;;
;; Design a function called tree-map that takes a function and a binary tree and
;; applies the function to each value in the tree. The function should return a
;; new tree with the same structure as the original tree, but with the values
;; replaced by the result of applying the function to the value that was
;; originally there.

;;!! IMPORTANT: Write your response BELOW this line:
;; Signature: tree-map : (X -> Y) [BinTree-of X] -> [BinTree-of Y] 
;; Purpose Statement: the function applies a function to each value in a
;; binary tree and then returns a new tree with the applied function to
;; each value
;; Tests:
(check-expect (tree-map zero? BT5) (make-node (make-leaf #f) (make-leaf #f)))
(check-expect (tree-map even? BT5) (make-node (make-leaf #f) (make-leaf #t)))
(check-expect (tree-map odd? BT5) (make-node (make-leaf #t) (make-leaf #f)))
(check-expect (tree-map (lambda (x) (+ x 1)) (make-leaf 3)) (make-leaf 4))
;; Code:
(define (tree-map fn bt)
  (cond [(leaf? bt) (make-leaf (fn (leaf-val bt)))]
        [(node? bt) (make-node (tree-map fn (node-left bt))
                               (tree-map fn (node-right bt)))]))

;;! Part B
;;
;; Design a function called tree-andmap that takes a predicate and determines whether all values in the
;; tree satisfy the predicate.

;;!! IMPORTANT: Write your response BELOW this line:
;; Signature: tree-andmap : (X -> Boolean) [BinTree-of-X] -> Boolean
;; Purpose Statement: the function takes in a predicate and checks to see
;; if all the values inside the binary tree satisfy the predicate
;; Tests:
(check-expect (tree-andmap zero? BT5) #f)
(check-expect (tree-andmap (lambda (x)
                             (> x 0))
                           (make-node (make-leaf 1) (make-node (make-leaf 2) (make-leaf 3)))) #t)
(check-expect (tree-andmap (lambda (x)
                             (> x 1))
                           (make-node (make-leaf 1) (make-node (make-leaf 2) (make-leaf 3)))) #f)
;; Code:
(define (tree-andmap pred bt)
  (cond [(leaf? bt) (pred (leaf-val bt))]
        [(node? bt) (and (tree-andmap pred (node-left bt))
                         (tree-andmap pred (node-right bt)))]))

;;! Part C
;;
;; Design a function called tree-ormap that takes a predicate and determines whether any values in the
;; tree satisfy the predicate.

;;!! IMPORTANT: Write your response BELOW this line:
;; Signature: tree-ormap : (X -> Boolean) [BinTree-of-X] -> Boolean
;; Purpose Statement: the function takes a predicate and checks to see if
;; any of the values in the tree satisfy the predicate given
;; Tests:
(check-expect (tree-ormap zero? BT5) #f)
(check-expect (tree-ormap (lambda (x)
                            (> x 0))
                          (make-node (make-leaf 0) (make-node (make-leaf 1) (make-leaf 3)))) #t)
(check-expect (tree-ormap (lambda (x)
                            (> x 1))
                          (make-node (make-leaf 1) (make-node (make-leaf 2) (make-leaf 3)))) #t)
;; Code:
(define (tree-ormap pred bt)
  (cond [(leaf? bt) (pred (leaf-val bt))]
        [(node? bt) (or (tree-ormap pred (node-left bt))
                        (tree-ormap pred (node-right bt)))]))

;;! Part D

;; Design a function tree-fold that acts like a fold over a tree. This takes in a function
;; to apply to leaf values, and a function to combine the results of folding subtrees.
;; These two functions should be used to compress a given tree down to
;; a single resulting value. It should have the following signature:

;; tree-fold : (X -> Y) (Y Y -> Y) [BinTree-of X] -> Y

;; where `(X -> Y)` is the function for the leaf, and
;; `(Y Y -> Y)` is the function to combine the results of folding subtrees.

;; A test is provided for clarity.

(check-expect (tree-fold string-upcase string-append
                         (make-node (make-leaf "hello") (make-leaf "world"))) "HELLOWORLD")

;;!! IMPORTANT: Write your response BELOW this line:
;; Signature: tree-fold : (X -> Y) (Y Y -> Y) [BinTree-of X] -> Y
;; Purpose Statement: the function takes in a function and applies it to the leaf
;; values and another function combine the results of folding subtrees, then compresses
;; the tree down into a single value
;; Tests:
(check-expect (tree-fold string-upcase string-append
                         (make-node (make-leaf "hello") (make-leaf "world"))) "HELLOWORLD")
(check-expect (tree-fold string-upcase string-append
                         (make-node (make-leaf "jesvin") (make-leaf "Jerry"))) "JESVINJERRY")
(check-expect (tree-fold identity + 
                         (make-node (make-leaf 1) (make-node (make-leaf 2) (make-leaf 3)))) 6)
;; Code:
(define (tree-fold pred combine bt)
  (cond [(leaf? bt) (pred (leaf-val bt))]
        [(node? bt) (combine (tree-fold pred combine (node-left bt))
                           (tree-fold pred combine (node-right bt)))]))

;;! Problem 3
;; Now we will use the tree-abstractions we defined in Problem 2 to reimplement the solutions in
;; Problem 1

;;! Part A
;;
;; Reimplement the tree-zero function using tree abstractions from problem 2; call it `tree-zero/v2`

;;!! IMPORTANT: Write your response BELOW this line:
;; Signature: tree-zero/v2 : [BinTree-of X] -> [BinTree-of Number]
;; Purpose Statement: the function takes in a binary tree and replaces all
;; the values with 0
;; Tests:
(check-expect (tree-zero/v2 BT5) (make-node (make-leaf 0) (make-leaf 0)))
(check-expect (tree-zero/v2 BT2) (make-node (make-leaf 0) (make-leaf 0)))
(check-expect (tree-zero/v2 (make-leaf 5)) (make-leaf 0))
;; Code:
(define (tree-zero/v2 bt)
  (tree-map (lambda (x) 0) bt))

;;! Part B
;;
;; Reimplement the tree-contains? function using tree abstractions from problem 2; call it `tree-contains?/v2`.

;;!! IMPORTANT: Write your response BELOW this line:
;; Signature: tree-contains?/v2 : String [BinTree-of String] -> Boolean
;; Purpose Statement: the function checks to see if the tree contains
;; the given string
;; Tests:
(check-expect (tree-contains?/v2 "Jesvin" BT2) #t)
(check-expect (tree-contains?/v2 "JESVIN" BT2) #f)
(check-expect (tree-contains?/v2 "FUNDIES" (make-node (make-leaf "fund") (make-leaf "FUNDIES"))) #t)
;; Code:
(define (tree-contains?/v2 str bt)
  (tree-ormap (lambda (x)
                (string=? x str)) bt))

;;! Part C
;;
;; Reimplement the tree-sum function using tree abstractions from problem 2; call it `tree-sum/v2`.

;;!! IMPORTANT: Write your response BELOW this line:
;; Signature: tree-sum/v2 : [BinTree-of Number] -> Number
;; Purpose Statement: the function takes a binary tree of numbers and then
;; returns the sum of all the numbers in the tree
;; Tests:
(check-expect (tree-sum/v2 BT5) 3)
(check-expect (tree-sum/v2 (make-node (make-leaf 2) (make-leaf 5))) 7)
(check-expect (tree-sum/v2 (make-node
                            (make-node (make-leaf 5) (make-leaf 6))
                            (make-node (make-leaf 1) (make-leaf 2)))) 14)
;; Code:
(define (tree-sum/v2 btn)
  (tree-fold identity + btn))

;;! Part D
;;
;; Reimplement the tree-flatten function using tree abstractions from problem 2;
;; call it `tree-flatten/v2`.

;;!! IMPORTANT: Write your response BELOW this line:
;; Signature: tree-flatten/v2 : [BinTree-of X] -> ListOf X
;; Purpose Statement: the function takes a binary tree and then converts it into
;; a list and having the left side of the node come before the leaves on the right side
;; Tests:
(check-expect (tree-flatten/v2 (make-leaf 5)) (list 5))
(check-expect (tree-flatten/v2 (make-node (make-leaf 21)
                                       (make-node (make-leaf 15) (make-leaf 16)))) (list 21 15 16))
(check-expect (tree-flatten/v2 (make-node
                             (make-node (make-leaf 21) (make-leaf 30))
                             (make-node (make-leaf 15) (make-leaf 16)))) (list 21 30 15 16))
;; Code:
(define (tree-flatten/v2 bt)
  (tree-fold (lambda (x)
               (list x)) append bt))
