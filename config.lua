--[[
lvim is the global options object

Linters should be
filled in as strings with either
a global executable or a path to
an executable
]]
-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT

-- general
lvim.log.level = "warn"
lvim.format_on_save = true
lvim.colorscheme = "gruvbox-material"
-- to disable icons and use a minimalist setup, uncomment the following
-- lvim.use_icons = false

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"
lvim.lsp.diagnostics.virtual_text = false
-- vim.keymap.del("n", "<C-Up>")
-- override a default keymapping
-- lvim.keys.normal_mode["<C-q>"] = ":q<cr>" -- or vim.keymap.set("n", "<C-q>", ":q<cr>" )

-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
local _, actions = pcall(require, "telescope.actions")
lvim.builtin.telescope.defaults.mappings = {
  -- for input mode
  i = {
    ["<C-j>"] = actions.move_selection_next,
    ["<C-k>"] = actions.move_selection_previous,
    ["<C-n>"] = actions.cycle_history_next,
    ["<C-p>"] = actions.cycle_history_prev,
  },
  -- for normal mode
  n = {
    ["<C-j>"] = actions.move_selection_next,
    ["<C-k>"] = actions.move_selection_previous,
  },
}

-- Change theme settings
-- lvim.builtin.theme.options.dim_inactive = true
-- lvim.builtin.theme.options.style = "storm"

-- Use which-key to add extra bindings with the leader-key prefix
-- lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
lvim.builtin.which_key.mappings["t"] = {
  name = "+Trouble",
  r = { "<cmd>Trouble lsp_references<cr>", "References" },
  f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
  d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics" },
  q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
  l = { "<cmd>Trouble loclist<cr>", "LocationList" },
  w = { "<cmd>Trouble workspace_diagnostics<cr>", "Workspace Diagnostics" },
}

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
-- lvim.builtin.notify.active = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false
lvim.builtin.dap.active = true
lvim.builtin.breadcrumbs.active = false
-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "javascript",
  "json",
  "lua",
  "python",
  "typescript",
  "tsx",
  "css",
  "rust",
  "java",
  "yaml",
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enable = true


local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  {
    command = "eslint",
    args = { "-f", "json", "--stdin", "--stdin-filename", "$FILENAME" },
    filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
  }
}

local formater = require "lvim.lsp.null-ls.formatters"
formater.setup {
  {
    command = "stylua",
    filetypes = { "org" },
  }
}
-- Additional Plugins
lvim.plugins = {
  { "lunarvim/colorschemes" },
  { "phaazon/hop.nvim",
    event = "BufRead",
    config = function()
      require("hop").setup()
      vim.api.nvim_set_keymap("n", "s", ":HopChar2<cr>", { silent = true })
      vim.api.nvim_set_keymap("n", "S", ":HopWord<cr>", { silent = true })
    end,
  },
  {
    "ray-x/lsp_signature.nvim",
    config = function() require "lsp_signature".on_attach() end,
    event = "BufRead"
  }, {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
  },
  {
    "akinsho/flutter-tools.nvim",
    requires = { "nvim-lua/plenary.nvim", 'nvim-lua/lsp-status.nvim' },
    config = function()
      require("flutter-tools").setup({})
      require("telescope").load_extension("flutter")
    end,
  },
  { 'nvim-telescope/telescope-ui-select.nvim' },
  { 'sainnhe/gruvbox-material' },

  { "olexsmir/gopher.nvim" },
  { "leoluz/nvim-dap-go" },
  -- { "mg979/vim-visual-multi" },
  { "iamcco/markdown-preview.nvim" },
  { 'kevinhwang91/nvim-ufo', requires = 'kevinhwang91/promise-async' },
  { 'nvim-orgmode/orgmode', config = function()
    require('orgmode').setup {}
  end
  },
  -- { 'akinsho/org-bullets.nvim', config = function()
  --   require('org-bullets').setup()
  -- end
  -- },
  -- {
  --   'lukas-reineke/headlines.nvim',
  --   after = 'nvim-treesitter',
  --   config = function()
  --     require('headlines').setup()
  --   end,
  -- },
}
require("luasnip.loaders.from_snipmate").lazy_load()

lvim.builtin.telescope.extensions = {
  ["ui-select"] = {
    require("telescope.themes").get_dropdown {
    }
  }
}


require("telescope").load_extension("ui-select")

vim.opt.relativenumber = true
vim.opt.listchars = "eol:↲,tab:» ,trail:·,extends:<,precedes:>,conceal:┊,nbsp:␣"

