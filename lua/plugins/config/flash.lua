require("flash").setup({
  modes = {
    search = {
      -- when `true`, flash will be activated during regular search by default.
      -- You can always toggle when searching with `require("flash").toggle()`
      enabled = false,
    },
  },
})

