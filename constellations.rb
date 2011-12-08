module Constellations

  def toad_at(x,y)
    star = Star.new(self,x,y)
    star.give_life_to(x-1,y)
    star.give_life_to(x,y+1)
    star.give_life_to(x+1,y)
    star.give_life_to(x+1,y+1)
    star.give_life_to(x+2,y+1)
  end
  
  def beacon_at(x,y)
    star = Star.new(self,x,y)
    star.give_life_to(x,y+1)
    star.give_life_to(x+1,y+1)
    star.give_life_to(x+2,y-2)
    star.give_life_to(x+3,y-1)
    star.give_life_to(x+3,y-2)
  end
  
  def blinker_at(x,y)
    star = Star.new(self,x,y)    
    star.give_life_to(x,y+1)
    star.give_life_to(x,y-1)
  end
  
  def glider_at(x,y)
    star = Star.new(self,x,y)    
    star.give_life_to(x+1,y)
    star.give_life_to(x+2,y)
    star.give_life_to(x+2,y+1)
    star.give_life_to(x+1,y+2)    
  end
  
  def block_at(x,y)
    star = Star.new(self,x,y)
    star.give_life_to(x+1,y)
    star.give_life_to(x+1,y+1)
    star.give_life_to(x,y+1)
  end
  
  def glider_gun_at(x,y)
    #barrel
    star = Star.new(self,x,y)
    star.give_life_to(x,y-1)
    star.give_life_to(x-2,y-1)
    star.give_life_to(x-3,y-2)
    star.give_life_to(x-4,y-2)
    star.give_life_to(x-4,y-3)    
    star.give_life_to(x-3,y-3)
    star.give_life_to(x-3,y-4)    
    star.give_life_to(x-4,y-4)  
    star.give_life_to(x-2,y-5)    
    star.give_life_to(x,y-5)    
    star.give_life_to(x,y-6)
    #handle
    star.give_life_to(x-7,y-5)
    star.give_life_to(x-8,y-4)    
    star.give_life_to(x-8,y-5)        
    star.give_life_to(x-8,y-6)
    star.give_life_to(x-9,y-3)
    star.give_life_to(x-9,y-7)
    star.give_life_to(x-10,y-5)
    star.give_life_to(x-11,y-2)
    star.give_life_to(x-11,y-8)
    star.give_life_to(x-12,y-2)
    star.give_life_to(x-12,y-8)
    star.give_life_to(x-13,y-3)
    star.give_life_to(x-13,y-7)
    star.give_life_to(x-14,y-4)
    star.give_life_to(x-14,y-5)
    star.give_life_to(x-14,y-6)
    #right block
    star.give_life_to(x+10,y-2)
    star.give_life_to(x+10,y-3)
    star.give_life_to(x+11,y-2)
    star.give_life_to(x+11,y-3)
    #left block
    star.give_life_to(x-23,y-4)
    star.give_life_to(x-23,y-5)
    star.give_life_to(x-24,y-4)
    star.give_life_to(x-24,y-5)    
  end

end