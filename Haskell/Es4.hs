data Tree a = Nil | Leaf a | Branch (Tree a) (Tree a) deriving (Show,Eq)

mymap :: (a -> b) -> Tree a -> Tree b 
mymap _ Nil = Nil
mymap f (Leaf a) = Leaf (f b)
mymap f (Branch l r) = Branch( mymap (f l) mymap (f r))

tcompose :: (a -> b -> c) -> Tree a -> Tree b -> Tree c
tcompose _ Nil _ = Nil                          -- t2 is the second tree
tcompose f (Leaf a) t2 = mymap (f a) t2         -- currying, (f a ) partial application of f , in mymap will be --> f = (f a) 
tcompose f (Branch l r) = Branch (tcompose f l t2) (tcompose f r t2)

fringe :: Tree a -> [a]
fringe t = fringe' t [] where
    fringe' Nil xs =  xs
    fringe' Leaf a xs = a : xs
    fringe' (Branch l r) xs = (fringe l) ++ (fringe r) ++ xs

revtree :: Tree a -> Tree a 
revtree t = t1
    where (t1, _) = revtree' t (reverse (fringe t)) where
        revtree' Nil xs = (Nil,xs)
        revtree' (Leaf v) (x :xs) = (Leaf x,xs)
        revtree' (Branch l r) xs = let (l' xs') = revtree' l xs
                                       (r' xs'') = revtree' r xs'
                                       in (Branch l' r', xs'')


reversetree' t (foldl (\xs x -> x:xs) [] t) -- 
reversetree :: Tree a -> Tree a
reversetree t = reversetree' t (foldl (\ x y -> y:x) [] t) where     --lambda function
    reversetree' Nil xs = (Nil, xs)
    reversetree' (Leaf v) (x : xs) = (Leaf x, xs)
    reversetree' (Leaf v) (x : xs) = (Leaf x, xs)

getValue :: Tree a -> a 
getValue (Leaf a) = a