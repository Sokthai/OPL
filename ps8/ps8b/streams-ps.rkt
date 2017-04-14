#lang racket
;ps8b
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


;;; ******************************************************************
;;; Based Exercise 3.53 on pp. 330:
;;; http://mitpress.mit.edu/sicp/full-text/book/book-Z-H-24.html#%_thm_3.53
;;;
;;; YOU SHOULD TRY TO ANSWER THIS WITHOUT RUNNING THE CODE.
;;; Questions like this will be on the final exam.
;;;
;;; Consider this stream:
(define s (cons-stream 1 (add-streams s s)))
;;;
;;; What is:
;;; (stream-ref s 0) ?
(define ex353-s-0 1)
;;;
;;; What is (stream-ref s 1) ?
(define ex353-s-1 2)
;;;
;;; What is (stream-ref s 2) ?
(define ex353-s-2 4)
;;;
;;; What is (stream-ref s 3) ?
(define ex353-s-3 8)


;;; ******************************************************************
;;; Complete Exercise 3.54 on pp. 331:
;;; http://mitpress.mit.edu/sicp/full-text/book/book-Z-H-24.html#%_thm_3.54
;;;
;;; Define a procedure mul-streams, analogous to add-streams, that
;;; produces the elementwise product of its two input streams. Use
;;; this together with the stream of integers to complete the
;;; following definition of the stream whose nth element (counting
;;; from 0) is n + 1 factorial:
;;;
;;; (define factorials (cons-stream 1 (mul-streams <??> <??>)))

(define (mul-streams s1 s2)  ;; this need to be implemented
  (stream-map-general * s1 s2))

 

(define factorials 
  (cons-stream 1 (mul-streams integers factorials))) ;; this line needs to be changed


;;; ******************************************************************
;;; This is based on Exercise 3.57:
;;; https://mitpress.mit.edu/sicp/full-text/book/book-Z-H-24.html#%_thm_3.57
;;;
;;; Consider the definition of Fibonacci using add-streams:
(define fibs
  (cons-stream 0
               (cons-stream 1
                              (add-streams (stream-cdr fibs) fibs)
               )
  ))
;;; remember that add-streams is:
;;; (define (add-streams s1 s2)
;;;   (stream-map + s1 s2))
;;;
;;; This is 0-indexed Fibonacci starting at 0, so:
;;; (stream-ref fibs 0) => 0 (0th Fibonacci number is 0) - base case
;;; (stream-ref fibs 1) => 1 (1st Fib # is 1) - base case
;;; (stream-ref fibs 2) => 1 (2nd Fib # is 1)
;;; (stream-ref fibs 3) => 2 (3rd Fib # is 2)
;;; (stream-ref fibs 4) => 3 (4th Fib # is 3)
;;; (stream-ref fibs 5) => 5 (5th Fib # is 5)
;;;
;;; Remember that streams memoize previously computed values.
;;; How many additions are involved in calculating (stream-ref fibs 2)?
;;; change the 0 to the correct answer.
(define fib-2-with-memo 0)
;;;
;;; How many additions to calculate (stream-ref fibs 3)?
(define fib-3-with-memo 0)
;;;
;;; How many additions to calculate (stream-ref fibs 4)?
(define fib-4-with-memo 0)
;;;
;;; Write a function that calculates how many additions are necessary
;;; to calculate the nth Fibonacci number. Remember that there are no
;;; additions necessary for the two base cases of the 0th and 1st Fibonacci
;;; number.
(define (fib-num-adds-with-memo n)
  0)
;;;
;;; Now suppose that streams did NOT memoize previously-computed values;
;;; e.g., that (delay <exp>) were simply implemented as (lambda () <exp>).
;;; Now what is the story?
;;;
;;; How many additions for (stream-ref fibs 2) ?
(define fib-2-wo-memo 0)
;;;
;;; for (stream-ref fibs 3) ?
(define fib-3-wo-memo 0)
;;;
;;; for (stream-ref fibs 4) ?
(define fib-4-wo-memo 0)
;;;
;;; for (stream-ref fibs 5) ?
(define fib-5-wo-memo 0)
;;;
;;; Write a function that calculates how many additions will be performed
;;; in computing the nth Fibonacci number in the case where streams do not
;;; memoize.
(define (fib-num-adds-wo-memo n)
  0)

;;; ************************ END OF FILE *****************************
