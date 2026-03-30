function fish_prompt
  set -l last_status $status
  set -l stat

  if test $last_status -ne 0
    set stat (set_color red)"[$last_status]"(set_color --reset)
  end

  string join '' -- (set_color blue) (prompt_pwd --dir-length=0) (set_color --reset) (set_color green) (fish_git_prompt) (set_color --reset) $stat '> '
end
