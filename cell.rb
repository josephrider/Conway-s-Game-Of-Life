class Star
  attr_accessor :universe, :x, :y
  
  def initialize(universe,x=0,y=0)
    @universe = universe
    @x = x
    @y = y
    universe.stars << self
  end
  
  #override == to evaluate based on value rather than object_id
  def ==(other)
    x.eql?(other.x) && y.eql?(other.y)
  end
  
  #is the star alive, simply uses not lifeless
  def alive?
    !lifeless?
  end
  
  #is the star lifeless
  def lifeless?
    !universe.stars.include?(self)
  end
  
  #instantiate relative to
  def give_life_to(x,y)
    Star.new(universe,x,y)
  end
  
  #extrapolate possible peers for a given star
  def possible_peers
    star_neighbors = []
    #Create an alternate universe
    new_universe = Universe.new
    #North            
    star_neighbors << Star.new(new_universe,x,y+1)
    #Northeast        
    star_neighbors << Star.new(new_universe,x+1,y+1)
    #Northwest        
    star_neighbors << Star.new(new_universe,x-1, y+1)
    #South            
    star_neighbors << Star.new(new_universe,x, y-1)
    #Southwest        
    star_neighbors << Star.new(new_universe,x-1, y-1)
    #East             
    star_neighbors << Star.new(new_universe,x+1, y)     
    #Southeast        
    star_neighbors << Star.new(new_universe,x+1, y-1)
    #West
    star_neighbors << Star.new(new_universe,x-1, y)
    star_neighbors
  end
  
  #determine peers in the specified universe
  def peers(universe)
    @peers = []
    universe.stars.each do |star|
      #Has a north peer
      if x == star.x && y == star.y - 1
        @peers << star
      end
      #Has a south peer
      if x == star.x  && y == star.y + 1
        @peers << star
      end        
      #Has a west peer
      if x == star.x + 1 && y == star.y
        @peers << star
      end        
      #Has an east peer
      if x == star.x - 1 && y == star.y
        @peers << star
      end        
      #Has a northeast peer
      if x == star.x - 1 && y == star.y - 1
        @peers << star
      end        
      #Has a northwest peer
      if x == star.x + 1 && y == star.y - 1
        @peers << star
      end        
      #Has a southwest peer
      if x == star.x + 1 && y == star.y + 1
        @peers << star
      end        
      #Has a southeast peer
      if x == star.x - 1 && y == star.y + 1
        @peers << star
      end  
    end
    @peers
  end

  
end