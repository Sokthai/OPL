#lang racket

;; in all definitions, use lambda to create a procedure

;; exercise 1: procedure to square its argument
(define square
  (lambda (n)
   ( * n n)))

;; exercise 2: write absolute value using the if statement
(define abs-using-if
  (lambda (n)
    (if (< n 0) (* n -1) n)))
        

;; exercise 3: write absolute value using the cond statement
;; see documentation on cond in SICP,
;; section 1.1.6 Conditional Expressions and Predicates (p. 22)
(define abs-using-cond
  (lambda (n)
    (cond
      [(> n 0) n]
      [else (- n)])))

;; exercise 4: implement factorial (just copy in the given code)
;; use define syntax
(define (fact n)
  (if (= n 1)
      1
      (* n (fact (- n 1))))) ;copied from the given code in book (p.41)

;; exercise 5: implement num of combinations of n things taken k at a time,
;; which is n! / k!(n - k)! 
(define comb
  (lambda (n k)
    (/ (fact n)
       (* (fact k) (fact (- n k))))))

;; exercise 6: triple its argument
(define triple
  (lambda (n)
    (* n 3)))

;; exercise 7: diff-of-triples
;; should return the first arg tripled minus the second arg tripled
(define diff-of-triples
  (lambda (n m)
    (- (triple n) (triple m))))

;; exercise 8: smallest-of-three
;; returns smallest of three args
;; you may Not use the "min" function
;; you may use the boolean "and" function
(define smallest-of-three
  (lambda (a b c)
    (cond
      [(and (<= a b) (<= a c)) a]
      [(and (<= b a) (<= b c)) b]
      [else c])))
      

;; exercise 9: smallest-tripled
;; returns tripled value of smallest arg
(define smallest-tripled
  (lambda (a b c)
    (* (smallest-of-three a b c) 3)))

;; exercises below adapted from Jay McCarthy
;; https://jeapostrophe.github.io/courses/2016/fall/301/course/basic.html

;; exercise 10: sum-coins
;; complete the procedure sum-coins, which calculates the amount of money
;; given number of pennies, nickels, dimes, and quarters
(define sum-coins
  (lambda (pennies nickels dimes quarters)
    (+ pennies (* nickels 5) (* dimes 10) (* quarters 25)))) ; to dollar

;; exercise 11: surface area of cylinder
;; complete the procedure area-cylinder, which calculates the surface area of a cylinder
;; see http://www.google.com/search?q=surface+area+of+cylinder
;; use the symbol pi for the value of pi in your code (it's defined already for you)
(define area-cylinder
  (lambda (base-radius height)
    (+ (* 2 pi base-radius height) (* 2 pi (square base-radius)))))