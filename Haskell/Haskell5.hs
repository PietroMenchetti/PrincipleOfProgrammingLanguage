-- Applicative functors

class (Functor f) => Applicative f where    -- f must be a functor
    pure :: a -> f a                        -- it's like a constructor, take a value and put it in a container
    (<*>) :: f (a -> b) -> f a -> f b       -- infix operator, apply operation, it's like a map definition, f (a -> b) it's a container containg a function
    
instance Applicative Maybe where
        pure = Just
        Just f <*> m = fmap f m             -- m it's a maybe containing a value 
        Nothing <*> _ = Nothing             --it's applicative if it's cointainter that can contain list of functions that can be applied to a list of value

concat :: Foldable t => t [a] -> [a]


concat [[1,2],[3],[4,5]] is [1,2,3,4,5]
concatMap :: (a -> [b] ) -> [a] -> [b]
concatMap f l = concat $ map f l            -- f a -> [b], 
-- > concatMap (\x -> [x, x+1]) [1,2,3]
-- [1,2,2,3,3,4]

-- making List as instance of Applicative

instance Applicative [] where
    pure x = [x]
    fs <*> xs = concatMap (\f -> map f xs) fs       -- i have a list containing functions and a list of value [(+1),(*2)] <*> [1,2,3]   i got 1+1,2+1,3+1 for the first function,2*1,2*2,2*3 for the second 
                            -- ogni elemento di fs è un f, mappo ogni f con gli xs e li concatento
-- we want to make trees applicative
-- need to define concat for tree
tconc Empty t = t
tconc t Emty = t
tconc t1 t2 = Node t1 t2

tconcat t = tfoldr tconc Empty t
-- need to define concatMap for tree

tconcmap f t = tconcat $ tmap f t

instance Applicative Tree where
    pure = Leaf
    fs <*> xs = tconcmap (\f -> tmap f xs) fs

    --monads allow the programmer to chain actions together to build an ordered
    --sequence, in which each action is decorated with additional processing
    --rules provided by the monad and performed automatically


-- Monads are sublcass of Applicative --> pure, <*>, fmap

class Applicative m => Monad m where
    -- Sequentially compose two actions, passing any value produced
    -- by the first as an argument to the second.
    (>>=) :: m a -> (a -> m b) -> m b           --the first argument is a container of values a, the second is a function wich returns a cointainer of b, and return a container of b
    -- Sequentially compose two actions, discarding any value produced
    -- by the first, like sequencing operators (such as the semicolon)
    -- in imperative languages.
    (>>) :: m a -> m b -> m b
    --m >> k = m >>= \_ -> k
    return :: a -> m a
    return = pure

    -- Fail with a message.
    fail :: String -> m a
    fail s = error s



    instance Monad Maybe where
        (Just x) >>= k = k x                -- k is a function that return a Maybe
        Nothing >>= _ = Nothing
        fail _ = Nothing

        --The do syntax is used to avoid the explicit use of >>= and >>
        --The essential translation of do is captured by the following two rules:
        --do e1 ; e2 <=> e1 >> e2
        --do p <- e1 ; e2 <=> e1 >>= \p -> e2