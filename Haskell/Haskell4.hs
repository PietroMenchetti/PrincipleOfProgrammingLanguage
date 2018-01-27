 --import Control.Exception
 --import System.IO.Error
--main = do {
--   putStr "Please, tell me something>";
--    thing <- getLine;
--    putStrLn $ "You told me \"" ++ thing ++ "\".";
--    }

-- IO is a type constructor, kind of a type == the structure of the type, * == Int, String ... , :k Int
-- *->* kind of IO, * -> * containers


-- main :: IO ()
-- putStr :: String -> IO ()  a function that takes a String and outputs an IO container containing nothing
-- getLine :: IO String     IO container cointaining a String 

--  import System.IO
--  import System.Environment
--  readfile = do {
--  args <- getArgs; -- command line arguments
--  handle <- openFile (head args) ReadMode;
--  contents <- hGetContents handle; -- note: lazy
--  putStr contents;
--  hClose handle;
--  }
-- main = readfile

-- readfile stuff.txt reads "stuff.txt" and shows it on the screen
-- hGetContents reads lazily the contents of the file

-- For exceptions we need I/O

--handle :: Exception e => (e -> IO a) -> IO a -> IO a -- takes a function that takes an excetpion and makes an IO action

-- Example: we catch the errors of readfile


-- main = handle handler testHandler
--        where handler e
--            | isDoesNotExistError e =
--                putStrLn "This file does not exist."
--            | otherwise =
--                putStrLn "Something is wrong."

-- immutable arrays Data.Array
-- changing data structure need IO monad

import Data.Map

exmap = let m = fromList [("nose", 11), ("emerald", 27)]
            n = insert "rug" 98 m   -- every update takes the previous map and create an ohter one with the update
            o = insert "nose" 9 n

in (m ! "emerald", n ! "rug", o ! "nose")

import Data.Array
exarr = let m = listArray (1,3) ["alpha","beta","gamma"] -- at pos 1 i have alpha ...
            n = m // [(2,"Beta")]                        
            o = n // [(1,"Alpha"), (3,"Gamma")]

in (m ! 1, n ! 2, o ! 1)

-- How to reach Monads
-- Type Class Foldabale
-- is a class used for folding
-- list provides foldl, foldr
-- a minimal implementation of Foldable requires foldr

data Tree a = Empty | Leaf a | Node (Tree a) (Tree a)

--  make this type an istance of Foldable

tfoldr f z Empty = z
tfoldr f z Leaf a = f z a
tfoldr f z (Node l r) = tfoldr f (tfoldr f z r) l 

instance Foldable Tree where
    foldr = tfoldr
    
-- Type Class Maybe
-- is used to represent computations that may fail
data Maybe a = Nothing | Just a -- box containing the actual value of the result if it's ok, otherwise gives Nothing
-- it is adopted in manu recent languages, to avoid NULL and limit execptions
-- make Maybe foldable

instance Foldable Maybe where
        foldr _ z Nothing = z
        foldr f z (Just x) = f x z

-- Type Class Functor
-- is the class that offer a map operation
-- the map opration of functors is called fmap

fmap :: (a -> b) -> f a -> f b -- f a container of as , f b container of bs

instance Functor Maybe where    -- instance of Functor on Maybes, Maybe is an istance of Functor
        fmap _ Nothing = Nothing
        fmap f (Just a) = Just (f a)