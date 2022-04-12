require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require "minitest/reporters"
Minitest::Reporters.use!

require_relative 'todolist'

class TodoListTest < MiniTest::Test

  def setup
    @todo1 = Todo.new("Buy milk")
    @todo2 = Todo.new("Clean room")
    @todo3 = Todo.new("Go to gym")
    @todos = [@todo1, @todo2, @todo3]

    @list = TodoList.new("Today's Todos")
    @list.add(@todo1)
    @list.add(@todo2)
    @list.add(@todo3)
  end
  
  def test_to_a
    assert_equal(@todos, @list.to_a)
  end

  def test_size
    assert_equal(3, @list.size)
  end
  
  def test_first
    assert_equal(@todo1, @list.first)
  end
  
  def test_last
    assert_equal(@todo3, @list.last)
  end
  
  def test_shift
    todo = @list.shift
    assert_equal(@todo1, todo)
    assert_equal(@todos[1,2], @list.to_a)
  end
  
  def test_pop
    todo = @list.pop
    assert_equal(@todo3, todo)
    assert_equal(@todos[0,2], @list.to_a)
  end
  
  def test_done?
    assert_equal(false, @list.done?)
  end
  
  def test_raises_type_error
    assert_raises(TypeError) { @list << "Hello" }
  end
  
  def test_shovel
    new_item = Todo.new('Test')
    @list << Todo.new('Test')
    assert_equal(new_item, @list.last)
  end
  
  def test_add
    new_item = Todo.new('Test')
    @list.add(Todo.new('Test'))
    assert_equal(new_item, @list.last)
  end
  
  def test_item_at
    assert_raises(IndexError) { @list.item_at(5) }
    assert_equal(@todos[0], @list.item_at(0))
  end
  
  def test_mark_done_at?
    assert_raises(IndexError) { @list.mark_done_at(5) }
    assert_equal(false, @todo1.done?)
    @list.mark_done_at(0)
    assert_equal(true, @todo1.done?)
  end
  
  def test_mark_undone_at?
    assert_raises(IndexError) { @list.mark_undone_at(5) }
    @todo1.done!
    assert_equal(true, @todo1.done?)
    @list.mark_undone_at(0)
    assert_equal(false, @todo1.done?)
  end
  
  def test_done!
    assert_equal(false, @list.done?)
    @list.done!
    assert_equal(true, @list.done?)
  end
  
  def test_remove_at
    assert_raises(IndexError) { @list.remove_at(100) }
    @list.remove_at(0)
    assert_equal(@todos[1,2], @list.to_a)
  end
  
  def test_to_s
    output = <<~OUTPUT.chomp
      ---- Today's Todos ----
      [ ] Buy milk
      [ ] Clean room
      [ ] Go to gym
      OUTPUT
      
    assert_equal(output, @list.to_s)
  end
  
  def test_to_s_one_done
    output = <<~OUTPUT.chomp
      ---- Today's Todos ----
      [X] Buy milk
      [ ] Clean room
      [ ] Go to gym
      OUTPUT
    
    @list.mark_done_at(0)
    assert_equal(output, @list.to_s)
  end
  
  def test_to_s_all_done
    output = <<~OUTPUT.chomp
      ---- Today's Todos ----
      [X] Buy milk
      [X] Clean room
      [X] Go to gym
      OUTPUT
    
    @list.done!
    assert_equal(output, @list.to_s)
  end
  
  def test_each
    @list.each { |x| x.done! }
    assert_equal(true, @list.done?)
  end
  
  def test_each_return
    assert_equal(@list, @list.each { |x| nil })
  end
  
  def test_select
    @list.mark_done_at(1)
    new_list = @list.select { |x| x.done? }
    assert_equal([@todo2], new_list.to_a)
  end
  
  def test_find_by_title
    assert_equal(@todo1, @list.find_by_title("Buy milk"))
  end
  
  def test_all_done
    assert_equal([], @list.all_done.to_a)
    @list.done!
    assert_equal(@todos, @list.all_done.to_a)
  end
  
  def test_all_not_done
    assert_equal(@todos, @list.all_not_done.to_a)
    @list.done!
    assert_equal([], @list.all_not_done.to_a)
  end
  
  def test_mark_done
    @list.mark_done("Buy milk")
    assert(@todo1.done?)
  end
  
  def test_mark_all_done
    @list.mark_all_done
    assert_equal(@todos, @todos.select { |x| x.done? })
  end
  
  def test_mark_all_not_done
    @list.mark_all_done
    @list.mark_all_not_done
    assert_equal(@todos, @todos.reject { |x| x.done? })
  end
end