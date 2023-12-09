class Node
  attr_accessor :data, :left, :right
  def initialize(data)
    @data = data
    @left = nil
    @right = nil
  end
end

class Tree
  def initialize(arr)
    @root = build_tree(arr)
  end

  def build_tree(arr, start = 0, final = arr.length)
    return nil if start > final
    mid = (start + final) / 2
    root = Node.new(arr[mid])
    root.left = build_tree(arr, start, mid - 1)
    root.right = build_tree(arr, mid + 1, final)
    root
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end

arr = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]

tree = Tree.new(arr)
tree.pretty_print
