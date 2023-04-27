local M = {}

function M.setup()
  -- Indicate first time installation
  local packer_bootstrap = false

  -- packer.nvim configuration
  local conf = {
    display = {
      open_fn = function()
        return require("packer.util").float { border = "rounded" }
      end,
    },
  }

  -- Check if packer.nvim is installed
  -- Run PackerCompile if there are changes in this file
  local function packer_init()
    local fn = vim.fn
    local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
      packer_bootstrap = fn.system {
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
      }
      vim.cmd [[packadd packer.nvim]]
    end
    vim.cmd "autocmd BufWritePost plugins.lua source <afile> | PackerCompile"
  end

  -- Plugins
  local function plugins(use)
    use { "wbthomason/packer.nvim" }

		-- Performance
		use { "lewis6991/impatient.nvim" }

		-- Load only when require
    use { "nvim-lua/plenary.nvim", module = "plenary" }

    -- Colorscheme
    use {
      "ellisonleao/gruvbox.nvim",
      config = function()
        vim.o.background = "dark" -- or "light" for light mode
        vim.cmd "colorscheme gruvbox"
      end,
    }
    -- Git
    use {
      "TimUntersberger/neogit",
			cmd = "Neogit",
      config = function()
        require("config.neogit").setup()
      end,
    }
    -- Treesitter
    use { 
      "nvim-treesitter/nvim-treesitter", 
      run = function()
        local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
        ts_update()
      end,
      config = function()
        require("config.nvim-treesitter").setup()
      end,
    }
		-- Better icons
    use {
      "kyazdani42/nvim-web-devicons",
      module = "nvim-web-devicons",
      config = function()
        require("nvim-web-devicons").setup { default = true }
      end,
    }
    -- Status line
    use {
      "nvim-lualine/lualine.nvim",
      event = "VimEnter",
      after = "nvim-treesitter",
      config = function()
        require("config.lualine").setup()
      end,
      wants = "nvim-web-devicons",
    }
    -- nvim-tree
    use {
      "kyazdani42/nvim-tree.lua",
      opt = true,
      wants = "nvim-web-devicons",
      cmd = { "NvimTreeToggle", "NvimTreeClose" },
      module = "nvim-tree",
      config = function()
        require("config.nvimtree").setup()
      end,
    }
		-- indent blankline
		use {
			'lukas-reineke/indent-blankline.nvim',
			event = "BufReadPre",
			config = function()
				require("config.indent-blankline").setup()
			end,
		}

    if packer_bootstrap then
      print "Restart Neovim required after installation!"
      require("packer").sync()
    end
  end

  packer_init()

  local packer = require "packer"

	-- Performance
	pcall(require, "impatient")

  packer.init(conf)
  packer.startup(plugins)
end

return M
