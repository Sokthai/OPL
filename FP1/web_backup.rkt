;#lang racket
;
;;(require net/url)
;;
;;(define myurl (string->url "http://www.cs.uml.edu/"))
;;(define myport (get-pure-port myurl))
;;(display-pure-port myport)
;
;
;(require web-server/servlet
;         web-server/servlet-env)
; 
;(define (start req)
;  (response/xexpr
;
;  
;   `(html (head (title "Hello world!")) 
;          (body (i p "awesome racket library")
;                (p "This is " (div ((class "emph")) "another") " example.")
;                (p ,(string-append "Hello " "you"))
;                (hr)
;                (a ((href "cnn.com")) "Past")
;   ))
;
;))
;
;(define (render-post post)
;  (response/xexpr
;   `(html (head (title "this is my first post")
;                (link ((rel "stylesheet")
;                       (href "/style.css")
;                       (type "text/css")))
;
;          )
;
;
;          
;          (body ;(style ((type "text/css")) "p { color: green }")
;                (p "this is"  (div ((class "myclass")) "myclass2") "example" )
;                (ul (li (a ((href "cnn.com"))  "larry"))
;                    (li "curly")
;                    (li "Moe")
;                    )
;           )
;    )
;   )
;  )
;
;
;
;
;
;
;
;
;
;(serve/servlet render-post   #:extra-files-paths(list (build-path "style.css")))
;;(serve/servlet start #:servlet-path "/hello.rkt" #:port 8080)
;;this will call the start function in which run the web url

#lang web-server/insta
(define (start request)
  (response/xexpr
   '(html (head (title "Web Page")
                (link ((rel "stylesheet")
                       (href "/style.css")
                       (type "text/css"))))

          (body 
                (h1 "Registration Form")
                ;(p "This is  " (span ((class "hot")) "awesome") ".")
              
                (label "Username   : ")
                (input ((name "username")))
                (br)(br)
                (label "Password   :  ")
                (input ((name "password")))
                (br)(br)
                (label "Name       : ")
                (input ((name "name")))
                (br)(br)
                (label "Address    : ")
                (input ((name "address")))
                (br)(br)
                (label "Country    : ")
                (select (option "Select a country")
                        (option "United States")
                        (option "United Kingdom")
                        (option "Canada")
                ) 
                (br)(br)
                (label "Zipcode    : ")
                (input ((name "zipcode")))
                (br)(br)
                (label "Email      : ")
                (input ((type "email" name "email")))
                (br)(br)
                (input ((type "submit")))
          )
     )

   ))
 
(static-files-path "htdocs")