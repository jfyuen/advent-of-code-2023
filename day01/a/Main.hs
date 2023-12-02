import System.Environment
import Data.Char (isDigit)

removeNonNumerical :: String -> String
removeNonNumerical = filter isDigit

getFirstLastChar :: String -> String
getFirstLastChar [l] = [l] ++ [l]
getFirstLastChar l = [head l] ++ [last l]

main = do
        arg <- head <$> getArgs
        contents <- readFile arg
        let all_lines = lines contents
        let numbers_str_list = map (\x -> getFirstLastChar (removeNonNumerical x)) all_lines
        let numbers_list = map (\x -> read x :: Integer) numbers_str_list
        print numbers_list
        print (sum numbers_list)


