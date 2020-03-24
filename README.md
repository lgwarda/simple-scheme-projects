# Project: Scoring Bridge Hands

A computer program that look at a bridge hand and decide how many points it's worth.
In our program, we'll represent a card by a word like `h5` (five of hearts) or dk (king of diamonds).
A hand will be a sentence of cards, like this:
`(sa s10 s7 s6 s2 hq hj h9 ck c4 dk d9 d3)`

[Scoring Bridge Hands](https://people.eecs.berkeley.edu/~bh/ssch9/bridge.html) is
the first project in the Simply Scheme: Introducing Computer Science 2/e book.



The objectivs are:

- Write a procedure ```card-val``` that takes a single card as its argument and returns the value of that card.
- Write a procedure ```high-card-points``` that takes a hand as its argument and returns the total number of points from high cards in the hand. (This procedure does not count distribution points.)
- Write a procedure ```count-suit``` that takes a suit and a hand as arguments and returns the number of cards in the hand with the given suit.
- Write a procedure ```suit-counts``` that takes a hand as its argument and returns a sentence containing the number of spades, the number of hearts, the number of clubs, and the number of diamonds in the hand.
- Write ```suit-dist-points``` that takes a number as its argument, interpreting it as the number of cards in a suit. The procedure should return the number of distribution points your hand gets for having that number of cards in a particular suit.
- Write ```hand-dist-points```, which takes a hand as its argument and returns the number of distribution points the hand is worth.
- Write a procedure ```bridge-val``` that takes a hand as its argument and returns the total number of points that the hand is worth.

- Run the test suite and make sure that it succeeds

* * * *
You need [racket](https://racket-lang.org/) and [simply-scheme package](https://docs.racket-lang.org/manual@simply-scheme/index.html) to run the program.

You can run the provided tests through DrRacket, or via the command line.

To run the test through DrRacket, simply open the test file and click the 'Run' button in the upper right.

To run the test from the command line, run the test from the exercise directory with the following command:

```
raco test scoring-bridge-hands-test.rkt 
```

which will display  something similar to the following:

```
raco test: (submod "scoring-bridge-hands-test.rkt" test)
8 success(es) 0 failure(s) 0 error(s) 8 test(s) run
0
8 tests passed
```

## Source

https://people.eecs.berkeley.edu/~bh/ssch9/bridge.html
