package = "add-redirect"
version = "0.1-0"
source = {
    url = "none"
}

description = {
   summary = "Add redirect for html files in folder",
   detailed = "Add redirect for html files in folder recursively",
--   homepage = "https://github.com/kikito/middleclass",
   license = "MIT"
}

dependencies = {
   "lua >= 5.2",
   "luafilesystem",
   "penlight",
   "lrexlib-pcre"
}

build = {
   type = "builtin",
   modules = {
       middleclass = "add-redirect.lua"
   }
}
