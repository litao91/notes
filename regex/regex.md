# Lookahead and Lookbehind Zero-Width Assertions
They are called "look around" or "zero-width assertion". Look around will actually match characters, but then *give up the match and only return the result match or no match*. 

## Positive`(?!reg)` and Negative`(?=)` Lookahead
Negative look ahead is indispensable if you want to *match something not followed by something else*. For example, `q(?!u)` may match a "q" that is not followed by a "u".

Positive look ahead works the same. `q(?=u)` matches a q that is followed by a u.

You can use any regular expression inside the lookahead(Not lookbehind). Any valid regular expression can be used inside the lookahead. If it contains capturing parentheses, the backreferences will be saved. If you want to put capturing parentheses around the regex inside the look ahead, like this `(?=(regex))`. 

### Regex Engine Internals of look ahead

Let's see how the engine applies `q(?!u)` to the string Iraq:

* The first token in the regex is the literal q. This will cause the engine to traverse the string until the q in the string is matched. 
* The position in the string is now the void beghind the string. 
* The next token is the look ahead. The engine takes note that it is inside a lookahead construct now, and begins matching he regex inside the lookahead. 
* So the next token is u and this does not match the void behind the q.
* The engine notes that the regex inside the lookahead failed. Because the lookahead is negtive.
* At this point, the entire regex has matched, and q is returned as match.

## Positive and Negative Lookbehind
Lookbehind has the same effect, but works backwords.  It tells the regex engine to *temporarily step backwards in the string, to check if the text inside the lookbehind can be matched there. `(?<!a)b` matches a "b" that is not preceded by an "a". and `(?<=a)b` for positive lookbehind.

## Lookbehind Internal
Let's apply `(?<=a)b` to thingamabob. The engine starts with the lookbehind and the first character in the string. In this case, the lookbehind tells the engine to step back one character, and see if an "a" can be matched there. The engine cannot step back one character because there are no characters before the t. So the lookbehind fails, and the engine starts again at the next character, the h. (Note that a negative lookbehind would have succeeded here.) Again, the engine temporarily steps back one character to check if an "a" can be found there. It finds a t, so the positive lookbehind fails again.

The lookbehind continues to fail until the regex reaches the m in the string. The engine again steps back one character, and notices that the a can be matched there. The positive lookbehind matches. Because it is zero-width, the current position in the string remains at the m. The next token is b, which cannot match here. The next character is the second a in the string. The engine steps back, and finds out that the m does not match a.

The next character is the first b in the string. The engine steps back and finds out that a satisfies the lookbehind. b matches b, and the entire regex has been matched successfully. It matches one character: the first b in the string.

## Important Notes About Lookbehind
Lookbehind only allows fix length string inside. 

# Lookaround is Atomic
As soon as the look around condition is satisfied, the regex engine forgets about everything inside the lookaround. 

The only situaltion in which make any difference is when you use capturing groups inside the lookaround.  Since the regex engine does not backtrack into look around, it will not try different permutations of the capturing groups.