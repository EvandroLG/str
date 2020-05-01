local utf8 = require 'lua-utf8'
local utils = require 'str.utils'

local str

str = {
  __VERSION = '1.4.0',
  __DESCRIPTION = "str is a string module with useful methods that don't exist in Lua's core",
  __LICENCE = [[
    The MIT License (MIT)

    Copyright (c) 2017 Evandro Leopoldino Gonçalves

    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in all
    copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
    SOFTWARE.
  ]],

  slice = function(s, start, finish)
    return string.sub(s, start, finish or #s)
  end,

  starts_with = function(s, start)
    return string.sub(s, 1, #start) == start
  end,

  ends_with = function(s, finish)
    return string.sub(s, -#finish) == finish
  end,

  count = function(s, substr)
    local total = 0
    local start = nil
    local finish = 1

    repeat
      start, finish = string.find(s, substr, finish, true)
      if start then total = total + 1 end
    until start == nil

    return total
  end,

  split = function(s, pattern)
    local output = {}
    local fpat = '(.-)' .. pattern
    local last_end = 1
    local _s, e, cap = s:find(fpat, 1)

    while _s do
      if _s ~= 1 or cap ~= '' then
        table.insert(output, cap)
      end

      last_end = e+1
      _s, e, cap = s:find(fpat, last_end)
    end

    if last_end <= #s then
      cap = s:sub(last_end)
      table.insert(output, cap)
    end

    return output
  end,

  trim_right = function(s)
    return string.match(s, '(.-)%s*$')
  end,

  trim_left = function(s)
    return string.match(s, '[^%s+].*')
  end,

  trim = function(s)
    return str.trim_right(str.trim_left(s))
  end,

  capitalize = function(s)
    if #s == 0 then
      return s
    end

    local output = {}
    output[1] = string.upper(string.sub(s, 1, 1))

    for i=2, #s do
      local character = string.sub(s, i, i)
      table.insert(output, string.lower(character))
    end

    return table.concat(output)
  end,

  center = function(s, n)
    local aux = ''

    for i=1, n do
      aux = aux .. ' '
    end

    return aux .. s .. aux
  end,

  slug = function(s)
    local splited = utils.get_list_chars(s)
    local output = {}
    local accents = [[ÀÁÂÃÄÅàáâãäåÒÓÔÕÕÖØòóôõöøÈÉÊËèéêëðÇçÐÌÍÎÏìíîï
    ÙÚÛÜùúûüÑñŠšŸÿýŽž~"\'~^!?.:@#$%&*]]
    local accents_out = [[AAAAAAaaaaaaOOOOOOOooooooEEEEeeeeeCcDIIIIiiii
    UUUUuuuuNnSsYyyZz---------------]]

    for key, value in pairs(splited) do
      local index_of = utf8.find(accents, value)

      if index_of then
        output[key] = utf8.sub(accents_out, index_of, index_of)
      else
        output[key] = value
      end
    end

    return utf8.lower(table.concat(output, ''):gsub('%s', '-'))
  end,

  is_ascii = function(s)
    for i=1, #s do
      if string.byte(s:sub(i, i)) > 126 then return false end
    end

    return true
  end,

  is_number = function(s)
    return utils.to_bool(string.find(s, '^%d+$'))
  end,

  each_char = function(s, callback)
    for i=1, #s do
      callback(s:sub(i, i), i)
    end
  end,

  each_byte = function(s, callback)
    str.each_char(s, function(char, i)
      callback(char:byte(), i)
    end)
  end,

  each_line = function(s, callback)
    for line in string.gmatch(s, '[^\n]+') do
      callback(line)
    end
  end,

  bytes = function(s)
    local output = {}

    str.each_char(s, function(s)
      table.insert(output, string.byte(s))
    end)

    return output
  end,

  delete = function(s, chars)
    local output = s

    for i=1, #chars do
      output = output:gsub(chars[i], '')
    end

    return output
  end
}

return str
