function ya --description 'stream audio from youtube'
  mpv --no-video --ytdl-format=bestaudio $argv
end
