local ls = require("luasnip")

ls.config.set_config{
	updateevents = "TextChanged, TextChangedI",

}

-- <C-k> expansion key
-- this will expand the current item or jump to the next item within the snippet
vim.keymap.set({ "i", "s" }, "<C-k>", function()
	if ls.expand_or_jumpable() then
		ls.expand_or_jump()
	end
end, { silent = true })

-- <C-j> jump backwards key
-- always moves to the previous item in the snippet
vim.keymap.set({ "i", "s" }, "<C-j>", function()
	if ls.jumpable(-1) then
		ls.jump(-1)
	end
end, { silent = true })

-- Choice nodes can be added



