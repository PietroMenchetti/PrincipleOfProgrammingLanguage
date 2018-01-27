-- the bind operator >>= takes a container and a function that has to be applied on the value contained in the container!!!!!!!!!! and output a container
-- THEREFORE i NEED for sure MAP!!!!! Why?!?!?!!!? cause i have a container of values and a function that have to be applied on them!!!!!!!!!!
-- NOW if i apply just MAP (\x -> [x]) [11,2,2,4]  ======= [[11],[2],[2],[4]]
-- What i get is a LIST OF LIST or in other words, a container of containers that contain values
-- I NEED to CONCAT!!!!!!!!! [[11],[2],[2],[4]]   ======> foldr (++) [] [[11],[2],[2],[4]] ====== [11,2,2,4]  NOW i GET A SINGLE CONTAINER!!!!!!!
-- Recaping in order to implement  >>= i need to MAP and then CONCAT  

data Gtree a = Leaf a | Node [Gtree a] deriving (Show, Eq)

gmap :: (a -> b) -> Gtree a -> Gtree b
gmap f (Leaf a) = Leaf $ f a
gmap f (Node list) = (Node (map (\x -> gmap f x) list))

gconcatMap :: Gtree ( a -> Gtree b) -> Gtree a -> Gtree (Gtree (Gtree b))
gconcatMap fs xs = gmap (\f -> gmap f xs) fs   
-- (\f -> gmap f xs) is passed to gmap as function f along with the Gtree with the  others function
-- Now fs is a Gtree, can be Leaf f or a Node [..]
-- In the Leaf i have 1 function f
-- Now gmap exectue (\f -> gmap f xs) (Leaf (+ 1))
-- the (+ 1 ) ====== f and it's extracted from the Leaf and a new gmap is called!!
-- Now the new gmap computes the Gtree with (Leaf (x + 1))
-- Then the first gmap repeats the calls ...


instance Functor Gtree where
    fmap = gmap

