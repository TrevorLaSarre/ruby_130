class TodoList
  attr_accessor :title

  def initialize(title)
    @title = title
    @todos = []
  end
  
  def add(item)
    if item.class == Todo
      @todos << item
    else
      raise TypeError('Can only add Todo objects')
    end
  end
  
  def <<(item)
    add(item)
  end
  
  def size
    @todos.size
  end
  
  def first
    item_at(0)
  end
  
  def last
    item_at(-1)
  end
  
  def to_a
    @todos.clone
  end
  
  def done?
    @todos.all? { |x| x.done? }
  end
  
  def item_at(idx)
    @todos.fetch(idx)
  end
  
  def mark_done_at(idx)
    item_at(idx).done!
  end
  
  def mark_undone_at(idx)
    item_at(idx).undone!
  end
  
  def done!
    @todos.each { |x| x.done! }
  end
  
  def shift
    @todos.shift
  end
  
  def pop
    @todos.pop
  end
  
  def remove_at(idx)
    @todos.delete_at(idx)
  end
  
  def to_s
    output = "---- Today's Todos ----\n"
    output += @todos.map(&:to_s).join("\n")
  end
  
  def each
    @todos.each { |x| yield(x) }
    self
  end
  
  def select
    result = TodoList.new(title)
    each { |obj| result << obj if yield(obj) }
    result
  end
  
  def find_by_title(title)
    each { |x| return x if x.title == title }
    nil
  end
  
  def all_done
    select { |x| x.done? }
  end
  
  def all_not_done
    select { |x| !x.done? }
  end
  
  def mark_done(title)
    each { |x| x.done! if x.title == title }
  end
  
  def mark_all_done
    each { |x| x.done! }
  end
  
  def marl_all_not_done
    each { |x| x.undone! }
  end
end

class Todo
  DONE_MARKER = 'X'
  UNDONE_MARKER = ' '

  attr_accessor :title, :description, :done

  def initialize(title, description='')
    @title = title
    @description = description
    @done = false
  end

  def done!
    self.done = true
  end

  def done?
    done
  end

  def undone!
    self.done = false
  end

  def to_s
    "[#{done? ? DONE_MARKER : UNDONE_MARKER}] #{title}"
  end

  def ==(otherTodo)
    title == otherTodo.title &&
      description == otherTodo.description &&
      done == otherTodo.done
  end
end

todo1 = Todo.new("Buy milk")
todo2 = Todo.new("Clean room")
todo3 = Todo.new("Go to gym")

list = TodoList.new("Today's Todos")
list.add(todo1)
list.add(todo2)
list.add(todo3)

todo1.done!

results = list.select { |todo| todo.done? }    # you need to implement this method

puts results.inspect