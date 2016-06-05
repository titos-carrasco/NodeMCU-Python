--[[
The MIT License (MIT)

Copyright (c) 2016 Roberto Carrasco <titos.carrasco@gmail.com>

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
--]]

if( geany.length() == 0 ) then
    return
end

function transform( line )
    line = string.gsub( line, "\r\n$", "" )
    line = string.gsub( line, "\n\r$", "" )
    line = string.gsub( line, "\r$", "" )
    line = string.gsub( line, "\n$", "" )
    line = string.gsub( line, "\\", "\\\\" )
    line = string.gsub( line, "'", "\\'" )
    line = string.gsub( line, "^", "f.write('" )
    line = string.gsub( line, "$", "')\n" )
    geany.copy( line )
    geany.paste()
end

local fname = geany.basename( geany.filename() )
local lineas = {}
for k, v in geany.lines() do
    lineas[k] = v
end

geany.newfile()

geany.copy( "f = open('" .. fname .. "','w')\n" )
geany.paste()
for k, v in pairs(lineas) do
    transform( v )
end
geany.copy( "f.close()\n" )
geany.paste()
