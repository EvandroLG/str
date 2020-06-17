local utf8 = require 'lua-utf8'

-- convert value passed by parameter to boolean
-- @param value {*}
-- @return {boolean}
local function to_bool(value)
  return not not value
end

-- return a array-like table with each character from a given string
-- @param s {string}
-- @return {table}
local function get_list_chars(s)
  local output = {}

  for k, c in utf8.codes(s) do
    table.insert(output, utf8.char(c))
  end

  return output
end

-- convert all characters to lowercase and apply a `transformer` over each word
-- @param s {string}
-- @param transformer {function}
-- @return {table}
local function match_case(s, transformer)
  local lower = string.lower(s)
  local result = {}
  local is_first_word = true

  for w in string.gmatch(lower, '%w+') do
    if is_first_word then
      table.insert(result, w)
      is_first_word = false
    else
      table.insert(result, transformer(w))
    end
  end

  return table.concat(result, '')
end

return {
  to_bool = to_bool,
  get_list_chars = get_list_chars,
  match_case = match_case
};
