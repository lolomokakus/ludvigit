import System.IO

sus :: String -> String
sus word
	| length word == 1 = word
	| length word `mod` 2 == 0 = take (length word `div` 2) word ++ reverse (take (length word `div` 2) word)
	| otherwise = take (length word `div` 2 + 1) word ++ reverse (take (length word `div` 2) word)

main :: IO ()
main = do
	eof <- hIsEOF stdin
	if eof
		then return ()
		else do
			line <- hGetLine stdin
			putStrLn (unwords (map sus (words line)))
			main
