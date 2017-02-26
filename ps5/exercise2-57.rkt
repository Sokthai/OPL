#lang racket

;; Exercise 2.57 on pp. 151.
;; Extend the differentiator to handle sums and products of length 2+.

;; You will need to change the following procedures:
;; make-sum
;; augend
;; make-product
;; multiplicand

(define (variable? x) (symbol? x))

(define (same-variable? v1 v2)
  (and (variable? v1) (variable? v2) (eq? v1 v2)))

(define (=number? exp num)
  (and (number? exp) (= exp num)))

;; per dotted-tail procedure notation, second and subsequent args
;; will get made into a list and provided in "augend"
;;
;; the constructor should deal with three cases:
;; [augend empty]    a  (make-sum 'x) is 'x
;; [augend length 1] d  (make-sum 'x 3) is '(+ x 3)
;;                   c  (make-sum 'x 0) is 'x
;;                   b  (make-sum 1 2) is 3
;; [augend is 2+]    e  (make-sum 'x 'y 'z) is '(+ x y z)
;;
;; the code for the length 1 case is quite similar to the original
;; implementation; you should bring it in and modify it


  (define (length elements)
    (if (null? elements) 0
        (+ 1 (length (cdr elements)))))  

(define (make-sum a1 . augend) ;augend is the list (after dot)

;
;  (cond
;    [(null? augend) a1] ;if null, return a1
;    [(= (length augend) 1) (cond ;length 1 case
;                            [(=number? a1 0) (car augend)]
;                            [(=number? augend 0) a1]
;                            [(and (number? a1) (number? (car augend))) (+ a1 (car augend))]
;                            [else (list '+ a1 (car augend))])]
;     
;    [(> (length augend) 1) (cond ;length 1 case
;                            [(=number? a1 0) (append (list '+) (addNumber augend))]
;                            [(and (= (length (addNumber augend)) 1) (number? a1) (number? (car (addNumber augend)))) 
;                                        (+ a1 (car (addNumber augend)))]
;                            [(and (> (length (addNumber augend)) 1) (number? a1) (number? (car (addNumber augend)))) 
;                                        (append (list (+ a1 (car (addNumber augend)))) (cdr (addNumber augend)))]
;                            [else (append (list '+ a1)  (addNumber augend))]
;                            )
;                           ] 
;  )
2
  )
    
  
(define (addNumber lst)
  (if (= (length lst) 1) (car lst)
      (cond
        [(not (pair? (car lst))) (cond ;set up a list 
                                   [(and (number? (car lst)) (number? (cadr lst))) (addNumber (append (list (list (* (car lst) (cadr lst)))) (rest (cdr lst))))] ;both #
                                   [(and (variable? (car lst)) (variable? (cadr lst))) (addNumber (append (list (list (car lst) (cadr lst))) (rest (cdr lst))))] ;both symbol
                                   [(and (number? (car lst)) (variable? (cadr lst))) (addNumber (append (list (list (car lst) (cadr lst))) (rest (cdr lst))))] ; first #, second symbol
                                   [(and (variable? (car lst)) (number? (cadr lst))) (addNumber (append (list (list (cadr lst) (car lst))) (rest (cdr lst))))])] ;first symbol, second #
        
        [(variable? (cadr lst)) (addNumber (append (list (append (car lst) (list (cadr lst)))) (rest (cdr lst))))] ;if second is symbol

        [(number? (cadr lst)) (if (number? (fcar lst)) 
                                (addNumber (append (list (append (list (* (fcar lst) (cadr lst))) (fcdr lst) )) (rest (cdr lst))))
                                ;lst
                                (addNumber (append (list (append (list (cadr lst)) (car lst) )) (rest (cdr lst))))   
                                )] ;both #
        
        )
  )
  
  )
  
(define (fcar lst)
  (car (car lst)))
(define (fcdr lst)
  (cdr (car lst)))

(define (sum? x)
  (and (pair? x) (eq? (car x) '+)))

(define (addend s) (cadr s))

;; you're allowed to have augend also be a constructor
;; you will need to test for the length of the augend, and do
;; something different the length=1 case and length is 2+ case. 
(define (augend lst)
 (if (= (length lst) 1) (car lst)
      (cond
        [(not (pair? (car lst))) (cond ;set up a list 
                                   [(and (number? (car lst)) (number? (cadr lst))) (addNumber (append (list (list (+ (car lst) (cadr lst)))) (rest (cdr lst))))] ;both #
                                   [(and (variable? (car lst)) (variable? (cadr lst))) (addNumber (append (list (list (car lst) (cadr lst))) (rest (cdr lst))))] ;both symbol
                                   [(and (number? (car lst)) (variable? (cadr lst))) (addNumber (append (list (list (car lst) (cadr lst))) (rest (cdr lst))))] ; first #, second symbol
                                   [(and (variable? (car lst)) (number? (cadr lst))) (addNumber (append (list (list (cadr lst) (car lst))) (rest (cdr lst))))])] ;first symbol, second #
        
        [(variable? (cadr lst)) (addNumber (append (list (append (car lst) (list (cadr lst)))) (rest (cdr lst))))] ;if second is symbol

        [(number? (cadr lst)) (if (number? (fcar lst)) 
                                (addNumber (append (list (append (list (+ (fcar lst) (cadr lst))) (fcdr lst) )) (rest (cdr lst))))
                                ;lst
                                (addNumber (append (list (append (list (cadr lst)) (car lst) )) (rest (cdr lst))))   
                                )] ;both #
        
        )
  )
  )

;; like make-sum, this should work with 1, 2, or 3+ args
;; and perform reductions on 1 and 2 arg cases
(define (make-product a1 . augend)
 (cond
    [(null? augend) a1] ;if null, return a1
    [(= (length augend) 1) (cond ;length 1 case
                            [(=number? a1 0) (car augend)]
                            [(=number? augend 0) a1]
                            [(and (number? a1) (number? (car augend))) (* a1 (car augend))]
                            [else (list '+ a1 (car augend))])]
     
    [(> (length augend) 1) (cond ;length 1 case
                            [(=number? a1 0) (append (list '*) (addNumber augend))]
                            [(and (= (length (addNumber augend)) 1) (number? a1) (number? (car (addNumber augend)))) 
                                        (* a1 (car (addNumber augend)))]
                            [(and (> (length (addNumber augend)) 1) (number? a1) (number? (car (addNumber augend)))) 
                                        (append (list (* a1 (car (addNumber augend)))) (cdr (addNumber augend)))]
                            [else (append (list '* a1)  (addNumber augend))]
                            )
                           ] 
  )
  )

(define (product? x) (and (pair? x) (eq? (car x) '*)))

(define (multiplier p) (cadr p))

;; may also construct a product expression
(define (multiplicand p)
  'z)

;;; differentiation for exponents
(define (make-exponentiation x y)
  (cond ((= y 0) 1)
	((= y 1) x)
	(else (list '** x y))))

(define (exponentiation? x)
  (and (pair? x) (eq? (car x) '**)))

(define (base x) (cadr x))

(define (exponent x) (caddr x))

;;; deriv including exponentiation

(define (deriv exp var)
  (cond ((number? exp) 0)
	((variable? exp)
	 (if (same-variable? exp var) 1 0))
	((sum? exp)
	 (make-sum (deriv (addend exp) var)
		   (deriv (augend exp) var)))
	((product? exp)
	 (make-sum 
	  (make-product (multiplier exp)
			(deriv (multiplicand exp) var))
	  (make-product (deriv (multiplier exp) var)
			(multiplicand exp))))
	((exponentiation? exp)
	 (make-product (exponent exp)
		       (make-product (make-exponentiation (base exp) 
							  (- (exponent exp) 1))
				     (deriv (base exp) var))))
	(else
	 (error "unknown expression type -- DERIV" exp))))


;; Don't remove the equation definitions.
(define equation1
  (make-product 'x
                'y
                (make-sum 'x 3))) ; i.e., ((x^2)y + 3xy) dx

(define equation2
  (make-sum (make-product 5 (make-exponentiation 'x 3))
            (make-product 7 (make-exponentiation 'x 2))
            (make-product -3 'x)
            12)) ;; 5x^3 + 7x^2 - 3x + 12







;(define (make-sum a1 . augend) ;augend is the list (after dot)
;
;  (define (length elements)
;    (if (null? elements) 0
;        (+ 1 (length (cdr elements)))))
;  (cond
;    [(null? augend) a1] ;if null, return a1
;    [(and (= (length augend) 1) (number? (car augend)) (number? a1)) (+ a1 (car augend))]
;    [(and (= (length augend) 1) (=number? (car augend) 0)) a1]
;    [(and (= (length augend) 1) (number? (car augend)) (not (= (car augend) 0))) (list '+ a1 augend)]
;    [(and (> (length augend) 1) 
;    
;    [(and (= (length augend) 1) (=number? (car augend))) a1]
;    [(and (number? a1) (number? augend)) (+ a1 augend)]
;    [(variable? a1) (list '+ a1 augend)]
;    [else "invalid"]
;         )
;  )