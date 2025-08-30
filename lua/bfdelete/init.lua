local function buf_is_visible(bufnr)
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		if vim.api.nvim_win_get_buf(win) == bufnr then return true end
	end
	return false
end

local function delete_buf(bufnr, force)
	-- pcall så én feil (f.eks. terminal) ikke stopper resten
	pcall(vim.api.nvim_buf_delete, bufnr, { force = force })
end

local function bfdelete(mode, force)
	local current = vim.api.nvim_get_current_buf()
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		-- bruk buflisted() i stedet for vim.bo[buf].listed
		if buf ~= current and vim.fn.buflisted(buf) == 1 then
			if mode == "hidden" then
				if not buf_is_visible(buf) then
					if force or not vim.bo[buf].modified then delete_buf(buf, force) end
				end
			elseif mode == "all" then
				if force or not vim.bo[buf].modified then delete_buf(buf, force) end
			end
		end
	end
end

vim.api.nvim_create_user_command("Bfdelete", function(opts)
	local bang = opts.bang
	local arg = (opts.fargs[1] or "hidden"):lower()
	if arg ~= "hidden" and arg ~= "all" then
		vim.notify("Bfdelete: bruk 'hidden' eller 'all'", vim.log.levels.ERROR)
		return
	end
	bfdelete(arg, bang)
end, {
	bang = true,
	nargs = "?",
	complete = function() return { "hidden", "all" } end,
})
