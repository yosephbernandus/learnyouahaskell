# Haskell Cheatsheet

---

## List Functions

`head` takes a list and returns its head. The head of a list is basically its first element.

`tail` takes a list and returns its tail. In other words, it chops off a list's head.

`last` takes a list and returns its last element.

`init` takes a list and returns everything except its last element.

`length` takes a list and returns its length, obviously.

`null` checks if a list is empty. If it is, it returns True, otherwise it returns False. Use this function instead of xs == [] (if you have a list called xs).

`reverse` reverses a list.

`take` takes a number and a list. It extracts that many elements from the beginning of the list.

`drop` works in a similar way, only it drops the number of elements from the beginning of a list.

`maximum` takes a list of stuff that can be put in some kind of order and returns the biggest element.

`minimum` returns the smallest.

`sum` takes a list of numbers and returns their sum.

`product` takes a list of numbers and returns their product.

`elem` takes a thing and a list of things and tells us if that thing is an element of the list. It's usually called as an infix function because it's easier to read that way.

`cycle` takes a list and cycles it into an infinite list. If you just try to display the result, it will go on forever so you have to slice it off somewhere.

`repeat` takes an element and produces an infinite list of just that element. It's like cycling a list with only one element.

Although it's simpler to just use the `replicate` function if you want some number of the same element in a list. `replicate 3 10` returns `[10,10,10]`.

---

## Tuple Functions

`fst` takes a pair and returns its first component.

`snd` takes a pair and returns its second component. Surprise!

A cool function that produces a list of pairs: `zip`. It takes two lists and then zips them together into one list by joining the matching elements into pairs. It's a really simple function but it has loads of uses. It's especially useful for when you want to combine two lists in a way or traverse two lists simultaneously.

---

## Basic Types

**`Int`** stands for integer. It's used for whole numbers. 7 can be an Int but 7.2 cannot. Int is bounded, which means that it has a minimum and a maximum value. Usually on 32-bit machines the maximum possible Int is 2147483647 and the minimum is -2147483648.

**`Integer`** stands for, er … also integer. The main difference is that it's not bounded so it can be used to represent really really big numbers. I mean like really big. Int, however, is more efficient.

**`Float`** is a real floating point with single precision.

**`Double`** is a real floating point with double the precision!

**`Bool`** is a boolean type. It can have only two values: True and False.

**`Char`** represents a character. It's denoted by single quotes. A list of characters is a string.

**Tuples** are types but they are dependent on their length as well as the types of their components, so there is theoretically an infinite number of tuple types, which is too many to cover in this tutorial. Note that the empty tuple `()` is also a type which can only have a single value: `()`

---

## Type Variables & Polymorphism

```
ghci> :t head
head :: [a] -> a
```

That means that `a` can be of any type.

Functions that have type variables are called **polymorphic functions**. The type declaration of head states that it takes a list of any type and returns one element of that type.

```
ghci> :t fst
fst :: (a, b) -> a
```

`fst` takes a tuple which contains two types and returns an element which is of the same type as the pair's first component.

Note that just because `a` and `b` are different type variables, they don't have to be different types. It just states that the first component's type and the return value's type are the same.

---

## Typeclasses

### Class Constraints

```
ghci> :t (==)
(==) :: (Eq a) => a -> a -> Bool
```

The `=>` symbol. Everything before the `=>` symbol is called a **class constraint**. We can read the previous type declaration like this: the equality function takes any two values that are of the same type and returns a Bool. The type of those two values must be a member of the Eq class (this was the class constraint).

---

### `Eq`

The Eq typeclass provides an interface for testing for equality. Any type where it makes sense to test for equality between two values of that type should be a member of the Eq class. All standard Haskell types except for IO (the type for dealing with input and output) and functions are a part of the Eq typeclass.

The elem function has a type of `(Eq a) => a -> [a] -> Bool` because it uses `==` over a list to check whether some value we're looking for is in it.

Eq is used for types that support equality testing. The functions its members implement are `==` and `/=`. So if there's an Eq class constraint for a type variable in a function, it uses `==` or `/=` somewhere inside its definition. All the types we mentioned previously except for functions are part of Eq, so they can be tested for equality.

---

### `Ord`

Ord is for types that have an ordering.

