class KnightPathFinder

  attr_reader :position
  attr_accessor :board

  def initialize(position, board = Array.new(8){Array.new(8)})
    @board = board
    @position = PolyTreeNode.new(position)
    @visited_positions = [@position]
    @tree = build_move_tree
  end

  def build_move_tree
    queue = [@position]
    until queue.empty?
      current_node = queue.shift
      new_move_positions(current_node)

    end

  end

  def find_path

  end
    #pos = [2, 0]
  def self.valid_moves(pos)
    directions = [[2,1], [1,2], [-2,-1], [-1,-2], [1 -2], [-1, 2], [2,-1], [-2, 1]]
    valid_moves = []
    directions.each do |direction|
      x_pos = direction[0] + pos[0]
      y_pos = direction[1] + pos[1]
      move = [x_pos, y_pos]
      valid_moves << move unless move.any? {|position| !position.between?(0, 7) }
    end
    valid_moves
  end

  def new_move_positions(pos)
    possible_moves = KnightPathFinder.valid_moves(pos)
    @visited_positions += possible_moves.reject!{ |position| @visited_positions.include?(position) }
    possible_moves
  end
end






class PolyTreeNode

  attr_reader :value, :parent, :children

  def initialize(value)
    @parent = nil
    @children = []
    @value = value
  end


  #sets the parent of current node to the passed in node
  #also sets current node as passed in node's child
  def parent=(node)
    # this is for deleting child when we are reassigning parent
    if @parent != nil
      @parent.children.delete(self)
    end

    @parent = node
    if node
      node.children << self unless node.children.include?(self)
    end
  end

  def add_child(child_node)
    child_node.parent=(self)
  end

  def remove_child(child_node)
    unless @children.include?(child_node)
      raise "that's not your child!"
    else
      child_node.parent=(nil)
    end
    #child_node.parent
  end

  def dfs(target_value)
    return self if target_value == self.value
    @children.each do |child|
      result = child.dfs(target_value)
      return result if result
    end
    nil
  end

  def bfs(target_value)
    queue = [self]
    until queue.empty?
      current_node = queue.shift
      return current_node if current_node.value == target_value
      current_node.children.each do |child|
        queue << child
      end
    end

  end

end
