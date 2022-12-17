import Data.List.Split

main :: IO()
main = do
    -- part 1
    f <- readFile "day14/day14.txt"
    let input = lines f
    let max = findMaxY input 0
    let empty1 = createMap 600 (max + 5)
    let map1 = parseInput empty1 input
    let p1 = countSand1 map1 0
    print p1
    -- part 2
    let empty2 = createMap 1000 (max + 5)
    let map2 = placeLine (parseInput empty2 input) 0 (max + 2) 999 (max + 2)
    let p2 = countSand2 map2 0
    print p2

findMaxY :: [String] -> Int -> Int
findMaxY ls currMax = do
    let line = splitOn " -> " (ls !! 0)
    let lineMax = findLineMaxY line 0
    if length ls == 1
        then max currMax lineMax
        else findMaxY (tail ls) (max currMax lineMax)

findLineMaxY :: [String] -> Int -> Int
findLineMaxY ls currMax = do
    let f = splitOn "," (ls !! 0)
    let y = read (f !! 1) :: Int
    if length ls == 1
        then max currMax y
        else findLineMaxY (tail ls) (max currMax y)

createMap :: Int -> Int -> [[Char]]
createMap x y = replicate y (replicate x '.')

placeBlock :: [[Char]] -> Int -> Int -> Char -> [[Char]]
placeBlock m x y obj = do
    let (a,b) = splitAt y m
    let (c,d) = splitAt x (head b)
    let e = c ++ (obj : tail d)
    a ++ [e] ++ tail b

placeLine :: [[Char]] -> Int -> Int -> Int -> Int -> [[Char]]
placeLine m x1 y1 x2 y2 = do
    let m1 = placeBlock m x1 y1 '#'
    if x1 == x2 && y1 == y2
        then m1
        else if x1 == x2 && y1 < y2
            then placeLine m1 x1 (y1+1) x2 y2
            else if x1 == x2 && y1 > y2
                then placeLine m1 x1 (y1-1) x2 y2
                else if x1 < x2
                    then placeLine m1 (x1+1) y1 x2 y2
                    else placeLine m1 (x1-1) y1 x2 y2

parseLine :: [[Char]] -> [String] -> [[Char]]
parseLine m ls = do
    let f = splitOn "," (ls !! 0)
    let x1 = read (f !! 0) :: Int
    let y1 = read (f !! 1) :: Int
    let s = splitOn "," (ls !! 1) 
    let x2 = read (s !! 0) :: Int
    let y2 = read (s !! 1) :: Int
    let m1 = placeLine m x1 y1 x2 y2
    if length ls == 2
        then m1
        else parseLine m1 (tail ls)

parseInput :: [[Char]] -> [String] -> [[Char]]
parseInput m ls = do
    let f = splitOn " -> " (ls !! 0)
    let m1 = parseLine m f
    if length ls == 1
        then m1
        else parseInput m1 (tail ls)

validRest :: [[Char]] -> [Int] -> [Int]
validRest m coord = do
    let x = coord !! 0
    let y = coord !! 1
    if (length m - 1) == y
        then []
        else if (m !! (y + 1)) !! x == '.'
            then validRest m [x, y+1]
            else if (m !! (y + 1)) !! (x - 1) == '.'
                then validRest m [x-1, y+1]
                else if (m !! (y + 1)) !! (x + 1) == '.'
                    then validRest m [x+1, y+1]
                    else [x, y]

countSand1 :: [[Char]] -> Int -> Int
countSand1 m count = do
    let pos = validRest m [500, 0]
    if length pos == 0
        then count
        else countSand1 (placeBlock m (pos !! 0) (pos !! 1) 'o') (count + 1)

countSand2 :: [[Char]] -> Int -> Int
countSand2 m count = do
    let pos = validRest m [500, 0]
    if pos == [500, 0]
        then count + 1
        else countSand2 (placeBlock m (pos !! 0) (pos !! 1) 'o') (count + 1)