-- type class = set of sets, like Num
-- Num = {Int,Integer,Float,Rational}  , type = set of values
-- class Eq is the set of all the classes that can be compared ( == )

x :: Eq a => a -> [a] -> Bool  -- type constraint on a, a must be an instance of calss Eq, a must provide the equality operation
x elem [] = False
x elem (y : ys) = x==y || (x elem ys)

-- call by need ex a && b if a is false is not needed to evaluate b
-- a class is a "container" of overloaded operations
class Eq a where
    ( == ) :: a -> a -> Bool

--define equality for Tree
data Tree a = Leaf a | Branch (Tree a) (Tree a)

--we are using equality for a
instance (Eq a) => Eq (Tree a) where   --we need equality for a!
    Leaf a == Leaf b = a == b  -- Leaf a is a value of type a
    (Branch l1 r1) == (Branch l2 r2) = (l1 == l2) && (r1 == r2)  -- equality of Tree not equality of a ( recursive definition )
    _ == _ = False

-- type in Haskell is class in Java, like Tree a
-- class in Haskell is interface in Java, like Eq (Tree a)
-- value in Haskell is Object in Java
-- a Type is an instance of a Class (in Haskell)

-- /= -- >not equal
-- is not needed to provide an implementation for inequality if i already define the implementiation of equality
-- Ord is a subclass of Eq
-- multiple inheritance 

class (X a,Y a) => Z a  -- i need the methods defined in X and Y to provide the methods in Z

-- class Show, for type that has "strange" representation
-- provide the method show

instance Show a => Show (Tree a) where -- look here i need that a in showable
    show (Leaf a) = show a
    show (Branch x y) = "<" ++ show x ++ " | " ++ show y ++ ">"

-- Deriving, make instance of Show,Ord,Eq
-- right associative , "first the last" 

data RPS = Rock | Paper | Scissor


data Rat = Rat !Integer !Integer deriving Eq


simplify (Rat x y) = let g = gcd x ys
                        in Rat (x 'div' g) (y 'div' g)

makeRat x y = simplify (Rat x y)

instance Num Rat where
    (Rat x y) + (Rat x' y') = makeRat (x*y' + x'*y) (y*y')
    (Rat x y) - (Rat x' y') = makeRat (x*y' - x'*y) (y*y')
    -- ...

-- : info <nameofClass> list of methods needed to implement

-- Input/Output
-- is problematic for pure functional lang
-- getChar get a char from the user, it's not possible to define the signature of getChar
-- I/O is based on idea of state changes, not functional
-- not referentially transparent : two different calls of getChar could return differnt characters
-- the sequence of I/O operations is important
-- getChar can be seen as a function :: Time -> Char
-- IO Char, is a type constructor with one parameter
-- putChar :: Char -> IO ()
-- () special type void
-- IO is an instance of the monad class, and in Haskell it is considered as an indelible stain of impurity
-- f! is the programmer that puts "!" to say that a function (in Scheme) has side effect
-- the type system ensures imperative code IO

main = do {
    putStr "Please";  -- ask the user to write something
    thing <- getLine;   -- IO action, thing is the string received from the user
    putStrln $ "You"++ thing ++ " ";    
}

-- special syntax for working with IO : do
-- to get a value from an I/O action "<-"
-- main :: IO ()
-- putStr :: String -> IO ()
-- getLine :: IO String