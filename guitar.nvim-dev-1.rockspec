rockspec_format = "3.0"
package = "guitar.nvim"
version = "dev-1"
source = {
  url = "git+ssh://git@github.com/mikemehl/guitar.nvim.git"
}
description = {
  summary = "A plugin to aid in writing guitar tablature in neovim.",
  detailed = "A plugin to aid in writing guitar tablature in neovim.",
  homepage = "*** please enter a project homepage ***",
  license = "*** please specify a license ***"
}
dependencies = {
  "lua ~> 5.1",
  "busted"
}
build = {
  type = "builtin",
  modules = {
    guitar = "lua/guitar.lua",
    ["guitar.cmds"] = "lua/guitar/cmds.lua",
    ["guitar.config"] = "lua/guitar/config.lua",
    ["guitar.init"] = "lua/guitar/init.lua",
    ["guitar.staff"] = "lua/guitar/staff.lua"
  },
  copy_directories = {
    "doc",
    "tests"
  }
}
test = {
  type = "command",
  command = "./test_shim.sh"
}
