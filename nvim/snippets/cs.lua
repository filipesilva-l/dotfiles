local ls = require("luasnip")

local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local f = ls.function_node
local d = ls.dynamic_node
local r = ls.restore_node
local fmt = require("luasnip.extras.fmt").fmt

local function split(inputstr, sep)
	if sep == nil then
		sep = "%s"
	end
	local result = {}
	for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
		table.insert(result, str)
	end
	return result
end

local function trim(value)
	return (value:gsub("^%s*(.-)%s*$", "%1"))
end

local function scandir(directory)
	local index, result, popen = 0, {}, io.popen
	local pfile = popen('ls -a "' .. directory .. '"')

	for filename in pfile:lines() do
		index = index + 1
		result[index] = filename
	end

	pfile:close()

	return result
end

local function compose_namespace(dir)
	local namespace = ""
	local has_csproj = false

	while not has_csproj do
		local splitted = split(dir, "/")
		local last_element = splitted[#splitted]
		local last_element_is_dir = not string.find(last_element, ".cs")

		if #splitted == 1 then
			return ""
		end

		dir = ""
		for idx = 1, #splitted - 1 do
			dir = dir .. "/" .. splitted[idx]
		end

		local files = scandir(dir)

		local csprojs = vim.tbl_filter(function(file)
			return string.find(file, ".csproj") ~= nil
		end, files)

		has_csproj = #csprojs ~= 0

		if not has_csproj and last_element_is_dir then
			namespace = last_element .. "." .. namespace
		elseif has_csproj then
			local to_concat = ""

			if last_element_is_dir then
				to_concat = last_element
			end

			namespace = string.sub(csprojs[1], 0, #csprojs[1] - #".csproj") .. "." .. to_concat .. "." .. namespace
		end
	end

	namespace = trim(namespace:gsub("%.", " ")):gsub("%s+", "."):gsub("-", "_")

	return namespace
end

local function get_current_buffer_filename()
	local buf_name = vim.api.nvim_buf_get_name(0)

	local splitted = split(buf_name, "/")

	return splitted[#splitted]:gsub(".cs", "")
end

local function get_constructable_node()
	local constructable_nodes =
		{ "abstract_class_declaration", "class_declaration", "record_declaration", "struct_declaration" }
	local node = vim.treesitter.get_node()

	while node ~= nil and not vim.tbl_contains(constructable_nodes, node:type()) do
		node = node:parent()
	end

	return node
end

local function is_inside_interface()
	local node = vim.treesitter.get_node()

	while node ~= nil do
		if node:type() == "interface_declaration" then
			return true
		end

		node = node:parent()
	end

	return false
end

local function get_node_identifier(node)
	for child in node:iter_children() do
		if child:type() == "identifier" then
			return vim.treesitter.get_node_text(child, 0)
		end
	end

	return get_current_buffer_filename()
end

local function interface_method_nodes()
	return {
		c(1, {
			sn(nil, { i(1, "string"), t(" "), i(2, "Name") }),
			sn(nil, { t("Task<"), i(1, "string"), t(">"), t(" "), i(2, "Name"), t("Async") }),
			sn(nil, { t("Task "), i(1, "Name"), t("Async") }),
		}),
		t("("),
		i(2),
		t(");"),
	}
end

local function class_method_nodes()
	return {
		t("public "),
		c(1, {
			sn(nil, { i(1, "string"), t(" "), i(2, "Name") }),
			sn(nil, { t("async Task<"), i(1, "string"), t(">"), t(" "), i(2, "Name"), t("Async") }),
			sn(nil, { t("async Task "), i(1, "Name"), t("Async") }),
		}),
		t("("),
		i(2),
		t({ ")", "{", "\t" }),
		i(3),
		t({ "", "}" }),
	}
end

return {
	s(
		"nmsp",
		fmt("namespace {1};", {
			f(function()
				local buf_name = vim.api.nvim_buf_get_name(0)

				return compose_namespace(buf_name)
			end),
		})
	),
	s(
		"cls",
		fmt(
			[[
                public class {1}
                {{
                    {}
                }}
            ]],
			{
				f(get_current_buffer_filename),
				i(0),
			}
		)
	),
	s(
		"rcd",
		fmt(
			[[
                public record {1}{2}({});
            ]],
			{
				f(get_current_buffer_filename),
				i(1),
				i(2),
			}
		)
	),
	s(
		"itr",
		fmt(
			[[
                public interface {1}
                {{
                    {}
                }}
            ]],
			{
				f(get_current_buffer_filename),
				i(0),
			}
		)
	),
	s(
		"enm",
		fmt(
			[[
                public enum {1}
                {{
                    {}
                }}
            ]],
			{
				f(get_current_buffer_filename),
				i(0),
			}
		)
	),
	s("prop", fmt("public {1} {} {{ get; init; }}", { i(1, "string"), i(0, "Propriedade") })),
	s(
		"ctor",
		fmt(
			[[
                public {1}()
                {{
                    {}
                }}
            ]],
			{
				f(function()
					return get_node_identifier(get_constructable_node())
				end),
				i(0),
			}
		)
	),
	s(
		"svc",
		fmt(
			[[
                public interface I{1}
                {{
                    {2}
                }}

                public class {1} : I{1}
                {{
                    {}
                }}
            ]],
			{
				f(get_current_buffer_filename),
				i(2),
			}
		)
	),
	s(
		"cmd",
		fmt(
			[[
                public record {1}() : IRequest<{2}>;

                public class {3}Handler : IRequestHandler<{4}, {5}>
                {{
                    {}
                }}
            ]],
			{
				c(1, {
					f(function()
						return get_current_buffer_filename() .. "Comando"
					end, {}),
					f(function()
						return get_current_buffer_filename() .. "Query"
					end, {}),
				}),
				i(2),
				f(get_current_buffer_filename),
				f(function(args)
					return args[1][1]
				end, { 1 }),
				f(function(args)
					return args[1][1]
				end, { 2 }),
				i(),
			}
		),
		{
			stored = {
				["return_type"] = i(1),
			},
		}
	),
	s("mtd", {
		d(1, function()
			if is_inside_interface() then
				return sn(nil, interface_method_nodes())
			end

			return sn(nil, class_method_nodes())
		end),
	}),
}
