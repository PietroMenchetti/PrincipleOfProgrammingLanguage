data Rf a b = Rf [a] (a -> b)

instance (Show a,Show b) => Show (Rf a b) where
    show (Rf list f) = show list ++ " --> " ++ show (map f list)

iter :: a -> ( a -> a) -> [a]
iter v f = [v] ++ (iter (f v) f)

instance Functor (Rf a) where
    fmap f (Rf d g) = Rf d (f.g)

compose ::(Eq b) => Rf a b -> Rf b c -> Rf a c
compose (Rf list f) (Rf list1 g) = (Rf [x | x <- list, elem (f x) list1] (g.f))