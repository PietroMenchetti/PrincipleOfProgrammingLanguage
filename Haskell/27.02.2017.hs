data LolStream x = LolStream Int [x]

-- if int is positive [x] is periodic
-- if int is negative [x] is not periodic
    
lol2lolstream :: [[a]] -> LolStream a
lol2lolstream list = LolStream (foldl (+) 0 (map length list)) (infiniteList list)


infiniteList :: [[a]]  -> [a]
infiniteList list = (foldl (++) [] list) ++ (infiniteList list)

lolcmp :: (Eq a) => [[a]] -> [[a]] -> Bool
lolcmp (x : xs) (y : ys)
            |  x == y =     (lolcmp xs ys)
            |  otherwise =  False
            
instance (Eq x) => Eq (LolStream x) where
    (LolStream _ list) == (LolStream _ list1) = (lolcmp list list1)

lmap :: ( a -> b) -> LolStream a -> LolStream b
lmap f (LolStream n list) = (LolStram n (map (\x -> map f x) list))

lfoldl :: (b -> a -> b) -> b -> LolStream a -> b
lfoldl f v (LolStream n list) = (foldl (\x -> foldl f v x) list)

