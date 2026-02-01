package = "bibit"
version = "0.2-0"
source = {
    url = "none"
}

description = {
   summary = "Bibit test task",
   detailed = "Bibit test task",
--   homepage = "",
   license = "MIT"
}

dependencies = {
   "lua >= 5.2",
   "luafilesystem",
   "penlight",
   "luaunit",
   "argparse"
--   "lrexlib-pcre"
}

build = {
   type = "builtin",
   modules = {

   }
}
