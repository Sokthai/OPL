#lang racket

;(require net/url)
;
;(define myurl (string->url "http://www.cs.uml.edu/"))
;(define myport (get-pure-port myurl))
;(display-pure-port myport)


(require web-server/servlet
         web-server/servlet-env)
 
(define (start req)
  (response/xexpr
   `(html (head (title "Hello world!")) 
          (body (p "awesome racket library")))))
(serve/servlet start  #:extra-files-paths(list (build-path "style.css")
;(serve/servlet start #:servlet-path "/hello.rkt" #:port 8080)
;this will call the start function in which run the web url