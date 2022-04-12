def each(arr)
  idx = 0
  
  while idx < arr.size
    yield(arr[idx])
    idx += 1
  end
  
  arr
end

#alternative Implementation

def each(arr)
  arr.size.times { |idx| yield(arr[idx]) }
  arr
end