```
ghci> :t (>)
(>) :: (Ord a) => a -> a -> Bool

ghci> "Abrakadabra" < "Zebra"
True
ghci> "Abrakadabra" `compare` "Zebra"
LT
ghci> 5 >= 2
True
ghci> 5 `compare` 3
GT
```

---

### `Show`

Members of Show can be presented as strings. All types covered so far except for functions are a part of Show. The most used function that deals with the Show typeclass is `show`. It takes a value whose type is a member of Show and presents it to us as a string.

```
ghci> show 3
"3"
ghci> show 5.334
"5.334"
ghci> show True
"True"
```

---

### `Read`

Read is sort of the opposite typeclass of Show. The `read` function takes a string and returns a type which is a member of Read.

```
ghci> read "True" || False
True
ghci> read "8.2" + 3.8
12.0
ghci> read "5" - 2
3
ghci> read "[1,2,3,4]" ++ [3]
[1,2,3,4,3]

ghci> :t read
read :: (Read a) => String -> a
```

It returns a type that's part of Read but if we don't try to use it in some way later, it has no way of knowing which type. That's why we can use explicit **type annotations**. Type annotations are a way of explicitly saying what the type of an expression should be. We do that by adding `::` at the end of the expression and then specifying a type. Observe:

```
ghci> read "5" :: Int
5
ghci> read "5" :: Float
5.0
ghci> (read "5" :: Float) * 4
20.0
ghci> read "[1,2,3,4]" :: [Int]
[1,2,3,4]
ghci> read "(3, 'a')" :: (Int, Char)
(3, 'a')
```

---

### `Enum`

Enum members are sequentially ordered types — they can be enumerated. The main advantage of the Enum typeclass is that we can use its types in list ranges. They also have defined successors and predecessors, which you can get with the `succ` and `pred` functions. Types in this class: `()`, `Bool`, `Char`, `Ordering`, `Int`, `Integer`, `Float` and `Double`.

```
ghci> ['a'..'e']
"abcde"
ghci> [LT .. GT]
[LT,EQ,GT]
ghci> [3 .. 5]
[3,4,5]
ghci> succ 'B'
'C'
```

---

### `Bounded`

Bounded members have an upper and a lower bound.

```
ghci> minBound :: Int
-2147483648
ghci> maxBound :: Char
'\1114111'
ghci> maxBound :: Bool
True
ghci> minBound :: Bool
False
```

---

### `Num`

Num is a numeric typeclass. Its members have the property of being able to act like numbers. Let's examine the type of a number.

```
ghci> :t 20
20 :: (Num t) => t
```

It appears that whole numbers are also polymorphic constants. They can act like any type that's a member of the Num typeclass.

```
ghci> 20 :: Int
20
ghci> 20 :: Integer
20
ghci> 20 :: Float
20.0
ghci> 20 :: Double
20.0
```

Those are types that are in the Num typeclass. If we examine the type of `*`, we'll see that it accepts all numbers.

```
ghci> :t (*)
(*) :: (Num a) => a -> a -> a
```

It takes two numbers of the same type and returns a number of that type. That's why `(5 :: Int) * (6 :: Integer)` will result in a type error whereas `5 * (6 :: Integer)` will work just fine and produce an Integer because 5 can act like an Integer or an Int.

To join Num, a type must already be friends with Show and Eq.

---

### `Integral`

Integral is also a numeric typeclass. Num includes all numbers, including real numbers and integral numbers, Integral includes only integral (whole) numbers. In this typeclass are `Int` and `Integer`.

---

### `Floating`

Floating includes only floating point numbers, so `Float` and `Double`.

---

### `fromIntegral`

A very useful function for dealing with numbers is `fromIntegral`. It has a type declaration of `fromIntegral :: (Num b, Integral a) => a -> b`. From its type signature we see that it takes an integral number and turns it into a more general number. That's useful when you want integral and floating point types to work together nicely. For instance, the length function has a type declaration of `length :: [a] -> Int` instead of having a more general type of `(Num b) => length :: [a] -> b`. If we try to get a length of a list and then add it to 3.2, we'll get an error because we tried to add together an Int and a floating point number. So to get around this, we do `fromIntegral (length [1,2,3,4]) + 3.2` and it all works out.

