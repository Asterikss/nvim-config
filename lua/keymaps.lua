local function m(a, b, v)
    vim.keymap.set(a, b, v, { noremap = true })
end

m({"n", "v"}, "<Space>", "<Nop>")

m("v", "y", "myy`y") -- keeps the position of the cursor after v yank

m({"n", "v"}, ";", ":")
m("n", ":", ";")

m({ "n", "x" }, "x", "\"_x") -- Prevent x from overwriting y's

m("v", ">", ">gv")
m("v", "<", "<gv")

m("n", "<Leader><Leader>q", "gqap") -- formatting text
m("v", "<Leader><Leader>q", "gq")

m("n", "n", "nzz")
m("n", "N", "Nzz")

m("n", "<C-j>", "<c-w>j")
m("n", "<C-k>", "<c-w>k")
m("n", "<C-l>", "<c-w>l")
m("n", "<C-h>", "<c-w>h")

m("n", "go", "o<Esc>k")
m("n", "gO", "O<Esc>j")

m("n", "<Down>", "<c-w>-")
m("n", "<Up>", "<c-w>+")
m("n", "<Left>", "<c-w>>")
m("n", "<Right>", "<c-w><")

m("i", "<A-7>",  "<Esc>gT") -- Zellij for some reason eats Control PageUp (booo)
m("i", "<A-8>",  "<Esc>gt") -- And Control End and Control Home are messing with browser pdf viewer
m("n", "<A-7>",  "gT")
m("n", "<A-8>",  "gt")

m("x", "J", ":m '>+1<CR>gv=gv")
m("x", "K", ":m '<-2<CR>gv=gv")

m({"n", "v"}, "<A-D>", "\"_d") -- delete without trashing the clippboard
m("n", "<A-d>", "\"_dd") -- delete line without trashing the clippboard

m("n", "<Leader>l", "<cmd>Lex 25<CR>")
m("n", "<Leader><Leader>l", "<cmd>Tex<CR>")

m("n", "<c-d>", "<c-d>zz")
m("n", "<c-u>", "<c-u>zz")

m("n", "<A-y>", '"zyy"zp') -- paste line under
m("n", "<Leader><A-y>", function () -- comment the line and paste it under
    vim.cmd('normal! "zyy')
    vim.cmd("normal gcc")
    vim.cmd('normal! "zp')
end)
m("x", "<Leader><A-y>", function () -- comment block and paste it under. Works with the cursor on the bottom of the block ("o" to switch)
    vim.cmd('normal! "zygv')
    vim.cmd("normal gc")
    vim.cmd('normal! gv\x1bo\x1b"zp')
end)

m("n", "D", "dd")
m("n", "dd", "D")
m("n", "C", "cc")
m("n", "cc", "C")
m("n", "f", "v")
m("n", "F", "V")
m({"n", "x"}, "v", "f")
m({"n", "x"}, "V", "F")

m("n", "Y", "yy")
m("n", "yy", "y$")

m("n", "J", "mzJ`z")

m("n", "<", "<<")
m("n", ">", ">>")

-- paste under and automatically allign using "="
m('n', 'p', "<cmd>pu<CR>V'[=")
m('n', 'P', "<cmd>pu<CR>")

-- voyager shortcuts

m({"i", "c"}, "", "<C-w>") -- map Control Backspace to Control W
m("c", "<Up>", "<C-p>" )
m("c", "<Down>", "<C-n>" )
m("c", "<C-p>", "<Up>" )
m("c", "<C-n>", "<Down>" )

-- clear all ^M
m("n", "<Leader><Leader>c", function ()
    vim.api.nvim_feedkeys(";%s/" ..
        vim.api.nvim_replace_termcodes("<C-q>", true, false, true) ..
        vim.api.nvim_replace_termcodes("<C-m>", true, false, true) ..
        "//g\r" , "m", true)
end)


m("n", "<Leader><Leader>Q", "q") -- q is taken for commenting

m("n", "gt", "<cmd>vsp | lua vim.lsp.buf.definition()<CR>")

m("n", "gT", function ()
    vim.cmd("normal! ma")
    vim.cmd("tabedit %")
    vim.cmd("normal! `a")
end)

m("n", "<Leader>o", function () -- Format file
    local file_type = vim.bo.filetype
    vim.cmd("w")
    if file_type == "python" then
        vim.cmd("! black " .. vim.api.nvim_buf_get_name(0))
    elseif file_type == "rust" then
        vim.cmd("! rustfmt " .. vim.api.nvim_buf_get_name(0))
        -- vim.cmd("RustFmt") Does not work and I dont want to install rust-lang/rust.vim to fix it
    elseif file_type == "cpp" then
        vim.lsp.buf.format()
    end
end)

