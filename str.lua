local function ternary(conditional, when_true, when_false)
    return conditional and when_true or when_false
end

local function to_bool(value)
    return not not value
end

local str = {
    __VERSION = '0.0.1',
    __DESCRIPTION = '',
    __LICENCE = [[]]
}

str = {
    slice = function(s, start, finish)
        return string.sub(s, start, ternary(finish, finish, #s))
    end,

    starts_with = function(s, start)
        return string.sub(s, 1, #start) == start
    end,

    ends_with = function(s, finish)
        return string.sub(s, -#finish) == finish
    end,

    count = function(s, substr)
        local total = 0
        local size_substr = #substr

        for i=1, #s do
            if string.sub(s, i, (i-1) + size_substr) == substr then
                total = total + 1
            end
        end

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
        local n = #s

        while string.find(string.sub(s, n, n), '%s') do
            n = n - 1
        end

        return string.sub(s, 1, n)
    end,

    trim_left = function(s)
        local n = 1

        while string.find(string.sub(s, n, n), '%s') do
            n = n + 1
        end

        return string.sub(s, n, #s)
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

    is_ascii = function(s)
        for i=1, #s do
            if string.byte(s:sub(i, i)) > 126 then return false end
        end

        return true
    end,

    slug = function(s)
    end,

    is_utf8 = function(s)
    end,

    is_number = function(s)
        return to_bool(string.find(s, '^%d*$'))
    end
}

return str
