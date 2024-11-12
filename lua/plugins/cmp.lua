-- nvim-cmp | A completion plugin for neovim coded in Lua
-- https://github.com/hrsh7th/nvim-cmp
---@diagnostic disable: missing-fields, inject-field

local function get_lsp_completion_context(completion, source)
	local ok, source_name = pcall(function()
	  return source.source.client.config.name
	end)
	if not ok then
	  return nil
	end
	if source_name == "tsserver" or source_name == "typescript-tools" then
	  return completion.detail
	elseif source_name == "pyright" then
	  if completion.labelDetails ~= nil then
		return completion.labelDetails.description
	  end
	end
  end

-- Return true if whitespace is detected before cursor position.
-- ---@return boolean
-- local has_whitespace_before = function()
-- 	local col = vim.fn.col(".") - 1
-- 	local line = vim.api.nvim_get_current_line()
-- 	return col == 0 or line:sub(col, col):match("%s")
--   end

-- Use buffers from the current tabpage, but omit man pages as they can
-- slow down neovim by being too large.
local search_tabpage = {
	get_bufnrs = function()
		local ret = {}
		for _, winid in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
			local bufnr = vim.api.nvim_win_get_buf(winid)
			local ft = vim.api.nvim_get_option_value("filetype", { buf = bufnr })
			if ft ~= "man" then
				table.insert(ret, bufnr)
			end
		end
		return ret
	end,
}

-- Options for completion/documentation windows
local window_opts = {
	max_width = 40,
	border = vim.g.border,
	winhighlight = table.concat({
		"NormalFloat:NormalFloat",
		"FloatBorder:FloatBorder",
		"CursorLine:PmenuSel",
		"Search:None",
	}, ","),
}

local source_labels = {
	buffer = "[Buffer]",
	codeium = "[Codeium]",
	crates = "[Crates]",
	git = "[Git]",
	latex_symbols = "[LaTex]",
	luasnip = "[LuaSnip]",
	neorg = "[Neorg]",
	nvim_lsp = "[LSP]",
	nvim_lua = "[Neovim]",
	path = "[Path]",
	spell = "[Spell]",
	treesitter = "[Treesitter]",
	ultisnips = "[UltiSnip]",
	vsnip = "[VSnip]",
	zsh = "[ZSH]",
}

-- Set source label for `vim_item.menu` in cmp popup menu.
-- If: source is nvim_lsp, replace `item.menu` with the clients name.
-- Else: set the appropriate label from `source_labels`.
---@param entry table
---@return string
local format_source_labels = function(entry)
	if entry.source.name == "nvim_lsp" then
		if entry.source.source.client then
			local name = entry.source.source.client.name
			return ("[%s]"):format(name)
		end
	end
	return source_labels[entry.source.name]
end

