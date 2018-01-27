check1 :: Int -> [Int] -> Bool
check1 n list 
            | (list !! n) == 1 = True
            | otherwise = False

check1s :: Int -> Int -> [[Int]] -> Bool
check1s 0 _ _  = True
check1s n a (x : xs) = (check1 a x) && (check1s (n - 1) (a + 1) xs)

checkDim :: [[Int]] -> Int -> Bool
checkDim [] 0 = True
checkDim list n 
            |(length (filter (\x -> x == n) (map length list))) == n = True
            | otherwise = False


checkFig :: [[Int]] -> Maybe Int
checkFig list
            | (checkDim list (length list)) && (check1s (length list) 0 list) = Just (length list)
            | otherwise = Nothing 