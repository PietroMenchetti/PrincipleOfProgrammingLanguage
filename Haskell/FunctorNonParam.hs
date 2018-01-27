data Dit a = V a 

mymap :: (a -> b) -> Dit a -> Dit b
mymap f (V v) = (V (f v))

instance Show (Dit a) where
    show (V a) = "asdadasdadsads" ++ show a 
instance Functor Dit where
    fmap = mymap