-- local _ = require "plenary.async"	-- not sure if needed
require("plenary.async")	-- not sure if needed

local telescope = require("telescope")
local actions = require("telescope.actions")

telescope.setup{
	defaults = {
		mappings = {

			i  = {
				["<Esc>"] = actions.close,
				-- For now I will do it like that
				-- I wanted to use the same key for both i and n
				-- and continueto switch to insert with <C-j>
				-- but it stops working with this remap. 
				-- Can't get to normal now. Can't press ?
				-- Can't use <C-c> for both. Does not work
				["<C-K>"] = actions.select_default,
				["<C-h>"] = actions.cycle_history_next,
				-- -^- or _prev. Used to be <C-k> (or <C-j> idk)
				-- I can't trigger it anyway
			},

			n  = {
				["<C-K>"] = actions.select_default,

			},

		},

		-- prompt_prefix = ""
		-- path_display = { "smart" },
	}

	--[[ extensions = {
		fzf = {
			fuzzy = true,                    -- false will only do exact matching
			override_generic_sorter = true,  -- override the generic sorter
			override_file_sorter = true,     -- override the file sorter
			case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
			-- the default case_mode is "smart_case"
		} ]]
}

-- :Telescope grep_string search=abcd -- fuzzy find over results 
-- :Telescope find_files cwd=~/.config/ smth or /code 


-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
telescope.load_extension('fzf')

