-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Snacks Explorer git 상태 자동 갱신
vim.api.nvim_create_autocmd("FocusGained", {
  group = vim.api.nvim_create_augroup("snacks_explorer_git_refresh", { clear = true }),
  callback = function()
    local ok, Git = pcall(require, "snacks.explorer.git")
    if not ok then
      return
    end
    for root in pairs(Git.state) do
      Git.state[root].last = 0
    end
    local explorers = Snacks.picker.get({ source = "explorer" })
    for _, explorer in ipairs(explorers) do
      require("snacks.explorer.actions").update(explorer, { refresh = true })
    end
  end,
})
