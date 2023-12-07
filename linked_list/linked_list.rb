class LinkedList
  def initialize
    @head = nil
    @tail = nil
  end

  def append(value)
    node = Node.new(value)
    if @head.nil?
      @head = node
      @tail = node
    else
      @tail.next = node
      @tail = node
    end
  end

  def preppend(value)
    node = Node.new(value)
    if @head.nil?
      @head = node
      @tail = node
    else
      node.next = @head
      @head = node
    end
  end

  def size
    counter = 0
    node = @head
    while node != nil
      node = node.next
      counter += 1
    end
    counter
  end

  def head
    @head.value.dup
  end

  def tail
    @tail.value.dup
  end

  def to_s
    node = @head
    stringfied_list = ""
    while node != nil
      stringfied_list << "(#{node.value.to_s}) -> "
      node = node.next
    end
    stringfied_list << 'nil'
    stringfied_list
  end
end

class Node
  attr_accessor :value, :next

  def initialize(value)
    @value = value
    @next = nil
  end
end
