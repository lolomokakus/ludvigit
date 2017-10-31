collatz :: [Integer] -> [Integer]
collatz nums
	| last nums == 1 = nums
	| last nums `mod` 2 == 0 = collatz $ nums ++ [last nums `div` 2]
	| otherwise = collatz $ nums ++ [last nums * 3 + 1]

main :: IO ()
main = do
	putStrLn "Enter a number:"
	num <- readLn :: IO Integer
	let steps = collatz [num]
	putStrLn "Steps:"
	_ <- mapM print steps
	putStrLn "Total stopping time:"
	print $ length steps - 1
