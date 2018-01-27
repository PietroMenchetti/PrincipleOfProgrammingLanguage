data Atom = N Int | S String deriving Eq
data Exp = E Atom [Exp] | A Atom deriving Eq


instance Show Atom where
 show (N a) = show a
 show (S a) = filter (\x -> x /= '"') a

instance Show Exp where
 show (A x) = show x
 show (E x (y:ys)) = show x ++ "(" ++
    show y ++
    concatMap (\t -> "," ++ show t) ys ++ ")"

instance Eq Atom where
    (N val) == (N val1) = val == val1
    (S s) == (S s1) = s == s1

instance Eq Exp where
    (E a []) == (E a1 list) = False
    (E a list) == (E a1 []) = False
    (E a list) == (E a1 list1) =  a == a1 && (head list) == (head list1)
    (E a []) == (E a1 []) = a && a1

subst :: Exp -> Atom -> Atom -> Exp
subst (A a) x y
        | a == x = (A y)
        | otherwise = (A a)

subst (E a exps ) x y
        | a == x = (E y map (\e -> subst e x y) exps )
        | otherwise = (E a map (\e -> subst e x y) exps)