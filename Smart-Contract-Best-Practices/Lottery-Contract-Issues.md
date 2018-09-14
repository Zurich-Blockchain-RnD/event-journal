# Lottery Contract Problems

## Oracle Contract

 - this is not a safe way to produce a random number. Once you know the seed, the random number can be predicted. It is easy to find the seed from the transaction that initialises the game.
 - There are no checks on the value of the seed to make sure it is valid, i.e. 1 or 0 can also be used as a seed.
 - the "Hide seed value" comment is misleading

## Lottery Contract

- the reset function misleads people, it really just produces an event.

### function registerTeam

 
- use of passwords like this should be discouraged, they are visible (and in this contract not implemented anyway)
- there are no checks that the address being used to identify the teams when registering, or when making a guess are the same as the account starting the transaction. This means you can register teams or make guesses on behalf of other people, effectively overwriting their team's data.
- when pushing to the array, no check is made as to whether the team already exists.
- admin addresses are hard-coded, better to set owner as admin and have owner give out further admin rights

### function makeAGuess
- if they make a winning guess their points are set to 100, rather than having 100 added. (teams[_team].points =+ 100;)
- pay out the first team that reached 100 rather than checking for the team with highest points
    - Iterating over all teams could make the contract too expensive to run if there are too many teams
- if they make an incorrect guess they can get underflow since points is a uint.


### function payoutWinningTeam
- open to re entrancy attack.


***

Source: https://hackmd.io/rIX-x9EzSWyRYZrBBAaCyg?view

