module CartProd where   --export everything
infixr 9 -*-            -- infixr right associative, 9 is the level of precedence
x -*- y = [(i,j) | i <- x , j <- y]
-- Here i defined the symbol -*- which returns the cartesian product

