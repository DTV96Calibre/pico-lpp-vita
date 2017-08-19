require("api")
require ("placeholder")
-- require("Graphics")
-- require("Screen")

Graphics.init()

-- Cartridge code
lua = ''

-- Patch Lua's syntax
lua = lua:gsub('!=', '~=')

while true do
  Screen.waitVblankStart()
  clip()
end
