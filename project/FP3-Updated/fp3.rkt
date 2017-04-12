#lang racket
(require rsound net/sendurl)
;(require racket/gui)
;(require  json  net/url)
(require  json srfi/13  net/url (only-in racket/gui play-sound))

;(require web-server/http)
;(require net/http-client)


;------connection-------------------
(define word "")
(define app_id "app_id:da0194c3")
(define app_key "app_key:761ad80847bb97ee40842f7ecc43fade")
(define open_api "https://od-api.oxforddictionaries.com:443/api/v1/entries/en/")



(define myrespond "")

(define file-path "C:\\Users\\sokthai\\Downloads/")
 (define sound-url "")

(define (search w)

  
 
  (define con-url (string->url (string-append open_api w)))
  (define dict-port (get-pure-port con-url (list app_id app_key)))
  (define respond (port->string dict-port))


  
  
  
  
  (close-input-port dict-port)
  
  (cond ((number? (string-contains respond "404 Not Found")) (printf "Not Found"))
        (else
         (searchDict (readjson-from-input respond) '|word| "word        : ")
         (searchDict (readjson-from-input respond) '|definitions| "definitions : ")
         (searchDict (readjson-from-input respond) '|examples| "examples    : ")
         (begin (set! sound-url (searchDict (readjson-from-input respond) '|audioFile| "pronunciation : ")))
         (begin (set! myrespond respond))
  ))
 
  (set! file-path (string-append file-path w "_gb_1.mp3"))
  ;(send-url "http://fsda")
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

;(define (display hash k des)
;  (cond
;    
;    ((list? (hash-ref hash k))
;     (cond
;       ((string? (car (hash-ref hash k))) (printf "~a~a\n" des (car (hash-ref hash k))))
;       (else
;        (show (hash-ref hash k) k des))))
;    (else (printf "~a~a\n" des (hash-ref hash k (lambda () ""))))
;  ))



(define (display hash k des)
  (cond
    
    ((list? (hash-ref hash k))
     (cond
       ((string? (car (hash-ref hash k))) (return des (car (hash-ref hash k))))
       (else
        (show (hash-ref hash k) k des))))
    (else (return des (hash-ref hash k (lambda () ""))))
  ))

(define (return des content result count )
  (if (> count 0)
      (if (list? result)
          (return des content (append result (list content)) (- count 1))
          (return des content (list result) (- count 1)))
     
      result )
  ;(printf "~a~a\n return" des content)

 
  ;"okay"
)
  



(define (show lst k des)
  (cond ((null? lst) lst)
        (else
         (for (((key val) (in-hash (car lst )))) 
           (printf "~a~a\n show" des val )
           ;(return des val)
           )

         (show (cdr lst) k des)
         )))




(module file-player racket/base
   (require racket/system)
   (define player (find-executable-path "xmms"))
   (define (play file)
     (system* player (if (path? file) (path->string file) file)))
   (provide play))




;-----play mp3

(define pth "./hello.mp3")    ; path to audio file (windows can only play .wav)

(define play-asynchronously #t) ; continue execution while file is playing?

;(define play (play-sound pth play-asynchronously))



;(define p "http://audio.oxforddictionaries.com/en/mp3/angry_gb_1.mp3")