Notice that `fromIntegral` has several class constraints in its type signature. That's completely valid and as you can see, the class constraints are separated by commas inside the parentheses.

---

## Pattern Matching

Recursion is important in Haskell and we'll take a closer look at it later. But in a nutshell, this is what happens if we try to get the factorial of, say, 3. It tries to compute 3 * factorial 2. The factorial of 2 is 2 * factorial 1, so for now we have 3 * (2 * factorial 1). factorial 1 is 1 * factorial 0, so we have 3 * (2 * (1 * factorial 0)). Now here comes the trick — we've defined the factorial of 0 to be just 1 and because it encounters that pattern before the catch-all one, it just returns 1. So the final result is equivalent to 3 * (2 * (1 * 1)). Had we written the second pattern on top of the first one, it would catch all numbers, including 0 and our calculation would never terminate. That's why order is important when specifying patterns and it's always best to specify the most specific ones first and then the more general ones later.

### Pattern match in tuple

```haskell
first :: (a, b, c) -> a
first (x, _, _) = x

second :: (a, b, c) -> b
second (_, y, _) = y

third :: (a, b, c) -> c
third (_, _, z) = z
```

### Pattern match in list comprehension

```
ghci> let xs = [(1,3), (4,3), (2,4), (5,3), (5,6), (3,1)]
ghci> [a+b | (a,b) <- xs]
[4,7,6,8,11,4]
```

### Pattern match on lists

Lists themselves can also be used in pattern matching. You can match with the empty list `[]` or any pattern that involves `:` and the empty list. But since `[1,2,3]` is just syntactic sugar for `1:2:3:[]`, you can also use the former pattern. A pattern like `x:xs` will bind the head of the list to `x` and the rest of it to `xs`, even if there's only one element so xs ends up being an empty list.

> **Note:** The `x:xs` pattern is used a lot, especially with recursive functions. But patterns that have `:` in them only match against lists of length 1 or more.

This function is safe because it takes care of the empty list, a singleton list, a list with two elements and a list with more than two elements. Note that `(x:[])` and `(x:y:[])` could be rewritten as `[x]` and `[x,y]` (because its syntactic sugar, we don't need the parentheses). We can't rewrite `(x:y:_)` with square brackets because it matches any list of length 2 or more.

```haskell
length' :: (Num b) => [a] -> b
length' [] = 0
length' (_:xs) = 1 + length' xs
```

This is similar to the factorial function we wrote earlier. First we defined the result of a known input — the empty list. This is also known as the **edge condition**. Then in the second pattern we take the list apart by splitting it into a head and a tail. We say that the length is equal to 1 plus the length of the tail. We use `_` to match the head because we don't actually care what it is. Also note that we've taken care of all possible patterns of a list. The first pattern matches an empty list and the second one matches anything that isn't an empty list.

Let's see what happens if we call `length'` on `"ham"`. First, it will check if it's an empty list. Because it isn't, it falls through to the second pattern. It matches on the second pattern and there it says that the length is `1 + length' "am"`, because we broke it into a head and a tail and discarded the head. O-kay. The `length'` of `"am"` is, similarly, `1 + length' "m"`. So right now we have `1 + (1 + length' "m")`. `length' "m"` is `1 + length' ""` (could also be written as `1 + length' []`). And we've defined `length' []` to be `0`. So in the end we have `1 + (1 + (1 + 0))`.

Let's implement sum. We know that the sum of an empty list is 0. We write that down as a pattern. And we also know that the sum of a list is the head plus the sum of the rest of the list. So if we write that down, we get:

```haskell
sum' :: (Num a) => [a] -> a
sum' [] = 0
sum' (x:xs) = x + sum' xs
```

### As-patterns

There's also a thing called **as patterns**. Those are a handy way of breaking something up according to a pattern and binding it to names whilst still keeping a reference to the whole thing. You do that by putting a name and an `@` in front of a pattern. For instance, the pattern `xs@(x:y:ys)`. This pattern will match exactly the same thing as `x:y:ys` but you can easily get the whole list via `xs` instead of repeating yourself by typing out `x:y:ys` in the function body again. Here's a quick and dirty example:

```haskell
capital :: String -> String
capital "" = "Empty string, whoops!"
capital all@(x:xs) = "The first letter of " ++ all ++ " is " ++ [x]
```

