-- https://stackoverflow.com/questions/72984648/neovim-lua-how-to-use-different-mappings-depending-on-file-type 
local function m(a, b, v)
	vim.keymap.set(a, b, v, { noremap = true })
end
-- could be global(from an import)
-- local map = require("utils").map

m("n", "<Leader><A-y>", "YI//<Esc>p")
