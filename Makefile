.SILENT:

test:
	LUA_PATH="./src/?.lua;./src/?/init.lua;./src/str/?.lua;;" lua test.lua

install:
	luarocks install luautf8

install_dev:
	luarocks install simple_test
