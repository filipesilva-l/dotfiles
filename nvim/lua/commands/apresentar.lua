local presentation_state = false

local function start_presentation()
	if not presentation_state then
		Snacks.dim.enable()
		vim.opt.cursorline = true
		presentation_state = true
	end
end

local function stop_presentation()
	if presentation_state then
		Snacks.dim.disable()
		vim.opt.cursorline = false
		presentation_state = false
	end
end

local function toggle_presentation()
	if presentation_state then
		stop_presentation()
	else
		start_presentation()
	end
end

local function apresentar_command(opts)
	local args = opts.fargs

	if #args == 0 then
		toggle_presentation()
	elseif #args == 1 then
		local subcommand = args[1]:lower()

		if subcommand == "iniciar" then
			start_presentation()
		elseif subcommand == "parar" then
			stop_presentation()
		elseif subcommand == "toggle" then
			toggle_presentation()
		else
			print("Subcomando inválido. Use: iniciar, parar, ou toggle")
		end
	else
		print("Muitos argumentos. Use: :Apresentar [iniciar|parar|toggle]")
	end
end

vim.api.nvim_create_user_command("Apresentar", apresentar_command, {
	nargs = "?",
	complete = function(ArgLead, CmdLine, CursorPos)
		return { "iniciar", "parar", "toggle" }
	end,
	desc = "Toggle presentation mode with Snacks.dim() and cursorline",
})
