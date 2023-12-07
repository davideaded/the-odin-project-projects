class Node
  attr_accessor :value, :next

  def initialize(value)
    @value = value
    @next = nil
  end
end

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
    @head ? @head.value.dup : nil
  end

  def tail
    @tail ? @tail.value.dup : nil
  end

  def at(index)
  return nil if index > size
    node = @head
    i = 1
    while i < index
      node = node.next
      i += 1
    end
    node
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

  def pop
    @tail = nil
    at(size - 1).next = nil
  end
end
