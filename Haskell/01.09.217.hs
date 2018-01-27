data Itree a = Node a (Itree a) (Itree a)

instance (Show a ) => Show (Itree a) where
    show (Node a l r) = show "( ......." ++ show a ++ " ........)"
    
costItree :: a -> Itree a
costItree n = Node n (costItree n) (costItree n)

list2Itree :: [a] -> Itree a
list2Itree (x : xs) = Node x (list2Itree xs) (list2Itree xs)

itmap :: ( a -> b) -> Itree a -> Itree b
itmap f (Node a l r) = (Node (f a) (itmap f l) (itmap f r ))

instance Functor Itree where
    fmap = itmap

data Tree a = Leaf a | Branch (Tree a) a (Tree a) deriving Show

takeLevels :: Int -> Itree a -> Tree a
takeLevels 0 (Node a l r) = (Leaf a)
takeLevels n (Node a l r) = (Branch (takeLevels (n -1 ) l) a (takeLevels (n -1 ) r))

applyAtLevel :: (a -> a) -> (Int -> Bool) -> Itree a -> Itree a
applyAtLevel f p n = apply' 0 f p n 

apply' :: Int -> (a -> a) -> (Int -> Bool) -> Itree a -> Itree a
apply' n f p (Node a l r) 
        | (p n) = (Node (f a) (apply' (n +1) f p l) (apply' (n +1) f p l))
        | otherwise =  (Node a (apply' (n +1) f p l) (apply' (n +1) f p l))