local str = require 'str'
local format = string.format

function it(name, func)
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

it('should returns "javascript"', function()
   assert_equal(str.slice('lua, javascript, python', 6, 15), 'javascript')
end)

it('should returns "javascript, python"', function()
   assert_equal(str.slice('lua, javascript, python', 6), 'javascript, python')
end)

it('should returns true', function()
    assert_equal(str.starts_with('lua is a great language', 'lua'), true)
end)

it('should returns true', function()
    assert_equal(str.starts_with('lua is a great language', 'ruby'), false)
end)
