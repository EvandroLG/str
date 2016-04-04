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
    assert_equal(str.is_ascii('á'), false)
end)

test('capitalize should returns string with first uppercase character', function()
    assert_equal(str.capitalize('lua is a great language'), 'Lua is a great language')
end)

test('count should returns how many times the substring was found', function()
    assert_equal(str.count('lua is a great language. lua is a brazilian language', 'lua'), 2)
end)

test('trim_left should returns string without left blank spaces', function()
    assert_equal(str.trim_left('  lua is a great language'), 'lua is a great language')
end)
