def select(arr)
  result = []

  arr.each do |x|
    result << x if yield(x)
  end

  result
end

array = [1, 2, 3, 4, 5]

p array.select { |num| num.odd? }
p array.select { |num| puts num } 
p array.select { |num| num + 1 }