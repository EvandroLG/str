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

test('slice should returns "javascript"', function()
   assert_equal(str.slice('lua, javascript, python', 6, 15), 'javascript')
end)

test('slice should returns "javascript, python"', function()
   assert_equal(str.slice('lua, javascript, python', 6), 'javascript, python')
end)

test('starts_with should returns true', function()
    assert_equal(str.starts_with('lua is a great language', 'lua'), true)
end)

test('starts_with should returns true', function()
    assert_equal(str.starts_with('lua is a great language', 'ruby'), false)
end)

test('ends_with  should returns true', function()
    assert_equal(str.ends_with('lua is a great language', 'language'), true)
end)

test('ends_with should returns false', function()
    assert_equal(str.ends_with('lua is a great language', 'programming'), false)
end)

test('is_ascii should returns true', function()
    assert_equal(str.is_ascii('lua is a great language'), true)
end)

test('is_ascii should returns false', function()
    assert_equal(str.is_ascii('ت'), false)
end)
