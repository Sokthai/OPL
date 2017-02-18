#lang racket

;; ps2c.rkt
;; last modified Thu Feb  4 20:13:43 2016 fredm@cs.uml.edu

;; before doing this, read:
;; SICP Chapter 2 intro
;; https://mitpress.mit.edu/sicp/full-text/book/book-Z-H-13.html#%_chap_2
;;
;; SICP Section 2.1, Introduction to Data Abstraction
;; https://mitpress.mit.edu/sicp/full-text/book/book-Z-H-14.html#%_sec_2.1

;; SICP exercise 2.2 (pp. 89-90). In this problem you create data
;; structures in Scheme representing line segments in a plane.

(define (print-point p) 
   (newline) 
   (display "'(")   ;;don't remove the single quote. It is needed for
		    ;;auto grader
   (display (x-point p)) 
   (display ", ") 
   (display (y-point p)) 
   (display ")")) 

;; Fill in the below procedures  
;;
;; the idea here is that you are creating an abstraction of the X,Y
;; point object.
;; 
;; make-point is the constructor and x-point and y-point are the
;; selectors. 
;; 
;; you can use any internal representation you like as long as the
;; constructor and selectors are consistent with the internal
;; representation. 
;; Point 
(define (make-point x y) 
  (cons x y))

(define (x-point p) 
  (car p))

(define (y-point p) 
  (cdr p))
 
;; Segment 
;; similarly, make-seg is the constructor;
;; start-seg and end-seg are accessors.
;; midpoint-seg is an accessor that finds the midpoint of the line
;; segment. 
;; make sure to use your point object inside your line segment!
;; (two of them)
(define (make-seg start-point end-point) 
  (cons start-point end-point))

(define (start-seg segment) 
  (car segment))   

(define (end-seg segment)
  (cdr segment))
  
 ; should return a point
(define (midpoint-seg segment)
  (let  
       ( 
         [x (+ (x-point (start-seg segment)) (x-point (end-seg segment)))]
         [y (+ (y-point (start-seg segment)) (y-point (end-seg segment)))]
       )
       
       (make-point (/ x 2) (/ y 2)) ;return midpoint 
    )) 
;(print-point (midpoint-seg (make-seg (make-point 110 30) (make-point 10 10)))) ; for testing midpoint
  

;; SICP exercise 2.3 (pp. 90). Here you represent rectangles and
;; construct procedures to compute perimeter and area.  Fill in the
;; below procedures
;; more constructors and selectors
;; you may use your point objects if you desire 

(define (make-rect x1 y1 x2 y2)
  (make-seg 
    (make-seg (make-point x1 y1) (make-seg x2 y1))
    (make-seg (make-point x2 y2) (make-seg x1 y2))
  )) 


(define (corner1 rect)
  ;(x-point (end-seg rect)) ;returning a corner point
  (make-seg (start-seg rect) (x-point (end-seg rect))) ;return 3 pionts corner
  ; should return some kind of object representing a corner
  )

(define (corner2 rect) 
 ; (let
 ;     (
 ;      [a (- (x-point (y-point (start-seg rect))) (x-point (x-point (start-seg rect))))]
 ;      [b (- (y-point (x-point (end-seg rect))) (y-point (y-point (start-seg rect))))]
 ;     )
 ;      (sqrt (+ (* a a) (* b b)))
 ;  )

  (make-seg (make-seg (x-point (start-seg rect)) (y-point (end-seg rect))) (x-point (end-seg rect)))
  
  
  ; should return the diagonally opposite corner
  )

(define (width rect)
  (abs (- (x-point (end-seg (corner2 rect))) (x-point (x-point (start-seg (corner1 rect))))))
  ; must use corner1 and corner2 selectors
  )

(define (height rect)
  (abs (- (y-point (end-seg (corner2 rect))) (y-point (x-point (start-seg (corner1 rect))))))
  ; must use corner1 and corner2 selectors
  )
  
;; area and perimeter 
;; must use your width and height abstractions!
(define (area rect) ; A = w * h
  (* (width rect) (height rect))
)

(define (perimeter rect) ; P = 2w + 2h
  (+ (* (width rect) 2) (* (height rect) 2))
)
