def times(int)
  num = 0
  
  while num < int do
    yield(num)
    num += 1
  end
  
  num
end

#Alternative Implimentation

def times(int)
  (0...int).each { |x| yield(x) }
  int
end