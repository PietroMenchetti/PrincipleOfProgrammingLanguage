data Clist a = Sentinel (Clist a) | Cnode a (Clist a)

instance (Eq a) => Eq (Clist a) where
    Sentinel _ == Sentinel _ = True
    (Cnode a next) == (Cnode b next')  = (a == b) && next = next'
    _ == _ = False

clist2list :: Clist a -> [a]
clist2list (Sentinel f) = []
clist2list (Cnode a n) = a : clist2list n


list2clist :: [a] -> Clist a
list2clist [] = let new = Sentinel new
                in new
list2clist (x:xs) = let first = Cnode x ( list2clist’ xs first)
                    in first

list2clist’ [] first = Sentinel first
list2clist’ (x:xs) first = Cnode x $ list2clist’ xs first


cmap :: (a -> b) -> Clist a -> Clist b
cmap f (Sentinel first) = (Sentinel first) 
cmap f (Cnode v next) = (Cnode (f v) (cmap f next))