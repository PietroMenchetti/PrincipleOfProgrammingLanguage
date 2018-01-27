data Tree a = Empty | Leaf a | Branch (Tree a) (Tree a) deriving (Show)

tconc :: Tree a -> Tree a -> Tree a
tconc Empty t = t
tconc t Empty = t
tconc t1 t2 = Branch t1 t2


foldrTree :: ( a -> b -> b ) -> b -> Tree a -> b
foldrTree f v Empty = v
foldrTree f v (Leaf n)  =  (f n v)
foldrTree f v (Branch l r) = (foldrTree f (foldrTree f v l) r)

instance Foldable Tree where
    foldr = foldrTree

f::  Int -> Maybe (Tree Int)
f 0 = Nothing
f x = Just (Leaf x)

tmap :: (a -> b) -> Tree a -> Tree b
tmap f Empty = Empty
tmap f (Leaf v) = (Leaf (f v))
tmap f (Branch l r) = (Branch (tmap f l) (tmap f r))


instance Functor Tree where 
    fmap = tmap



tconcat t = foldrTree tconc Empty t

tconcmap :: (a -> Tree b) -> Tree a -> Tree b
tconcmap f t = tconcat ( tmap f t)

instance Applicative Tree where
    pure = Leaf
    fs <*> xs = tconcmap (\f -> tmap f xs) fs
    


prova :: a -> Int   -- puo essere un Tree, o una list di trees
prova _ = 1
