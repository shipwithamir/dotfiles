return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		build = ":TSUpdate",
		lazy = false, -- the plugin no longer supports lazy-loading
		dependencies = {
			"windwp/nvim-ts-autotag",
			"JoosepAlviste/nvim-ts-context-commentstring",
		},
		config = function()
			-- Enable treesitter highlighting (now provided by Neovim core)
			vim.api.nvim_create_autocmd("FileType", {
				callback = function()
					local ok = pcall(vim.treesitter.start)
					if ok then
						-- Experimental treesitter-based indentation
						vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
					end
				end,
			})

			-- Install parsers (no-op if already installed)
			require("nvim-treesitter").install({
				"json",
				"javascript",
				"typescript",
				"tsx",
				"yaml",
				"html",
				"css",
				"prisma",
				"markdown",
				"markdown_inline",
				"bash",
				"lua",
				"vim",
				"gitignore",
				"query",
				"go",
				"sql",
				"python",
				"c",
				"cpp",
			})

			-- Enable autotagging for HTML/XML-like tags
			require("nvim-ts-autotag").setup()

			-- Enable ts-context-commentstring plugin for JSX/TSX comments
			require("ts_context_commentstring").setup({
				enable_autocmd = false, -- Disable autocommands
			})
		end,
	},
}
