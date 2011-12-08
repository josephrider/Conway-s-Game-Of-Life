class Universe
  attr_accessor :stars

  include Constellations


  def initialize
    @stars = []    
  end
  
  def probe
    output = ""
    stars.each_with_index do |r,index|
      output << "star#{index}:\n\tx:#{r.x}\n\ty:#{r.y}\n"
    end
    puts "#{output}"
  end
  
  def uniq!
    @results = @stars.dup
    while @stars.count > 0
      star = @stars.shift
      @stars.each_with_index do |c,index|
        (c == star) ? (@results[index] = nil) : false
      end
    end
    self.stars = @results.reject { |x| x.nil? }
  end
  
  def evolve!
    transform_life
  end
  
  def transform_life
    @universe = self
    #dup the stars before transformation   
    rule1 = stars.dup
    rule3 = stars.dup
    rule4 = stars.dup
    #initialize some holders
    @rr1 = []
    @rr3 = []
    @rr4 = []
    #stars with fewer than 2 peers die
    rule1.each do |star|
      if star.peers(@universe).count < 2
        @rr1 << star
      end
    end
    #stars with greater than 3 peers die
    rule3.each do |star|
      if star.peers(@universe).count > 3
        @rr3 << star
      end
    end
    #stars that are dead that have exactly 3 peers come to life
    rule4.each do |star|
      star.possible_peers.each do |q|
        if !@universe.stars.include?(q)
          @new_universe = nil
          @new_universe = Universe.new                  
          @universe.stars.each do |c|
            Star.new(@new_universe,c.x,c.y)
          end          
          z = Star.new(@new_universe,q.x,q.y)
          if z.peers(@new_universe).count == 3
            @rr4 << z.dup unless @rr4.include?(z)
          end
        end
      end
    end
    #insert the alternate universe stars into our universe
    @rr4.each do |r|
      Star.new(@universe,r.x,r.y)
    end
    #subtract the stars that should be dead
    self.stars = @universe.stars - @rr1 - @rr3
    #make sure they are unique
    self.uniq!
  end

  def render_existence
    ROWS.downto(-12) do |row|
      -36.upto(COLUMNS) do |col|
          pseudo_star = Star.new(Universe.new,col,row)
          print @stars.include?(pseudo_star) ? '*' : ' '
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