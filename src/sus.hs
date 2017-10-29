import Control.Monad
import System.Exit
import System.IO

sus :: String -> String
sus word
	| length word == 1 = word
	| length word `mod` 2 == 0 = take (length word `div` 2) word ++ (reverse . take (length word `div` 2)) word
	| otherwise = take (length word `div` 2 + 1) word ++ (reverse . take (length word `div` 2)) word

main :: IO ()
main = forever $ do
	eof <- hIsEOF stdin
	if not eof
		then do
			line <- getLine
			putStrLn $ (unwords . map sus . words) line
			main
		else exitSuccess
