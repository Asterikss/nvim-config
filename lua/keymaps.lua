local Job = require('plenary.job')

local function m(a, b, v)
  vim.keymap.set(a, b, v, { noremap = true })
end

m({ 'n', 'v' }, '<Space>', '<Nop>')

m('v', 'y', 'myy`y') -- keeps the position of the cursor after v yank

m({ 'n', 'v' }, ';', ':')
m('n', ':', ';')

m({ 'n', 'x' }, 'x', '"_x') -- Prevent x from overwriting clippboard
m('v', '<A-d>', '"_d')
m('n', '<A-d>', '"_dd')
m('n', '<A-D>', '"_d')

m('v', '>', '>gv')
m('v', '<', '<gv')

m('n', '<Leader><Leader>q', 'gqap') -- formatting text
m('v', '<Leader><Leader>q', 'gq')

m('n', 'n', 'nzz')
m('n', 'N', 'Nzz')

m('n', '<C-j>', '<c-w>j')
m('n', '<C-k>', '<c-w>k')
m('n', '<C-l>', '<c-w>l')
m('n', '<C-h>', '<c-w>h')

m('n', 'go', 'o<Esc>k')
m('n', 'gO', 'O<Esc>j')

m('n', '<Down>', '<c-w>-')
m('n', '<Up>', '<c-w>+')
m('n', '<Left>', '<c-w>>')
m('n', '<Right>', '<c-w><')

m('i', '<A-7>', '<Esc>gT') -- Zellij for some reason eats Control PageUp (booo)
m('i', '<A-8>', '<Esc>gt')
m('n', '<A-7>', 'gT')
m('n', '<A-8>', 'gt')

m('x', 'J', ":m '>+1<CR>gv=gv")
m('x', 'K', ":m '<-2<CR>gv=gv")

m('n', '<Leader>l', '<cmd>Lex 25<CR>')
m('n', '<Leader><Leader>l', '<cmd>Tex<CR>')

m('n', '<c-d>', '<c-d>zz')
m('n', '<c-u>', '<c-u>zz')

m('n', '<A-y>', '"zyy"zp') -- paste line under
m('n', '<Leader><A-y>', function() -- comment the line and paste it under
  vim.cmd('normal! "zyy')
  vim.cmd('normal gcc')
  vim.cmd('normal! "zp')
end)
m(
  'x',
  '<Leader><A-y>',
  function() -- comment block and paste it under. Works with the cursor on the bottom of the block ("o" to switch)
    vim.cmd('normal! "zygv')
    vim.cmd('normal gc')
    vim.cmd('normal! gv\x1bo\x1b"zp')
  end
)

m('n', 'D', 'dd')
m('n', 'dd', 'D')
m('n', 'C', 'cc')
m('n', 'cc', 'C')
m('n', 'f', 'v')
m('n', 'F', 'V')
m({ 'n', 'x' }, 'v', 'f')
m({ 'n', 'x' }, 'V', 'F')

m('n', 'Y', 'yy')
m('n', 'yy', 'y$')

m('n', 'J', 'mzJ`z')

m('n', '<', '<<') -- delay like there is multiple keymaps that start with "<" and does not even show up in Telescope keymaps
m('n', '>', '>>')