```
ghci> capital "Dracula"
"The first letter of Dracula is D"
```

Normally we use as patterns to avoid repeating ourselves when matching against a bigger pattern when we have to use the whole thing again in the function body.

One more thing — you can't use `++` in pattern matches. If you tried to pattern match against `(xs ++ ys)`, what would be in the first and what would be in the second list? It doesn't make much sense. It would make sense to match stuff against `(xs ++ [x,y,z])` or just `(xs ++ [x])`, but because of the nature of lists, you can't do that.

---

## Guards

Guards are indicated by pipes that follow a function's name and its parameters. Usually, they're indented a bit to the right and lined up. A guard can be one of two things. The first is basically a boolean expression. If it evaluates to True, then the corresponding function body is used. If it evaluates to False, checking drops through to the next guard and so on. If we call this function with 24.3, it will first check if that's smaller than or equal to 1.2. Because it isn't, it falls through to the next guard. The check is carried out with the second guard and because 24.3 is less than 1000.0, the second string is returned.

This is very reminiscent of a big if else tree in imperative languages, only this is far better and more readable. While big if else trees are usually frowned upon, sometimes a problem is defined in such a discrete way that you can't get around them. Guards are a very nice alternative for this.

Many times, the last guard is `otherwise`. `otherwise` is defined simply as `otherwise = True` and catches everything. This is very similar to patterns, only they check if the input satisfies a pattern but boolean guards check for boolean conditions. If all the guards of a function evaluate to False (and we haven't provided an `otherwise` catch-all guard), evaluation falls through to the next pattern. That's how patterns and guards play nicely together. If no suitable guards or patterns are found, an error is thrown.

---

## Where Bindings

We put the keyword `where` after the guards (usually it's best to indent it as much as the pipes are indented) and then we define several names or functions. These names are visible across the guards and give us the advantage of not having to repeat ourselves. If we decide that we want to calculate density a bit differently, we only have to change it once. It also improves readability by giving names to things and can make our programs faster since stuff like our density variable here is calculated only once.

The names we define in the `where` section of a function are only visible to that function, so we don't have to worry about them polluting the namespace of other functions.

You can also use where bindings to pattern match! We could have rewritten the where section of our previous function as:

```haskell
...
    where density = mass / volume
          (air, water) = (1.2, 1000.0)
```

Let's make another fairly trivial function where we get a first and a last name and give someone back their initials.

```haskell
initials :: String -> String -> String
initials firstname lastname = [f] ++ ". " ++ [l] ++ "."
    where (f:_) = firstname
          (l:_) = lastname
```

We could have done this pattern matching directly in the function's parameters (it would have been shorter and clearer actually) but this just goes to show that it's possible to do it in where bindings as well.

Just like we've defined constants in where blocks, you can also define functions. Staying true to our solids programming theme, let's make a function that takes a list of mass-volume pairs and returns a list of densities.

```haskell
calcDensities :: (RealFloat a) => [(a, a)] -> [a]
calcDensities xs = [density m v | (m, v) <- xs]
    where density mass volume = mass / volume
```

And that's all there is to it! The reason we had to introduce density as a function in this example is because we can't just calculate one density from the function's parameters. We have to examine the list passed to the function and there's a different density for every pair in there.

Where bindings can also be nested. It's a common idiom to make a function and define some helper function in its where clause and then to give those functions helper functions as well, each with its own where clause.

---

## Let Bindings

Very similar to where bindings are **let bindings**. Where bindings are a syntactic construct that let you bind to variables at the end of a function and the whole function can see them, including all the guards. Let bindings let you bind to variables anywhere and are expressions themselves, but are very local, so they don't span across guards. Just like any construct in Haskell that is used to bind values to names, let bindings can be used for pattern matching. Let's see them in action! This is how we could define a function that gives us a cylinder's surface area based on its height and radius:

```haskell
cylinder :: (RealFloat a) => a -> a -> a
cylinder r h =
    let sideArea = 2 * pi * r * h
        topArea = pi * r ^2
    in  sideArea + 2 * topArea
```

The form is `let <bindings> in <expression>`. The names that you define in the `let` part are accessible to the expression after the `in` part. As you can see, we could have also defined this with a where binding. Notice that the names are also aligned in a single column. So what's the difference between the two? For now it just seems that `let` puts the bindings first and the expression that uses them later whereas `where` is the other way around.

The difference is that let bindings are expressions themselves. where bindings are just syntactic constructs. Remember when we did the if statement and it was explained that an if else statement is an expression and you can cram it in almost anywhere?

```
ghci> [if 5 > 3 then "Woo" else "Boo", if 'a' > 'b' then "Foo" else "Bar"]
["Woo", "Bar"]
ghci> 4 * (if 10 > 5 then 10 else 0) + 2
42
```

You can also do that with let bindings.

```
ghci> 4 * (let a = 9 in a + 1) + 2
42
```

They can also be used to introduce functions in a local scope:

```
ghci> [let square x = x * x in (square 5, square 3, square 2)]
[(25,9,4)]
```

If we want to bind to several variables inline, we obviously can't align them at columns. That's why we can separate them with semicolons.

```
ghci> (let a = 100; b = 200; c = 300 in a*b*c, let foo="Hey "; bar = "there!" in foo ++ bar)
(6000000,"Hey there!")
```

You don't have to put a semicolon after the last binding but you can if you want. Like we said before, you can pattern match with let bindings. They're very useful for quickly dismantling a tuple into components and binding them to names and such.

```
ghci> (let (a,b,c) = (1,2,3) in a+b+c) * 100
600
```

You can also put let bindings inside list comprehensions. Let's rewrite our previous example of calculating lists of mass-volume pairs to use a let inside a list comprehension instead of defining an auxiliary function with a where.

```haskell
calcDensities :: (RealFloat a) => [(a, a)] -> [a]
calcDensities xs = [density | (m, v) <- xs, let density = m / v]
```

We include a let inside a list comprehension much like we would a predicate, only it doesn't filter the list, it only binds to names. The names defined in a let inside a list comprehension are visible to the output function (the part before the `|`) and all predicates and sections that come after of the binding. So we could make our function return only the densities that will float in air:

```haskell
calcDensities :: (RealFloat a) => [(a, a)] -> [a]
calcDensities xs = [density | (m, v) <- xs, let density = m / v, density < 1.2]
```

We can't use the density name in the `(m, v) <- xs` part because it's defined prior to the let binding.

We omitted the `in` part of the let binding when we used them in list comprehensions because the visibility of the names is already predefined there. However, we could use a `let in` binding in a predicate and the names defined would only be visible to that predicate. The `in` part can also be omitted when defining functions and constants directly in GHCi. If we do that, then the names will be visible throughout the entire interactive session.

```
ghci> let zoot x y z = x * y + z
ghci> zoot 3 9 2
29
ghci> let boot x y z = x * y + z in boot 3 4 2
14
ghci> boot
<interactive>:1:0: Not in scope: `boot'
```

---

## Case Expressions

```haskell
head' :: [a] -> a
head' [] = error "No head for empty lists!"
head' (x:_) = x
```

```haskell
head' :: [a] -> a
head' xs = case xs of [] -> error "No head for empty lists!"
                      (x:_) -> x
```

As you can see, the syntax for case expressions is pretty simple:

```haskell
case expression of pattern -> result
                   pattern -> result
                   pattern -> result
                   ...
```

The expression is matched against the patterns. The pattern matching action is the same as expected: the first pattern that matches the expression is used. If it falls through the whole case expression and no suitable pattern is found, a runtime error occurs.

Whereas pattern matching on function parameters can only be done when defining functions, case expressions can be used pretty much anywhere. For instance:

```haskell
describeList :: [a] -> String
describeList xs = "The list is " ++ case xs of [] -> "empty."
                                               [x] -> "a singleton list."
                                               xs -> "a longer list."
```

They are useful for pattern matching against something in the middle of an expression. Because pattern matching in function definitions is syntactic sugar for case expressions, we could have also defined this like so:

```haskell
describeList :: [a] -> String
describeList xs = "The list is " ++ what xs
    where what [] = "empty."
          what [x] = "a singleton list."
          what xs = "a longer list."
```

---

## Recursion

### `maximum'`

```haskell
maximum' :: (Ord a) => [a] -> a
maximum' [] = error "maximum of empty list"
maximum' [x] = x
maximum' (x:xs)
    | x > maxTail = x
    | otherwise = maxTail
    where maxTail = maximum' xs
```

Let's take an example list of numbers and check out how this would work on them: `[2,5,1]`. If we call `maximum'` on that, the first two patterns won't match. The third one will and the list is split into `2` and `[5,1]`. The where clause wants to know the maximum of `[5,1]`, so we follow that route. It matches the third pattern again and `[5,1]` is split into `5` and `[1]`. Again, the where clause wants to know the maximum of `[1]`. Because that's the edge condition, it returns `1`. Finally! So going up one step, comparing `5` to the maximum of `[1]` (which is 1), we obviously get back `5`. So now we know that the maximum of `[5,1]` is `5`. We go up one step again where we had `2` and `[5,1]`. Comparing `2` with the maximum of `[5,1]`, which is `5`, we choose `5`.

### `replicate'`

Now that we know how to generally think recursively, let's implement a few functions using recursion. First off, we'll implement replicate. `replicate` takes an Int and some element and returns a list that has several repetitions of the same element. For instance, `replicate 3 5` returns `[5,5,5]`. Let's think about the edge condition. My guess is that the edge condition is 0 or less. If we try to replicate something zero times, it should return an empty list. Also for negative numbers, because it doesn't really make sense.

We used guards here instead of patterns because we're testing for a boolean condition. If n is less than or equal to 0, return an empty list. Otherwise, return a list that has x as the first element and then x replicated n-1 times as the tail. Eventually, the (n-1) part will cause our function to reach the edge condition.

### `take'`

```haskell
take' :: (Num i, Ord i) => i -> [a] -> [a]
take' n _
    | n <= 0   = []
take' _ []     = []
take' n (x:xs) = x : take' (n-1) xs
```

The first pattern specifies that if we try to take a 0 or negative number of elements, we get an empty list. Notice that we're using `_` to match the list because we don't really care what it is in this case. Also notice that we use a guard, but without an `otherwise` part. That means that if n turns out to be more than 0, the matching will fall through to the next pattern. The second pattern indicates that if we try to take anything from an empty list, we get an empty list. The third pattern breaks the list into a head and a tail. And then we state that taking n elements from a list equals a list that has x as the head and then a list that takes n-1 elements from the tail as a tail. Try using a piece of paper to write down how the evaluation would look like if we try to take, say, 3 from `[4,3,2,1]`.

Calling `repeat 3` will give us a list that starts with 3 and then has an infinite amount of 3's as a tail. So calling `repeat 3` would evaluate like `3:repeat 3`, which is `3:(3:repeat 3)`, which is `3:(3:(3:repeat 3))`, etc. `repeat 3` will never finish evaluating, whereas `take 5 (repeat 3)` will give us a list of five 3's. So essentially it's like doing `replicate 5 3`.

### `zip'`

`zip` takes two lists and zips them together. `zip [1,2,3] [2,3]` returns `[(1,2),(2,3)]`, because it truncates the longer list to match the length of the shorter one. How about if we zip something with an empty list? Well, we get an empty list back then. So there's our edge condition. However, zip takes two lists as parameters, so there are actually two edge conditions.

First two patterns say that if the first list or second list is empty, we get an empty list. The third one says that two lists zipped are equal to pairing up their heads and then tacking on the zipped tails. Zipping `[1,2,3]` and `['a','b']` will eventually try to zip `[3]` with `[]`. The edge condition patterns kick in and so the result is `(1,'a'):(2,'b'):[]`, which is exactly the same as `[(1,'a'),(2,'b')]`.

### `quicksort`

So, the type signature is going to be `quicksort :: (Ord a) => [a] -> [a]`. No surprises there. The edge condition? Empty list, as is expected. A sorted empty list is an empty list. Now here comes the main algorithm: a sorted list is a list that has all the values smaller than (or equal to) the head of the list in front (and those values are sorted), then comes the head of the list in the middle and then come all the values that are bigger than the head (they're also sorted). Notice that we said sorted two times in this definition, so we'll probably have to make the recursive call twice! Also notice that we defined it using the verb is to define the algorithm instead of saying do this, do that, then do that …. That's the beauty of functional programming! How are we going to filter the list so that we get only the elements smaller than the head of our list and only elements that are bigger? List comprehensions. So, let's dive in and define this function.
