

arg1 :: Int -> [Int] -> [Int]
arg1 i list = i : list

arg2 :: Int -> [Int] -> Int
arg2 i list = foldr (+) i list


duofold :: (Int -> Int -> Int) -> (Int -> Int -> Int) -> Int ->  [Int] -> Int
duofold f g n [] = n
duofold f g n (x : xs) = duofold g f (f n x) xs