local function m(a, b, v)
    vim.keymap.set(a, b, v, { noremap = true })
end

m("n", "<Space>", "<Nop>")
vim.g.mapleader = " "
vim.g.maplocalleader = " "

if not vim.fn.has('wsl') then
    m("n", "<Leader>ve", "<cmd>e ~/AppData/Local/nvim/init.vim<CR>")
    m("n", "<Leader>vr", "<cmd>source ~/AppData/Local/nvim/init.vim<CR>")
    m("n", "<Leader><Leader>s", "<cmd>w C:/Users/lono8/Desktop/.txt<Left><Left><Left><Left>")
    m("n", "<C-z>", "<Nop>")
    m("i", "<C-z>", "<Nop>")
    m("t", "<C-z>", "<Nop>")
    m("v", "<C-z>", "<Nop>")
else
    m("n", "<Leader>ve", "<cmd>e ~/.config/nvim/init.lua<CR>")
    m("n", "<Leader>vr", "<cmd>source ~/.config/nvim/init.lua<CR>")
end


m("i", "kj", "<Esc>")

m("v", "y", "myy`y") -- keeps the position of the cursor after v yank

m("n", ";", ":")
m("v", ";", ":")

m("n", ":", ";")

m("n", "x", "\"_x") -- Prevent x from overwriting y's
-- m("n", "X", "\"_X")
m("x", "x", "\"_x")

m("v", ">", ">gv")
m("v", "<", "<gv")

m("n", "<Leader><Leader>q", "gqap")
m("v", "<Leader><Leader>q", "gq")

m("n", "n", "nzz") -- :h zw
m("n", "N", "Nzz")

m("n", "<C-t>", ":tabnew ") -- <C-t> has something to do with TagStack

m("n", "go", "o<Esc>k")
m("n", "gO", "O<Esc>j")
-- <A-k> <A-j> does not work. Maby alt first, then...

-- --windows--
m("n", "<Down>", "<c-w>-")
m("n", "<Up>", "<c-w>+")
m("n", "<Left>", "<c-w>>")
m("n", "<Right>", "<c-w><")


-- m("n", "<C-h>", "<C-w>h")
-- m("n", "<C-j>", "<C-w>j")
-- m("n", "<C-k>", "<C-w>k")
-- m("n", "<C-l>", "<C-w>l")

m("n", "<A-h>", "gT")
m("n", "<A-l>", "gt")
m("i", "<A-h>", "<Esc>gT")
m("i", "<A-l>", "<Esc>gt")

m("i", "<C-e>", "<Esc>A")
m("i", "<C-a>", "<Esc>I")

m("x", "J", "<cmd>m '>+1<CR>gv=gv")
m("x", "K", "<cmd>m '<-2<CR>gv=gv")

m("x", "p", "\"_dP") -- Without trashing the clippboard
m("x", "<A-p>", "p") -- There might be a better way

m("n", "<Leader>y", "\"ay")
m("v", "<Leader>y", "\"ay")
m("n", "<Leader>p", "\"aP") --  <- old p here. Changes the clippboard
m("v", "<Leader>p", "\"aP") -- not sure know how change that (with nvim_feedkeys)

m("n", "<A-d>", "\"_d")     -- Without trashing the clippboard
m("v", "<A-d>", "\"_d")

m("n", "<Leader><Leader>d", "ddO<Esc>") -- might remove that

m("n", "<Leader>l", "<cmd>Lex 25<CR>")
m("n", "<Leader><Leader>l", "<cmd>Tex<CR>")

-- m("n", "<Leader>a", "g'\"") -- harpoon uses that keemap


-- m("n", "<Leader>o", "o<C-w>")
-- m("n", "<Leader>O", "O<C-w>") 

m("n", "<c-d>", "<c-d>zz")
m("n", "<c-u>", "<c-u>zz")

m("n", "<A-y>", "Yp")

m("n", "D", "dd")
m("n", "dd", "D")
m("n", "C", "cc")
m("n", "cc", "C")

m("n", "Y", "yy")
m("n", "yy", "y$")

m("n", "J", "mzJ'z")


-- m("n", "<a-w>", "ZQ") used for exiting <Leader>q


