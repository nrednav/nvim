local core_loaded, core_error = pcall(require, "core")

if not core_loaded then
	io.stderr:write("Critical Error while loading core config: " .. tostring(core_error) .. "\n")
	return
end

local plugins_loaded, plugins_error = pcall(require, "core.lazy")

if not plugins_loaded then
	vim.api.nvim_create_autocmd("VimEnter", {
		callback = function()
			vim.notify(
				"CRITICAL: Plugin system failed to load.\n"
					.. "You are in 'Safe Mode'. Standard editing is still functional.\n\n"
					.. "Error: "
					.. tostring(plugins_error),
				vim.log.levels.ERROR
			)
		end,
	})
end
