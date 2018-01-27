import Data.Char

infixes :: [Char] -> [[Char]]
infixes [] = []
infixes (x : xs) 
            | null xs = [[x]]
            | otherwise = infixes xs ++ [[x] ++ xs]

infixes' :: [Char] -> [[Char]]
infixes' [] = []
infixes' list = infixes list  ++ infixes' (take ((length list) -1) list )     