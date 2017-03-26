#lang racket
;; yandex key dict.1.1.20170323T170038Z.28bb54dea06871fd.0c66c86a1240bbcd6952d69b7e7cd2d2b9e74b16

;; Oxford "credentials" 7b58b972

(require web-server/http)
(require net/http-client)
(require net/url)

(define app_id  "app_id: da0194c3")
(define app_key "app_key: 761ad80847bb97ee40842f7ecc43fade")
(define url  (string->url "https://od-api.oxforddictionaries.com:443/api/v1/entries/en/rain"))
(define header (list app_id app_key))
(define my-port (get-pure-port url header))
(define respond (port->string my-port))