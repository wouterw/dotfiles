return {
  -- { "github/copilot.vim" },
  {
    "zbirenbaum/copilot.lua",
    lazy = true,
    event = { "InsertEnter" },
    config = function()
      require("copilot").setup {}
    end,
  },
}
