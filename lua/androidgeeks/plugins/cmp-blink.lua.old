return {
  'saghen/blink.cmp',
  -- optional: provides snippets for the snippet source
  dependencies = {
    --[[{
      'Fildo7525/pretty_hover',
      -- enabled = true, ---@type boolean
      event = 'LspAttach',
      opts = {},
    }, ]]
    'brenoprata10/nvim-highlight-colors',
  },

  -- use a release tag to download pre-built binaries
  version = '1.*',
  -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
  build = 'cargo build --release',
  -- If you use nix, you can build from source using latest nightly rust with:
  -- build = 'nix run .#build-plugin',
  --
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
    -- 'super-tab' for mappings similar to vscode (tab to accept)
    -- 'enter' for enter to accept
    -- 'none' for no mappings
    --
    -- All presets have the following mappings:
    -- C-space: Open menu or open docs if already open
    -- C-n/C-p or Up/Down: Select next/previous item
    -- C-e: Hide menu
    -- C-k: Toggle signature help (if signature.enabled = true)
    --
    -- See :h blink-cmp-config-keymap for defining your own keymap
    keymap = { preset = 'enter' },

    appearance = {
      highlight_ns = vim.api.nvim_create_namespace 'blink_cmp',
      -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned
      nerd_font_variant = 'normal',
      kind_icons = {
        Text = '󰉿',
        Method = '󰊕',
        Function = '󰊕',
        Constructor = '󰒓',

        Field = '󰜢',
        Variable = '󰆦',
        Property = '󰖷',

        Class = '󱡠',
        Interface = '󱡠',
        Struct = '󱡠',
        Module = '󰅩',

        Unit = '󰪚',
        Value = '󰦨',
        Enum = '󰦨',
        EnumMember = '󰦨',

        Keyword = '󰻾',
        Constant = '󰏿',

        Snippet = '󱄽',
        Color = '󰏘',
        File = '󰈔',
        Reference = '󰬲',
        Folder = '󰉋',
        Event = '󱐋',
        Operator = '󰪚',
        TypeParameter = '󰬛',
      },
    },

    -- (Default) Only show the documentation popup when manually triggered
    completion = {
      keyword = {
        -- 'prefix' will fuzzy match on the text before the cursor
        -- 'full' will fuzzy match on the text before _and_ after the cursor
        -- example: 'foo_|_bar' will match 'foo_' for 'prefix' and 'foo__bar' for 'full'
        range = 'prefix',
      },
      accept = { auto_brackets = { enabled = true } },
      trigger = {
        -- shows after entering insert mode on top of a trigger character
        show_on_insert_on_trigger_character = false, ---@type boolean
      },
      list = {
        -- Maximum number of items to display
        max_items = 50, ---@type number?
        selection = {
          preselect = true, ---@type boolean
          auto_insert = false, ---@type boolean
        },
      },
      menu = {
        enabled = true, ---@type boolean
        border = 'rounded', ---@type "none" | "single" | "double" | "rounded"
        auto_show = true, ---@type boolean
        draw = {
          treesitter = { 'lsp' },
          columns = {
            { 'kind_icon', gap = 1 },
            { 'label', gap = 1, 'kind' },
            -- { 'kind', gap = 1 },
          },
          components = {
            kind_icon = {
              ellipsis = false, ---@type boolean
              text = function(ctx)
                -- Default kind icon
                local icon = ctx.kind_icon
                -- If LSP source, check for color derived from documentation
                if ctx.item.source_name == 'LSP' then
                  local color_item = require('nvim-highlight-colors').format(ctx.item.documentation, { kind = ctx.kind })
                  if color_item and color_item.abbr ~= '' then
                    icon = color_item.abbr
                  end
                end
                return icon .. ctx.icon_gap
              end,
              -- Set the highlight priority to 20000 to beat the cursorline's default priority of 10000
              highlight = function(ctx)
                -- Default highlight group
                local highlight = 'BlinkCmpKind' .. ctx.kind
                -- If LSP source, check for color derived from documentation
                if ctx.item.source_name == 'LSP' then
                  local color_item = require('nvim-highlight-colors').format(ctx.item.documentation, { kind = ctx.kind })
                  if color_item and color_item.abbr_hl_group then
                    highlight = color_item.abbr_hl_group
                  end
                end
                return highlight
              end,
            },
          },
        },
      },
      documentation = {
        auto_show = true,
        window = { border = 'rounded' },
        --winhighlight = 'Pmenu:Pmenu,FloatBorder:FloatBorder,CursorLine:Visual,Search:None',
        treesitter_highlighting = true, ---@type boolean
        --[[ pretty_hover plugin
        draw = function(opts)
          if opts.item and opts.item.documentation then
            local out = require('pretty_hover.parser').parse(opts.item.documentation.value)
            opts.item.documentation.value = out:string()
          end

          opts.default_implementation(opts)
        end,]]
      },
    },

    -- Default list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, due to `opts_extend`
    sources = {
      default = function()
        local success, node = pcall(vim.treesitter.get_node)
        if success and node and vim.tbl_contains({ 'comment', 'line_comment', 'block_comment' }, node:type()) then
          return { 'buffer' }
        elseif vim.bo.filetype == 'lua' then
          return { 'lsp', 'path' }
        else
          return { 'lsp', 'path', 'buffer' }
        end
      end,
      providers = {
        path = {
          opts = {
            get_cwd = function(_)
              return vim.fn.getcwd()
            end,
          },
        },
      },
    },

    -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
    -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
    -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
    --
    -- See the fuzzy documentation for more information
    fuzzy = {
      implementation = 'rust',
      sorts = {
        'exact',
        -- defaults
        'score',
        'sort_text',
      },
    },
    signature = {
      enabled = true,
      window = {
        border = 'rounded', ---@type "none" | "single" | "double" | "rounded"
        -- To only show the signature, and not the documentation
        show_documentation = false, ---@type boolean
      },
      trigger = {
        -- Show the signature help window when the cursor comes after a trigger character when entering insert mode
        show_on_insert_on_trigger_character = true, ---@type boolean
      },
    },
    cmdline = {
      enabled = true,
      completion = { menu = { auto_show = true }, ghost_text = { enabled = false } },
      keymap = {
        preset = 'none', ---@type "default" | "none"

        ['<Up>'] = { 'select_prev', 'fallback' },
        ['<Down>'] = { 'select_next', 'fallback' },

        ['<C-Z>'] = { 'select_and_accept' },
        ['<C-X>'] = { 'cancel' },
      },
    },
  },
  -- opts_extend = { "sources.default" }
}
