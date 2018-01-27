data Itree a = Branch a (Itree a) (Itree a)

instance (Show a) => Show (Itree a) where
    show (Branch a l r) = "Node(..." ++ show a ++ "...)" 

costItree :: a -> Itree a
costItree n = Branch n (costItree n) (costItree n)

list2Itree :: [a] -> Itree a
list2Itree (x : xs) = Branch x (list2Itree xs) (list2Itree xs)

imap :: (a -> b) -> Itree a -> Itree b
imap f (Branch a l r) = (Branch (f a) (imap f l) (imap f r))

instance Functor Itree where
    fmap = imap

data Tree a = Leaf a | Node a (Tree a) (Tree a) deriving(Show)

takesLevels :: Int -> Itree a -> Tree a
takesLevels n t = takesLevels' 0 n t

takesLevels':: Int -> Int -> Itree a -> Tree a
takesLevels' i n (Branch v l r)
            | i < n = (Node v (takesLevels' (i + 1) n l) (takesLevels' (i + 1) n r))
            |otherwise = (Leaf v)