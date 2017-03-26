#lang racket
 (require net/url json 2htdp/batch-io)


;(define language "en")
(define app_id "da0194c3")
(define app_key "&appid=761ad80847bb97ee40842f7ecc43fade")
(define open_api "https://od-api.oxforddictionaries.com:443/api/v1/entries/en")
(define connection (string-append open_api app_id app_key))


  (define myconnection (string->url connection))
(define dictionary (get-pure-port myconnection))
(define respond (port->string dictionary))

  (close-input-port dictionary)
(write-file (