m("x", "<Leader>o", function () -- Comment Block and Paste it under. Works with the cursor on the top ("o" to switch)
    vim.api.nvim_feedkeys("ygvo\x1bo\x1bpgvq", "m", true)
    -- local last_selected_line = vim.fn.line("'>") is flawed
end)

function CommentPrint() -- maybe I don't need nvim_feedkeys
    vim.api.nvim_feedkeys(":g/print/s/^/#/\r", "m", true)
end

m("x", "<Leader>cp", "<cmd>lua CommentPrint()<cr>")

m({"n", "t"}, "X", "<Esc><cmd>wa<CR><cmd>qa<CR>")
m({"n", "t"}, "<A-X>", "<Esc><cmd>wa<CR><cmd>mks! .dev/Session.vim<CR><cmd>qa<CR>")


------ fugitive ------
m("n", "<Leader>hg", function ()
    if vim.bo.filetype == "fugitive" then
        vim.cmd("x")
    else
        vim.cmd("G")
    end
end)

m("n", "<Leader>hw", "<cmd>Gwrite<CR>")

m("n", "<Leader>hc", ':G commit -m""<Left>')

m("n", "<Leader>hu", "<cmd>G push<CR>")

m({"n", "v"}, "<Leader>ha", "<cmd>Gitsign stage_hunk<CR>")


------ Harpoon + terminal mappings ------
m("n", "<Leader><Leader>m", function()
    if vim.bo.filetype == "python" then
        -- vim.api.nvim_feedkeys(';lua require("harpoon.cmd-ui").toggle_quick_menu()\rdapap ' .. vim.fn.expand('%:h') .. "/" .. vim.fn.expand('%:t') .. "\x1bq", "m", true)
        vim.api.nvim_feedkeys(
        ';lua require("harpoon.cmd-ui").toggle_quick_menu()\rdipap ' ..
        vim.fn.expand('%:h') .. "/" .. vim.fn.expand('%:t') .. "\x1bq", "m", true)
    else
        vim.api.nvim_feedkeys(';lua require("harpoon.cmd-ui").toggle_quick_menu()\rdapacargo run\x1bq', "m", true)
    end
end)

m("n", "<Leader>a", '<cmd>lua require("harpoon.mark").add_file()<CR>')
m("n", "<C-h>", '<cmd>lua require("harpoon.ui").nav_file(1)<CR>')
m("n", "<C-j>", '<cmd>lua require("harpoon.ui").nav_file(2)<CR>')
m("n", "<C-k>", '<cmd>lua require("harpoon.ui").nav_file(3)<CR>')
-- m("n", "<C-l>", '<cmd>lua require("harpoon.ui").nav_file(4)<CR>')
m("n", "<A-m>", '<cmd>lua require("harpoon.ui").toggle_quick_menu()<CR>') -- this is also Enter
m("n", "<Leader>m", '<cmd>lua require("harpoon.cmd-ui").toggle_quick_menu()<CR>')

m("n", "<A-n>", function() -- goes to the beginning of the command line. Always in insert mode
    if vim.bo.buftype == "terminal" then
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-^>", true, false, true), "m", true)
    else
        vim.api.nvim_feedkeys(';lua require("harpoon.term").gotoTerminal(1)\ra', "m", true)
    end
end)

m("n", "<A-N>", function() -- does not change the original location of the cursor. Alsways in normal mode
    if vim.bo.buftype == "terminal" then
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-^>", true, false, true), "m", true)
    else
        vim.api.nvim_feedkeys(';lua require("harpoon.term").gotoTerminal(1)\r', "m", true)
    end
end)

m("n", "<A-b>", function()
    if vim.bo.buftype == "terminal" then
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-^>", true, false, true), "m", true)
    else
        vim.api.nvim_feedkeys(';wa\r;lua require("harpoon.term").gotoTerminal(2)\r', "m", true)
    end
end)

m("n", "<A-j>", function()
    if vim.bo.buftype == "terminal" then
        vim.api.nvim_feedkeys(
        vim.api.nvim_replace_termcodes("<c-^>", true, false, true) ..
        ';lua require("harpoon.term").gotoTerminal(1)\r;lua require("harpoon.term").sendCommand(1, 1)\ra\r', "m", true)
    else
        vim.api.nvim_feedkeys(
        ';wa\r;lua require("harpoon.term").gotoTerminal(1)\r;lua require("harpoon.term").sendCommand(1, 1)\ra\r', "m",
            true)
    end
end)

m("i", "<A-j>", function()
    vim.api.nvim_feedkeys(
    '\x1b' ..
    ';wa\r;lua require("harpoon.term").gotoTerminal(1)\r;lua require("harpoon.term").sendCommand(1, 1)\ra\r', "m",
        true)
end)

