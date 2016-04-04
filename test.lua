local str = require 'str'
local format = string.format

function test(name, func)
  xpcall(function()
    func()
    print(format('[pass] %s', name))
  end, function(err)
    print(format('[fail] %s : %s', name, err))  
  end)
end

function _equal(a, b)
  return a == b
end

function assert_equal(a, b)
  assert(_equal(a, b))
end

test('make slice with start and end', function()
   assert_equal(str.slice('lua, javascript, python', 6, 15), 'javascript')
end)

test('make slice with start and without end parameter', function()
   assert_equal(str.slice('lua, javascript, python', 6), 'javascript, python')
end)
