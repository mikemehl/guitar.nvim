test:
  luarocks test

setup:
  luarocks init --local ./guitar.nvim-dev-1.rockspec
  luarocks install --only-deps ./guitar.nvim-dev-1.rockspec
