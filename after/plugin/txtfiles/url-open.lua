-- find the os
local function getOS()
	local handle = io.popen("uname -s")
	local osName = handle:read("*a")
	-- remove leading/trailing whitespace
	osName = osName:match("^%s*(.-)%s*$")

	if osName == "Linux" then 
		return "Linux"
	elseif osName == "Darwin" then
		return "MacOS"
	else
		return "unknown"
	end
end

-- return bash cmd 
local function getOpenCmd(os)
	if os == "Linux" then 
		return "google-chrome "
	elseif os == "MacOS" then
		return 'open -a "Google Chrome" '
	else
		return error("OS did not match {MacOS, Linux}")
	end
end

function OpenChromeWithURL()
	local url = VisualSelection()
	local opSys = getOS()
	local cmd = getOpenCmd(opSys)
	local cmdToExecute = cmd .. url
	local success, errMsg, errCode = os.execute(cmdToExecute)
	if success then 
		print("Chrome opened correctly")
	else
		print("Error opening Chrome: " .. errMsg)
	end
end

