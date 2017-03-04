sum1 :: [x] -> x
--sum1 :: (Num a) => [a] -> a
sum1 [] = error "cant tell"
sum1 (x:_) = x
