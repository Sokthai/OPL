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
;It would be print out the '(a b c) since the quotation make ' is used clearly as the literal value. 


;(list (list 'george))
(define p2_2 #t)
;it would print a list of literal word 'george', because the 'george' is a symbol due to quotation

;(cdr '((x1 x2) (y1 y2)))
(define p2_3 #t)
;it will print a sublist start from the second item, in this case is '((y1 y2)) since its items is another list. 
;the quotation will treat each items in list as symbol 


;(cadr '((x1 x2) (y1 y2)))
(define p2_4 #t)
;the cadr selector extract the second item of the list. this will produce the list of '(y1 y2) since
;its second item is also a list




;(pair? (car '(a short list)))
(define p2_5 #t)
;it will produce a #f (false) result. the car selector extract the symbol 'a which is
;obviously not the pair. the quotation before the parenthesis will literally treat every word in
;the parenthesis as a string of character rather than variables



;(memq 'red '((red shoes) (blue socks)))
(define p2_6 #t)
;this will produce a #f (false) result. the 'red' keyword will not be found in the list
;since the memq search and match only each element of the list agaist the 'red keyword.
;it won't search the sublist.




;(memq 'red '(red shoes blue socks))
(define p2_7 #t)
;it will return the original list since the first item in the list is the keyword
;the memq are searching for. it return the the every items after the match keyword including the
;keyword itself '(red shoes blue socks)

;; **********************************************************************

;;3. Exercise 2.54 on pp. 145, building your own version of equal?.
; Fill in the below procedure

(define (my-equal? list1 list2)
  (cond
    [(and (null? list1) (null? list2)) #t]
    [(or (null? list1) (null? list2)) #f]
    [
      (cond
        [(and (not (list? list1)) (not (list? list2)))
           (if (not (eq? list1 list2)) #f
               (my-equal? (newLst list1) (newLst list2)))]
          
          [(and (list? (car list1)) (list? (car list2)))
           (if (not (eq? (caar list1) (caar list2))) #f
               (my-equal? (newLst list1) (newLst list2)))]
                                                                   
          [(and (not (list? (car list1))) (not (list? (car list2))))
              (if (not (eq? (car list1) (car list2))) #f
               (my-equal? (cdr list1) (cdr list2)))]
           
           
          [else (my-equal? (cdr list1) (cdr list2))] 
      )
     ]

    [(and (not (list? list1)) (not (list? list2)))
           (if (not (eq? list1 list2)) #f
               (my-equal? (newLst list1) (newLst list2)))]

    [(not (eq? (car list1) (car list2))) #f]
    [else (my-equal? (cdr list1) (cdr list2))]
    )

  )

(define (newLst lst)
  (if (list? lst) 
  (if (= (length (car lst)) 1) (cdr lst)
             (append (list (cdr (car lst))) (cdr lst)))
  (list)
  )

)

;(print (my-equal? '() '())) t 
;(print (my-equal? '(this is a list) '(this is a list))) t
;(print (my-equal? '(this is a list) '(this (is a) list))) #f
;(print (my-equal? '(this (is a) list) '(this (is a) list))) t
;(print (my-equal? '(this is a list) '())) f



;; **********************************************************************

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

(define p4 #t)
;because the quoation ''abracadabra is return a pair of list which
;the first item is the quote and the second item is the string of character.
;if she types (cdr ''abracadabra), she would have gotten the "abracadabra" word

;; **********************************************************************





