sus :: String -> String
sus word
	| length word == 1 = word
	| length word `mod` 2 == 0 = take (length word `div` 2) word ++ (reverse . take (length word `div` 2)) word
	| otherwise = take (length word `div` 2 + 1) word ++ (reverse . take (length word `div` 2)) word

main :: IO ()
main = interact (unlines . map (unwords . map sus . words) . lines)
