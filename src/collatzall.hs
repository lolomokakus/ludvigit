import Numeric.Natural

collatz :: Natural -> [Natural]
collatz 1 = [1]
collatz x
	| even x = x : collatz (x `div` 2)
	| odd x = x : collatz (x * 3 + 1)

formatCollatz :: Natural -> IO ()
formatCollatz x = putStrLn (show x ++ ": " ++ (show . length . collatz) x)

main :: IO ()
main = mapM_ formatCollatz [1..]
