local platform = require('utils.platform')()

local options = {
   default_prog = {},
   launch_menu = {},
}

if platform.is_mac then
   options.default_prog = { 'zsh', '-l' }
   options.launch_menu = {
      { label = 'Bash', args = { 'bash', '-l' } },
      { label = 'Zsh', args = { 'zsh', '-l' } },
   }

end

return options
