# Programming Test - Prize Bingo
Here is the source code for a programming test I completed for a job interview at a game studio that produced online Flash games.

In keeping with their guidelines, I kept the amount of time I worked on the project to 8.5 hours and then I spent another 45 minutes documenting and packaging everything.

## Guidelines 
**PARAMETERS**

Create a simple game using AS3, adhering to these guidelines:

1. Use a combination of slots and bingo to create a small web game.

2. The player should be able to load the game, start gameplay from a UI, play a game, see
the results of their game, and start a new game.

3. Keep iteration and live product support in mind.

Note that we will be reviewing both the game you create and the actual code that you write. Please note that we are looking for a simple game experience. We do not require candidates to create power-ups, challenges, web calls, save states or any other large systems. 

**TIMEFRAME**

This test should take you no more than a day of work. A day is about 8 hours. We don’t believe in crunch!

## [Results](http://amigaabattoir.github.io/ProgrammingTest-PrizeBingo)

The results of the test are [here](http://amigaabattoir.github.io/ProgrammingTest-PrizeBingo)

I used Flash Professional CS6 for the art work and Flash Builder 4.6 for the coding.

The only classes that I pulled from other projects of mine were the GameUniverseTimer and MoreMath classes.

The game basically is a bingo game, where balls roll in from the right and you have to grab the ball you need. If you click on the ball and drag it up towards the board, it will turn green and it is used on your board. If you "use" a ball that has a number on your board, it marks off the number and you get points and additional time. If it is not on the board, you will loose points, and time. If you click a ball and release it below the bingo board, it just removes the ball allowing for more balls to come out.

My original intension was to have "prizes" appear on the board which you would collect with a bingo. I set up some classes for it but never got to implement it. I also left in some of the debug code I had to test if the board was getting marked. I decided if they wanted to see what I could do in about one day of work, I figured they would expect to see some of the code in there not fully implemented.

There are other things that the game should have, like a "get ready" screen to allow the user to view the board. I tried to keep the code fairly easy to adjust. One of the things that needs to be play tested and adjusted accordingly would be the initial speed of the balls and how many appear at most. I set the code up so that at a new game they are initialized to particular values. They can also be modified later to a new value, say after every bingo, or if there was an bonus ball that slows or speeds things up. Also as documented in the code, the random values of the board should not repeat, but I figured I would at least get the basics of game working and not focus so much on perfecting one particular part of the game. I had Boardwalk Empire on my mind when I started doing the art, so I just Google some art deco borders to use in the game for mock up. 
