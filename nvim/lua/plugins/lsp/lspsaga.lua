return {
    'nvimdev/lspsaga.nvim',
    dependencies = {
        'nvim-treesitter/nvim-treesitter', -- optional
        'nvim-tree/nvim-web-devicons',     -- optional
        "neovim/nvim-lspconfig",
    },
    config = function()
        require('lspsaga').setup({
            symbol_in_winbar = { -- 顶部条
                enable = false
            },
            outline = {
                auto_preview = false
            },
            lightbulb = {
                enable = false, -- 关闭灯塔                enable_in_insert = true,
                sign = true,
                sign_priority = 40,
                virtual_text = true,
            },
            -- rename = {
            --     quit = "<C-c>",
            --     exec = "<CR>",
            --     mark = "x",
            --     confirm = "<CR>",
            --     in_select = true,
            -- },
            ui = {
                -- code_action =
            }
        })
        -- Set different settings for different languages' LSP
        -- LSP list: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
        -- How to use setup({}): https://github.com/neovim/nvim-lspconfig/wiki/Understanding-setup-%7B%7D
        --     - the settings table is sent to the LSP
        --     - on_attach: a lua callback function to run after LSP atteches to a given buffer
        local lspconfig = require('lspconfig')

        -- Use an on_attach function to only map the following keys
        -- after the language server attaches to the current buffer
        local on_attach = function(client, bufnr)
            local opts = { noremap = true, silent = true, buffer = bufnr }
            local keymap = vim.keymap.set
            keymap("n", "gh", "<cmd>Lspsaga finder<CR>", opts)
            keymap({ "n", "v" }, "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts)
            keymap("n", "gr", "<cmd>Lspsaga rename<CR>", opts)
            keymap("n", "gp", "<cmd>Lspsaga peek_definition<CR>", opts)
            keymap("n", "gd", "<cmd>Lspsaga goto_definition<CR>", opts)
            keymap("n", "<leader>sl", "<cmd>Lspsaga show_line_diagnostics<CR>", opts)
            keymap("n", "<leader>sb", "<cmd>Lspsaga show_buf_diagnostics<CR>", opts)
            keymap("n", "<leader>sw", "<cmd>Lspsaga show_workspace_diagnostics<CR>", opts)
            keymap("n", "<leader>sc", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts)
            keymap("n", "gk", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
            keymap("n", "gj", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)
            keymap("n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
            keymap("n", "<leader>o", "<cmd>Lspsaga outline<CR>", opts)
            keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)
            keymap("n", "<Leader>ci", "<cmd>Lspsaga incoming_calls<CR>", opts)
            keymap("n", "<Leader>co", "<cmd>Lspsaga outgoing_calls<CR>", opts)
            keymap("n", "<space>f", function()
                vim.lsp.buf.format({ async = true })
            end, opts)
        end

        -- Configure each language
        -- How to add LSP for a specific language?
        -- 1. use `:Mason` to install corresponding LSP
        -- 2. add configuration below

        local capabilities = require('cmp_nvim_lsp').default_capabilities()
        lspconfig.lua_ls.setup({
            on_attach = on_attach,
            settings = {
                Lua = {
                    -- 解决提示 undefined global `vim`
                    diagnostics = { globals = { 'vim' } }
                }
            },
            capabilities = capabilities,
        })
        lspconfig.cssls.setup {
            on_attach = on_attach,
            capabilities = capabilities,
        }
        lspconfig.marksman.setup {
            on_attach = on_attach,
            capabilities = capabilities,
            filetypes ={ "markdown", "markdown.mdx" }
        }
        lspconfig.emmet_ls.setup {
            on_attach = on_attach,
            capabilities = capabilities,
        }
        lspconfig.html.setup {
            on_attach = on_attach,
            capabilities = capabilities,
        }
        lspconfig.tsserver.setup {
            on_attach = on_attach,
            capabilities = capabilities,
        }
        lspconfig.pyright.setup {
            on_attach = on_attach,
            capabilities = capabilities,
        }
        lspconfig.volar.setup {
            on_attach = on_attach,
            capabilities = capabilities,
            -- filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
            filetypes = {"vue"},
            init_options = {
                typescript = {
                    -- tsdk = '/path/to/.npm/lib/node_modules/typescript/lib'
                    -- Alternative location if installed as root:
                    tsdk = '/usr/local/lib/node_modules/typescript/lib',
                },
                vue = {
                    hybridMode = false,
                },
            },

        }

        local signs = {
            { name = "DiagnosticSignError", text = "" },
            { name = "DiagnosticSignWarn", text = "" },
            { name = "DiagnosticSignHint", text = "" },
            { name = "DiagnosticSignInfo", text = "" },
        }
        for _, sign in ipairs(signs) do
            vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
        end
        local config = {
            -- disable virtual text
            virtual_text = false,
            -- show signs
            signs = {
                active = signs,
            },
            update_in_insert = true,
            underline = true,
            severity_sort = true,
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
            },
        }
        vim.diagnostic.config(config)
    end,
}
