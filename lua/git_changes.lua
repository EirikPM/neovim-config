local M = {}

function M.open(filter)
	filter = filter or "all"

	local root_result = vim.system({ "git", "rev-parse", "--show-toplevel" }, { text = true }):wait()

	if root_result.code ~= 0 then
		vim.notify("Not inside a Git repository", vim.log.levels.ERROR)
		return
	end

	local root = vim.trim(root_result.stdout)

	local result = vim.system({ "git", "-C", root, "status", "--porcelain=v1", "-z" }, { text = true }):wait()

	if result.code ~= 0 then
		vim.notify("Unable to read Git status", vim.log.levels.ERROR)
		return
	end

	local parts = vim.split(result.stdout, "\0", {
		plain = true,
		trimempty = true,
	})

	local items = {}
	local i = 1

	while i <= #parts do
		local entry = parts[i]

		local status = entry:sub(1, 2)
		local x = status:sub(1, 1)
		local y = status:sub(2, 2)
		local path = entry:sub(4)

		if status:find("[RC]") then i = i + 1 end

		local staged = x ~= " " and x ~= "?"
		local unstaged = y ~= " " or status == "??"

		local include = filter == "all" or (filter == "staged" and staged) or (filter == "unstaged" and unstaged)

		if include then
			table.insert(items, {
				filename = vim.fs.joinpath(root, path),
				lnum = 1,
				col = 1,
				text = status,
			})
		end

		i = i + 1
	end

	vim.fn.setqflist({}, " ", {
		title = ({
			all = "Git Changes",
			staged = "Git Staged",
			unstaged = "Git Unstaged",
		})[filter],
		items = items,
	})

	if #items == 0 then
		vim.notify("No Git changes")
		return
	end

	vim.cmd("copen")
end

return M
