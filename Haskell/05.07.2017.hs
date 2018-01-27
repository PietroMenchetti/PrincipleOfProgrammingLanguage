data Tree a = Nil | Leaf a | Branch (Tree a)(Tree a) deriving (Show, Eq)
 
tmap :: (a -> a) -> Tree a -> Tree a
tmap f Nil = Nil
tmap f (Leaf x) = Leaf (f x)
tmap f (Branch l r) = (Branch (tmap f l) (tmap f r))

tcompose :: (a -> a -> a) -> Tree a -> Tree a -> Tree a
tcompose f Nil _ = Nil
tcompose f (Leaf x) (Branch l r) = (Branch (tmap (f x) l) (tmap (f x) r)) 
tcompose f (Branch l r) t2 = (Branch (tcompose f l t2) (tcompose f r t2))

fringe :: Tree a -> [a]
fringe Nil = []
fringe (Leaf a) = [a]
fringe (Branch l r) =   (fringe l) ++ (fringe r)

switchLeaf :: Tree a -> [a] -> Tree a
switchLeaf Nil _ = Nil
switchLeaf (Leaf x) (y : ys) = (Leaf y)
switchLeaf (Branch l r) list = (Branch (seq (switchLeaf l list) (switchLeaf l list)) (seq (switchLeaf r list) (switchLeaf r list)))


revtree :: Tree a -> Tree a
revtree t = switchLeaf t (fringe t)

