local function get_python_path()
	local os_name = vim.loop.os_uname().sysname

	if os_name == "Darwin" then
		-- macOS
		return "/opt/homebrew/bin/python3.11"
	elseif os_name == "Linux" then
		-- Only check for WSL if we are confirmed to be on Linux
		local file = io.open("/proc/version", "r")
		if file then
			local content = file:read("*a")
			file:close()
			if content and string.lower(content):find("microsoft") then
				return "/usr/bin/python3" -- WSL Python path
			end
		end
		return "/usr/bin/python" -- Standard Linux Python path
	else
		-- Fallback for other systems
		return "/usr/bin/python"
	end
end

-- Set leader key
vim.g.mapleader = ","

-- Set python path dynamically
vim.g.python3_host_prog = get_python_path()
