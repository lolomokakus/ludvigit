import System.Environment
import System.IO

sus :: String -> String
sus word
	| length word == 1 = word
	| length word `mod` 2 == 0 = take (length word `div` 2) word ++ (reverse . take (length word `div` 2)) word
	| otherwise = take (length word `div` 2 + 1) word ++ (reverse . take (length word `div` 2)) word

susArgs :: [String] -> IO ()
susArgs args = putStrLn $ (unwords . map sus . words . unwords) args

susStdin :: IO ()
susStdin = do
	eof <- hIsEOF stdin
	if eof
		then return ()
		else do
			line <- getLine
			putStrLn $ (unwords . map sus . words) line
			susStdin

main :: IO ()
main = do
	args <- getArgs
	if null args
		then susStdin
		else susArgs args
