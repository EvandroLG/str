# str
<code>str</code> is a string module with useful methods that don't exist in Lua's core

## Installation
To install str, run:
```sh
$ luarocks install str
```
Or simply copy the str.lua file and paste in your project.

## Methods
* str.<code>slice(value:string, start:number, end:number):string</code>
* str.<code>starts_with(value:string, start:number):string</code>
* str.<code>ends_with(value:string, end:number):string</code>
* str.<code>count(value:string, substring:string):number</code>
* str.<code>split(value:string, pattern:string):table</code>
* str.<code>trim_right(value:string):string</code>
* str.<code>trim_left(value:string):string</code>
* str.<code>capitalize(value:string):string</code>
* str.<code>center(value:string, size:number):string</code>
* str.<code>slug(value:string):string</code>
* str.<code>is_ascii(value:string):boolean</code>
* str.<code>is_number(value:string):boolean</code>
* str.<code>each_line(value:string, callback:function):void</code>
* str.<code>each_char(value:string, callback:function):void</code>
* str.<code>each_byte(value:string, callback:function):void</code>
