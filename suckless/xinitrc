#!/bin/sh


if [ -f ~/.config/xprofile ]; then
  . ~/.config/xprofile
fi

# Launch dwm as a subprocess of the ssh agent,
# so that when dwm terminates, the agent does too.
ssh-agent dwm
