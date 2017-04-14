#lang racket
;ps7a
;;; +++++++++ Required for auto grading ++++++++++++

;; Allow name nil to be used for the empty list.
(define nil '()) 			

;; Some other constants with non-traditional names:
(define true #t)
(define false #f)

;; For stream programming section 3.5
;; We use a force and delay which are slightly
;; different from the force and delay defined in the book:
;; delay (aka make-promise) handles recursive forcing.

(define the-empty-stream '())
(define stream-null? null?)
(define stream-car car)
(define (stream-cdr s)
  (force (cdr s)))

(define-syntax cons-stream
  (syntax-rules ()
    ((_ head tail)
     (cons head (delay tail)))))

(define (stream-ref a n)
  (if (= n 0)
      (stream-car a)
      (stream-ref (stream-cdr a) (- n 1))))

(define (stream-map proc s)
  (if (stream-null? s)
      the-empty-stream
      (cons-stream (proc (stream-car s))
                   (stream-map proc (stream-cdr s)))))

; Following is the general stream-map from Exercise 3.50
(define (stream-map-general proc . argstreams)
  (if (stream-null? (car argstreams))
      the-empty-stream
      (cons-stream 
       (apply proc (map stream-car argstreams))
       (apply stream-map-general (cons proc (map stream-cdr argstreams))))))

(define (stream-for-each proc s)
  (if (stream-null? s)
      the-empty-stream
      (begin (proc (stream-car s))
             (stream-for-each proc (stream-cdr s)))))

(define (stream-filter pred stream)
  (cond ((stream-null? stream) the-empty-stream)
        ((pred (stream-car stream))  
         (cons-stream (stream-car stream)
                      (stream-filter pred
                                     (stream-cdr stream))))
        (else (stream-filter pred (stream-cdr stream)))))

(define (display-stream s)
  (stream-for-each display-line s))

(define (display-line x)
  (newline)
  (display x))

(define (stream-enumerate-interval low high)
  (if (> low high)
      the-empty-stream
      (cons-stream
       low
       (stream-enumerate-interval (+ low 1) high))))

(define (integers-starting-from n)
  (cons-stream n (integers-starting-from (+ n 1))))

(define integers (integers-starting-from 1))

(define (add-streams s1 s2)
  (stream-map-general + s1 s2))

(define (stream->list stream)
            (if (stream-null? stream)
                '()
                (cons (stream-car stream)
                      (stream->list (stream-cdr stream)))))

;;; *******************************************************************
;;; Use stream-map (pp. 320 of textbook) to define a procedure called
;;; convert-temps that takes a stream of temperatures in Fahrenheit
;;; and returns a stream of converted temperatures in Celsius. Recall
;;; that to convert Fahrenheit to Celsius, the equation is C = 5/9 *
;;; (F-32).

;; first define a proc named convert-f-to-c which converts a single value

(define (convert-f-to-c f)
  (* (/ 5 9) (- f 32)))

;; then use that function with stream-map to define convert-temps

(define (convert-temps fahrenheit-stream)
      (stream-map (lambda (x) (* (/ 5 9) (- x 32))) fahrenheit-stream) 
)


;;; ******************************************************************
;;; Use stream-filter (pp. 322 of textbook) to define the stream of
;;; all integers that are evenly divisible by 2, 3, or 5.

(define (divisible? x y)
  (= (remainder x y) 0))

(define (divisible-by-2-3-5 int-stream)
  (if (stream-null? int-stream) the-empty-stream
      (stream-filter (lambda (x) (or (= (remainder x 2) 0)
                                     (= (remainder x 3) 0)
                                     (= (remainder x 5) 0))) int-stream))

)

;;; ******************************************************************
;;; Replace the lambda function to complete the following alternative
;;; definition of the integers stream:
;;;
;;; (define my-integers (cons-stream 1 (stream-map <??> my-integers)))

(define my-integers
  (cons-stream 1 (stream-map (lambda (x)  (+ 1 x)) my-integers)))

 
;;; ******************************************************************
;;; This is based on Exercise 3.51 on pp. 325:
;;; http://mitpress.mit.edu/sicp/full-text/book/book-Z-H-24.html#%_thm_3.51
;;;
;;; NOTE:
;;; YOU SHOULD TRY TO ANSWER THIS WITHOUT RUNNING THE CODE.
;;; questions like this will be on the final exam.
;;;
;;; In order to take a closer look at delayed evaluation, we will use
;;; the following procedure, which simply returns its argument after
;;; printing it:
;;;
(define (show x)
  (display-line x)
  x)
;;;
;;; Answer the following questions by changing the values in the associated
;;; definitions.
;;; 
;;; After evaluating the following statement:
;;; (define x (stream-map show (stream-enumerate-interval 0 10)))
;;;
;;; How many cons cells in stream x exist?
(define ex351-num-cons-cells 1)

;;; Of these cons cells in stream x, how many have values in their car positions
;;; that have already been forced (or were never delayed in the first place)?
(define ex351-num-forced-at-outset 1)
;;;
;;; Now evaluate this expression:
;;; (stream-ref x 5)
;;;
;;; How many cons cells exist now?
(define ex351-num-cons-cells-after-stream-ref-5 6)
;;;
;;; How many car-positions have been forced now?
(define ex351-num-forced-after-stream-ref-5 6)
;;;
;;; If "(stream-ref x 5)" is evaluated again, will the either of the two
;;; answers above change?
;;; Change the 0 to 'yes or 'no.
(define ex351-num-forced-twice-stream-ref-5 'no)
;;;
;;; Now evaluate:
;;; (stream-ref x 7)
;;;
;;; How many car-positions have been forced now?
(define ex351-num-forced-after-stream-ref-7 8)
;;;
;;; How many total cons cells have been created at this point?
;;; Hint: recognize that two streams exist -- the original stream
;;; created by stream-enumerate-interval, and the stream created
;;; by stream-map.
(define ex351-total-cons-cells 0)


;;; ******************************************************************
;;; This is based on Exercise 3.52:
;;; http://mitpress.mit.edu/sicp/full-text/book/book-Z-H-24.html#%_thm_3.52
;;;
;;; NOTE:
;;; YOU SHOULD TRY TO ANSWER THIS WITHOUT RUNNING THE CODE.
;;; questions like this will be on the final exam.
;;;
;;; Or at least, if you run the code to get the answers,
;;; make sure you understand why you are getting the results that you do.
;;;
;;; You should manually calculate each value of the "seq" stream.
;;; 
;;; Consider this sequence of expressions:
(define sum 0)
(define (accum x)
  (set! sum (+ x sum))
  sum)
(define seq (stream-map accum (stream-enumerate-interval 1 20)))
;;;
;;; After these expresssions are evaluated,
;;; what is the value of sum?
(define ex352-sum-initial-value 1)
;;;
;;; Now we evaluate:
;;; (define y (stream-filter even? seq))
;;; How many cons cells does seq have after this definition?
(define ex352-num-cons-seq-after-y-defined 3)
;;; What is the value of sum after y is defined?
(define ex352-sum-after-y-defined 6)
;;;
;;; Now we evaluate:
;;; (define z (stream-filter (lambda (x) (= (remainder x 5) 0)) seq))
;;; How many cons cells does seq have after this definition?
(define ex352-num-cons-seq-after-z-defined 4)
;;; What is the value of sum after z is defined?
(define ex352-sum-after-z-defined 10)
;;;
;;; Now we evaluate:
;;; (stream-ref y 2)
;;; How many cons cells does y have?
(define ex352-num-cons-y-after-stream-ref-y-2 3)
;;; How many cons cells does seq have?
(define ex352-num-cons-seq-after-stream-ref-y-2 7)
;;; What is sum?
(define ex352-sum-after-stream-ref-y-2 28)
;;;
;;; Now we evaluate:
;;; (display-stream z)
;;; How many cons cells does seq have?
(define ex352-num-cons-seq-after-display-z 20)
;;; How many cons cells does z have?
(define ex352-num-cons-z-after-display-z 8)

;;; ************************ END OF FILE *****************************
