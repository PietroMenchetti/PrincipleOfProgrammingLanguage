
data TT = List [TT] | Value Int

lile :: TT  -> Bool
lile (Value a) = a == 1
lile (List l) = lile' (List l) (length l)

lile' :: TT -> Int -> Bool
lile' (Value a) n
            | a == n = True
            | otherwise = False
lile' (List []) n = False            
lile' (List (x :xs)) n
            | lile' x n = True
            | otherwise = lile' (List xs) n

lileg :: TT -> Bool
lileg  (List ((List x) : xs)) = lile (List ((List x) : xs)) && lileg (List xs)
lileg (List ((Value x) : xs)) = lile (List ((Value x) : xs))
lileg _ = True
 
