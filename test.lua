local test = require 'simple_test'
local str = require 'str'

test('meta infos', function(a)
  a.equal(str.__VERSION, '1.4.0')
  a.equal(str.__DESCRIPTION, "str is a string module with useful methods that don't exist in Lua's core")
end)

test('slice', function(a)
  a.equal(
    str.slice('lua, javascript, python', 6, 15),
    'javascript'
  )

  a.equal(
    str.slice('lua, javascript, python', 6),
    'javascript, python'
  )
end)

test('starts_with', function(a)
  a.equal(
    str.starts_with('lua is a great language', 'lua'),
    true
  )

  a.equal(
    str.starts_with('lua is a great language', 'ruby'),
    false
  )
end)

test('ends_with', function(a)
  a.equal(
    str.ends_with('lua is a great language', 'language'),
    true
  )

  a.equal(
    str.ends_with('lua is a great language', 'programming'),
    false
  )
end)

test('is_ascii', function(a)
  a.equal(
    str.is_ascii('lua is a great language'),
    true
  )

  a.equal(
    str.is_ascii('á'), false
  )
end)

test('capitalize', function(a)
  a.equal(
    str.capitalize('lua is a great language'),
    'Lua is a great language'
  )
end)

test('count', function(a)
  a.equal(
    str.count('lua is a great language. lua is a brazilian language', 'python'),
    0
  )

  a.equal(
    str.count('lua is a great language. lua is a brazilian language', 'lua'),
    2
  )
end)

test('trim_left', function(a)
  a.equal(
    str.trim_left('  lua is a great language'),
    'lua is a great language'
  )
end)

test('trim_right', function(a)
  a.equal(
    str.trim_right('lua is a great language  '),
    'lua is a great language'
  )
end)

test('trim', function(a)
  a.equal(
    str.trim('  lua is a great language  '),
    'lua is a great language'
  )
end)

test('is_number', function(a)
  a.equal(
    str.is_number('12345'),
    true
  )

  a.equal(
    str.is_number('1234a5'),
    false
  )

  a.equal(
    str.is_number(''),
    false
  )
end)

test('center', function(a)
  a.equal(
    str.center('lua', 3),
    '   lua   '
  )
end)

test('split', function(a)
  local result = str.split('lua is a great language', ' ')

  a.equal(#result, 5)
  a.equal(result[1], 'lua')
  a.equal(result[2], 'is')
  a.equal(result[3], 'a')
  a.equal(result[4], 'great')
  a.equal(result[5], 'language')
end)

test('slug', function(a)
  a.equal(
    str.slug('Lua is a great language'),
    'lua-is-a-great-language'
  )

  a.equal(
    str.slug('Lua é uma ótima linguagem'),
    'lua-e-uma-otima-linguagem'
  )
end)

test('each_char', function(a)
  local result = {}
  str.each_char('lua', function(char)
    table.insert(result, char)
  end)

  a.equal(#result, 3)
  a.equal(result[1], 'l')
  a.equal(result[2], 'u')
  a.equal(result[3], 'a')
end)

test('each_byte', function(a)
  local result = {}
  str.each_byte('lua', function(char)
    table.insert(result, char)
  end)

  a.equal(#result, 3)
  a.equal(result[1], 108)
  a.equal(result[2], 117)
  a.equal(result[3], 97)
end)

test('each_line', function(a)
  local result = {}
  str.each_line('lua\nruby\npython', function(line)
    table.insert(result, line)
  end)

  a.equal(#result, 3)
  a.equal(result[1], 'lua')
  a.equal(result[2], 'ruby')
  a.equal(result[3], 'python')
end)

test('bytes', function(a)
  local result = str.bytes('lua')

  a.equal(type(result), 'table')
  a.equal(#result, 3)
  a.equal(result[1], 108)
  a.equal(result[2], 117)
  a.equal(result[3], 97)
end)

test('delete', function(a)
  a.equal(
    str.delete('hello world!', {'h', 'o'}),
    'ell wrld!'
  )
end)

test('truncate', function(a)
  local value = string.rep('Lorem ipsum ', 10)

  a.equal(
    str.truncate(value),
    'Lorem ipsum Lorem ipsum Lor...'
  )

  a.equal(
    str.truncate(value, { size = 10 }),
    'Lorem i...'
  )

  a.equal(
    str.truncate(value, { size = 10, omission = '.' }),
    'Lorem ips.'
  )
end)
