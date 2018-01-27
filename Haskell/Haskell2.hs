

fib = 1 : 1 : [ a+b | (a,b) <- zip fib (tail fib) ]   -- infinite list call by need , something is computed when it's needed (1,2) (1,2)

-- Error
-- bottom (undefined) _|_ , is the representation of an error situation

let bot = bot
-- the type of bot is a value shared by all types, so error function can be used anywhere
-- infinite loop

-- Pattern matching
-- definitions are processed fromt top to bottom
-- we cannot do ( x : x : xs), like a list that starts with the same element
-- solution ( x : y : xs) | x = y

take :: Int -> [a] -> [a]
take 0 _ = []
take _ [] = []
take n (x :xs) = x : take (n-1) xs

-- the order of definition matters

-- let is let* in scheme

let x = 3
    y = 12
in x + y

-- where is like let but postfix

powset set = powset' set [[]] where -- call of local function
    powset' [] out = out
    powset' ( e : xs) out = powset' set (out ++ [ e : x | x <- out])

-- fold left is tail recursive !

foldl :: (a -> b) -> a -> [a]-> b
foldl f z [] = z
foldl f z (x : xs) = foldl z (f z x) xs

-- in Haskell foldl is not more efficient than foldr, cause of call by need
-- foldl (+) 0 [1,2,3]
-- foldl (+) (0+1) [2,3]
-- foldl (+) ((0+1)+2) [3]
-- foldl (+) (((0+1)+2)+3) []
-- (((0+1)+2)+3) = 6   creating bigger and bigger items in the heap without computing anything


--Sometimes we want to force the evaluation 
-- ! symbol to force call by value

data Complex = Complex !Float !Float

-- when define the complex number the float numbers are evaluated, we don't want to store (((0+1,2)+2.4)+3.5)


--force evaluation with seq :: a -> t -> t
-- seq x y returns y, first evaluate the first argoment than return the second argoment

foldl' f z [] = z
foldl' f z (x :xs) = let z' = f z x -- force the evaluation of the first
                     in seq z' (foldl' f z' xs)