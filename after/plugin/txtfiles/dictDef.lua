function VisualSelection()
  local s_start = vim.fn.getpos("'<")
  local s_end = vim.fn.getpos("'>")
	local wd = vim.api.nvim_buf_get_text(0, s_start[2]-1, s_start[3]-1, s_end[2]-1, s_end[3], {})[1]
	return wd
end

local function makeCall(wd)
	local cmd = 'python3 ~/.config/nvim/after/plugin/txtfiles/dict-def.py ' .. wd
	local handle = io.popen(cmd)
	local result = handle:read("*a")
	handle:close()
	return result --returns a string '{word = <wd>, definition = <definition>}'
end

function GetDef()
	local wd = VisualSelection()
	-- print(makeCall(wd))
	local wdObjStr = makeCall(wd) --returns string
	local tblFunc = load("return " .. wdObjStr)
	local wdObj = tblFunc()
	CreateFloatingWindow(wdObj)
end