---@type LazyPluginSpec
return {
	"hrsh7th/nvim-cmp",
	event = { "InsertEnter", "CmdlineEnter" },
	dependencies = {
		"dmitmel/cmp-cmdline-history",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-nvim-lua",
		"hrsh7th/cmp-path",
		"saadparwaiz1/cmp_luasnip",
		"onsails/lspkind-nvim",
		{
			"js-everts/cmp-tailwind-colors",
			config = true,
		},
	},
	config = function()
		local cmp = require("cmp")
		local lspkind = require("lspkind")

		cmp.setup({
			enable = true,
		    formatting = {
				format = function(entry, vim_item)
				  -- Set the highlight group for the Codeium source
				  if entry.source.name == "codeium" then
					vim_item.kind_hl_group = "CmpItemKindCopilot"
				  end
	  
				  -- Get the item with kind from the lspkind plugin
				  local item_with_kind = require("lspkind").cmp_format({
					mode = "symbol_text",
					maxwidth = 50,
					symbol_map = source_labels,
				  })(entry, vim_item)
	  
				  item_with_kind.kind = lspkind.symbolic(item_with_kind.kind, { with_text = true })
				  item_with_kind.menu = source_labels[entry.source.name]
				  item_with_kind.menu = vim.trim(item_with_kind.menu or "")
				  item_with_kind.abbr = string.sub(item_with_kind.abbr, 1, item_with_kind.maxwidth)
	  
				  if entry.source.name == "codeium" then
					if entry.completion_item.data ~= nil and entry.completion_item.data.detail ~= nil then
					  item_with_kind.kind = " " .. lspkind.symbolic("Event", { with_text = false }) .. "codeium"
					  item_with_kind.menu = item_with_kind.menu .. entry.completion_item.data.detail
					else
					  item_with_kind.kind = " " .. lspkind.symbolic("Event", { with_text = false }) .. "codeium"
					  item_with_kind.menu = item_with_kind.menu .. " TBN"
					end
				  end
	  
				  local completion_context = get_lsp_completion_context(entry.completion_item, entry.source)
				  if completion_context ~= nil and completion_context ~= "" then
					item_with_kind.menu = item_with_kind.menu .. [[ -> ]] .. completion_context
				  end
	  
				  if string.find(vim_item.kind, "Color") then
					-- Override for plugin purposes
					vim_item.kind = "Color"
					local tailwind_item = require("cmp-tailwind-colors").format(entry, vim_item)
					item_with_kind.menu = lspkind.symbolic("Color", { with_text = false }) .. " Color"
					item_with_kind.kind = " " .. tailwind_item.kind
				  end
	  
				  return item_with_kind
				end,
			  },
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body)
				end,
			},
			mapping = cmp.mapping.preset.insert({
				["<C-j>"] = cmp.mapping.select_prev_item(), -- previous suggestion
				["<C-k>"] = cmp.mapping.select_next_item(), -- next suggestion
				["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					elseif require("luasnip").expand_or_jumpable() then
						require("luasnip").expand_or_jump()
					else
						fallback()
					end
				end, { "i", "s" }),
				["<S-Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					elseif require("luasnip").jumpable(-1) then
						require("luasnip").jump(-1)
					else
						fallback()
					end
				end, { "i", "s" }),
				["<C-u>"] = cmp.mapping.scroll_docs(-4), -- scroll up preview
				["<C-e>"] = cmp.mapping.scroll_docs(4), -- scroll down preview
				["<C-Space>"] = cmp.mapping.complete({}), -- show completion suggestionsB
				["<C-c>"] = cmp.mapping.abort(),       -- close completion window
				["<CR>"] = cmp.mapping.confirm({ select = true }), -- select suggestion
			}),
			comparators = {
				cmp.config.compare.offset,
				cmp.config.compare.exact,
				cmp.config.compare.score,
				cmp.config.compare.recently_used,
				cmp.config.compare.locality,
				cmp.config.compare.kind,
				cmp.config.compare.sort_text,
				cmp.config.compare.length,
				cmp.config.compare.order,
			},
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
				{ name = "buffer",  option = search_tabpage },
				{ name = "path",    option = { trailing_slash = true } },
			}, {
				{ name = "spell" },
			}),
			experimental = {
				native_menu = false,
				ghost_text = false
			},
			completion = {
				get_trigger_characters = function(chars)
					local extras = { "!", "#", "-", "." }
					return vim.list_extend(chars, extras)
				end,
			},
			performance = { max_view_entries = 40 },
			window = {
				completion = {
					border = "rounded",
				},
				documentation = {
					border = "rounded",
				},
			},
			view = {
				entries = {
					name = "custom",
					selection_order = "near_cursor",
				},
			},
		})

		-- Define options for cmdline: `:`
		-- (if you enabled `native_menu`, this won't work anymore).
		cmp.setup.cmdline(":", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources({
				{ name = "cmdline" },
				{ name = "nvim_lua" },
			}, {
				{ name = "path", option = { trailing_slash = true } },
			}, {
				{ name = "cmdline_history" },
			}),
		})

		-- Define options for search commands: `/`, `?`
		-- (if you enabled `native_menu`, this won't work anymore).
		cmp.setup.cmdline({ "/", "?" }, {
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources({
				{ name = "buffer", option = search_tabpage },
			}, {
				{ name = "cmdline_history" },
			}),
		})

		-- Define specific sources for gitcommit filetype
		cmp.setup.filetype("gitcommit", {
			sources = cmp.config.sources({
				{ name = "cmp_git" },
				{ name = "path",   option = { trailing_slash = true } },
			}, {
				{ name = "buffer", option = search_tabpage },
				{ name = "spell" },
			}),
		})
	end,
}
