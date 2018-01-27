data Color = Yellow | Blue deriving (Show)
data Ttree a  = Leaf a Color | Branch a Color (Ttree a) (Ttree a) (Ttree a) deriving (Show)

ttree :: ( a -> b) -> Ttree a -> Ttree b
ttree f (Leaf a c ) = (Leaf (f a ) c)
ttree f (Branch a c l m r) = (Branch (f a) c (ttree f l) (ttree f m) (ttree f r))

instance Functor Ttree where
    fmap = ttree



yellowSubTrees :: Ttree a -> [Ttree a]
yellowSubTrees (Leaf v Yellow) = [(Leaf v Yellow)]
yellowSubTrees (Leaf v Blue) = []
yellowSubTrees (Branch v Yellow l m r) = filter (\x -> allYellows x) [l,m,r] 
yellowSubTrees (Branch v Blue l m r) = yellowSubTrees l ++ yellowSubTrees m ++ yellowSubTrees r

allYellows :: Ttree a -> Bool
allYellows (Leaf v Yellow) = True
allYellows (Branch v Yellow l m r) = (allYellows l) && (allYellows m) && (allYellows r)
allYellows _ = False 