m('n', 'p', "<cmd>pu<CR>V'[=") -- paste under / over and automatically allign using "=". Also see :h ]p and [P
m('n', '<A-p>', '<cmd>pu<CR>')
m('n', 'P', "<cmd>pu!<CR>V']=")
m('n', '<A-P>', '<cmd>pu!<CR>')
m('x', 'p', '"_dP') -- paste without trashing the clippboard

m('n', 't', 'yiw')
m('n', 'T', 'viw"_dP')
m('n', '<A-t>', 'yiW')
m('n', '<A-T>', 'viW"_dP')

m('n', '<Leader><Leader>Q', 'q') -- q is taken for commenting

m('n', 'gt', '<cmd>vsp | lua vim.lsp.buf.definition()<CR>')

m({ 'i', 'c' }, '', '<C-w>') -- map Control Backspace to Control W
m('c', '<Up>', '<C-p>')
m('c', '<Down>', '<C-n>')
m('c', '<C-p>', '<Up>')
m('c', '<C-n>', '<Down>')

m('i', '<A-=>', ' == ')

m('n', '-', '<CMD>Oil<CR>')
-- m("n", "-", require('oil').toggle_float)

m({ 'n', 'i' }, '<C-e>', function()
  vim.cmd('wa')
end)

m('i', "<A-'>", function() -- this took me 3 hours
  -- vim.api.nvim_feedkeys('\x1blyla, \x12"\x12"' .. vim.api.nvim_replace_termcodes("<Left>", true, false, true), "m", true) -- \x16 for c-c; 12 for c-r
  local col = vim.api.nvim_win_get_cursor(0)[2]
  local char_under_cursor = vim.api.nvim_get_current_line():sub(col + 1, col + 1)

  if char_under_cursor == ')' then
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Right>', true, false, true) .. ', (', 'm', true)
  elseif char_under_cursor == ']' then
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Right>', true, false, true) .. ', [', 'm', true)
  elseif char_under_cursor == '}' then
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Right>', true, false, true) .. ', {', 'm', true)
  elseif char_under_cursor == '"' then
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Right>', true, false, true) .. ', "', 'm', true)
  elseif char_under_cursor == "'" then
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Right>', true, false, true) .. ", '", 'm', true)
  end
end)

m('n', '<Leader><Leader>c', function() -- clear all ^M
  vim.api.nvim_feedkeys(
    ';%s/'
      .. vim.api.nvim_replace_termcodes('<C-q>', true, false, true)
      .. vim.api.nvim_replace_termcodes('<C-m>', true, false, true)
      .. '//g\r',
    'm',
    true
  )
end)

m('n', 'gT', function() -- open current file in a new tab
  vim.cmd('normal! ma')
  vim.cmd('tabedit %')
  vim.cmd('normal! `a')
end)

m('n', '<Leader>o', function() -- format file based on the extension
  local file_type = vim.bo.filetype
  vim.cmd('w')
  if file_type == 'python' then
    vim.cmd('! black ' .. vim.api.nvim_buf_get_name(0))
  elseif file_type == 'rust' then
    vim.cmd('! rustfmt ' .. vim.api.nvim_buf_get_name(0))
    -- vim.cmd("RustFmt") Does not work and I dont want to install rust-lang/rust.vim to fix it
  elseif file_type == 'cpp' then
    vim.lsp.buf.format()
  elseif file_type == 'lua' then
    -- ad hoc
    -- vim.cmd("! stylua " .. vim.api.nvim_buf_get_name(0))
    -- search-parent-directories | vim.fn.findfile(".stylua.toml", vim.fn.getcwd())
    -- local stylua_toml = vim.fn.findfile(".stylua.toml", vim.fn.getcwd() .. ";")
    local args = { '--config-path', '.stylua.toml', '-' }
    local errors = {}
    local job = Job:new({
      command = 'stylua',
      args = args,
      writer = vim.api.nvim_buf_get_lines(0, 0, -1, false),
      on_stderr = function(_, data)
        table.insert(errors, data)
      end,
    })
    local output = job:sync()
    if job.code == 0 then
      vim.api.nvim_buf_set_lines(0, 0, -1, false, output)
    else
      vim.schedule(function()
        error(string.format('[stylua] %s', errors[1] or 'Failed to format due to errors'))
      end)
    end
  end
end)

m({ 'n', 't' }, 'X', '<Esc><cmd>wa<CR><cmd>qa<CR>')
m({ 'n', 't' }, '<A-X>', '<Esc><cmd>wa<CR><cmd>mks! .dev/Session.vim<CR><cmd>qa<CR>')

-- merge it with alt y?
vim.api.nvim_create_user_command('CopyLineAbove', function(opts)
  -- local count = opts.count
  local distance = opts.line2 - opts.line1 + 1
  -- print(count, distance)
  -- print(vim.inspect(opts))
  if opts.count > 0 then
    vim.cmd('-' .. distance) -- vim.cmd("normal! " .. distance .. "k")
    vim.cmd('y') -- vim.cmd("normal! Y")
    vim.cmd('+' .. distance) -- vim.cmd("normal! " .. distance .. "j")
    vim.cmd('pu') -- vim.cmd("normal p")
    vim.cmd("normal! V'[=") -- align using "="
  end
end, { nargs = 0, count = true })
m('n', '<Leader><Leader>k', ':CopyLineAbove<CR>')

------ fugitive ------
m('n', '<Leader>hg', function()
  if vim.bo.filetype == 'fugitive' then
    vim.cmd('x')
  else
    vim.cmd('G')
  end
end)

m('n', '<Leader>hw', '<cmd>Gwrite<CR>')

m('n', '<Leader>hc', ':G commit -m""<Left>')

m('n', '<Leader>hu', '<cmd>G push<CR>')

m({ 'n', 'v' }, '<Leader>ha', '<cmd>Gitsign stage_hunk<CR>')

------ plugin development ------
P = function(t)
  print(vim.inspect(t))
  return t
end

RELOAD = function(...)
  return require('plenary.reload').reload_module(...)
end

R = function(name, skip_setup)
  RELOAD(name)
  if not skip_setup then
    require(name).setup({})
  end
  return require(name)
end

------ Harpoon + terminal mappings ------
m(
  'n',
  '<Leader>m',
  function() -- pupulate Harpoon Commands based on the current buffer and run the first command in 1st terminal
    if vim.bo.filetype == 'python' then
      vim.api.nvim_feedkeys(
        ';lua require("harpoon.cmd-ui").toggle_quick_menu()\rdipap '
          .. vim.fn.expand('%:h')
          .. '/'
          .. vim.fn.expand('%:t')
          .. '\x1bq'
          .. ';wa\r;lua require("harpoon.term").gotoTerminal(1)\r;lua require("harpoon.term").sendCommand(1, 1)\ra\r',
        'm',
        true
      )
    else
      vim.api.nvim_feedkeys(';lua require("harpoon.cmd-ui").toggle_quick_menu()\rdapacargo run\x1bq', 'm', true)
    end
  end
)

m('n', '<Leader>a', '<cmd>lua require("harpoon.mark").add_file()<CR>')
m('n', 'ą', '<cmd>lua require("harpoon.ui").nav_file(1)<CR>')
m('n', 'ś', '<cmd>lua require("harpoon.ui").nav_file(2)<CR>')
m('n', 'ę', '<cmd>lua require("harpoon.ui").nav_file(3)<CR>')
m('n', '<A-9>', '<cmd>lua require("harpoon.ui").nav_file(4)<CR>')
m('n', '<A-0>', '<cmd>lua require("harpoon.ui").nav_file(5)<CR>')
m('n', '<A-a>', '<cmd>lua require("harpoon.ui").toggle_quick_menu()<CR>')
m('n', '<Leader><Leader>m', '<cmd>lua require("harpoon.cmd-ui").toggle_quick_menu()<CR>')

m('n', '<A-n>', function() -- goes to the beginning of the command line. Always in insert mode
  if vim.bo.buftype == 'terminal' then
    -- vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-^>", true, false, true), "m", true) -- change to :e %
    vim.cmd('b #')
    vim.cmd('normal! zz')
  else
    vim.api.nvim_feedkeys(';lua require("harpoon.term").gotoTerminal(1)\ra', 'm', true) -- Can you go into insert mode via command -- keepjumps, also needed for C-^ -> almost equivalent to ":e #"!
  end
end)

m('n', '<A-N>', function() -- same, but does not change the original location of the cursor. Alsways in normal mode
  if vim.bo.buftype == 'terminal' then
    -- vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-^>", true, false, true), "m", true)
    vim.cmd('e #')
    -- vim.schedule(function()
    --     vim.cmd("normal! zz")
    -- end)
    vim.cmd('normal! zz')
  else
    vim.api.nvim_feedkeys(';lua require("harpoon.term").gotoTerminal(1)\r', 'm', true) -- Maby do that with a command since a is not needed
  end
end)

m('n', '<A-b>', function()
  if vim.bo.buftype == 'terminal' then
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-^>', true, false, true), 'm', true)
  else
    vim.api.nvim_feedkeys(';wa\r;lua require("harpoon.term").gotoTerminal(2)\ra', 'm', true)
  end
end)

m('n', '<A-j>', function()
  if vim.bo.buftype == 'terminal' then
    vim.api.nvim_feedkeys(
      vim.api.nvim_replace_termcodes('<c-^>', true, false, true)
        .. ';lua require("harpoon.term").gotoTerminal(1)\r;lua require("harpoon.term").sendCommand(1, 1)\ra\r',
      'm',
      true
    )
  else
    vim.api.nvim_feedkeys(
      ';wa\r;lua require("harpoon.term").gotoTerminal(1)\r;lua require("harpoon.term").sendCommand(1, 1)\ra\r',
      'm',
      true
    )
  end
end)

m('i', '<A-j>', function()
  vim.api.nvim_feedkeys(
    '\x1b' .. ';wa\r;lua require("harpoon.term").gotoTerminal(1)\r;lua require("harpoon.term").sendCommand(1, 1)\ra\r',
    'm',
    true
  )
end)

m(
  'n',
  '<Leader><Leader>1',
  function() -- TODO that type of thing can be done with leader A-1 etc since A-1 is on the keyboard
    if vim.bo.buftype == 'terminal' then
      vim.api.nvim_feedkeys(
        vim.api.nvim_replace_termcodes('<C-^>', true, false, true)
          .. ';lua require("harpoon.term").gotoTerminal(1)\r;lua require("harpoon.term").sendCommand(1, 2)\ra\r',
        'm',
        true
      )
    else
      vim.api.nvim_feedkeys(
        ';wa\r;lua require("harpoon.term").gotoTerminal(1)\r;lua require("harpoon.term").sendCommand(1, 2)\ra\r',
        'm',
        true
      )
    end
  end
)

m('t', '<Esc>', '<C-\\><C-n>')
m('t', '<C-u>', '<C-\\><C-N><C-u>')
m('t', '<A-k>', '<C-\\><C-N>k')
m('t', '<A-7>', '<C-\\><C-N>gT')
m('t', '<A-8>', '<C-\\><C-N>gt')

m('t', 'ą', '<cmd>lua require("harpoon.ui").nav_file(1)<CR>')
m('t', 'ś', '<cmd>lua require("harpoon.ui").nav_file(2)<CR>')
m('t', 'ę', '<cmd>lua require("harpoon.ui").nav_file(3)<CR>')
m('t', '<A-9>', '<cmd>lua require("harpoon.ui").nav_file(4)<CR>')
m('t', '<A-0>', '<cmd>lua require("harpoon.ui").nav_file(5)<CR>')

m('t', '<A-n>', function()
  vim.cmd('b #') -- vim.api.nvim_feedkeys("\x1b" .. vim.api.nvim_replace_termcodes("<C-^>", true, false, true), "m", true)
  vim.cmd('normal! zz')
end)

m('t', '<A-b>', function()
  vim.cmd('b #')
  vim.cmd('normal! zz')
end)

m('t', '<A-j>', function()
  vim.api.nvim_input('<Esc>') -- nvim_feedkeys("\x1b") -- vim.cmd("stopinsert") -- vim.api.nvim_command("stopinsert")
  vim.cmd('buffer #') -- toggle previous buffer to preserve previous file if called from terminal different than terminal 1
  vim.cmd('buffer #') -- here same as require("harpoon.term").gotoTerminal(1) or nvim_feedkeys + vim.api.nvim_replace_termcodes("<c-^>", true, false, true)
  require('harpoon.term').sendCommand(1, 1)
  vim.api.nvim_input('a\r') -- vim.cmd("startinsert") and vim.api.nvim_command("startinsert") did not work properly
end)

-- TODO
-- m("t", "<A-1>", function()
--     vim.api.nvim_feedkeys("\x1b" ..
--     vim.api.nvim_replace_termcodes("<c-^>", true, false, true) ..
--     ';lua require("harpoon.term").gotoTerminal(1)\r;lua require("harpoon.term").sendCommand(1, 2)\ra\r', "m", true)
-- end)

------ Telescope
m('n', '<Leader>f', function()
  require('telescope.builtin').find_files(require('telescope.themes').get_dropdown {
    previewer = false,
  })
end)

m('n', '<Leader>/', function()
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    windblend = 10,
    previewer = false,
  })
end)

m('n', '<leader>sc', function()
  require('telescope.builtin').find_files({ cwd = vim.fn.stdpath 'config' })
end)

m('n', '<leader>sn', function()
  require('telescope.builtin').find_files({ cwd = '/home/lono/notes' })
end)

m('n', '<Ł>', function()
  require('telescope.builtin').find_files({ cwd = '.dev/' })
end)
m('t', 'ł', '<CMD>e .dev/notes.txt<CR>')
m('n', 'ł', function()
  if vim.fn.expand('%') ~= '.dev/notes.txt' then
    vim.cmd('e .dev/notes.txt')
  else
    local prev_buf_name = vim.fn.bufname('#')
    vim.cmd('b #')
    if prev_buf_name:match('^term') then
      vim.cmd('startinsert')
    end
  end
end)

m('n', '<Leader><Leader>f', require('telescope.builtin').find_files)
m('n', '<Leader>b', require('telescope.builtin').buffers)
m('n', '<Leader>gg', require('telescope.builtin').live_grep)
m('n', '<Leader>gh', require('telescope.builtin').help_tags)
m('n', '<Leader>?', require('telescope.builtin').oldfiles)
m('n', '<Leader>sd', require('telescope.builtin').diagnostics)
m('n', '<Leader>sw', require('telescope.builtin').grep_string)

----- Diagnostic keymaps
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })
