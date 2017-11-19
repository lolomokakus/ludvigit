import Numeric.Natural

collatz :: Natural -> [Natural]
collatz 1 = [1]
collatz x
	| even x = x : collatz (x `div` 2)
	| odd x = x : collatz (x * 3 + 1)

main :: IO ()
main = do
	putStrLn "Enter a number:"
	x <- readLn :: IO Natural
	let steps = collatz x
	putStrLn ("Steps: " ++ (unwords . map show) steps)
	putStrLn ("Total stopping time: " ++ show (length steps - 1))
