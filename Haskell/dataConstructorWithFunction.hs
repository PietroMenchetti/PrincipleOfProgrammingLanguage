data Car1 = Car1 String String Int deriving (Show)

data Car2 = Car2 {tryCar :: Int -> Int}                     -- let c2 = Car2 (\x -> x + 1)
                                                            -- (tryCar c2 1) returns 2 !!!!!
                                                            -- (tryCar c2) returns the function in c2 !!!!!!

newtype State1 st a = State1 {runState1 :: st -> (a, st)}   -- i can't derive Show
                                                            -- State1 is equivalent to State3, runState is just naming the function that is cointained in State
                                                            
newtype State3 st a = State3 (st -> (a,st))                                                

instance Functor (State1 s) where                           -- At the end i will have a NEW state with a function "st -> (f a,s)"  
    fmap f (State1 g) = State1 (\s -> --(f x,s))
                                    let (x,s') = g s        -- g s  ========== runState (State1 g) s                       
                                    in (f x,s'))            
                                                            
                                                            -- the fmap will produce a new State1 with a new function in it newState = State1 (\s -> (f x , s'))
                                                            -- now i have newState
                                                            -- fmap (+ 1) newState --> will produce a new State1 with a new function in it newState' = State1 (\s -> ( (f x) + 1,s''))
                                                            -- ...


-- (<*>) :: Applicative f => f (a -> b) -> f a -> f b

-- f :: st -> ((a -> b),st) here our a is a function!!!!!! st -> (a,st)
-- f s returns the pair ((a -> b), s')  ===== (f',s')
-- f' :: (a -> b)
-- d s' returns the pair (a ,s'')       ===== (f'',s'')
-- f'' :: a
-- apply f' f''

instance Applicative (State1 s) where
    pure a = State1 (\s -> (a,s))
    (State1 f) <*> (State1 d) = State1 (\s -> 
                            let (x',s') = f s
                                (x'',s'') = d s'
                            in (x' x'',s''))

-- The (<*>) action takes the input state, (s)
-- and obtains the function f' and an updated state s', 
-- then passes the updated state s' to d, obtaining 
-- the argument f'' and an updated state s'', and finally 
-- we package up the application f' f'' and the final state s'' into a pair. 


-- It is important to understand that (<*>) specifies an order 
-- in which the state is used: left-hand argument (f), 
-- then the right-hand argument (d).
-- (State1 f) <*> (State1 d) first i apply f s, then d s'

instance Monad (State1 s) where
    return = pure                                           -- return it's "free" if i wrote correctly applicative
    State1 a >>= f = State1 (\s ->
           let (a', s') = a s                               -- a s returns the pair
               (State1 b) = f a'
               (b', s'') = b s'
           in (b', s''))

-- functions to access the internal state
-- evalState :: State s a -> s -> a
-- evalState ma s = fst (runState ma s)
    
-- execState :: State s a -> s -> s
-- execState ma s = snd (runState ma s)