-- m("n", "<A-j>", ":tabm -1<CR>")
-- m("n", "<A-k>", ":tabm +1<CR>")

-- Enable spel checking, z=
-- map <leader>s :getlocal spell! spelllang=en_us<CR>

-- m("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

-- for future reference
-- vim.api.nvim_buf_set_keymap(bufnr, "n", "gdt", "<cmd>tab split | lua vim.lsp.buf.definition()<CR>", opts)
-- m("n", "ggt", "<cmd>tab split | lua vim.lsp.buf.definition()<CR>")
m("n", "gd", "<cmd>vsp | lua vim.lsp.buf.definition()<CR>")

m("n", "<Leader><Leader>Q", "q") -- I wanted q to do smth else. In case I want to use it

-- function Comm() -- could change it in the plugin itself
    -- vim.api.nvim_feedkeys("gcc", "m", true)
-- end

-- function CommV()
--     vim.api.nvim_feedkeys("gc", "m", true)
-- end

-- m("n", "q", "<cmd>lua Comm()<CR>")
m("n", "q", function () -- could change it in the plugin itself
    vim.api.nvim_feedkeys("gcc", "m", true)
end)

-- m("x", "q", "<cmd>lua CommV()<CR>")
m("x", "q", function ()
    vim.api.nvim_feedkeys("gc", "m", true)
end)

function FormatFile()
    local file_type = vim.bo.filetype
    vim.cmd("w")
    if file_type == "python" then
        -- FormatPython()
        vim.cmd("! black " .. vim.api.nvim_buf_get_name(0))
    elseif file_type == 'rust' then
        vim.cmd("! rustfmt " .. vim.api.nvim_buf_get_name(0))
        -- vim.cmd('RustFmt') Does not work and I dont want to install rust-lang/rust.vim to fix it
    end
end

--[[ function FormatPython()
    vim.cmd("w")
    -- or vim.fn.expand('%:p') --  .. " >/dev/null 2>&1 &" can be added to the back, but silent makes no diff
    -- silent and defer_fn can be removed to get feedback and for the file to be automatically
    -- changed (formatted) after pressing enter / <C-c>
    -- vim.cmd("silent ! black " .. vim.api.nvim_buf_get_name(0)) -- or vim.fn.expand('%:p')
    vim.cmd("! black " .. vim.api.nvim_buf_get_name(0))
    -- vim.defer_fn(function()
    --     vim.cmd("e")
    -- end, 150)
end ]]

-- m("n", "<Leader>o", "<cmd>lua FormatFile()<CR>")
m("n", "<Leader>o", "<cmd>lua FormatFile()<CR>")

-- TODO: reformat the functions so that they are anonymous functions

function CommBandP() -- Comment Block and Paste it
    vim.api.nvim_feedkeys("ygvo\x1bo\x1bpgvgc", "m", true)
    -- local last_selected_line = vim.fn.line("'>") is flawed
end

m("x", "<Leader>o", "<cmd>lua CommBandP()<cr>")

function CommentPrint() -- maby I don't need nvim_feedkeys
    vim.api.nvim_feedkeys(":g/print/s/^/#/\r", "m", true)
end

m("x", "<Leader>cp", "<cmd>lua CommentPrint()<cr>")


m("n", "<Leader>x", '<Esc><cmd>wa<CR><cmd>qa<CR>') -- maby ctrl x so I can also map it in "t" mode
m("n", "<Leader><Leader>x", '<Esc><cmd>wa<CR><cmd>mks!<CR><cmd>qa<CR>')


------ Harpoon + terminal mappings
m("n", "<Leader><Leader>m", function () -- might change to full path later; also del whole buf not just first line
    if vim.bo.filetype == "python" then
        -- vim.api.nvim_feedkeys(';lua require("harpoon.cmd-ui").toggle_quick_menu()\rdapap ' .. vim.fn.expand('%:h') .. "/" .. vim.fn.expand('%:t') .. "\x1bq", "m", true)
        vim.api.nvim_feedkeys(';lua require("harpoon.cmd-ui").toggle_quick_menu()\rdipap ' .. vim.fn.expand('%:h') .. "/" .. vim.fn.expand('%:t') .. "\x1bq", "m", true)
    else
        vim.api.nvim_feedkeys(';lua require("harpoon.cmd-ui").toggle_quick_menu()\rdapacargo run\x1bq', "m", true)
    end
end)
m("n", "<Leader>a", '<cmd>lua require("harpoon.mark").add_file()<CR>')
m("n", "<C-h>", '<cmd>lua require("harpoon.ui").nav_file(1)<CR>')
m("n", "<C-j>", '<cmd>lua require("harpoon.ui").nav_file(2)<CR>')
m("n", "<C-k>", '<cmd>lua require("harpoon.ui").nav_file(3)<CR>')
-- m("n", "<C-l>", '<cmd>lua require("harpoon.ui").nav_file(3)<CR>')
m("n", "<A-m>", '<cmd>lua require("harpoon.ui").toggle_quick_menu()<CR>') -- this is also Enter
m("n", "<Leader>m", '<cmd>lua require("harpoon.cmd-ui").toggle_quick_menu()<CR>')
-- m("n", "<C-n>", function ()
m("n", "<A-n>", function ()
    if vim.bo.buftype == "terminal" then
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-^>", true, false, true), "m", true)
    else
        vim.api.nvim_feedkeys(';lua require("harpoon.term").gotoTerminal(1)\ra', "m", true)
    end
end)

m("n", "<C-b>", function ()
    if vim.bo.buftype == "terminal" then
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-^>", true, false, true), "m", true)
    else
        vim.api.nvim_feedkeys(';wa\r;lua require("harpoon.term").gotoTerminal(2)\r', "m", true)
    end
end)

m("n", "<A-j>", function ()
    if vim.bo.buftype == "terminal" then
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-^>", true, false, true) ..';lua require("harpoon.term").gotoTerminal(1)\r;lua require("harpoon.term").sendCommand(1, 1)\ra\r', "m", true)
    else
        vim.api.nvim_feedkeys(';wa\r;lua require("harpoon.term").gotoTerminal(1)\r;lua require("harpoon.term").sendCommand(1, 1)\ra\r', "m", true)
    end
end)
m("i", "<A-j>", function ()
    if vim.bo.buftype == "terminal" then
        vim.api.nvim_feedkeys('\x1b' .. vim.api.nvim_replace_termcodes("<C-^>", true, false, true) ..';lua require("harpoon.term").gotoTerminal(1)\r;lua require("harpoon.term").sendCommand(1, 1)\ra\r', "m", true)
    else
        vim.api.nvim_feedkeys('\x1b' .. ';wa\r;lua require("harpoon.term").gotoTerminal(1)\r;lua require("harpoon.term").sendCommand(1, 1)\ra\r', "m", true)
    end
end)

m("n", "<Leader>1", function ()
    if vim.bo.buftype == "terminal" then
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-^>", true, false, true) ..';lua require("harpoon.term").gotoTerminal(1)\r;lua require("harpoon.term").sendCommand(1, 1)\ra\r', "m", true)
    else
        vim.api.nvim_feedkeys(';wa\r;lua require("harpoon.term").gotoTerminal(1)\r;lua require("harpoon.term").sendCommand(1, 2)\ra\r', "m", true)
    end
end)

m("t", "<Esc>", "<C-\\><C-n>")
m("t", "<C-u>", "<C-\\><C-N><C-u>")
m("t", "<A-k>", "<C-\\><C-N>k")
-- m("t", "<C-n>", function ()
m("t", "<A-n>", function ()
    vim.api.nvim_feedkeys("\x1b" .. vim.api.nvim_replace_termcodes("<C-^>", true, false, true), "m", true) end)

m("t", "<C-b>", function ()
    vim.api.nvim_feedkeys("\x1b" .. vim.api.nvim_replace_termcodes("<C-^>", true, false, true), "m", true) end)

m("t", "<A-j>", function ()
    vim.api.nvim_feedkeys("\x1b" .. vim.api.nvim_replace_termcodes("<C-^>", true, false, true), "m", true) end)
-- m("t", "<C-h>", '<cmd>lua require("harpoon.ui").nav_file(1)<CR>')
-- m("t", "<C-j>", '<cmd>lua require("harpoon.ui").nav_file(2)<CR>')
-- m("t", "<C-k>", '<cmd>lua require("harpoon.ui").nav_file(3)<CR>')


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
