-- define common options
local opts = {
    noremap = true, -- non-recursive
    silent = true,  -- do not show message
}

-----------------:<C-U>TmuxNavigateRight<cr>
-- Normal mode --
-----------------
-- Hint: see `:h vim.map.set()`
-- Better window navigation
vim.keymap.set('i', '<C-h>', '<Left>', opts)
vim.keymap.set('i', '<C-j>', '<Down>', opts)
vim.keymap.set('i', '<C-k>', '<Up>', opts)
vim.keymap.set('i', '<C-l>', '<Right>', opts)

-- 折叠

-- vim.keymap.set('n', 'zz', 'za', opts)
-- vim.keymap.set('v', 'zz', 'zf', opts)

-- let g:tmux_navigator_no_mappings = 1
--
-- noremap <silent> {Left-Mapping} :<C-U>TmuxNavigateLeft<cr>
-- noremap <silent> {Down-Mapping} :<C-U>TmuxNavigateDown<cr>
-- noremap <silent> {Up-Mapping} :<C-U>TmuxNavigateUp<cr>
-- noremap <silent> {Right-Mapping} :<C-U>TmuxNavigateRight<cr>
-- noremap <silent> {Previous-Mapping} :<C-U>TmuxNavigatePrevious<cr>

-- Resize with arrows
-- delta: 2 lines
vim.keymap.set('n', '<c-Down>', ':resize -2<CR>', opts)
vim.keymap.set('n', '<c-Up>', ':resize +2<CR>', opts)
vim.keymap.set('n', '<c-Left>', ':vertical resize -2<CR>', opts)
vim.keymap.set('n', '<c-Right>', ':vertical resize +2<CR>', opts)

-- exit
-- save
vim.keymap.set('n', '<c-s>', ':w<CR>', opts)
-- 刷新文件
vim.keymap.set('n', 'R', ':e!<CR>', opts)
-- 切换窗口
vim.keymap.set('n', '<c-x>', '<c-w>x', opts)
-- buffers
vim.keymap.set('n', '<leader>h', ':bp<cr>', opts)
vim.keymap.set('n', '<leader>l', ':bn<cr>', opts)
-- 移除lsp里面的映射，加速切换c-w
vim.cmd([[
unmap <c-w><c-d>
unmap <c-w>d
]])
vim.keymap.set('n', '<c-w>', ':buffer #<cr>', opts)

vim.cmd([[
set nohlsearch
nnoremap <silent> <esc> :nohl<cr>
noremap <silent> n :set hlsearch<cr>n
noremap <silent> N :set hlsearch<cr>N
noremap / :set hlsearch<cr>/
noremap ? :set hlsearch<cr>?
" noremap <silent> * *:set hlsearch<cr>
noremap <silent> <leader>w *:set hlsearch<cr>

nnoremap <expr><leader>r Sh()

function! Sh()
let wordUnderCursor =  expand("<cword>")
set hlsearch
" return ":%s/" .. wordUnderCursor .. "/"
return ":%s/" .. wordUnderCursor

endfunc
]])


vim.keymap.set('v', 'u', '<esc>', opts)
vim.keymap.set('n', '<c-q>', ':q<cr>', opts)
vim.keymap.set('n', '<leader>q', ':qa<cr>', opts)
vim.keymap.set({ 'n', 'v', 'o' }, 'H', '^', opts)
vim.keymap.set({ 'n', 'v', 'o' }, 'L', '$', opts)

-- Hint: start visual mode with the same area as the previous area and the same mode
vim.keymap.set('v', '<', '<gv', opts)
vim.keymap.set('v', '>', '>gv', opts)

-- 按p不会把删除的加到剪贴板
---@diagnostic disable-next-line: redefined-local
-- local function map(mode, lhs, rhs, opts)
--     local keys = require("lazy.core.handler").handlers.keys
--     --@cast keys LazyKeysHandler
--     -- do not create the keymap if a lazy keys handler exists
--     if not keys.active[keys.parse({ lhs, mode = mode }).id] then
--         opts = opts or {}
--         opts.silent = opts.silent ~= false
--         vim.keymap.set(mode, lhs, rhs, opts)
--     end
-- end
-- Paste over currently selected text without yanking it
-- map("v", "p", '"_dP', { silent = true })

--格式化
vim.keymap.set('n', '<leader>=', 'mwggvG=`w', opts)

vim.keymap.set('v', 'v', 'vggVG', opts)
-----------------
-- 插件 --
-----------------
-- 翻译
-- local fl = require('config.floatwin')
-- vim.keymap.set({ 'v', 'n' }, '<c-f>', fl.trans, opts)

-- BufferLine


-- toggleterm
-- vim.keymap.set('n', '<silent><c-t>', 'exe v:count1 . "toggleterm"<CR>', opts)
-- vim.keymap.set('i', '<silent><c-t>', '<esc><Cmd>exe v:count1 . "toggleterm"<CR>', opts)

-- nvim-telescope
-- local builtin = require('telescope.builtin')
-- vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
-- vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
-- vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
-- vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
-- vim.keymap.set('n', '<leader>fr', builtin.oldfiles, {})
-- vim.keymap.set('n', '<leader>fa', builtin.autocommands, {})
-- vim.keymap.set('n', '<leader>fk', builtin.keymaps, {})
-- vim.keymap.set('n', '<leader>fc', builtin.commands, {})
-- vim.keymap.set('n', '<leader>fm', builtin.marks, {})
-- vim.keymap.set('n', '<leader>uc', builtin.colorscheme, {})
