local function ternary(conditional, when_true, when_false)
    return conditional and when_true or when_false
end

local str = {
    slice = function(s, start, finish)
        return string.sub(s, start, ternary(finish, finish, #s))
    end,

    min = function(s)
    end,

    max = function(s)
    end,

    split = function(s, pattern)
    end,

    trim = function(s) 
    end,

    trim_right = function(s)
    end,

    trim_left = function(s)
    end,

    starts_with = function(s, start, finish)
    end,

    ends_with = function(s, start, finish)
    end,

    capitalize = function(s)
    end,

    is_ascii = function(s)
    end,

    is_decimal = function(s)
    end,

    is_number = function(s)
    end,

    is_digit = function(s)
    end
}

return str
