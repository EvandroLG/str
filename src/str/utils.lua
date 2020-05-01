local utf8 = require 'lua-utf8'

local function to_bool(value)
  return not not value
end

local function get_list_chars(s)
  local output = {}

  for k, c in utf8.codes(s) do
    table.insert(output, utf8.char(c))
  end

  return output
end

return {
  to_bool = to_bool,
  get_list_chars = get_list_chars
};
