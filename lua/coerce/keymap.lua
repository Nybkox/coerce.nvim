--- A module with utilities for manipulating keymaps.
--
-- @module coerce.keymap
local M = {}

M.plain_keymap_registry = {
	register_keymap_group = function(mode)
		return nil
	end,
	register_keymap = function(mode, keymap, action, description)
		vim.keymap.set(mode, keymap, action)
	end,
}

M.which_key_keymap_registry = {
	register_keymap_group = function(mode, keymap, description)
		require("which-key").register({
			[keymap] = { name = description },
		}, { mode = mode })
		-- Fixes a bug, where the WhichKey window doesn’t show up in the visual mode.
		-- The open bug in question: https://github.com/folke/which-key.nvim/issues/458.
		if mode == "v" or mode == "x" then
			vim.keymap.set(mode, keymap, "<cmd>WhichKey " .. keymap .. " " .. mode .. "<cr>")
		end
	end,
	register_keymap = function(mode, keymap, action, description)
		require("which-key").register({
			[keymap] = {
				action,
				description,
			},
		}, { mode = mode })
	end,
}

--- Returns a keymap registry.
M.keymap_registry = function()
	local which_key_status, _ = pcall(require, "which-key")
	if which_key_status then
		return M.which_key_keymap_registry
	else
		return M.plain_keymap_registry
	end
end

return M
