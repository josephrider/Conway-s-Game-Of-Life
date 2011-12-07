module Constellations

  def toad_at(x,y)
    star = Star.new(self,x,y)
    star1 = star.give_life_to(x-1,y)
    star2 = star.give_life_to(x,y+1)
    star3 = star.give_life_to(x+1,y)
    star4 = star.give_life_to(x+1,y+1)
    star5 = star.give_life_to(x+2,y+1)
  end
  
  def beacon_at(x,y)
    star = Star.new(self,x,y)
    star1 = star.give_life_to(x,y+1)
    star2 = star.give_life_to(x+1,y+1)
    star3 = star.give_life_to(x+2,y-2)
    star4 = star.give_life_to(x+3,y-1)
    star5 = star.give_life_to(x+3,y-2)
  end
  
  def blinker_at(x,y)
    star = Star.new(self,x,y)    
    star1 = star.give_life_to(x,y+1)
    star2 = star.give_life_to(x,y-1)
  end

end