# thesis
Application of Ant Lion Optimizer Algorithm for Knapsack Problem

Pseudocode (adapted from Emary, Zawbaa, dan Hassanien, 2016)

input	:         N Number of antlions, n Number of ants, IterMax Number of iterations. 

output	:         xelite Optimal antlion binary position, f(xelite) Best fitness value. 

1.	Initialize a population of n ants’ position at random ϵ 0,1. 
2.	Initialize a population of N antlions’ position at random ϵ 0,1. 
3.	Calculate the fitness of all ants and antlions. 
4.	Find the fittest antlion; xelite. 
5.	while Stopping criteria not met do 
    - Calculate the radius of the ant’s random walk;
      for each antj do
      -	Select an antlion at random using Roulette wheel selection (building trap) (antlionRW). 
      -	Apply random walk around antlionRW given the current random walk radius; called x1. 
      -	Apply random walk around xelite given the current random walk radius; called x2. 
      -	Squash the solutions in x1 and x2 using squashing function; called y1, y2. 
      -	Apply stochastic threshold on y1, y2 to output RW1, RW2. 
      -	Perform crossover between RW1, RW2 and set the new position of antj to the output of crossover. 
      end
    - Calculate the fitness of all ants.
    - Replace an antlion with its corresponding ant if it becomes fitter (Catching Prey).
    - Update the elite (if an antlion becomes fitter than the elite). 
    end 
6.	Produce the elite antlion xelite and its fitness.
