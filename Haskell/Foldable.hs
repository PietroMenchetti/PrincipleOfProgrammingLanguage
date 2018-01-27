data Tree a = Empty | Leaf a | Node (Tree a) (Tree a) deriving (Show)

tmap :: ( a -> b) -> Tree a -> Tree b
tmap f Empty = Empty
tmap f (Leaf a) = (Leaf (f a))
tmap f (Node l r) = (Node (tmap f l) (tmap f r))

tfoldr :: (a -> b -> a) -> a -> Tree a -> a
tfoldr f a Empty = a
tfoldr f a (Leaf c) = f a c
tfoldr f a (Node l r) = tfoldr f (tfoldr f a l) r 

instance Foldable Tree where
    foldr = tfoldr
instance Functor Tree where
    fmap = tmap

instance Foldable Maybe where
    foldr _ z Nothing = z
    foldr f z (Just x) = f x z
        