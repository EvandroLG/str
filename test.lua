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

test('count should returns 0', function()
    assert_equal(str.count('lua is a great language. lua is a brazilian language', 'python'), 0)
end)

test('count should returns how many times the substring was found', function()
    assert_equal(str.count('lua is a great language. lua is a brazilian language', 'lua'), 2)
end)

test('trim_left should returns string without left blank spaces', function()
    assert_equal(str.trim_left('  lua is a great language'), 'lua is a great language')
end)

test('trim_right should returns string without right blank spaces', function()
    assert_equal(str.trim_right('lua is a great language  '), 'lua is a great language')
end)

test('trim should returns string with complete trim', function()
    assert_equal(str.trim('  lua is a great language  '), 'lua is a great language')
end)

test('is_number should returns true', function()
    assert_equal(str.is_number('12345'), true)
end)

test('is_number should returns false', function()
    assert_equal(str.is_number('1234a5'), false)
end)

test('is_number should returns false when value is empty', function()
    assert_equal(str.is_number(''), false)
end)

test('center should returns centralized string', function()
    assert_equal(str.center('lua', 3), '   lua   ')
end)

test('split should returns a table resultant from the splited string', function()
    local result = str.split('lua is a great language', ' ')

    assert_equal(#result, 5)
    assert_equal(result[1], 'lua')
    assert_equal(result[2], 'is')
    assert_equal(result[3], 'a')
    assert_equal(result[4], 'great')
    assert_equal(result[5], 'language')
end)

test('slug should returns a new lowercase string and without spaces', function()
    local result = str.slug('Lua is a great language')
    assert_equal(result, 'lua-is-a-great-language')
end)

test('slug should returns a new string without accents', function()
    local result = str.slug('Lua é uma ótima linguagem')
    assert_equal(result, 'lua-e-uma-otima-linguagem')
end)

test('each_char should returns every character of the string', function()
    local result = {}
    str.each_char('lua', function(char)
        table.insert(result, char)
    end)

    assert_equal(#result, 3)
    assert_equal(result[1], 'l')
    assert_equal(result[2], 'u')
    assert_equal(result[3], 'a')
end)

test('each_byte should returns the byte of every character of the string', function()
    local result = {}
    str.each_byte('lua', function(char)
        table.insert(result, char)
    end)

    assert_equal(#result, 3)
    assert_equal(result[1], 108)
    assert_equal(result[2], 117)
    assert_equal(result[3], 97)
end)

test('each_line should returns every line of the string', function()
    local result = {}
    str.each_line('lua\nruby\npython', function(line)
        table.insert(result, line)
    end)

    assert_equal(#result, 3)
    assert_equal(result[1], 'lua')
    assert_equal(result[2], 'ruby')
    assert_equal(result[3], 'python')
end)
