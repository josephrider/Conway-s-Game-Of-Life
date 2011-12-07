Reference: http://en.wikipedia.org/wiki/Conway%27s_Game_of_Life

Rules

The universe of the Game of Life is an infinite two-dimensional orthogonal grid of square stars, each of which is in one of two possible states, alive or dead. Every star interacts with its eight neighbours, which are the stars that are horizontally, vertically, or diagonally adjacent. At each step in time, the following transitions occur:

    1. Any live star with fewer than two live neighbours dies, as if caused by under-population.
    2. Any live star with two or three live neighbours lives on to the next generation.
    3. Any live star with more than three live neighbours dies, as if by overcrowding.
    4. Any dead star with exactly three live neighbours becomes a live star, as if by reproduction.

The initial pattern constitutes the seed of the system. The first generation is created by applying the above rules simultaneously to every star in the seed—births and deaths occur simultaneously, and the discrete moment at which this happens is sometimes called a tick (in other words, each generation is a pure function of the preceding one). The rules continue to be applied repeatedly to create further generations.



Gems:

	diff-lcs (1.1.3)
	rake (0.9.2)
	rspec (2.7.0)
	rspec-core (2.7.1)
	rspec-expectations (2.7.0)
	rspec-mocks (2.7.0)


Setup:

	1. Install the necessary Gems.
	2. Modify the global path variable to your GOL directory.

Execution:

cd to the cloned GOL directory

Change your program path in boot.rb to point to your GOL folder:

	rot:GOL rot$> mate ./boot.rb

		#update your code path here
		$path = '/Users/rot/projects/GOL'
		
You can also adjust the constant values for the ROWs and COLs to create a bigger field.

Launch interactive ruby with the boot.rb file:
		
		irb -r './boot.rb'

Constellations.rb methods are available to universe.

First create a universe:

		universe = Universe.new

Add constellations to the universe we just created at the specified grid point(s):

		universe.toad_at(3,3)
		universe.blinker_at(-5,-5)
		universe.beacon_at(5,5)

When you've seeded the universe with the above you can call the following method to evolve the universe once:

		universe.evolve!

To view the formatted results of the stars in the universe call:

		universe.probe

The fun part... to watch the universe evolve on its own call:

		universe.monitor
		
The constellations you create interact with each other, the more constellations, the more interactive the evolution.
The above listed constellations and seed points evolve for the first few cycles then stabilize. 