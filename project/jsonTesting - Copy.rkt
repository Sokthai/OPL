#lang racket


 (require json)


(define api
    "{
      \"metadata\":
        {
            \"provider\": \"Oxford University Press\"
        },
     \"results\":
        {
            \"id\": \"rain\",
            \"language\": \"en\",
             \"the condensed moisture of the atmosphere falling visibly in separate drops\"
            \"type\": \"headword\",
            \"word\": \"rain\"
        }\"
    
  }"
)



(define v (hasheq 'arr 1))
(define x (string->jsexpr "{\"foo\": {\"bar\": 888}, \"bar\": 123}"))





(define json  #hash(("a" . 1) ("b" . 20)))


;(with-input-from-string json
;    (lambda () (read-json)))

(with-input-from-string
    "{\"sandwich\":1}"
   ; "data.json"
    (λ () (read-json)))
 





(if (eq? "a" "b") "\na"
    (printf "\nb")) 





(define (readjson file)
  (with-input-from-string 
  (call-with-input-file file (lambda (in) (port->string in)))
    (lambda () (read-json)))
)



(define (getDic word)
  (hash-ref (hash-ref word '|metadata|) '|provider|)
)


(define (getResult word)
  (hash-ref word '|results|))


(define (getWord word)
  (hash-ref (car word) '|word|))

(define (getDef word)
  (hash-ref 
   (car (hash-ref (car (hash-ref (car (hash-ref (car (hash-ref word '|results|)) '|lexicalEntries|)) '|entries|))
        '|senses|))
   '|definitions|)

  )







(define name "data.json")
(define path (string-append "./" name))

(define (writeTofile content)
  (cond ((file-exists? path) (deleteFile content ))
        (else (output name))
))


(define (deleteFile content)
  (delete-file path)
  (output content)
  )


(define (output content)
  (with-output-to-file name
           (lambda () (printf (jsexpr->string content)))))

'#hasheq((metadata . #hasheq((provider . "Oxford University Press")))
         (results . (#hasheq((language . "en") (id . "rain") (lexicalEntries . "sokthai"))))
  )








(define (hashmap hash)
  (hash))







(define (hash-set-in ht ks v)
  (cond [(not (list? ks)) (error "ks not a list")]
        [(empty? (cdr ks)) (hash-set ht (car ks) v)]
        [else
         (hash-set ht 
                   (car ks) 
                   (hash-set-in (hash-ref ht (car ks))
                                (cdr ks)
                                v))]))


(define keys '|id|)

(define (getAnswer hash k)
  (cond ((list? hash)  (getAnswer (car hash) k))
        ;(else (hash-ref hash key) )
        ;((equal? true (hash-ref hash k (lambda () #f))) (hash-ref hash k))
        ((and (hash? hash) (not (empty? (hash-ref hash k (lambda () empty)))))

         


         (display hash k)
       ; (printf "definition ->   ~a \n"  (hash-ref hash k (lambda () "")))
       
        
                                        )
        
       
        (else
         
         (cond ((string? hash) hash)
               (else 
                (for (((key val) (in-hash hash)))
                  ;(printf "~s~%"    key )
                   ;(display (hash-ref hash key))
                  (getAnswer (hash-ref hash key) k)
                  )))
   )
  ))

(define (display hash k)
  (cond ((list? (hash-ref hash k))
         (for (((key val) (in-hash (car (hash-ref hash k))))) 
           (printf "~a\n" val))) 
        (else (printf "definition ->   ~a \n"  (hash-ref hash k (lambda () ""))))
  ))



        
(define (loop hash)
(for (((key val) (in-hash hash)))
 (getAnswer (hash-ref hash key) keys))
  ;(printf "~a~%" key))
)
;(define e (readjson path))
;(not (empty? (hash-ref e '|metadsata| (lambda () empty))))