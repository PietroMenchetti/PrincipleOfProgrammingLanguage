data Expr a = Val a | Div (Expr a) (Expr a)


safedif :: Int -> Int -> Maybe Int
safedif n m 
        | m == 0 = Nothing
        | otherwise = (Just (div n m))

eval :: (Expr Int) -> Maybe Int
eval (Val v) = return v
eval (Div n m) = do x <- eval n
                    y <- eval m
                    safedif x y

eval1 :: (Expr Int) -> Maybe Int
eval1 (Val v) = return v
eval1 (Div n m) = eval n >>= (\x ->  -- performs eval n, the result is passed to the lambda
                    eval m >>= (\y ->   -- performs eval m, the ruslt is passed to the lambda
                      safedif x y))     -- i have two Just 

add :: Maybe Int -> Maybe Int -> Maybe Int
add mx my =             -- Adds two values of type (Maybe Int), where each input value can be Nothing
  mx   >>=   (\x ->         -- Extracts value x if mx is not Nothing
    my   >>=   (\y ->       -- Extracts value y if my is not Nothing
      return (x + y))) 