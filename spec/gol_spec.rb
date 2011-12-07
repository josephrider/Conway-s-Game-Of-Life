#update your code path here
$path = '/Users/rot/projects/GOL'

require "#{$path}/boot.rb"

describe "Conway's Game of Life" do
  let(:universe) { Universe.new }
  
  context "universe utilities" do
    
    describe "evolution" do
      it "should respond to the evolve! method" do
        universe.respond_to?(:evolve!)
      end
      
      it "should respond to the transform_life method" do
        universe.respond_to?(:transform_life)
      end
      
      it "should respond to the probe method" do
        universe.respond_to?(:probe)
      end
      
      it "should respond to the monitor method" do
        universe.respond_to?(:monitor)
      end
      
    end
    
    describe "toad constellation" do
      it "should have a toad_at method" do
        universe.respond_to?(:toad_at)
      end
      
      it "should create the expected number of stars" do
        expect{
          universe.toad_at(3,3)
        }.to change(universe.stars, :count).by(6)
      end
      
      it "should create a toad constellation relative to its initial passed values" do
        universe.toad_at(3,3)
        pseudo_universe = Universe.new
        pseudo_stars = []        
        pseudo_stars << Star.new(pseudo_universe,3,3)
        pseudo_stars << Star.new(pseudo_universe,2,3)
        pseudo_stars << Star.new(pseudo_universe,3,4)
        pseudo_stars << Star.new(pseudo_universe,4,3)        
        pseudo_stars << Star.new(pseudo_universe,4,4)                
        pseudo_stars << Star.new(pseudo_universe,5,4)                        
        pseudo_stars.each do |star|
          universe.stars.include?(star)
        end
      end
    end
    
    describe "beacon constellation" do
      it "should have a beacon_at method" do
        universe.respond_to?(:beacon_at)
      end
      
      it "should create the expected number of stars" do
        expect{
          universe.beacon_at(3,3)
        }.to change(universe.stars, :count).by(6)
      end
      
      it "should create a beacon constellation relative to its initial passed values" do
        universe.beacon_at(3,3)
        pseudo_universe = Universe.new
        pseudo_stars = []        
        pseudo_stars << Star.new(pseudo_universe,3,3)
        pseudo_stars << Star.new(pseudo_universe,3,4)
        pseudo_stars << Star.new(pseudo_universe,4,4)
        pseudo_stars << Star.new(pseudo_universe,5,1)        
        pseudo_stars << Star.new(pseudo_universe,6,2)                
        pseudo_stars << Star.new(pseudo_universe,6,1)                        
        pseudo_stars.each do |star|
          universe.stars.include?(star)
        end
      end
    end
    
    describe "blinker constellation" do
      it "should have a blinker_at method" do
        universe.respond_to?(:blinker_at)
      end
      
      it "should create the expected number of stars" do
        expect{
          universe.blinker_at(3,3)
        }.to change(universe.stars, :count).by(3)
      end
      
      it "should create a blinker constellation relative to its initial passed values" do
        universe.blinker_at(3,3)
        pseudo_universe = Universe.new
        pseudo_stars = []
        pseudo_stars << Star.new(pseudo_universe,3,3)
        pseudo_stars << Star.new(pseudo_universe,3,4)
        pseudo_stars << Star.new(pseudo_universe,3,2)
        pseudo_stars.each do |star|
          universe.stars.include?(star)
        end
      end
    end
    
  end
  
  context "star utilities" do
    subject { Star.new(universe) }
    it "should spawn relative to" do
      star = subject.give_life_to(2, 3)
      star.instance_of?(Star).should be_true
      star.x.should == 2
      star.y.should == 3
      star.universe.should == subject.universe
    end
    
    it "should respond to peers" do
      subject.should respond_to(:peers)
    end
    
    it "should respond to give_life_to" do
      subject.should respond_to(:give_life_to)
    end
    
    it "should have a peer to the North" do
      subject.give_life_to(0,1)
      subject.peers(universe).count.should == 1
    end
    
    it "should have a peer to the South" do
      subject.give_life_to(0,-1)
      subject.peers(universe).count.should == 1
    end
    
    it "should have a peer to the West" do
      subject.give_life_to(-1,0)
      subject.peers(universe).count.should == 1
    end
    
    it "should have a peer to the East" do
      subject.give_life_to(1,0)
      subject.peers(universe).count.should == 1
    end
    
    it "should have a peer to the Northeast" do
      subject.give_life_to(1,1)
      subject.peers(universe).count.should == 1
    end
    
    it "should have a peer to the Northwest" do
      subject.give_life_to(-1,1)
      subject.peers(universe).count.should == 1
    end
    
    it "should have a peer to the Southeast" do
      subject.give_life_to(-1,-1)
      subject.peers(universe).count.should == 1
    end
    
    it "should have a peer to the Southwest" do
      subject.give_life_to(-1,1)
      subject.peers(universe).count.should == 1
    end
    
  end
  describe "Rule: 1 (Any live star with fewer than two live peers dies, as if caused by under-population)" do
    it "should not recognize peers that are not directly connected" do
      star = Star.new(universe)
      new_star = star.give_life_to(2,0)
      star.peers(universe).count.should == 0
    end
    
    it "should kill off stars that don't have enough peers after an evolution" do
      star = Star.new(universe)
      new_star = star.give_life_to(2,0)
      universe.evolve!
      star.should be_lifeless
    end
    
    it "should remain stars that do have enough peers after an evolution" do
      star = Star.new(universe)
      new_star = star.give_life_to(1,0)
      other_new_star = star.give_life_to(-1,0)
      universe.evolve!
      star.should be_alive
    end
  end
  
  describe "Rule: 2 (Any live star with two or three live neighbours lives on to the next generation.)" do
    it "should survive with two peers" do
      star = Star.new(universe)
      first_peer = star.give_life_to(1,0)
      second_peer = star.give_life_to(-1,0)
      universe.evolve!
      star.should be_alive
    end
    
    it "should survive with three peers" do
      star = Star.new(universe)
      first_peer = star.give_life_to(1,0)
      second_peer = star.give_life_to(-1,0)
      third_peer = star.give_life_to(0,-1)
      universe.evolve!
      star.should be_alive
    end
    
    it "should not survive with four peers" do
      star = Star.new(universe)
      first_peer = star.give_life_to(1,0)
      second_peer = star.give_life_to(-1,0)
      third_peer = star.give_life_to(0,-1)
      fourth_peer = star.give_life_to(-1,-1)      
      universe.evolve!
      star.should be_lifeless
    end
  end
  
  describe "Rule: 3 (Any live star with more than three live neighbours dies, as if by overcrowding)" do
    it "should die as expected" do
      star = Star.new(universe)
      first_peer = star.give_life_to(1,0)
      second_peer = star.give_life_to(1,1)
      third_peer = star.give_life_to(1,-1)
      fourth_peer = star.give_life_to(-1,0)      
      universe.evolve!
      star.should be_lifeless
    end
  end
  
  describe "Rule: 4 (Any dead star with exactly three live neighbours becomes a live star, as if by reproduction)" do
    it "should resurrect a dead star" do
      star = Star.new(universe)
      pseudo_star = Star.new(Universe.new,-1,0)
      first_peer = star.give_life_to(0,1)
      second_peer = star.give_life_to(0,-1)
      !universe.stars.include?(pseudo_star)
      universe.evolve!
      universe.stars.include?(pseudo_star)
    end
  end

  
end