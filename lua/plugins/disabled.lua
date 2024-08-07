---
-- Enable/disable plugins here.
---

return {
  -- General
  { 'Bekaboo/deadcolumn.nvim', enabled = true },
  { 'sjclayton/harpoon', enabled = true },
  { 'lukas-reineke/headlines.nvim', enabled = true },
  { 'smoka7/hop.nvim', enabled = true },
  { '3rd/image.nvim', enabled = false },
  { 'iamcco/markdown-preview.nvim', enabled = true },
  { 'epwalsh/obsidian.nvim', enabled = true },
  -- AI
  { 'Exafunction/codeium.nvim', enabled = true },
  { 'David-Kunz/gen.nvim', enabled = true },
  -- Coding
  { 'rmagatti/alternate-toggler', enabled = true },
  { 'lewis6991/gitsigns.nvim', enabled = true },
  { 'lukas-reineke/indent-blankline.nvim', enabled = true },
  { 'echasnovski/mini.ai', enabled = true },
  { 'echasnovski/mini.surround', enabled = true },
  { 'NeogitOrg/neogit', enabled = true },
  { 'windwp/nvim-autopairs', enabled = true },
  { 'NvChad/nvim-colorizer.lua', name = 'nvim-colorizer', enabled = true },
  { 'luckasRanarison/nvim-devdocs', enabled = true },
  { 'hedyhli/outline.nvim', enabled = true },
  { 'folke/todo-comments.nvim', enabled = true },
  { 'Wansmer/treesj', enabled = true },
  { 'folke/trouble.nvim', enabled = true },
  { 'RRethy/vim-illuminate', enabled = true },
  -- LSP / Completion / Formatting / Linting / Debugging / Testing
  { 'williamboman/mason.nvim', enabled = true },
  { 'WhoIsSethDaniel/mason-tool-installer.nvim', enabled = true },
  { 'neovim/nvim-lspconfig', enabled = true },
  { 'hrsh7th/nvim-cmp', enabled = true },
  { 'stevearc/conform.nvim', enabled = true },
  { 'mfussenegger/nvim-lint', enabled = true },
  { 'mfussenegger/nvim-dap', enabled = true },
  { 'nvim-neotest/neotest', enabled = true },
  -- Language Specific
  { 'Saecki/crates.nvim', enabled = true },
  { 'olexsmir/gopher.nvim', enabled = true },
  { 'leoluz/nvim-dap-go', enabled = true },
  { 'mrcjkb/haskell-tools.nvim', enabled = true },
  { 'mrcjkb/rustaceanvim', enabled = true },
  -- Treesitter
  { 'nvim-treesitter/nvim-treesitter', enabled = true },
  -- Colorschemes
  { 'catppuccin/nvim', name = 'catppuccin', enabled = true },
  { 'rose-pine/neovim', name = 'rose-pine', enabled = true },
  { 'folke/tokyonight.nvim', name = 'tokyonight', enabled = true },
  -- UI
  { 'stevearc/dressing.nvim', enabled = true },
  { 'j-hui/fidget.nvim', enabled = true },
  { 'nvim-lualine/lualine.nvim', enabled = true },
  { 'willothy/nvim-cokeline', enabled = true },
  { 'folke/noice.nvim', enabled = true },
  { 'rcarriga/nvim-notify', enabled = true },
  { 'rachartier/tiny-devicons-auto-colors.nvim', enabled = true },
  { 'folke/zen-mode.nvim', enabled = true },
  -- Utils
  { 'AntonVanAssche/music-controls.nvim', enabled = true },
  { 'JManch/nomodoro', enabled = true },
  { 'nvim-neo-tree/neo-tree.nvim', enabled = true },
  { 'nyngwang/NeoZoom.lua', name = 'neo-zoom', enabled = true },
  { 'nvim-telescope/telescope.nvim', enabled = true },
  { 'akinsho/toggleterm.nvim', enabled = true },
  { 'alexghergh/nvim-tmux-navigation', enabled = true },
  { 'wakatime/vim-wakatime', enabled = true },
  { 'folke/which-key.nvim', enabled = true },
}
