test:
  luarocks test --lua-version 5.1

setup:
  luarocks init --local ./guitar.nvim-dev-1.rockspec --lua-version 5.1
  luarocks install --only-deps ./guitar.nvim-dev-1.rockspec --lua-version 5.1
