data Tree a = Leaf a | Branch (Tree a) (Tree a)

instance (Show a) => Show (Tree a) where
    show (Leaf a)  =  show a
    show (Branch l r) = "<" ++ show l ++ "|" ++ show r ++ ">"

numberTree :: Tree a -> Tree (a,Int)
numberTree t = numberTree' t 0


numberTree' :: Tree a -> Int -> Tree (a,Int)
numberTree' (Leaf a) st =   ((Leaf (a, st + 1)), st + 1)      -- i need to return the state (counter ) reached in  the leaf to explore the right branch!
numberTree' (Branch l r) st = (Branch (numberTree' l st))     -- then i can visit the branch without using Monand



--  Using the State Monad

newtype State st a = State {runState :: st -> (a, st)}

put :: a -> State s ()
put new = State (\_ -> ((), new))

get :: State state state                                       
get = State (\state -> (state,state))

runStateM :: State state a -> state -> a
runStateM (State f) st = fst (f st)

fst :: (a,b) -> a
fst (a,b) = a

numberTreeM :: Tree a -> State Int (Tree (a,Int))
numberTreeM tree = mapTreeM number tree 
    where number value = do
        curr <- get
        put (curr + 1)
        return (value, curr)

      --  get >>= (\cur -> put (cur +1) >> (\_ -> return (value,cur + 1)))

mapTreeM :: (t -> m a) -> Tree t -> m (Tree a)
mapTreeM f (Leaf t) = do
    a  <- f t
    return (Leaf a)

mapTreeM f (Branch l r) = do
    l' <- mapTreeM f l
    r' <- mapTreeM f r
    return (Branch l' r')



-- LOGGER

type Log = [String]

newtype Logger a = Logger {run :: (a, Log)}  -- not a function, just a pair
 
instance (Show a) => Show (Logger a) where
    show (Logger a) = show a


instance (Eq a) => Eq (Logger a) where
    Logger (x,y) == Logger (a,b) = x == a && y == b

instance Functor Logger where              -- Logger is unary, i don't need to use (Logger a)
    fmap f log =
        let (a,ls) = run log
            n = f a
            in  Logger (n,ls)

llap lf la =
    let (f,lsf) = run lf 


instance Applicative Logger where
    pure a = Logger (a, [])
    (<*>) = llap
