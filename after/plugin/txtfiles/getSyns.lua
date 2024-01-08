local function makeSynCall(wd)
	local cmd = 'python3 ~/.config/nvim/after/plugin/txtfiles/synonym.py ' .. wd
	local handle = io.popen(cmd)
	local result = handle:read("*a")
	handle:close()
	return result --returns a string '{word = <wd>, synonyms = <list of syns>}'
end

function GetSyns()
	local wd = VisualSelection()
	local wdObjString = makeSynCall(wd) --returns string
	local tblFunc = load('return ' .. wdObjString) --converts string to table obj
	local wdObj = tblFunc()
	CreateFloatingWindow(wdObj,'Thesaurus:')
end
