local luasnip = require("luasnip")

local snippet = luasnip.snippet
-- local text_node = luasnip.text_node
local insert_node = luasnip.insert_node
local function_node = luasnip.function_node
local choice_node = luasnip.choice_node
local fmta = require("luasnip.extras.fmt").fmta

local function get_module_name()
  local filename = vim.fn.expand("%:t:r")

  if not filename or filename == "" then return "ModuleName" end

  local parts = vim.split(filename, "_")

  for index, part in ipairs(parts) do
    parts[index] = part:sub(1, 1):upper() .. part:sub(2)
  end

  return table.concat(parts, "")
end

return {
  -- Generic module
  snippet("dmod", fmta([[
    defmodule <module> do
      <finish>
    end
  ]], {
    module = function_node(get_module_name),
    finish = insert_node(0)
  })),

  -- IO.inspect with Label
  snippet("ii", fmta([[
    IO.inspect(<var>, label: "<label>")
  ]], {
    var = insert_node(1),
    label = function_node(function(args) return args[1][1] end, { 1 })
  })),

  -- Public function
  snippet("def", fmta([[
    def <name>(<args>) do
      <body>
    end
  ]], {
    name = insert_node(1, "function_name"),
    args = insert_node(2),
    body = insert_node(0)
  })),

  -- Private function
  snippet("defp", fmta([[
    defp <name>(<args>) do
      <body>
    end
  ]], {
    name = insert_node(1, "function_name"),
    args = insert_node(2),
    body = insert_node(0)
  })),

  -- GenServer
  snippet(
    "genserver",
    fmta(
      [[
        defmodule <module> do
          use GenServer

          def start_link(opts \\ []) do
            GenServer.start_link(__MODULE__, opts, name: __MODULE__)
          end

          @impl true
          def init(state) do
            {:ok, state}
          end
        end
      ]],
      { module = function_node(get_module_name) }
    )
  ),

  -- handle_call (GenServer)
  snippet("hcall", fmta([[
    @impl true
    def handle_call(<msg>, _from, state) do
      {:reply, <reply>, state}
    end
  ]], {
    msg = insert_node(1, ":message"),
    reply = insert_node(2, ":ok"),
  })),

  -- GenServer Async Handler (Cast/Info Switcher)
  snippet("hcast", {
    choice_node(1, {
      -- Option 1: handle_cast
      fmta([[
        @impl true
        def handle_cast(<msg>, state) do
          {:noreply, state}
        end
      ]], { msg = insert_node(1, "{:msg}") }),
      -- Option 2: handle_info (Activated by Ctrl+L)
      fmta([[
        @impl true
        def handle_info(<msg>, state) do
          {:noreply, state}
        end
      ]], { msg = insert_node(1, "{:msg}") })
    })
  }),
}
