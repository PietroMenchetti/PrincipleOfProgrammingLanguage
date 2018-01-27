transpose :: [[a]] -> [[a]]
transpose [] = []
transpose list = [(map (\x -> (head x)) list)] ++ transpose (filter (not null) (map (\x -> (tail x)) list))
