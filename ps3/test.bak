#lang racket
;(define (<name> a b)
;  (if (> a b) 0
;      (+ (<term> a) (<name> (<next> a)))))
;
;(define (sum term a next b)
;  (if (> a b) 0
;      (+ (define (inc n) (+ n 1))
;         (define (sum-cubes a b) (sum cube a inc b)))))



(define (identity x) x)
(define (cube n) (* n n n))
(define (inc n) (+ n 1))




(define (sum term a next b)
  (if (> a b) 0
      (+ (term a)
         (sum term (next a) next b)))) 
;----------------

;(define (sum term a next b)
;   (define (iter a result)
;     (if (> a b) result (iter (next a) (+ (term a) result)))
;   )
;   (iter a 0)
;)



;-------------------

(define (product1 term a next b) 
  (if (> a b) 1
      (* (term a)
         (product1 term (next a) next b)))
 ) 


;-------------------
;; factorial procedure in terms of product
(define (factorial n)
  (product1 identity 1 inc n)
 ) 



(define (product2 term a next b)
 (define (iter a result)
     (if (> a b) result (iter (next a) (* (term a) result)))
   )
   (iter a 1)
  )
;---------------

(define (sum-cubes a b)
  (sum cube a inc b))


;-----------------

(define (sum-integer a b)
  (sum identity a inc b))

;-----------------
(define (product-integer a b)
  (product1 identity a inc b))


;--------------
(define (pi-sum a b)
  (define (pi-term x)(/ 1 (* x (+ x 2))))
  (define (pi-next x)(+ x 4))
  (sum pi-term a pi-next b))




(define (list-ref items n)
  (if (= n 0)
      (car items)
      (list-ref (cdr items) (- n 1))))
(define squars (list 1 4 9 16 25))





(define (accumulate combiner null-value term a next b)
     (if (> a b) null-value
      (combiner (term a)
          (accumulate combiner null-value term (next a) next b)))
 )


(define (sum1 term a next b)
  (accumulate1 + 0 term a next b)
)

(define (product term a next b)
  (accumulate1 * 1 term a next b)
)

(define (mySum a b)
  (product identity a inc b))

(define (myProduct a b)
  (sum1 identity a inc b))



(define (accumulate1 combiner null-value term a next b)
   (define (iter a result)
     (if (> a b) result
         (iter (next a) (combiner (term a) result)))
   )
   (iter a null-value)
 )


;(define (expnt-iter n)
;  (cond
;    [(= n 0) (lambda(x) 1)]
;    [(= n 1) (lambda(x) x)]
;    [else
;       (lambda (x) ((expnt-iter (- n 1)) (* x x) ))
;    ]
;  )
;)

(define (expnt-iter n)
  (cond
    ((= n 0) (lambda (x) 1))
    ((= n 1) (lambda (x) x))
    (else
         (lambda (x) ((expnt-iter (- n 1)) (* x x))))))












    

