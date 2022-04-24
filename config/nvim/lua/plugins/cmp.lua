local cmp = require('cmp')

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
end

cmp.setup({
  completion = {
    autocomplete = true,
    completeopt = 'menu,menuone,noinsert',
  },

  window = {
    documentation = {
      winhighlight = 'NormalFloat:CmpDocumentation,FloatBorder:CmpDocumentationBorder',
      border = 'rounded',
    },
  },

  mapping = {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),

    ['<C-e>'] = cmp.mapping.close(),

    ['<C-n>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
      end
    end, { 'i', 's' }),
    ['<C-p>'] = cmp.mapping(function()
      if cmp.visible() then
        cmp.select_prev_item()
      end
    end, { 'i', 's' }),

    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-y>'] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  },

  formatting = {
    format = function(entry, vim_item)
      -- set a name for each source
      vim_item.menu = ({
        cmp_git = '[git]',
        nvim_lsp = ' [lsp]',
        path = '[path] ',
        buffer = '[buff] ',
        spell = '[spell]',
      })[entry.source.name]

      return vim_item
    end,
  },

  sources = {
    { name = 'nvim_lsp' },
    { name = 'path' },
    { name = 'spell' },
    { name = 'buffer', keyword_length = 5 },
  },

  sorting = {
    comparators = {
      cmp.config.compare.offset,
      cmp.config.compare.exact,
      cmp.config.compare.sort_text,
      cmp.config.compare.score,
      cmp.config.compare.kind,
      cmp.config.compare.length,
      cmp.config.compare.order,
    },
  },

  experimental = {
    native_menu = false,
    ghost_text = true,
  },
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
  sources = {
    { name = 'buffer' },
  },
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  sources = cmp.config.sources({
    { name = 'path' },
  }, {
    { name = 'cmdline' },
  }),
})
