---@type vim.lsp.Config
return {
  settings = {
    tailwindCSS = {
      -- NativeWind uses className directly; these functions cover common
      -- React Native helpers such as cn(), clsx(), and twMerge().
      classAttributes = { "class", "className", "class:list", "classList", "ngClass" },
      classFunctions = { "cn", "clsx", "cva", "tw", "twMerge" },
    },
  },
}
