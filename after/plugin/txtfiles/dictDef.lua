function VisualSelection()
  local s_start = vim.fn.getpos("'<")
  local s_end = vim.fn.getpos("'>")
	local wd = vim.api.nvim_buf_get_text(0, s_start[2]-1, s_start[3]-1, s_end[2]-1, s_end[3], {})[1]
return wd
end

local function makeCall(opt, wd)
	local cmd = '~/.config/nvim/after/plugin/txtfiles/dict-api --'..opt..' "'..wd..'"'
	local handle = io.popen(cmd)
	if handle == nil then 
		return error("error in makeCall")
	end
	local result = handle:read("*a")
	handle:close()
	return result --returns a string '{word = <wd>, definition = <definition>}'
end

function GetDefOrSyn(opt)
	if opt ~= 'def' and opt ~= 'syn' then
		return error("opt must be 'def' or 'syn', you passed "..opt)	
	end
	local title = (opt == 'def') and 'Dictionary:' or 'Thesaurus:'
	vim.cmd('normal! gv"xy')
	local wd = vim.fn.getreg('x')
	wd = string.gsub(wd, '\n',"") --strip whitespace
	local wdObjStr = makeCall(opt, wd) --returns string
	local tblFunc = load("return " .. wdObjStr)
	if tblFunc == nil then
		print("error in building table")
		return
	end
	local wdObj = tblFunc()
	CreateFloatingWindow(wdObj, title)
end

