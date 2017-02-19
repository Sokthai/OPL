#lang racket
;ps3d
;; last modified Sat Feb 20 15:45:14 2016 fredm@cs.uml.edu

;; +++++++++++++++ Required for auto grading ++++++++++++++++++++++++++++
(define nil '())
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++



;; **********************************************************************
;;
;; 2. Consider the following procedure for operating on trees:
(define (tree-manip tree init leaf accum) 
  (cond ((null? tree) init) 
        ((not (pair? tree)) (leaf tree)) 
        (else (accum  
               (tree-manip (car tree) init leaf accum) 
               (tree-manip (cdr tree) init leaf accum)))))

;; Suppose that we provide a test tree, 
(define test-tree '(1 (2 (3 (4) 5) 6) 7))
;;
;; 2a. Write the parameters to tree-manip that will count the number
;;     of leaves in the tree, evaluating to 7 for test-tree; e.g.:
;;     (tree-manip test-tree <param1> <param2> <param3>). (Figure out
;;     the three parameters.)
;;
;; 2b. Write the parameters to tree-manip that will add the values of
;;     the leaves in the tree, evaluating to 28 for test-tree.
;;
;; 2c. Write the parameters to tree-manip that will triple each of the
;;     values in test-tree, evaluating to (3 (6 (9 (12) 15) 18) 21).

;; Answer:
;2a.
(define (count-leaves tree) 
  (tree-manip tree 0 (lambda (x) (/ x x)) +)
 
  )

;2b.
(define (sum-leaves tree)
  (tree-manip tree 0 (lambda (x) x) +)
  )

;2c.
(define (triple-leaves tree) 
  (tree-manip tree nil (lambda (x) (* x 3)) cons)
 )

;; **********************************************************************
;; 
;; 3. SICP exercise 2.35 (pp. 120), another way of implementing
;; count-leaves as an accumulation.  Fill in the below procedure.
;;
;; uncomment line starting with "foldl" and replace with answer



(define (count-leaves-with-map t)
  (foldl + 0 (map (lambda (x) (if (list? x) (count-leaves  x) 1)) t))  
)
;; not the right answer :)


;; **********************************************************************
;;
;; 4. Using flip, negate, and compose.
;;
;;     4a. Define and play with the functions flip, negate, and
;;     compose, as they are defined below.
;;
;;     4b. Define, for instance, a flipped cons function and a flipped
;;     minus function.
;;
;;     4c. Define the function odd? in terms of even? and negate.

(define (flip f)
  (lambda (x y)
    (f y x)))

(define (negate p)
  (lambda (x) 
    (if (p x) #f #t)))

(define (compose f g)
  (lambda (x)
    (f (g x))))

;;Answer:
;3.b 
(define (flip-cons lst1 lst2)
  
  ((flip (lambda (a b) (list a b))) lst1 lst2)
 )

(define (flip-minus x y)  ;what does flip-minus do?
  ((flip -) x y)
 )

;3.c
(define (flip-odd x)
  ((negate even?) x) 
 )

;; **********************************************************************
;; 
;; 5. SICP exercise 2.38 (pp. 121), introducing fold-right and fold-left.
;; https://mitpress.mit.edu/sicp/full-text/book/book-Z-H-15.html#%_thm_2.38
;;
;; Write the defintion for fold-right (hint: Answer to fold-right is
;; in the question. Read the question carefully)
;;
;; Write down each step of substitution in comment line for each of
;; the following.
;;
;; What are the values of
;(fold-right / 1 (list 1 2 3))
;(fold-left / 1 (list 1 2 3))
;(fold-right list nil (list 1 2 3))
;(fold-left list nil (list 1 2 3))

;; Answer the following:
;; Given in the question that accumulate is also known as fold-right. So,
(define (fold-right op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (fold-right op initial (cdr sequence))))
  )

(define (fold-left op initial sequence)
  (define (iter result rest)
    (if (null? rest)
        result
        (iter (op result (car rest))
              (cdr rest)))
    )
  
  (iter initial sequence)
  )

;(fold-right / 1 (list 1 2 3))
;(/ 1 (fold-right / 1 (list 2 3)))
;(/ 1 (/ 2 (fold-right / 1 (list 3))))
;(/ 1 (/ 2 (/ 3 (fold-right / 1 (list nil)))))
;(/ 1 (/ 2 (/ 3 1)))
;(/ 1 (/ 2 3))
;(/ 1 2/3)
;3/2

;(fold-left / 1 (list 1 2 3))
;(iter 1 (list 1 2 3))
;(iter (/ 1 1) (list 2 3))
;(iter (/ 1 2) (list 3))
;(iter (/ 0.5 3) (list nil))
;1/6

;(fold-right list nil (list 1 2 3))
;(list 1 (fold-right list nil (list 2 3)))
;(list 1 (list 2 (folder-right list nil (list 3))))
;(list 1 (list 2 (list 3 (fold-right list nil (list nil)))))
;(list 1 (list 2 (list 3 nil)))
;'(1 (2 (3 ())))

;(fold-left list nil (list 1 2 3))
;(iter nil (list 1 2 3))
;(iter (list nil 1) (list 2 3))
;(iter (list (list nil 1) 2) (list 3))
;(iter (list (list (list nil 1) 2) 3) (list nil))
;(list (list (list nil 1) 2) 3) 
;'(((() 1) 2) 3)

;; Which property must op should satisfy to guarantee that fold-right
;; and fold-left will produce the same values for any sequence?
;;
;; uncomment the correct answer
;; note: answer to this question is not autograded locally
;;
 (define fold-property 'commutative)
;; (define fold-property 'associative)
;; (define fold-property 'distributive)



;; **********************************************************************
;; 
;; 6. Use fold-right to define the function bucket. 
;;
;; It consumes a list of numbers, and returns a list of sublists of
;; adjacent equal numbers.
;;
;; For example:
;; (bucket '(1 1 2 2 2 3 1 1 1 2 3 3)) –> 
;;  '((1 1) (2 2 2) (3) (1 1 1) (2) (3 3))
;;
;; PLEASE NOTE
;; it's trivial to find the answer for this on the internet
;; please do not succumb
;; you won't learn very much unless you struggle with it
;;
;; think about each of the two objects that are consumed by the 
;; folding function as the fold proceeds
;;
;; and think about what sort of object should be produced by that
;; function 
;; 
;; for full credit on this, show your work,
;; including partial / broken solutions and explanations
;;
;; Fill in the below procedure
;; 
(define (bucket lst)
  (fold-right (lambda (x p)
                (if (null?  p) (list (list x))
                    (if (= x  (car (car p)))
                        ;(if (null? (rest p))
                         ;   (list (append (list x) (car p)))
                            (append (list (append (list x) (car p))) (rest p)) 
                         ;)
                        (append (list (list x))  p))
                ))
  
     nil lst)

 );
;; ************************ END OF FILE *********************************
