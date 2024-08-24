''

  -- Set Leader
  vim.g.mapleader = ";"

  -- Telescope Keybinds
  vim.api.nvim_create_user_command('FF', 'Telescope find_files', {})
  vim.cmd('cnoreabbrev ff FF')
  vim.api.nvim_create_user_command('FG', 'Telescope live_grep', {})
  vim.cmd('cnoreabbrev fg FG')

  -- Neotree Keybinds
  vim.api.nvim_create_user_command('NT', 'Neotree toggle', {})
  vim.cmd('cnoreabbrev nt NT')

''
