revmap :: ( a -> b) -> [a] -> [b]
revmap f list = (map f (reverse list))