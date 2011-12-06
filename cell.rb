class Cell
  attr_accessor :universe, :x, :y
  
  def initialize(universe,x=0,y=0)
    @universe = universe
    @x = x
    @y = y
    universe.cells << self
  end
  
  #override == to evaluate based on value rather than object_id
  def ==(other)
    x.eql?(other.x) && y.eql?(other.y)
  end
  
  #is the cell alive, simply uses not lifeless
  def alive?
    !lifeless?
  end
  
  #is the cell lifeless
  def lifeless?
    !universe.cells.include?(self)
  end
  
  #instantiate relative to
  def give_life_to(x,y)
    Cell.new(universe,x,y)
  end
  
  #extrapolate possible peers for a given cell
  def possible_peers
    cell_neighbors = []
    #Create an alternate universe
    new_universe = Universe.new
    #North            
    cell_neighbors << Cell.new(new_universe,x,y+1)
    #Northeast        
    cell_neighbors << Cell.new(new_universe,x+1,y+1)
    #Northwest        
    cell_neighbors << Cell.new(new_universe,x-1, y+1)
    #South            
    cell_neighbors << Cell.new(new_universe,x, y-1)
    #Southwest        
    cell_neighbors << Cell.new(new_universe,x-1, y-1)
    #East             
    cell_neighbors << Cell.new(new_universe,x+1, y)     
    #Southeast        
    cell_neighbors << Cell.new(new_universe,x+1, y-1)
    #West
    cell_neighbors << Cell.new(new_universe,x-1, y)
    cell_neighbors
  end
  
  #determine peers in the specified universe
  def peers(universe)
    @peers = []
    universe.cells.each do |cell|
      #Has a north peer
      if x == cell.x && y == cell.y - 1
        @peers << cell
      end
      #Has a south peer
      if x == cell.x  && y == cell.y + 1
        @peers << cell
      end        
      #Has a west peer
      if x == cell.x + 1 && y == cell.y
        @peers << cell
      end        
      #Has an east peer
      if x == cell.x - 1 && y == cell.y
        @peers << cell
      end        
      #Has a northeast peer
      if x == cell.x - 1 && y == cell.y - 1
        @peers << cell
      end        
      #Has a northwest peer
      if x == cell.x + 1 && y == cell.y - 1
        @peers << cell
      end        
      #Has a southwest peer
      if x == cell.x + 1 && y == cell.y + 1
        @peers << cell
      end        
      #Has a southeast peer
      if x == cell.x - 1 && y == cell.y + 1
        @peers << cell
      end  
    end
    @peers
  end

  
end