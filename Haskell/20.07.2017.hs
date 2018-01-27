data Color = Yellow | Blue
data Ttree a = Node a Color | Branch a Color (Ttree a) (Ttree a) (Ttree a) 

tmap :: ( a -> b) -> Ttree a -> Ttree b
tmap f (Node v c) = (Node (f v) c)
tmap f (Branch v c l m r ) = (Branch (f v) c (tmap f l) (tmap f m) (tmap r))

tfoldr :: (a -> b -> b) -> b -> Ttree a -> b
tfoldr f n (Node v c) = (f v n)
tfoldr f n (Branch v c l m r) =  (f v (tfoldr f (tfoldr f (tfoldr f n l) m) r))

yellowSubTrees :: Ttree a ->  [Ttree a]
yellowSubTrees (Node v Yellow) = [(Node v Yellow)]
yellowSubTrees (Node v _) = []
yellowSubTrees (Branch _ Yellow l m r)
                            | (allYellows l) && (allYellows m) && (allYellows r) = [(Branch _ Yellow l m r)]
                            |otherwise = yellowSubtrees l ++ yellowSubtrees m ++ yellowSubtrees r 
yellowSubTrees (Branch _ _ l m r) = yellowSubtrees l ++ yellowSubtrees m ++ yellowSubtrees r

allYellows :: Ttree a -> Bool
allYellows (Node _ Yellow) = True
allYellows (Node _ _ ) = False
allYellows (Branch _ Yellow l m r) = (allYellows l) && (allYellows m) && (allYellows r) 
allYellows (Branch _ _ l m r) = False
  