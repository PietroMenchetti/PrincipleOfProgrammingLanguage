data Atom = V Integer | End deriving (Show)
data Ulist = L [Atom] deriving (Show)
data Demuxed = D !Integer [Integer]

demuxe :: Ulist -> Demuxed
demuxe L [] = D 0 []
demuxe L (x : xs) = 