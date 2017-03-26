#lang racket


  (require  json 2htdp/batch-io)
(require web-server/http)
(require net/http-client)
(require net/url)


;------connection-------------------
(define word "")
(define app_id "app_id:da0194c3")
(define app_key "app_key:761ad80847bb97ee40842f7ecc43fade")
(define open_api "https://od-api.oxforddictionaries.com:443/api/v1/entries/en/")



;(define respond "")




(define (search w)
  
(define con-url (string->url (string-append open_api w)))
(define dict-port (get-pure-port con-url (list app_id app_key)))

(define respond (port->string dict-port))
(close-input-port dict-port)
(getAnswer (readjson-from-input respond) '|word| "word: ")
(getAnswer (readjson-from-input respond) '|definitions| "definitions: ")
(getAnswer (readjson-from-input respond) '|examples| "examples: ")

  )




(define (readjson-from-file file)
  (with-input-from-string 
  (call-with-input-file file (lambda (in) (port->string in)))
    (lambda () (read-json)))
)


(define (readjson-from-input var)
  (with-input-from-string var
    (lambda () (read-json)))
      
  )



(define (getAnswer hash k des)
  (cond ((list? hash)  (getAnswer (car hash) k))
        ((and (hash? hash) (not (empty? (hash-ref hash k (lambda () empty))))) (display hash k))     
        (else        
         (cond ((hash? hash)              
                (for (((key val) (in-hash hash)))
                  (getAnswer (hash-ref hash key) k des)))                  
               (else hash)))))
;--------------
(define (display hash k des)
  (cond
    
    ((list? (hash-ref hash k))
     (cond
       ((string? (car (hash-ref hash k))) (printf "~a~a\n" des (car (hash-ref hash k))))
       (else
        (show (hash-ref hash k) k des))))
    (else (printf "~a~a\n" des (hash-ref hash k (lambda () ""))))
  ))
    
  
;-------------


(define (show lst k des)
  (cond ((null? lst) lst)
        (else
         (for (((key val) (in-hash (car lst )))) 
           (printf "~a~a\n" des (hash-keys (car lst)) val ))

         (show (cdr lst) k des)
         )))

;--------------

