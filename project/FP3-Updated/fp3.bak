#lang racket


(require  json srfi/13 net/url)
;(require web-server/http)
;(require net/http-client)


;------connection-------------------
(define word "")
(define app_id "app_id:da0194c3")
(define app_key "app_key:761ad80847bb97ee40842f7ecc43fade")
(define open_api "https://od-api.oxforddictionaries.com:443/api/v1/entries/en/")



(define myrespond "")




(define (search w)
  
  (define con-url (string->url (string-append open_api w)))
  (define dict-port (get-pure-port con-url (list app_id app_key)))
  (define respond (port->string dict-port))
  
  (begin (set! myrespond respond))
  
  (close-input-port dict-port)
  
  (cond ((number? (string-contains respond "404 Not Found")) (printf "Not Found"))
        (else
         (searchDict (readjson-from-input respond) '|word| "word        : ")
         (searchDict (readjson-from-input respond) '|definitions| "definitions : ")
         (searchDict (readjson-from-input respond) '|examples| "examples    : ")))

)




(define (readjson-from-input var)
  (with-input-from-string var
    (lambda () (read-json)))
      
  )



(define (searchDict hash k des)
  (cond ((list? hash)  (searchDict (car hash) k des))
        ((and (hash? hash) (not (empty? (hash-ref hash k (lambda () empty))))) (display hash k des))     
        (else        
         (cond ((hash? hash)              
                (for (((key val) (in-hash hash)))
                  (searchDict (hash-ref hash key) k des)))                  
               (else hash)))))

(define (display hash k des)
  (cond
    
    ((list? (hash-ref hash k))
     (cond
       ((string? (car (hash-ref hash k))) (printf "~a~a\n" des (car (hash-ref hash k))))
       (else
        (show (hash-ref hash k) k des))))
    (else (printf "~a~a\n" des (hash-ref hash k (lambda () ""))))
  ))
    
  



(define (show lst k des)
  (cond ((null? lst) lst)
        (else
         (for (((key val) (in-hash (car lst )))) 
           (printf "~a~a\n" des val ))

         (show (cdr lst) k des)
         )))



