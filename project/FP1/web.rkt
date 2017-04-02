;Sokthai Tang 3/12/2017
#lang web-server/insta
(require web-server/servlet web-server/servlet-env)
(require  json srfi/13 net/url)

(define (start request)
  (response/xexpr
   '(html (head (title "Web Page")
                (link ((rel "stylesheet")
                       (href "/style.css")
                       (type "text/css"))))

          (body 
                (h1 "Dictionary")              
                (label "Search : ")
                (input ((name "search")))
                (br)(br)
                (label "Word : ")
                (input ((name "word")))
                (br)(br)
                (label "Definition : ")
                (input ((name "definition")))
                (br)(br)
                (label "Examples : ")
                (input ((name "example")))
              
                (br)
                (input ((type "submit")))
          )
     )

   )

  
  (send/suspend
 (lambda (k-url)
   (response/xexpr
    `(html (head (title "Enter a number"))
           (body
            (form ([action ,"http://localhost:8000/servlets/standalone.rkt"])
                  "Enter a number: "
                  (input ([name "number"]))
                  (input ([type "submit"]))
                  (label (search "boy"))
              )
            )))))


  
  )

  

(static-files-path "htdocs")
(serve/servlet start)













;---------
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
         (getAnswer (readjson-from-input respond) '|word| "word        : ")
         (getAnswer (readjson-from-input respond) '|definitions| "definitions : ")
         (getAnswer (readjson-from-input respond) '|examples| "examples    : ")))

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
  (cond ((list? hash)  (getAnswer (car hash) k des))
        ((and (hash? hash) (not (empty? (hash-ref hash k (lambda () empty))))) (display hash k des))     
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
           (printf "~a~a\n" des val ))

         (show (cdr lst) k des)
         )))

;--------------