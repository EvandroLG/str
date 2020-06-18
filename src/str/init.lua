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

  -- extracts a part of the string and returns a new string
  -- @param s {string}
  -- @param start {number}
  -- @param finish {number | nil}
  -- @return {string}
  slice = function(s, start, finish)
    return string.sub(s, start, finish or #s)
  end,

  -- checks whether string starts with the value passed by parameter
  -- @param s {string}
  -- @param start {number}
  -- @return {string}
  starts_with = function(s, start)
    return string.sub(s, 1, #start) == start
  end,

  -- checks whether string ends with the value passed by parameter
  -- @param s {string}
  -- @param finish {number}
  -- @return {string}
  ends_with = function(s, finish)
    return string.sub(s, -#finish) == finish
  end,

  -- returns how many times the substring was found
  -- @param s {string}
  -- @param substr {string}
  -- @return {number}
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

  -- splits the string into substring using the specified separator and return them as a table
  -- @param s {string}
  -- @param pattern {string}
  -- @return {table}
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

  -- returns a new string with trailing whitespace removed
  -- @param s {string}
  -- @return {string}
  trim_right = function(s)
    return string.match(s, '(.-)%s*$')
  end,

  -- returns a new string with leading whitespace removed
  -- @param s {string}
  -- @return {string}
  trim_left = function(s)
    return string.match(s, '[^%s+].*')
  end,

  -- returns a copy of string leading and trailing whitespace removed
  -- @param s {string}
  -- @return {string}
  trim = function(s)
    return str.trim_right(
      str.trim_left(s)
    )
  end,

  -- returns a new string with the first character converted to uppercase and the remainder to lowercase
  -- @param s {string}
  -- @return {string}
  capitalize = function(s)
    if #s == 0 then
      return s
    end

    local function upperFirst()
      return string.upper(
        string.sub(s, 1, 1)
      )
    end

    local function lowerRest()
      return string.lower(
        string.sub(s, 2)
      )
    end

    return upperFirst() .. lowerRest()
  end,

  -- returns a copy of the string passed as parameter centralized with spaces passed in size parameter
  -- @param s {string}
  -- @param n {number}
  -- @return {string}
  center = function(s, n)
    local aux = ''

    for i=1, n do
      aux = aux .. ' '
    end

    return aux .. s .. aux
  end,

  -- converts string to slug and returns it as a new string
  -- @param s {string}
  -- @return {string}
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

  -- checks whether the string has only ascii characters
  -- @param s {string}
  -- @return {boolean}
  is_ascii = function(s)
    for i=1, #s do
      if string.byte(s:sub(i, i)) > 126 then return false end
    end

    return true
  end,

  -- checks whether the string has only numbers characters
  -- @param s {string}
  -- @return {boolean}
  is_number = function(s)
    return utils.to_bool(
      string.find(s, '^%d+$')
    )
  end,

  -- executes a provided function once for each character of the string
  -- @param s {string}
  -- @param callback {function}
  -- @return {void}
  each_char = function(s, callback)
    for i=1, #s do
      callback(s:sub(i, i), i)
    end
  end,

  -- passes every byte in string to the given function
  -- @param s {string}
  -- @param callback {function}
  -- @return {void}
  each_byte = function(s, callback)
    str.each_char(s, function(char, i)
      callback(char:byte(), i)
    end)
  end,

  -- executes a provided function once for each line of the string
  -- @param s {string}
  -- @param callback {function}
  -- @return {void}
  each_line = function(s, callback)
    for line in string.gmatch(s, '[^\n]+') do
      callback(line)
    end
  end,

  -- returns a table with the byte of every string's character
  -- @param s {string}
  -- @return {table}
  bytes = function(s)
    local output = {}

    str.each_char(s, function(s)
      table.insert(output, string.byte(s))
    end)

    return output
  end,

  -- returns a copy of the string passed by parameter without the specified characters
  -- @param s {string}
  -- @param chars {table}
  -- @return {table}
  delete = function(s, chars)
    local output = s

    for i=1, #chars do
      output = output:gsub(chars[i], '')
    end

    return output
  end,

  -- returns the index within the given string of the last occurrence of the specified value;
  -- returns nil if the value is not found
  -- @param s {string}
  -- @param match {string}
  -- @return {table}
  find_last = function(s, match)
    local i = s:match('.*' .. match .. '()')

    if not i then
      return nil
    end

    return i - 1
  end,

  -- truncates string if it's longer than the given maximum size
  -- @param s {string}
  -- @param options {table}
  -- @return {table}
  truncate = function(s, options)
    local _options = options or {}
    local omission = _options.omission or '...'
    local size = _options.size or 30
    local separator = _options.separator
    local cutted = str.slice(s, 1, size - #omission)

    if separator then
      local i = str.find_last(cutted, separator) - 1
      return str.slice(s, 1, i) .. omission
    end

    return cutted .. omission
  end,

  -- converts string to `camel case`
  -- @param s {string}
  -- @return string
  camel_case = function(s)
    return utils.match_case(s, str.capitalize)
  end,

  -- converts string to `kebab case`
  -- @param s {string}
  -- @return string
  kebab_case = function(s)
    return utils.match_case(s, function(w)
      return '-' .. w
    end)
  end,

  -- converts string to `snake case`
  -- @param s {string}
  -- @return string
  snake_case = function(s)
    return utils.match_case(s, function(w)
      return '_' .. w
    end)
  end,

  -- determines wether the substring was found within the string
  -- @param s {string}
  -- @param substr {string}
  -- @return boolean
  includes = function(s, substr)
    return utils.includes(s, substr)
  end,

  -- converts the characters "&", "<", ">", '"', and "'" in string to their corresponding html entities.
  -- @param s {string}
  -- @return string
  escape = function(s)
    local match = {
      ['<'] = '&lt;',
      ['>'] = '&gt;',
      ['"'] = '&quot;',
      ["'"] = '&apos;',
      ['&'] = '&amp;'
    }

    local keys = utils.hash_keys(match)
    local output = {}

    for i=1, #s do
      local char = string.sub(s, i, i)
      local is_special = utils.includes_item(char, keys)

      table.insert(output, is_special and match[char] or char)
    end

    return table.concat(output, '')
  end
}

return str
