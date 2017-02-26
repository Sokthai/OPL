#lang racket

;;+++++++++++++++ Required for auto grading +++++++++++++++++++++++++
(define nil '())

(define (map proc items)
  (if (null? items)
      nil
      (cons (proc (car items))
            (map proc (cdr items)))))

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

;; **********************************************************************

;;1. Exercise 2.36 on pp. 120, accumulating with lists of lists.
;; fill in code where it's got <??> in two places
;;
;; e.g.,
;; (accumulate-n + 0 '((1 2 3) (4 5 6) (7 8 9)))
;; 
;; should be
;; (12 15 18)
;;
 (define (accumulate-n op init seqs)
   (if (null? (car seqs))
       nil 
       
       (cons (accumulate op init (newList seqs))
             (accumulate-n op init (newNextList seqs) )))
 )


(define (newList lst) ;keep the first item from each sublist (1 4 7)
  (if (null? lst) nil
      (append (list (car (car lst))) (newList (cdr lst))))

  )

(define (newNextList lst) ;create a new list
  (if (null? lst) nil 
       (append (list (cdr (car lst))) (newNextList (cdr lst))))
  )



;; **********************************************************************

;;2. Exercise 2.53 on pp. 144, testing quote, pair?, and memq.
;; Write the answers and explanation in comment line and change #f to #t

;(list 'a 'b 'c)
(define p2_1 #t)
;It would be print out the '(a b c) since the quation make ' is used clearly as the literal value. 


;(list (list 'george))
(define p2_2 #t)
;it would print a list of list of literal word 'geoorge', because the 'george' is the literal word sublist of a list

;(cdr '((x1 x2) (y1 y2)))
(define p2_3 #t)
;it will print a list of list of '((y1 y2)), since there are only 2 items in it. 
;every sublist in the list will be treated as an item that delimited with
;a blank and parenthesis.

;(cadr '((x1 x2) (y1 y2)))
(define p2_4 #t)
;it will print out a list of '(y1 y2), the cadr selector extract the second item of the list 




;(pair? (car '(a short list)))
(define p2_5 #t)
;it will produce a #f (false) result. the car selector extract a literal letter 'a which is
;obviously not the pair. the quotation before the parenthesis will treat every varibles in
;the parenthesis as a literal word rather than is actual value



;(memq 'red '((red shoes) (blue socks)))
(define p2_6 #t)
;this will produce a #f (false) result. the 'red' keyword will not be found in the list
;since the memq search and match only each element of the list agaist the 'red keyword.
;it won't search the sublist.




;(memq 'red '(red shoes blue socks))
(define p2_7 #t)
;it will return the original list since the first item in the list is the keyword
;the memq are searching for. it return the the every items after the match keyword inlude the
;keyword itself '(red shoes blue socks)

;; **********************************************************************

;;3. Exercise 2.54 on pp. 145, building your own version of equal?.
; Fill in the below procedure

(define (my-equal? list1 list2)

  (cond
        ((and (null? list1) (null? list2)) #t)
        ((or (null? list1) (null? list2)) #f)
        ((not (eq? (car list1) (car list2))) #f)
        (else (my-equal? (cdr list1) (cdr list2)))
        ))

;(print (my-equal? '() '()))
;(print (my-equal? '(this is a list) '(this is a list)))
;(print (my-equal? '(this is a list) '(this (is a) list)))
;(print (my-equal? '(this (is a) list) '(this (is a) list)))
;(print (my-equal? '(this is a list) ()))

;;4. Exercise 2.55 on pp. 145, pushing the limits of quote.
;
; Eva Lu Ator types to the interpreter the expression
;
; (car ''abracadabra)
; 
; To her surprise, the interpreter prints back quote. Explain.
; 
; Write the answer and explanation for the below procedure call and replace
; #f with #t.

(define p4 #f)

;; **********************************************************************