m("n", "<A-1>", function() -- TODO
    if vim.bo.buftype == "terminal" then
        vim.api.nvim_feedkeys(
        vim.api.nvim_replace_termcodes("<C-^>", true, false, true) ..
        ';lua require("harpoon.term").gotoTerminal(1)\r;lua require("harpoon.term").sendCommand(1, 2)\ra\r', "m", true)
    else
        vim.api.nvim_feedkeys(
        ';wa\r;lua require("harpoon.term").gotoTerminal(1)\r;lua require("harpoon.term").sendCommand(1, 2)\ra\r', "m",
            true)
    end
end)

m("t", "<Esc>", "<C-\\><C-n>")
m("t", "<C-u>", "<C-\\><C-N><C-u>")
m("t", "<A-k>", "<C-\\><C-N>k")
m("t", "<A-h>", "<C-\\><C-N>gT")
m("t", "<A-l>", "<C-\\><C-N>gt")

m("t", "<A-n>", function()
    vim.api.nvim_feedkeys("\x1b" .. vim.api.nvim_replace_termcodes("<C-^>", true, false, true), "m", true)
end)

m("t", "<A-b>", function()
    vim.api.nvim_feedkeys("\x1b" .. vim.api.nvim_replace_termcodes("<C-^>", true, false, true), "m", true)
end)

m("t", "<A-j>", function()
    vim.api.nvim_feedkeys("\x1b" ..
    vim.api.nvim_replace_termcodes("<c-^>", true, false, true) ..
    ';lua require("harpoon.term").gotoTerminal(1)\r;lua require("harpoon.term").sendCommand(1, 1)\ra\r', "m", true)
end)

m("t", "<A-1>", function()
    vim.api.nvim_feedkeys("\x1b" ..
    vim.api.nvim_replace_termcodes("<c-^>", true, false, true) ..
    ';lua require("harpoon.term").gotoTerminal(1)\r;lua require("harpoon.term").sendCommand(1, 2)\ra\r', "m", true)
end)


------ Telescope
m("n", "<Leader>f", function()
    require("telescope.builtin").find_files(require('telescope.themes').get_dropdown {
        previewer = false
    })
end)
m("n", "<Leader>/", function()
    require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown {
        windblend = 10,
        previewer = false,
    })
end)

m('n', '<leader>sn', function()
    require("telescope.builtin").find_files({ cwd = vim.fn.stdpath 'config' })
end)

m('n', '<leader>sb', function()
    require("telescope.builtin").find_files({ cwd = '/home/lono/notes' })
end)

m("n", "<Leader><Leader>f", require("telescope.builtin").find_files)
m("n", "<Leader>b", require("telescope.builtin").buffers)
m("n", "<Leader>gg", require("telescope.builtin").live_grep)
m("n", "<Leader>gh", require("telescope.builtin").help_tags)
m("n", "<Leader>?", require("telescope.builtin").oldfiles)
m("n", "<Leader>sd", require("telescope.builtin").diagnostics)
m("n", "<Leader>sw", require("telescope.builtin").grep_string)


----- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- :Telescope builtin
-- m("n", "<Leader>f", "<cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({ previewer = false}))<CR>")
-- :Telescope grep_string search=abcd -- fuzzy find over results
-- :Telescope find_files cwd=~/.config/ smth or /code

-- https://github.com/nvim-telescope/telescope.nvim/wiki/Configuration-Recipes
-- https://github.com/nvim-telescope/telescope.nvim#default-mappings or use ? in normal mode inside Telescope

-- for future reference
-- https://github.com/neovim/neovim/issues/12642
-- function! Is_WSL() abort
-- let proc_version = '/proc/version'
-- return filereadable(proc_version)
--   \  ? !empty(filter(
--   \    readfile(proc_version, '', 1), { _, val -> val =~? 'microsoft' }))
--   \  : v:false
-- endfunction
--
-- for future reference
-- vim.api.nvim_buf_set_keymap(bufnr, "n", "gdt", "<cmd>tab split | lua vim.lsp.buf.definition()<CR>", opts)
-- m("n", "gr", "<cmd>tab split | lua vim.lsp.buf.definition()<CR>")

-- m("n", "<Leader>y", "\"ay")
-- m("v", "<Leader>y", "\"ay")
-- m("n", "<Leader>p", "\"aP") --  <- old p here. Changes the clippboard
-- m("v", "<Leader>p", "\"aP") -- not sure know how change that (with nvim_feedkeys)

-- m("n", "<Leader>a", "g'\"") -- harpoon uses that keemap

-- m("n", "<a-w>", "ZQ") used for exiting <Leader>q

-- Enable spel checking, z=
-- map <leader>s :getlocal spell! spelllang=en_us<CR>

-- m("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")


-- vim.defer_fn(function()
--     vim.cmd("e")
-- end, 150)
-- this can be used in Fromat File keymap with the addition of 
-- "silent" before e.g. "! black..." It will supress the need 
-- to press <enter> after formatting.

