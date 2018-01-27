class Blup a where
    fisto :: (a b c) -> Maybe b
    fosto :: (a b c) -> Maybe c

data Blargh a b = Bip a b | Bop a | Bup

instance Blup Blargh where
    fisto (Bip a b) = Just a
    fisto (Bop a) = Just a
    fisto Bup = Nothing
    fosto (Bip a b) = Just b
    fosto _ = Nothing

data Blarf a = La [a] | Lb [b]

instance Blup Blarf where
    fisto (La list) = Just (head list)
    fosto (Lb list) = Just (head list)
    fisto _ = Nothing
    fosto _ = Nothing

smap :: [Int] -> (Int -> Int) -> (Int -> Int -> Int) -> Int -> [Int]
smap list f op treshold = map f list op treshold 0 []

smap' :: [Int] -> (Int -> Int) -> (Int -> Int -> Int) -> Int -> Int -> [Int] -> [Int]
smap' (x :xs) f op threshold k res
                | k != threshold = smap' xs f op threshold (op (f x) k) [(f x) ++ res]
                |otherwise = res