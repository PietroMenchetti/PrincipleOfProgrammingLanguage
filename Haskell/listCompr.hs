myf:: [(Int,Int)]
myf =   do  x <- [1,2,3]
            y <- [1,2,3]
            return (x,y)

myf':: [(Int,Int)]
myf' = [(x,y) | x <- [1,2,3], y <- [1,2,3]]

myf'' :: [(Int,Int)]
myf'' = [1,2,3] >>= (\x -> [1,2,3] >>= (\y -> return (x,y)))