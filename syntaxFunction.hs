-- lucky :: (Integral a) => a -> String
lucky 7 = "LUCKY NUMBER SEVEN!"
lucky x = "Sorry, you're out of luck, pal!"

-- sayMe :: (Integral a) => a -> String
sayMe 1 = "One!"
sayMe 2 = "Two!"
sayMe 3 = "Three!"
sayMe 4 = "Four!"
sayMe 5 = "Five!"
sayMe x = "Not between 1 and 5"

-- factorial :: (Integral a) => a -> a
factorial 0 = 1
factorial n = n * factorial (n - 1)


-- charName :: Char -> String
harName 'a' = "Albert"
charName 'b' = "Broseph"
charName 'c' = "Cecil"


-- pattern matching on tuple
-- addVectors :: (Num a) => (a, a) -> (a, a) -> (a, a)
addVectors a b = (fst a + fst b, snd a + snd b)

-- addVectors :: (Num a) => (a, a) -> (a, a) -> (a, a)
addVectors (x1, y1) (x2, y2) = (x1 + x2, y1 + y2)

-- Find head pattern match
head' :: [a] -> a
head' [] = error "Can't call head on an empty list, dummy!"
head' (x:_) = x

-- ghci> head' [4,5,6]
-- 4
-- ghci> head' "Hello"
-- 'H'


-- tell :: (Show a) => [a] -> String
tell [] = "The list is empty"
tell (x:[]) = "The list has one element: " ++ show x
tell (x:y:[]) = "The list has two elements: " ++ show x ++ " and " ++ show y
tell (x:y:_) = "This list is long. The first two elements are: " ++ show x ++ " and " ++ show y

-- Guard
-- densityTell :: (RealFloat a) => a -> String
densityTell density
  | density < 1.2 = "Wow! You're going for a ride in the sky!"
  | density <= 1000.0 = "Have fun swimming, but watch out for sharks!"
  | otherwise   = "If it's sink or swim, you're going to sink."


-- densityTell :: (RealFloat a) => a -> a -> String
densityTell mass volume
  | mass / volume < 1.2 = "Wow! You're going for a ride in the sky!"
  | mass / volume <= 1000.0 = "Have fun swimming, but watch out for sharks!"
  | otherwise   = "If it's sink or swim, you're going to sink."


-- max' :: (Ord a) => a -> a -> a
max' a b
  | a > b     = a  
  | otherwise = b

-- max' :: (Ord a) => a -> a -> a
max' a b | a > b = a | otherwise = b

-- myCompare :: (Ord a) => a -> a -> Ordering
a `myCompare` b
  | a > b     = GT
  | a == b    = EQ
  | otherwise = LT

-- ghci> 3 `myCompare` 2
-- GT

-- add check not that an argument satisfies some pattern
-- densityTell :: String -> String
densityTell input
  | Just density <- readMaybe input, density < 1.2 = "Wow! You're going for a ride in the sky!"
  | Just density <- readMaybe input, density <= 1000.0 = "Have fun swimming, but watch out for sharks!"
  | Nothing <- readMaybe input :: (RealFloat a => Maybe a) = "You know I need a density, right?"
  | otherwise   = "If it's sink or swim, you're going to sink."


-- adding where
-- densityTell :: (RealFloat a) => a -> a -> String  
densityTell mass volume
    | density < 1.2 = "Wow! You're going for a ride in the sky!"
    | density <= 1000.0 = "Have fun swimming, but watch out for sharks!"
    | otherwise   = "If it's sink or swim, you're going to sink."
    where density = mass / volume


-- densityTell :: (RealFloat a) => a -> a -> String
densityTell mass volume
    | density < air = "Wow! You're going for a ride in the sky!"
    | density <= water = "Have fun swimming, but watch out for sharks!"
    | otherwise   = "If it's sink or swim, you're going to sink."
    where density = mass / volume
          air = 1.2
          water = 1000.0

-- cylinder :: (RealFloat a) => a -> a -> a
cylinder r h =
    let sideArea = 2 * pi * r * h
        topArea = pi * r ^2
    in  sideArea + 2 * topArea


-- calcDensities :: (RealFloat a) => [(a, a)] -> [a]
calcDensities xs = [density | (m, v) <- xs, let density = m / v]

-- calcDensities :: (RealFloat a) => [(a, a)] -> [a]
calcDensities xs = [density | (m, v) <- xs, let density = m / v, density < 1.2]

-- case expression
-- describeList :: [a] -> String
describeList xs = "The list is " ++ case xs of [] -> "empty."
                                               [x] -> "a singleton list."
                                               xs -> "a longer list."

-- describeList :: [a] -> String
describeList xs = "The list is " ++ what xs
    where what [] = "empty."
          what [x] = "a singleton list."
          what xs = "a longer list."

