#!/bin/sh


if [ -f "${HOME}/.xprofile" ]; then
  . "${HOME}/.xprofile"
fi

# Launch dwm as a subprocess of the ssh agent,
# so that when dwm terminates, the agent does too.
ssh-agent dwm
