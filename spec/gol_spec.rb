require "/Users/rot/projects/GOL/cell.rb"
require "/Users/rot/projects/GOL/universe.rb"

describe "Conway's Game of Life" do
  let(:universe) { Universe.new }
  context "cell utilities" do
    subject { Cell.new(universe) }
    it "should spawn relative to" do
      cell = subject.give_life_to(2, 3)
      cell.instance_of?(Cell).should be_true
      cell.x.should == 2
      cell.y.should == 3
      cell.universe.should == subject.universe
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
  describe "Rule: 1 (Any live cell with fewer than two live peers dies, as if caused by under-population)" do
    it "should not recognize peers that are not directly connected" do
      cell = Cell.new(universe)
      new_cell = cell.give_life_to(2,0)
      cell.peers(universe).count.should == 0
    end
    
    it "should kill off cells that don't have enough peers after an evolution" do
      cell = Cell.new(universe)
      new_cell = cell.give_life_to(2,0)
      universe.evolve!
      cell.should be_lifeless
    end
    
    it "should remain cells that do have enough peers after an evolution" do
      cell = Cell.new(universe)
      new_cell = cell.give_life_to(1,0)
      other_new_cell = cell.give_life_to(-1,0)
      universe.evolve!
      cell.should be_alive
    end
  end
  
  describe "Rule: 2 (Any live cell with two or three live neighbours lives on to the next generation.)" do
    it "should survive with two peers" do
      cell = Cell.new(universe)
      first_peer = cell.give_life_to(1,0)
      second_peer = cell.give_life_to(-1,0)
      universe.evolve!
      cell.should be_alive
    end
    
    it "should survive with three peers" do
      cell = Cell.new(universe)
      first_peer = cell.give_life_to(1,0)
      second_peer = cell.give_life_to(-1,0)
      third_peer = cell.give_life_to(0,-1)
      universe.evolve!
      cell.should be_alive
    end
    
    it "should not survive with four peers" do
      cell = Cell.new(universe)
      first_peer = cell.give_life_to(1,0)
      second_peer = cell.give_life_to(-1,0)
      third_peer = cell.give_life_to(0,-1)
      fourth_peer = cell.give_life_to(-1,-1)      
      universe.evolve!
      cell.should be_lifeless
    end
  end
  
  describe "Rule: 3 (Any live cell with more than three live neighbours dies, as if by overcrowding)" do
    it "should die as expected" do
      cell = Cell.new(universe)
      first_peer = cell.give_life_to(1,0)
      second_peer = cell.give_life_to(1,1)
      third_peer = cell.give_life_to(1,-1)
      fourth_peer = cell.give_life_to(-1,0)      
      universe.evolve!
      cell.should be_lifeless
    end
  end
  
  describe "Rule: 4 (Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction)" do
    it "should resurrect a dead cell" do
      cell = Cell.new(universe)
      psuedo_cell = Cell.new(Universe.new,-1,0)
      first_peer = cell.give_life_to(0,1)
      second_peer = cell.give_life_to(0,-1)
      !universe.cells.include?(psuedo_cell)
      universe.evolve!
      universe.cells.include?(psuedo_cell)
    end
  end

  
end