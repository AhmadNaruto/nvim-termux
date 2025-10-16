return {
  'saghen/blink.cmp',
  dependencies = {
    'brenoprata10/nvim-highlight-colors',
  },
  version = '1.*',
  build = 'cargo build --release',

  opts = {
    keymap = { preset = 'enter' },
    appearance = {
      highlight_ns = vim.api.nvim_create_namespace 'blink_cmp',
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
    completion = {
      keyword = { range = 'prefix' },
      accept = { auto_brackets = { enabled = true } },
      trigger = { show_on_insert_on_trigger_character = false },
      list = {
        max_items = 50,
        selection = { preselect = true, auto_insert = false },
      },
      menu = {
        enabled = true,
        border = 'rounded',
        auto_show = true,
        draw = {
          treesitter = { 'lsp' },
          columns = {
            { 'kind_icon', gap = 1 },
            { 'label', gap = 1, 'kind' },
          },
          components = {
            kind_icon = {
              ellipsis = false,
              text = function(ctx)
                local icon = ctx.kind_icon
                if ctx.item.source_name == 'LSP' then
                  local color_item = require('nvim-highlight-colors').format(ctx.item.documentation, { kind = ctx.kind })
                  if color_item and color_item.abbr ~= '' then
                    icon = color_item.abbr
                  end
                end
                return icon .. ctx.icon_gap
              end,
              highlight = function(ctx)
                local highlight = 'BlinkCmpKind' .. ctx.kind
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
        treesitter_highlighting = true,
      },
    },

    -- 🔧 THIS IS THE KEY SECTION — enhanced with deduplication
    sources = {
      -- Keep your existing default logic
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

      -- Keep your providers
      providers = {
        path = {
          opts = {
            get_cwd = function(_)
              return vim.fn.getcwd()
            end,
          },
        },
      },

      -- ✅ ADD THIS: deduplicate items by label + kind
      transform_items = function(_, items)
        local seen = {}
        local unique_items = {}
        for _, item in ipairs(items) do
          -- Safely convert to string and add separator to avoid collisions
          local label = tostring(item.label or '')
          local kind = tostring(item.kind or '')
          local key = label .. '|' .. kind

          if not seen[key] then
            seen[key] = true
            table.insert(unique_items, item)
          end
        end
        return unique_items
      end,
    },

    fuzzy = {
      implementation = 'rust',
      sorts = { 'exact', 'score', 'sort_text' },
    },
    signature = {
      enabled = true,
      window = { border = 'rounded', show_documentation = false },
      trigger = { show_on_insert_on_trigger_character = true },
    },
    cmdline = {
      enabled = true,
      completion = { menu = { auto_show = true }, ghost_text = { enabled = false } },
      keymap = {
        preset = 'none',
        ['<Up>'] = { 'select_prev', 'fallback' },
        ['<Down>'] = { 'select_next', 'fallback' },
        ['<C-Z>'] = { 'select_and_accept' },
        ['<C-X>'] = { 'cancel' },
      },
    },
  },
}
