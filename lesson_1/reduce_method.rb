def reduce(arr, acc=nil)
  unless acc
    arr[0].class == Integer ? acc = 0 : acc = arr[0].class.new
  end
  
  arr.each { |x| acc = yield(acc, x) }
  acc
end

p reduce(['a', 'b', 'c']) { |acc, value| acc += value }     # => 'abc'
p reduce([[1, 2], ['a', 'b']]) { |acc, value| acc + value } # => [1, 2, 'a', 'b']

array = [1, 2, 3, 4, 5]

p reduce(array) { |acc, num| acc + num }                    # => 15
p reduce(array, 10) { |acc, num| acc + num }                # => 25
