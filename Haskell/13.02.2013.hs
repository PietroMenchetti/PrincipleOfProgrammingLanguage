data Offer = Val Int | Str String deriving (Show)
data CBCB = Items [Offer] deriving (Show)

allPossibleBikes :: [CBCB] -> [CBCB]
allPossibleBikes [] = []
allPossibleBikes (y : ys) =  [ (x : xs) | x <- y, xs <- ys] ++ (allPossibleBikes xs)