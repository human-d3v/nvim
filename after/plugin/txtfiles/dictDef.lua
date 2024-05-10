local function makeCall(opt, wd)
	local cmd = '~/.config/nvim/after/plugin/txtfiles/dict-api --'..opt..' "'..wd..'"'
	local handle = io.popen(cmd)
	local result = handle:read("*a")
	if result == nil or handle == nil then
		print("error in call")
		return 
	end
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

