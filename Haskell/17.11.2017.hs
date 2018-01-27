
data Color = Blue | Yellow deriving (Eq, Show)
data Ttree a = Tleaf a Color | TBranch a Color (Ttree a) (Ttree a) (Ttree a) deriving Show

noBlues :: Ttree a -> Bool
noBlues (Tleaf _ Blue) = True
noBlues (Tleaf _ Yellow) = False
noBlues (TBranch _ Blue l m r ) = False
noBlues (TBranch _ Yellow l m r ) = (noBlues l) && (noBlues m) && (noBlues && r)  

yellowSubTrees :: Ttree a -> [Ttree a]
yellowSubTrees (Tleaf _ Blue) = []
yellowSubTrees (Tleaf _ Yellow) = [(Tleaf _ Yellow)]
yellowSubTrees (TBranch _ l m r) = (yellowSubTrees l) ++ (yellowSubTrees m) ++ (yellowSubTrees r) 