function ls --description 'enhanced ls'
  # Ugly hack to get the Nix-provided ls command, because the MacOS ls doesn't
  # support some of the options I want.
  /run/current-system/sw/bin/ls -FNh --color=auto --group-directories-first $argv
end
