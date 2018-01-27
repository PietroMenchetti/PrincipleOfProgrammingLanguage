module A160311	where
    
myReverse :: [a] -> [a]
myReverse [] = []
myReverse (x :  xs) = myReverse xs ++ [x]
    
    
myRange :: Integer -> Integer -> [Integer]
myRange a b = if a > b
        then error
        else if a < b
            then (myRange a ( b - 1 )) ++ [b]
            else [a]
    
myRange2 :: Integer -> Integer -> [Integer]
myRange2 a b 
        | a > b = error "Low > High"
        | a == b = [a]
        | otherwise = a : myRange2 (a+1) b

-- Infinite list, use "take"!
-- take 3 (myrange3 10)
myRange3 :: Int -> [Int]
myRange3 a = a : myRange3(a +1)

-- Infinite list!
myCycle :: [a] -> [a]
myCycle [] = error "Empty List"
myCycle (x : xs) = x:xs ++ myCycle(x:xs)

-- Call a function is (f x)!
myMap :: ( a->b ) -> [a] -> [b]
myaMap  f [] = []
myMap  f (x:xs) = (f x) : myMap f xs

myFilter :: (a-> Bool) -> [a] -> [a]
myFilter  _ [] = []
myFilter  p (x :xs)
            | (p x) = x : MyFilter p xs
            | otherwise MyFilter p xs

myFoldL :: (a -> a -> a) -> a -> [a] -> a
myFoldL f x [] = x
myFoldL f x (y:ys) = myFoldL f (f x y) ys

myZip :: [a] -> [b] -> [(a,b)]
myZip _ [] = []
myZip [] _ = []
myZip (x : xs) (y : ys) = (x,y):(myZip xs ys)-- uderscore is whatever

-- L : list comprehensions
-- [x*2 | x <- [1..10]]

rightTriangle :: [(Integer,Interger,Interger)]
rightTriangle = [(a,b,c)] |c <- [1..10], b <- [1..c], a <- [1..b], a^2 + b^2 = c^2, a + b + c = 24]

factorial :: Integer -> Integer
factorial n = production [1..n]

-- take Int -> [a] -> [a]
-- take 3 [1,2...]      [1,2,3]


fib :: Int -> Int
fib need
    | n == 0 = 0
    | n == 1 = 1
    | n == 2 = 1
    | n > 2 = fib (n - 2) + fib (n - 1)


-- => separates two parts of a type signature
-- on the left, typeclass constraints ( need to be something that can be Equal, eq is implemented)
-- on the right, the actual type
-- where just says that sub is y : ys
packetHelper :: Eq a => [a] -> [[a]] -> [a] -> [[a]]
packHelper [] acc sub = sub:acc
packHelper (x:xs) acc [] = packHelper xs acc [x]
packHelper (x:xs) acc (y:ys)
    | x == y = packHelper xs acc (x:sub)
    | otherwise = packHelper xs (sub:acc) [x]
    where sub = y:ys

pack :: Eq a => [a] -> [[a]]
pack input = reverse (packetHelper input [] [])

-- head extract the first element of a list
encode :: Eq a => [a] -> [(a,Int)]
encode input = zip (map head packed) (map length packed)
            where packed = pack input

cylinder :: (RealFloat a) => a -> a -> a  
cylinder r h = 
    let sideArea = 2 * pi * r * h  
    topArea = pi * r ^2  
    in  sideArea + 2 * topArea 
          
    -- let <bindings> in <expression> 
    -- The names that you define in the 
    -- let part are accessible to the expression after the in part. 

-- Implementing a type class
-- 
-- Definition from the Prelude:
-- class Eq a where
--     (==) :: a -> a -> Bool
--     (/=) :: a -> a -> Bool
--     x == y = not (x /= y)
--     x /= y = not (x == y)
--
-- This means that a) we have to implement both "equals" and "not equals"
-- and b) since "x is equal to y if x is not equal to y" and viceversa,
-- we can just define "equals" or "not equals" and Haskell will infer the
-- other one.

-- Do not need to instantiate sicne they are nullary constructor
-- kind of Enum or Boolean


data TrafficLight = Red | Yellow | Green -- type sum, deriving Eq now == works

-- Eq, Ord and Show are like "interfaces" that need to be implemented in order to
-- Red == Green 
-- compare Red Green
-- show Green
instance Eq TrafficLight where 
    Red == Red = True
    Green == Green = True
    Yellow == Yellow = True
    _ == _ = False   -- _ the other match

instance Ord TrafficLight where
    compare Red _ = LT  -- Lower Than
    compare Green _ = GT
    compare Yellow Red = GT
    compare Yellow Green = LT

instance Show TrafficLight where
    show Red = "Red light"
    show Green = "Green light"
    show Yellow = "Yellow light"



-- PRODUCT TYPE

data Point = Point Float Float deriving (Show)

-- Pattern matching
getX (Point x _ ) = x
getY (Point _ y ) = y

-- :: -> define!

data Person = Person {  firstname :: String,
                        age :: Int,
                        email :: String
}   -- need Show to print them in the console

-- implementation of show for person

instance Show Person where 
    show (Person x y z) = "Name" ++ x ++ "Age" ++ (show y) ++ "Email" ++ z

quicksort :: (Ord a) => [a] -> [a]
quicksort [] = []
quicksort (x : xs) =
    let right = quicksort [a | a <- xs , a <= x]
        left = quicksort [a | a <- xs , a > x]
    in right ++ [x] ++ left