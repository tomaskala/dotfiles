#!/bin/bash


function play_file {
    path=$1
    rest=$2

    filename=$(basename -- "${path}")
    extension="${filename##*.}"

    if [ "${extension}" == "mp3" ] || [ "${extension}" == "flac" ] ; then
        mplayer "${path}" "${rest}"
        exit 0
    else
        >&2 echo "The file must be an .mp3 or a .flac file."
        exit 1
    fi
}


function play {
    path="${args[0]}"
    rest="${args[@]:1}"

    if [ -d "${path}" ] ; then
        # Directory -> play it recursively.
        find "${path}" -type f \( -name \*.mp3 -or -name \*.flac \) >playlist
        mplayer -playlist playlist "${rest}"
    elif [ -f "${path}" ] ; then
        # File -> play it.
        play_file "${path}" "${rest}"
    else
        # Try if the given path ends with an integer and play the file beginning with it.
        isnum='^[0-9]+$'
        lastpart=$(basename -- "${path}")

        if [[ "${lastpart}" =~ ${isnum} ]] ; then
            directory=$(dirname -- "${path}")
            startswithnum="^0?${lastpart}.*$"
            found=false

            for filename in "${directory}"/* ; do
                base=$(basename -- "${filename}")

                if [[ "${base}" =~ ${startswithnum} ]] ; then
                    found=true
                    break
                fi
            done

            if [ "${found}" = true ] ; then
                play_file "${filename}" "${rest}"
            else
                >&2 echo "No file found."
                exit 1
            fi
        else
            >&2 echo "Invalid input. Provide either a directory, a file, or the number of a song to be played."
            exit 1
        fi
    fi
}


if [ $# -eq 0 ] ; then
    >&2 echo "Please provide the path to be played."
    exit 1
fi


if [ "$1" == "-h" ] || [ "$1" == "--help" ] ; then
    usage="$(basename "$0") [-h] [--help] path [rest]

    where:
        -h, --help  show this help message and exit
        path  the directory or a song to be played; if the path ends with (or is) an integer, the music file
              beginning with it is played; this assumes that the files begin with their numbers on an album
        rest  additional arguments passed to \`mplayer\`
    "
    >&2 echo "${usage}"
    exit 1
fi


args=("$@")
play
