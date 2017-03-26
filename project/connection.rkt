#lang racket
 (require  json 2htdp/batch-io)
(require web-server/http)
(require net/http-client)
(require net/url)


;(define language "en")
(define options "&mode=json&units=imperial&cnt=10")
(define app_id "app_id:da0194c3")
(define app_key "app_key:761ad80847bb97ee40842f7ecc43fade")
(define open_api "https://od-api.oxforddictionaries.com:443/api/v1/entries/en/boy")
;(define connection (string-append open_api app_id app_key))


  (define myconnection (string->url open_api))
(define dict-port (get-pure-port myconnection (list app_id app_key)))
(define respond (port->string dict-port))

  (close-input-port dict-port)

;(write-file "con.json" respond)

(define (readjson file)
  (with-input-from-string 
  (call-with-input-file file (lambda (in) (port->string in)))
    (lambda () (read-json)))
)


(define (readjson-var var)
  (with-input-from-string var
    (lambda () (read-json)))
      
  )





