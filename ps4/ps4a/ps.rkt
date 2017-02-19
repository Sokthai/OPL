#lang racket

;; BEFORE DOING THESE EXERCISES, READ
;; SICP Chapter 3, "Modularity, Objects, and State"
;; all the way through 3.2.3 "Frames as the Repository of Local State"
;; this means all of these sections:
;; 3  Modularity, Objects, and State
;;        3.1  Assignment and Local State
;;            3.1.1  Local State Variables
;;            3.1.2  The Benefits of Introducing Assignment
;;            3.1.3  The Costs of Introducing Assignment
;;        3.2  The Environment Model of Evaluation
;;            3.2.1  The Rules for Evaluation
;;            3.2.2  Applying Simple Procedures
;;            3.2.3  Frames as the Repository of Local State
;;
;; start here
;; https://mitpress.mit.edu/sicp/full-text/book/book-Z-H-19.html#%_chap_3
;;
;; or pp. 294-335 of the Github PDF of SICP.

;; Exercise 3.1
;; https://mitpress.mit.edu/sicp/full-text/book/book-Z-H-20.html#%_thm_3.1
;; 
;; After writing and testing the code, draw the environment diagram that would
;; result from evaluating the three statements in the exercise.
;; 
;; Include as ASCII drawing in this file, or upload image named
;; exercise3.1-env.png (or .jpg)

(define (make-accumulator balance)
  (lambda (amount)
      (begin (set! balance (+ balance amount)) balance) 
   )
  )

(define exercise-3.1-env #t)
;; change to #t after you include diagram

;; Exercise 3.2
;; https://mitpress.mit.edu/sicp/full-text/book/book-Z-H-20.html#%_thm_3.2
;;
;; After writing and testing the code, draw the environment diagram that would
;; result from evaluating the three statements in the exercise.
;; 
;; Include as ASCII drawing in this file, or upload image named
;; exercise3.2-env.png (or .jpg)

(define (make-monitored p)
  (let ([count 0])
    (lambda (input)
      (cond
        [(eq? input 'reset-count) (set! count 0)]
        [(eq? input 'how-many-calls?) count]
        [else (set! count (+ count 1))
                    (p input)])
      )
    )
  )

(define exercise-3.2-env #t)
;; change to #t after you include diagram


;; Exercise 3.3
;; https://mitpress.mit.edu/sicp/full-text/book/book-Z-H-20.html#%_thm_3.3
(define (make-account balance passwd)
  (define (withdraw amount)
    (if (>= balance amount)
        (begin (set! balance (- balance amount)) balance)
        "Insufficient funds"))
  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)
  (define (dispatch m passwdVerify)
    (cond
      [(not (eq? passwd passwdVerify)) (error "Incorrect password")]
      [(eq? m 'withdraw) withdraw]
      [(eq? m 'deposit) deposit]
      [else (error "Unknown request: MAKE-ACCOUNT" m)]))

  dispatch   
  )
                                       
;; Exercise 3.4
;; https://mitpress.mit.edu/sicp/full-text/book/book-Z-H-20.html#%_thm_3.4
;;
;; this procedure should be called "make-account-secure"
;;
;; important note:
;;   once an account is locked, you should not be able to withdraw funds
;;   from it, even if then using the correct password!
(define (make-account-secure balance passwd)
  (let ([attempt 0])
    (define (withdraw amount)
      (if (>= balance amount)
          (begin (set! balance (- balance amount)) balance)
          "Insufficient funds"))
    (define (deposit amount)
      (set! balance (+ balance amount))
      balance)
    (define (dispatch m passwdVerify)
      (cond
        [(>= attempt 7) (error (call-the-cops))]
        [(not (eq? passwd passwdVerify))
         (begin (set! attempt (+ attempt 1)) (error "Incorrect password"))]
        [(eq? m 'withdraw) withdraw]
        [(eq? m 'deposit) deposit]
        [else (error "Unknown request: MAKE-ACCOUNT" m)]))
    
  dispatch   )
  )
    
; don't modify this
(define (call-the-cops)
  "your account has been locked. please call customer service.")
  