myfunction :: Int -> Int -> Int
myfunction n m = let x = n
                     y = m
                in x + y

myfunction1 :: Int -> Int
myfunction1 n = myf' n 10 where
    myf' n 0 = n
    myf' n m = myf' (n + 1) (m - 1)