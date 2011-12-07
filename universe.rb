ROWS = 12
COLUMNS = 36

# pre-populate the field with random cells with this density
DENSITY = 0.12

# speed of evolution (in frames per second)
FPS = 3

# generate a random field
$field = (0...ROWS).map{ |x| (0...COLUMNS).map{ |y| rand < DENSITY } }

class Universe
  attr_accessor :cells

  def initialize
    @cells = []    
  end
  
  def probe
    output = ""
    cells.each_with_index do |r,index|
      output << "cell#{index}:\n\tx:#{r.x}\n\ty:#{r.y}\n"
    end
    puts "#{output}"
  end
  
  def uniq!
    @results = @cells.dup
    while @cells.count > 0
      cell = @cells.shift
      @cells.each_with_index do |c,index|
        (c == cell) ? (@results[index] = nil) : false
      end
    end
    self.cells = @results.reject { |x| x.nil? }
  end
  
  def evolve!
    transform_life
  end
  
  def transform_life
    @universe = self
    #dup the cells before transformation   
    rule1 = cells.dup
    rule3 = cells.dup
    rule4 = cells.dup
    #initialize some holders
    @rr1 = []
    @rr3 = []
    @rr4 = []
    #cells with fewer than 2 peers die
    rule1.each do |cell|
      if cell.peers(@universe).count < 2
        @rr1 << cell
      end
    end
    #cells with greater than 3 peers die
    rule3.each do |cell|
      if cell.peers(@universe).count > 3
        @rr3 << cell
      end
    end
    #cells that are dead that have exactly 3 peers come to life
    rule4.each do |cell|
      cell.possible_peers.each do |q|
        if !@universe.cells.include?(q)
          @new_universe = nil
          @new_universe = Universe.new                  
          @universe.cells.each do |c|
            Cell.new(@new_universe,c.x,c.y)
          end          
          z = Cell.new(@new_universe,q.x,q.y)
          if z.peers(@new_universe).count == 3
            @rr4 << z.dup unless @rr4.include?(z)
          end
        end
      end
    end
    #insert the alternate universe cells into our universe
    @rr4.each do |r|
      Cell.new(@universe,r.x,r.y)
    end
    #subtract the cells that should be dead
    self.cells = @universe.cells - @rr1 - @rr3
    #make sure they are unique
    self.uniq!
  end

  def render_existence
    (-12...ROWS).each do |row|
      (-36...COLUMNS).each do |col|
          pseudo_cell = Cell.new(Universe.new,row,col)
          print @cells.include?(pseudo_cell) ? '*' : ' '
      end
      puts
    end
  end
  
  def monitor
    loop do
      sleep(1.0 / FPS.to_f)
      self.evolve!
      system('clear')      
      self.render_existence
    end
  end

  
end