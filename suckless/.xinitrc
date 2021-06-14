#!/bin/sh


if [ -f "${HOME}/.config/.xprofile" ]; then
  . "${HOME}/.config/.xprofile"
fi

# Launch dwm as a subprocess of the ssh agent,
# so that when dwm terminates, the agent does too.
ssh-agent dwm
