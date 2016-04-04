local function ternary(conditional, when_true, when_false)
    return conditional and when_true or when_false
end

local str = {
    slice = function(s, start, finish)
        return string.sub(s, start, ternary(finish, finish, #s))
    end,

    starts_with = function(s, start)
        return string.sub(s, 1, #start) == start
    end,

    ends_with = function(s, finish)
        return string.sub(s, -#finish) == finish
    end,

    split = function(s, pattern)
    end,

    trim = function(s) 
    end,

    trim_right = function(s)
    end,

    trim_left = function(s)
    end,

    capitalize = function(s)
    end,

    is_ascii = function(s)
        for i=1, #s do
            if string.byte(s:sub(i, i)) > 126 then return false end
        end

        return true
    end,

    is_utf8 = function(s)
    end,

    is_decimal = function(s)
    end,

    is_number = function(s)
    end,

    is_digit = function(s)
    end
}

return str
