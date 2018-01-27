import Data.Char

count ::  [Int] -> Int
count [x] = 0
count (x : xs) 
            | x == (head xs) = x + count xs
            | otherwise  = count xs

pack :: [Char] -> [Int]
pack list = map digitToInt list 

min :: [Int] -> Int
min list = min' list (head list)

min' :: [Int] -> Int -> Int
min' [] n = n
min' (x : xs) n 
            | x <= n = min' xs x
            | otherwise = min' xs n

max :: [Int] -> Int
max list = max' list (head list)

max' :: [Int] -> Int -> Int
max' [] n = n
max' (x : xs) n 
        | x >= n = max' xs x
        | otherwise = max' xs n

checksum :: [[Int]] -> Int
checksum list = foldr + 0 (map - (map max list) (map min list)