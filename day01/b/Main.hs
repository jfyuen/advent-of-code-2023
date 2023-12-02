import System.Environment
import Data.Char (isDigit)

mapStr :: String -> String
mapStr "" = ""
mapStr ('o':'n':'e':r) = '1' : (mapStr ('n':'e':r))
mapStr ('t':'w':'o':r) = '2' : (mapStr ('w':'o':r))
mapStr ('t':'h':'r':'e':'e':r) = '3' : (mapStr ('h':'r':'e':'e':r))
mapStr ('f':'o':'u':'r':r) = '4' : (mapStr ('o':'u':'r':r))
mapStr ('f':'i':'v':'e':r) = '5' : (mapStr ('i':'v':'e':r))
mapStr ('s':'i':'x':r) = '6' : (mapStr ('i':'x':r))
mapStr ('s':'e':'v':'e':'n':r) = '7' : (mapStr ('e':'v':'e':'n':r))
mapStr ('e':'i':'g':'h':'t':r) = '8' : (mapStr ('i':'g':'h':'t':r))
mapStr ('n':'i':'n':'e':r) = '9' : (mapStr ('i':'n':'e':r))
mapStr (a:r) = a : (mapStr r)

removeNonNumerical :: String -> String
removeNonNumerical = filter isDigit

getFirstLastChar :: String -> String
getFirstLastChar [l] = [l] ++ [l]
getFirstLastChar l = [head l] ++ [last l]

main = do
        arg <- head <$> getArgs
        contents <- readFile arg
        let all_lines = lines contents
        let numbers_str_list = map (\x -> getFirstLastChar (removeNonNumerical (mapStr x))) all_lines
        let numbers_list = map (\x -> read x :: Integer) numbers_str_list
        print numbers_list
        print (sum numbers_list)


