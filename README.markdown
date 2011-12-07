Reference: http://en.wikipedia.org/wiki/Conway%27s_Game_of_Life

Rules

The universe of the Game of Life is an infinite two-dimensional orthogonal grid of square cells, each of which is in one of two possible states, alive or dead. Every cell interacts with its eight neighbours, which are the cells that are horizontally, vertically, or diagonally adjacent. At each step in time, the following transitions occur:

    1. Any live cell with fewer than two live neighbours dies, as if caused by under-population.
    2. Any live cell with two or three live neighbours lives on to the next generation.
    3. Any live cell with more than three live neighbours dies, as if by overcrowding.
    4. Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.

The initial pattern constitutes the seed of the system. The first generation is created by applying the above rules simultaneously to every cell in the seed—births and deaths occur simultaneously, and the discrete moment at which this happens is sometimes called a tick (in other words, each generation is a pure function of the preceding one). The rules continue to be applied repeatedly to create further generations.



	Gems:
		diff-lcs (1.1.3)
		rake (0.9.2)
		rspec (2.7.0)
		rspec-core (2.7.1)
		rspec-expectations (2.7.0)
		rspec-mocks (2.7.0)


Execution:
cd to GOL directory
	
		irb -r './cell.rb' -r './universe.rb'

Copy and paste one of the following example seeds:

	"Toad"
		universe = Universe.new
		@cells = []
		cell1 = Cell.new(universe,-1,0)
		cell2 = Cell.new(universe,0,0)
		cell3 = Cell.new(universe,0,1)
		cell4 = Cell.new(universe,1,0)
		cell5 = Cell.new(universe,1,1)
		cell6 = Cell.new(universe,2,1)
		@cells << cell1 << cell2 << cell3 << cell4 << cell5 << cell6


	"Blinker"
		universe = Universe.new
		@cells = []
		cell1 = Cell.new(universe,0,0)
		cell2 = Cell.new(universe,0,1)
		cell3 = Cell.new(universe,0,-1)
		@cells << cell1 << cell2 << cell3

	"Beacon"
		universe = Universe.new
		@cells = []
		cell1 = Cell.new(universe,0,0)
		cell2 = Cell.new(universe,0,1)
		cell3 = Cell.new(universe,1,1)
		cell4 = Cell.new(universe,2,-2)
		cell5 = Cell.new(universe,3,-1)
		cell6 = Cell.new(universe,3,-2)
		@cells << cell1 << cell2 << cell3 << cell4 << cell5 << cell6


When you've seeded the universe with the above call:

		universe.evolve!

To view formatted results call:

		universe.probe

To watch the universe evolve on its own call:

		universe.monitor