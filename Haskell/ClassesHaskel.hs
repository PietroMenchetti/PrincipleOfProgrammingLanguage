
-- Maybe is foldable -> i can do foldr on a Maybe, like foldr on a tree 

instance Foldable Maybe where
foldr _ z Nothing = z
foldr f z (Just x) = f x z

-- Maybe is functor -> i can do fmap on a Maybe

instance Functor Maybe where
    fmap _ Nothing = Nothing
    fmap f (Just x) = (Just (f x)) 

-- Maybe is an applicative functor -> i can do pure and <*> on a Maybe

-- pure :: a -> f a
-- (<*>) :: f (a -> b) -> f a -> f b

instance Applicative Maybe where
    pure = Just
    Just f <*> m = fmap f m
    Nothing <*> _ = Nothing  

-- f is a container
-- pure takes a value and returns an f containing it
-- <*> is like fmap, but instead of taking a function, takes an f containing a
-- function, to apply it to a suitable container of the same kind
