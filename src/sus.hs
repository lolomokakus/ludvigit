import Control.Monad
import System.Environment
import System.Exit
import System.IO

sus :: String -> String
sus word
	| length word == 1 = word
	| length word `mod` 2 == 0 = take (length word `div` 2) word ++ (reverse . take (length word `div` 2)) word
	| otherwise = take (length word `div` 2 + 1) word ++ (reverse . take (length word `div` 2)) word

main :: IO ()
main = do
	args <- getArgs
	if (not . null) args
		then do
			putStrLn $ (unwords . map sus . words . unwords) args
			exitSuccess
		else forever $ do
			eof <- hIsEOF stdin
			if eof
				then exitSuccess
				else do
					line <- getLine
					putStrLn $ (unwords . map sus . words) line
