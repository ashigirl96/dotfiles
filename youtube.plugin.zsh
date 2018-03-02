function mp3() {
    youtube-dl "$1" --extract-audio --audio-format mp3
}
function m4a() {
    youtube-dl -f 140 "$1"
}
function mp4() {
    youtube-dl "$1" --extract-audio --audio-format mp4
}
