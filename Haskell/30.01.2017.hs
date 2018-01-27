data Lt a = Lt Int [[a]] deriving (Show, Eq)


mytake :: Int -> a -> [a] -> [[a]]
mytake 0 x _ = [[x]]
mytake n x list = [[x] ++ (take n list)] ++ (mytake (n - 1) x list)

sublists :: [a] -> [[a]]
sublists [] = []
sublists (x : xs) = (mytake (length xs) x xs) ++ (sublists xs)

checklist :: (Eq a) => [a] -> Lt a -> Maybe [[a]]
checklist list (Lt _ lis) = Just (filter (\x -> notElem x lis) (sublists list))

lmap :: (a -> b) -> Lt a -> Lt b
lmap f (Lt n list) = (Lt n (map (\x -> map f x) list))

instance Functor Lt where
    fmap = lmap