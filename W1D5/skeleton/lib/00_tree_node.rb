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


# class Node
#   attr_reader :val, :children
#   def initialize(val, children = [])
#     @val = val
#     @children = children
#   end
#
# end
# def dfs(node, target)
#   return node if node.value == target
#   node.children.each do |child|
#     result = dfs(child, target)
#     #return result if result
#   end
#   nil
# end
