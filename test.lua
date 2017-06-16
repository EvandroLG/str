local test = require 'simple_test'
local str = require 'str'

test('meta infos', function(a)
  a.equal(str.__VERSION, '1.4.0')
  a.equal(str.__DESCRIPTION, "str is a string module with useful methods that don't exist in Lua's core")
end)

test('slice should returns "javascript"', function(a)
  a.equal(str.slice('lua, javascript, python', 6, 15), 'javascript')
end)

test('slice should returns "javascript, python"', function(a)
  a.equal(str.slice('lua, javascript, python', 6), 'javascript, python')
end)

test('starts_with should returns true', function(a)
  a.equal(str.starts_with('lua is a great language', 'lua'), true)
end)

test('starts_with should returns true', function(a)
  a.equal(str.starts_with('lua is a great language', 'ruby'), false)
end)

test('ends_with  should returns true', function(a)
  a.equal(str.ends_with('lua is a great language', 'language'), true)
end)

test('ends_with should returns false', function(a)
  a.equal(str.ends_with('lua is a great language', 'programming'), false)
end)

test('is_ascii should returns true', function(a)
  a.equal(str.is_ascii('lua is a great language'), true)
end)

test('is_ascii should returns false', function(a)
  a.equal(str.is_ascii('á'), false)
end)

test('capitalize should returns string with first uppercase character', function(a)
  a.equal(str.capitalize('lua is a great language'), 'Lua is a great language')
end)

test('count should returns 0', function(a)
  a.equal(str.count('lua is a great language. lua is a brazilian language', 'python'), 0)
end)

test('count should returns how many times the substring was found', function(a)
  a.equal(str.count('lua is a great language. lua is a brazilian language', 'lua'), 2)
end)

test('trim_left should returns string without left blank spaces', function(a)
  a.equal(str.trim_left('  lua is a great language'), 'lua is a great language')
end)

test('trim_right should returns string without right blank spaces', function(a)
  a.equal(str.trim_right('lua is a great language  '), 'lua is a great language')
end)

test('trim should returns string with complete trim', function(a)
  a.equal(str.trim('  lua is a great language  '), 'lua is a great language')
end)

test('is_number should returns true', function(a)
  a.equal(str.is_number('12345'), true)
end)

test('is_number should returns false', function(a)
  a.equal(str.is_number('1234a5'), false)
end)

test('is_number should returns false when value is empty', function(a)
  a.equal(str.is_number(''), false)
end)

test('center should returns centralized string', function(a)
  a.equal(str.center('lua', 3), '   lua   ')
end)

test('split should returns a table resultant from the splited string', function(a)
  local result = str.split('lua is a great language', ' ')

  a.equal(#result, 5)
  a.equal(result[1], 'lua')
  a.equal(result[2], 'is')
  a.equal(result[3], 'a')
  a.equal(result[4], 'great')
  a.equal(result[5], 'language')
end)

test('slug should returns a new lowercase string and without spaces', function(a)
  local result = str.slug('Lua is a great language')
  a.equal(result, 'lua-is-a-great-language')
end)

test('slug should returns a new string without accents', function(a)
  local result = str.slug('Lua é uma ótima linguagem')
  a.equal(result, 'lua-e-uma-otima-linguagem')
end)

test('each_char should returns every character of the string', function(a)
  local result = {}
  str.each_char('lua', function(char)
    table.insert(result, char)
  end)

  a.equal(#result, 3)
  a.equal(result[1], 'l')
  a.equal(result[2], 'u')
  a.equal(result[3], 'a')
end)

test('each_byte should returns the byte of every character of the string', function(a)
  local result = {}
  str.each_byte('lua', function(char)
    table.insert(result, char)
  end)

  a.equal(#result, 3)
  a.equal(result[1], 108)
  a.equal(result[2], 117)
  a.equal(result[3], 97)
end)

test('each_line should returns every line of the string', function(a)
  local result = {}
  str.each_line('lua\nruby\npython', function(line)
    table.insert(result, line)
  end)

  a.equal(#result, 3)
  a.equal(result[1], 'lua')
  a.equal(result[2], 'ruby')
  a.equal(result[3], 'python')
end)

test('bytes should returns a table with bytes of every string character', function(a)
  local result = str.bytes('lua')

  a.equal(type(result), 'table')
  a.equal(#result, 3)
  a.equal(result[1], 108)
  a.equal(result[2], 117)
  a.equal(result[3], 97)
end)

test('delete should returns a copy of the string with the characters passed as arguments deleted', function(a)
  local result = str.delete('hello world!', {'h', 'o'})
  a.equal(result, 'ell wrld!')
end)
