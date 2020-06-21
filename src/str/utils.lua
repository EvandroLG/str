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

-- returns an array-line table with the keys from a given hash-like table
-- @param obj {table}
-- @return {table}
local function hash_keys(obj)
  local output = {}

  for k in pairs(obj) do
    table.insert(output, k)
  end

  return output
end

-- determines wether the substring was found within the string
-- @param s {string}
-- @param substr {string}
-- @return {boolean}
local function includes(s, substr)
  for i=1, #s do
    local value = string.sub(s, i, i+#substr-1)
    if value == substr then return true end
  end

  return false
end

-- determines wether one of the items intot he array was found within the string
-- @param s {string}
-- @param array {table}
-- @return {boolean}
local function includes_item(s, array)
  for i, v in pairs(array) do
    local result = includes(s, v)
    if result then return true end
  end

  return false
end

return {
  to_bool = to_bool,
  get_list_chars = get_list_chars,
  match_case = match_case,
  hash_keys = hash_keys,
  includes = includes,
  includes_item = includes_item
}
