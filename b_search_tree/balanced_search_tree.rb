class Node
  attr_accessor :data, :left, :right
  def initialize(data)
    @data = data
    @left = nil
    @right = nil
  end
end

class Tree
  attr_reader :root
  def initialize(arr)
    @root = build_tree(arr.sort.uniq)
  end

  def build_tree(arr)
    return nil if arr.empty?

    mid = arr.length / 2
    root = Node.new(arr[mid])
    root.left = build_tree(arr[0...mid])
    root.right = build_tree(arr[(mid + 1)..-1])
    root
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  def insert(node = @root, value)
    return Node.new(value) if node.nil?

    if value > node.data
      node.right = insert(node.right, value)
    elsif value < node.data
      node.left = insert(node.left, value)
    end
    node
  end

  def delete(node = @root, value)
    return node if node.nil?
    if value < node.data
      node.left = delete(node.left, value)
    elsif value > node.data
      node.right = delete(node.right, value)
    else
      return node.right if node.left.nil?
      return node.left if node.right.nil?

      leftmost_node = leftmost_leaf(node.right)
      node.data = leftmost_node.data
      node.right = delete(node.right, leftmost_node.data)
    end
    node
  end

  def leftmost_leaf(node)
    node = node.left until node.left.nil?
    node
  end

  def find(value, node = @root)
    return node if node.nil? || node.data == value
    value < node.data ? find(value, node.left) : find(value, node.right)
  end

  def level_order
    queue = [@root]
    values = []
    while !queue.empty?
      node = queue.shift
      values << node.data
      queue.push(node.left) unless node.left.nil?
      queue.push(node.right) unless node.right.nil?
      yield node if block_given?
    end
    values
  end

  def rec_level_order(queue = [@root], values = [], &block)
    return values if queue.empty?
    node = queue.shift
    values << node.data if node
    yield node if block_given?
    queue.push(node.left) unless node.left.nil?
    queue.push(node.right) unless node.right.nil?
    rec_level_order(queue, values, &block)
  end

  def preorder
    node = @root
    values = []
    stack = [node]

    while !stack.empty?
      node = stack.pop
      yield node if block_given?
      values << node.data
      stack.push(node.right) if node.right != nil
      stack.push(node.left) if node.left != nil
    end
    values
  end

  def inorder
    node = @root
    values = []
    stack = []

    while !stack.empty? || node
      while node
        stack.push(node)
        node = node.left
      end

      node = stack.pop
      yield node if block_given?
      values << node.data
      node = node.right
    end
    values
  end


  def postorder
    node = @root
    values = []
    stack = [node.right, node.left]

    while !stack.empty?
      node = stack.pop
      yield node if block_given?
      values << node.data
      stack.push(node.right) if node.right != nil
      stack.push(node.left) if node.left != nil
    end
    node = @root
    yield node if block_given?
    values << node.data
    values
  end

  def height(node)
    return -1 if node.nil?

    left_height = height(node.left)
    right_height = height(node.right)

    [left_height, right_height].max + 1
  end

  def depth(n, node = @root, i = 0)
    return i if n == node.data
    if n < node.data
      depth(n, node.left, i +=1)
    else
      depth(n, node.right, i+=1)
    end
  end

  def balanced?(node = @root)
    return true if node.nil?
    left_height = height(node.left)
    right_height = height(node.right)

    return true if (left_height - right_height).abs <= 1 && balanced?(node.left) && balanced?(node.right)
    false
  end

  def rebalance
    @root = build_tree(inorder)
  end
end

arr = (Array.new(15) { rand(1..100) })
tree = Tree.new(arr)
p tree.balanced?
p tree.level_order
p tree.preorder
p tree.postorder
p tree.inorder

5.times do
  n = rand(100..500)
  tree.insert(n)
end
p tree.balanced?
tree.rebalance
p tree.balanced?
p tree.level_order
p tree.preorder
p tree.postorder
p tree.inorder
# tree.pretty_print
