require "#{$path}/star.rb"
require "#{$path}/universe.rb"

describe "Conway's Game of Life" do
  let(:universe) { Universe.new }
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