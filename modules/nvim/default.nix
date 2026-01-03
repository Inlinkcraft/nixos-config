{ config, pkgs, inputs, ...}:
{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    plugins = with pkgs.vimPlugins; [
        nvim-web-devicons
        lualine-nvim
	tokyonight-nvim
	plenary-nvim
	telescope-nvim
	nvim-treesitter
	nvim-treesitter-parsers.lua
	nvim-treesitter-parsers.cpp
	nvim-treesitter-parsers.markdown
	nvim-treesitter-parsers.markdown_inline
	nvim-treesitter-parsers.cmake
    nvim-treesitter-parsers.eww
    ];
    extraLuaConfig = with pkgs.vimPlugins; 
    "
      ${builtins.readFile ./config/options.lua}
      ${builtins.readFile ./config/keybinds.lua}
      
      vim.cmd.colorscheme 'tokyonight'
      vim.api.nvim_set_hl(0, 'Normal', {bg = 'none' })

      require('lualine').setup()

      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
      vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

      local configs = require('nvim-treesitter.configs')
      configs.setup({
        highlight = {
	  enable = true,
	  },
	  indent = { enable = true },
	  autotage = { enable = true },
          auto_install = false,
        })
    ";
  };
}
