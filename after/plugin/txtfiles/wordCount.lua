function WordCount()
	vim.cmd('normal! gv"xy')
	local block = vim.fn.getreg('x')
	local wd_count = 0
	for _ in string.gmatch(block, "%S+") do
		wd_count = wd_count + 1
	end
	print("Word Count:"..wd_count)
end

