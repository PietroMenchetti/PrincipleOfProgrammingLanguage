newtype State st a = State (st -> (st, a))

instance Monad (State state) where
    return x = let f t = (t,x)
                in State f

    State f >>= g = State (\oldstate ->
                let (newstate, val) = f oldstate
                    State f' = g val
                in f' newstate)

getState :: State state state
getState = State (\state -> (state, state))

putState :: state -> State state ()
putState new = State (\_ -> (new, ()))

-- Define the monadic function 
    -- mapListM :: (t -> State st a) -> [t] -> State st [a]
    -- that applies its first argument (another monadic function, as 
    -- you can see by the signature) to every element of the list
    -- passed as its second argument (i.e. like a map).ù

mapListM :: (t -> State st a) -> [t] -> State st [a]
mapListM f [] = do return []
mapListM f (x : xs) = do x1 <- f x     --  f x >>= (\x1 -> mapListM f xs >>= (\xs1 -> return (x1:xs1)))
                        xs1 <- mapListM f xs
                        return (x1:xs1)

numberList :: Num st => [st] -> State st [(st, st)]
numberList list = mapListM incrState list
            where incrState v = do
                        curr <- getState
                        put (curr + v)
                        return (v,curr + v)