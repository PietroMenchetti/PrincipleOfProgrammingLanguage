import System.IO
import System.Environment

readfile = do {
    putStr "Specify a file name in the current directory \n ";
    args <- getLine;
    handle <- openFile args ReadMode;
    contents <- hGetContents handle;
    putStr contents;
    putStr "\n";
    hClose handle;
}

main = readfile


mymap :: (a -> b) -> [a] -> [b]
mymap f [a] = [f a]
mymap f (x : xs) = [f x] ++ mymap f xs

myconcatMap :: (a -> [b]) -> [a] -> [b]
myconcatMap f list = foldr (++) [] (mymap f list)

mysuperconcatMap :: [(a -> b)] -> [a] -> [b]
mysuperconcatMap fs xs =  myconcatMap (\f -> mymap f xs) fs