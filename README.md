# str
<code>str</code> is a string module with useful methods that don't exist in Lua's core

[![Build
Status](https://travis-ci.org/EvandroLG/str.svg?branch=master)](https://travis-ci.org/EvandroLG/str)

## Installation
To install str, run:
```sh
$ luarocks install str
```
Or simply copy the str.lua file and paste in your project.

## Methods
* str.<code>bytes(value:string):table</code><br />
Returns a table with the byte of every string's character

* str.<code>capitalize(value:string):string</code><br />
Returns a new string with the first character converted to uppercase and the remainder to lowercase

* str.<code>center(value:string, size:number):string</code><br />
Returns a copy of the string passed as parameter centralized with spaces passed in size parameter

* str.<code>count(value:string, substring:string):number</code><br />
Returns how many times the substring was found

* str.<code>delete(value:string, chars:table):string</code><br />
Returns a copy of the string passed by parameter without the specified characters

* str.<code>each_byte(value:string, callback:function):void</code><br />
Passes every byte in string to the given function

* str.<code>each_char(value:string, callback:function):void</code><br />
Executes a provided function once for each character of the string

* str.<code>each_line(value:string, callback:function):void</code><br />
Executes a provided function once for each line of the string

* str.<code>slice(value:string, start:number, end:number):string</code><br />
Extracts a part of the string and returns a new string

* str.<code>starts_with(value:string, start:number):boolean</code><br />
Checks whether string starts with the value passed by parameter

* str.<code>ends_with(value:string, end:number):string</code><br />
Checks whether string ends with the value passed by parameter

* str.<code>is_ascii(value:string):boolean</code><br />
Checks whether the string has only ASCII characters

* str.<code>is_number(value:string):boolean</code><br />
Checks whether the string has only numbers characters

* str.<code>slug(value:string):string</code><br />
Converts string to slug and returns it as a new string

* str.<code>split(value:string, pattern:string):table</code><br />
Splits the string into substring using the specified separator and return them as a table

* str.<code>trim(value:string):string</code><br />
Returns a copy of string leading and trailing whitespace removed

* str.<code>trim_left(value:string):string</code><br />
Returns a new string with leading whitespace removed

* str.<code>trim_right(value:string):string</code><br />
Returns a new string with trailing whitespace removed

* str.<code>find_last(value:string, match:string):string</code><br />
Returns the index within the given string of the last occurrence of the specified value to `match` parameter. If the value is not found, it returns nil.

* str.<code>truncate(value:string, options: { size:number, omission:string, separator:string }):string</code><br />
Truncates string if it's longer than the `size` value passed by parameter.

## Author
|[![@evandrolg](https://avatars3.githubusercontent.com/u/444054?v=3&amp;s=96)](https://github.com/evandrolg)|
|:---:|
|[@evandrolg](http://www.github.com/evandrolg)|

## See too:
* [array.lua](http://www.github.com/evandrolg/array.lua)
* [Hash.lua](https://github.com/EvandroLG/Hash.lua)

