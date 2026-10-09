#!/bin/bash
# Gera os 4 criativos (1080x1350). Rode: bash criativos/render.sh
cd "$(dirname "$0")"
CH="/c/Program Files/Google/Chrome/Application/chrome.exe"; M=$(cygpath -m "$PWD")
shot() {
  "$CH" --headless=new --user-data-dir="$M/.chrome-$1" --disable-gpu --hide-scrollbars --allow-file-access-from-files \
    --virtual-time-budget=5000 --window-size=1080,1350 --screenshot="$M/$1" "file:///$M/$2" 2>/dev/null
  rm -rf ".chrome-$1"
}
enc() { node -e 'console.log(encodeURIComponent(process.argv[1]))' "$1" 2>/dev/null || python3 -c 'import sys,urllib.parse;print(urllib.parse.quote(sys.argv[1]))' "$1"; }
shot criativo-1-instagram.png  "ad.html?img=p9.png&s=1080&y=-260&p=800&tag=$(enc '🤫 Private')&h=$(enc 'She doesn’t post <em>this</em> on Instagram')&sub=$(enc 'Her private page is finally open.')"
shot criativo-2-just-for-you.png "ad.html?img=p8.png&s=1250&y=-420&p=820&h=$(enc '“I made something <em>just for you</em>…”')&sub=$(enc 'Only a few people get to see it 😏')"
shot criativo-3-friends.png    "ad.html?img=p7.png&s=1180&y=-120&p=860&tag=$(enc '👀 Nobody knows')&h=$(enc 'Her friends don’t know <em>this page exists</em>')&sub=$(enc 'See what she keeps private.')"
shot criativo-4-no-filters.png "ad.html?layout=grid&imgs=p9.png,p8.png,p7.png&ys=-150,-230,-100&p=540&fs=130&tag=$(enc '🔒 Private')&h=$(enc '1 girl.<br><em>No filters.</em>')&sub=$(enc 'Her most private side, all in one place.')"
