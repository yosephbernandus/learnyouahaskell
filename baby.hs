doubleMe x = x + x
doubleUs x y = doubleMe x + doubleMe y  
-- doubleSmallNumber x = if x > 100 then x else x * 2
doubleSmallNumber x = (if x > 100 then x else x * 2) + 1

conanO'Brien = "It's a-me, Conan O'Brien!"

-- lostNumbers = [4,8,15,16,23,42]
--
-- arrData = [1,2,3,4] ++ [9,10,11,12]
-- strMerge = "hello" ++ " " ++ "world"


-- prepend
-- 'A':" SMALL CAT" 
-- 5:[1,2,3,4,5]

-- "Steve Buscemi" !! 6 
-- [9.4,33.2,96.2,11.2,23.25] !! 1
--

headArray = head [5,4,3,2,1]
tailArray = tail [5,4,3,2,1]

-- last [5,4,3,2,1]  
-- init [5,4,3,2,1]

-- length [5,4,3,2,1] 
-- null [1,2,3]
-- reverse [5,4,3,2,1]
--take 3 [5,4,3,2,1] 
-- drop 3 [8,4,2,1,5,6] 
-- minimum [8,4,2,1,5,6]
-- maximum [1,9,2,3,4]
-- sum [5,2,1,6,3,2,5,7]
-- product [6,2,1,2]
-- 4 `elem` [3,4,5,6]
-- [1..20]
-- ['a'..'z']
-- [2,4..20]
-- take 10 (cycle [1,2,3])
-- take 10 (repeat 5)
-- replicate 3 10


-- [x*2 | x <- [1..10]]. x is drawn from [1..10] and for every element in [1..10] (which we have bound to x), we get that element, only doubled. Here’s that comprehension in action

-- [x*2 | x <- [1..10]]


-- [x*2 | x <- [1..10], x*2 >= 12]
-- [ x | x <- [50..100], x `mod` 7 == 3]

boomBangs xs = [ if x < 10 then "BOOM!" else "BANG!" | x <- xs, odd x]
-- boomBangs [7..13]


-- [ x | x <- [10..20], x /= 13, x /= 15, x /= 19]
-- [ x*y | x <- [2,5,10], y <- [8,10,11]]
-- [ x*y | x <- [2,5,10], y <- [8,10,11], x*y > 50]

nouns = ["hobo","frog","pope"]
adjectives = ["lazy","grouchy","scheming"]
-- [adjective ++ " " ++ noun | adjective <- adjectives, noun <- nouns]
-- length' xs = sum [1 | _ <- xs]


removeNonUppercase st = [ c | c <- st, c `elem` ['A'..'Z']]
-- removeNonUppercase "Hahaha! Ahahaha!" 
-- emoveNonUppercase "IdontLIKEFROGS"

-- fst (8,11)
-- fst ("Wow", False)
--snd (8,11)


-- zip [1,2,3,4,5] [5,5,5,5,5] 
-- zip [1 .. 5] ["one", "two", "three", "four", "five"]

-- triangles = [ (a,b,c) | c <- [1..10], b <- [1..10], a <- [1..10] ]  
-- rightTriangles = [ (a,b,c) | c <- [1..10], b <- [1..c], a <- [1..b], a^2 + b^2 == c^2]

rightTriangles = [ (a,b,c) | c <- [1..10], b <- [1..c], a <- [1..b], a^2 + b^2 == c^2, a+b+c == 24]
