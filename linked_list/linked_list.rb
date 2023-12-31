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
    index.times do
      node = node.next
    end
    node
  end

  def pop
    @tail = nil
    at(size - 1).next = nil
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

  def contains?(value)
    node = @head
    while node != nil
      if node.value == value
        return true
      end
      node = node.next
    end
    false
  end

  def find(value)
    return nil unless contains?(value)
    i = 0
    while i <= size
      node = at(i)
      return i if node.value == value
      i += 1
    end
  end
end
