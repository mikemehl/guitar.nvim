#!/usr/bin/env bash
set -euo
if [[ ${TRACE-0} -eq 1 ]]; then set -x; fi;
eval "$(luarocks path)"
nvim --clean \
  -l lua_modules/lib/luarocks/rocks-5.1/busted/2.2.0-1/bin/busted