lvim.autocommands = {
  -- {
  --   "BufWritePost", {
  --     pattern = { "*.org" },
  --     callback = function()
  --       vim.cmd [[ silent !rsync -r --size-only ~/OrgFiles/ ~/OrgMod/ --temp-dir=/tmp --no-owner --no-group]]
  --     end
  --   }
  -- },
  {
    "InsertLeave", {
      pattern = { "*" },
      callback = function()
        vim.opt.relativenumber = true
        vim.opt.cursorline = true
      end
    },
  }, {
    "InsertEnter", {
      pattern = { "*" },
      callback = function()
        vim.opt.relativenumber = false
        vim.opt.cursorline = false
      end
    },
  }, {
    "BufRead", {
      pattern = { "*.go", "*,dart" },
      callback = function()
        vim.cmd([[
      set nofoldenable
      set foldlevel=999999
      set fillchars=fold:\
      set foldtext=CustomFoldText()
      setlocal foldmethod=expr
      setlocal foldexpr=GetPotionFold(v:lnum)

      function! GetPotionFold(lnum)
        if getline(a:lnum) =~? '\v^\s*$'
          return '-1'
        endif

        let this_indent = IndentLevel(a:lnum)
        let next_indent = IndentLevel(NextNonBlankLine(a:lnum))

        if next_indent == this_indent
          return this_indent
        elseif next_indent < this_indent
          return this_indent
        elseif next_indent > this_indent
          return '>' . next_indent
        endif
      endfunction

      function! IndentLevel(lnum)
          return indent(a:lnum) / &shiftwidth
      endfunction

      function! NextNonBlankLine(lnum)
        let numlines = line('$')
        let current = a:lnum + 1

        while current <= numlines
            if getline(current) =~? '\v\S'
                return current
            endif

            let current += 1
        endwhile

        return -2
      endfunction

      function! CustomFoldText()
        " get first non-blank line
        let fs = v:foldstart

        while getline(fs) =~ '^\s*$' | let fs = nextnonblank(fs + 1)
        endwhile

        if fs > v:foldend
            let line = getline(v:foldstart)
        else
            let line = substitute(getline(fs), '\t', repeat(' ', &tabstop), 'g')
        endif

        let w = winwidth(0) - &foldcolumn - (&number ? 8 : 0)
        let foldSize = 1 + v:foldend - v:foldstart
        let foldSizeStr = " " . foldSize . " lines "
        let foldLevelStr = repeat("+--", v:foldlevel)
        let expansionString = repeat(" ", w - strwidth(foldSizeStr.line.foldLevelStr))
        return line . expansionString . foldSizeStr . foldLevelStr
      endfunction
      ]] )
      end
    },
  },
}


-- Load custom treesitter grammar for org filetype
require('orgmode').setup_ts_grammar()

require('orgmode').setup(
  {
    notifications = {
      enabled = false,
      cron_enabled = true,
      repeater_reminder_time = false,
      deadline_warning_reminder_time = false,
      reminder_time = 10,
      deadline_reminder = true,
      scheduled_reminder = true,
      notifier = function(tasks)
        local result = {}
        for _, task in ipairs(tasks) do
          require('orgmode.utils').concat(result, {
            string.format('# %s (%s)', task.category, task.humanized_duration),
            string.format('%s %s %s', string.rep('*', task.level), task.todo, task.title),
            string.format('%s: <%s>', task.type, task.time:to_string())
          })
        end

        if not vim.tbl_isempty(result) then
          require('orgmode.notifications.notification_popup'):new({ content = result })
        end
      end,
      cron_notifier = function(tasks)
        for _, task in ipairs(tasks) do
          local title = string.format('%s (%s)', task.category, task.humanized_duration)
          local subtitle = string.format('%s %s %s', string.rep('*', task.level), task.todo, task.title)
          local date = string.format('%s: %s', task.type, task.time:to_string())

          -- Linux
          if vim.fn.executable('notify-send') == 1 then
            vim.loop.spawn('notify-send', { args = { string.format('%s\n%s\n%s', title, subtitle, date) } })
          end

          -- MacOS
          if vim.fn.executable('terminal-notifier') == 1 then
            vim.loop.spawn('terminal-notifier', { args = { '-title', title, '-subtitle', subtitle, '-message', date } })
          end
        end
      end
    },
  }
)

-- Treesitter configuration
require('nvim-treesitter.configs').setup {
  -- If TS highlights are not enabled at all, or disabled via `disable` prop,
  -- highlighting will fallback to default Vim syntax highlighting
  highlight = {
    enable = true,
    -- Required for spellcheck, some LaTex highlights and
    -- code block highlights that do not have ts grammar
    additional_vim_regex_highlighting = { 'org' },
  },
  ensure_installed = { 'org' }, -- Or run :TSUpdate org
}

require('orgmode').setup({
  org_agenda_files = { '~/OrgFiles/**/*' },
  org_default_notes_file = '~/OrgFiles/refile.org',
  org_hide_leading_stars = true,
  org_agenda_skip_scheduled_if_done = true,
  org_agenda_skip_deadline_if_done = true,
})

vim.opt.conceallevel = 2
vim.opt.concealcursor = 'nc'
vim.opt.shellslash = true
