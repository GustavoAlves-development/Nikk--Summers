#!/bin/bash
# Gera os criativos 9:16 (feed + Reels). Rode: bash criativos/render-916.sh
cd "$(dirname "$0")"
CH="/c/Program Files/Google/Chrome/Application/chrome.exe"; M=$(cygpath -m "$PWD")
shot() {
  "$CH" --headless=new --user-data-dir="$M/.chrome-$1" --disable-gpu --hide-scrollbars --allow-file-access-from-files \
    --virtual-time-budget=5000 --window-size=1080,1920 --screenshot="$M/$1" "file:///$M/$2" 2>/dev/null
  rm -rf ".chrome-$1"
}
enc() { node -e 'console.log(encodeURIComponent(process.argv[1]))' "$1"; }
shot 916-1-banned.png       "ad-916.html?img=p8.png&s=1250&y=-280&tag=$(enc '😳 Oops')&h=$(enc 'This got me <em>banned</em> from Instagram')&sub=$(enc 'So I posted it somewhere else…')&c=$(enc 'Tap “Learn More” to see it')"
shot 916-2-not-supposed.png "ad-916.html?img=p7.png&s=1180&y=0&h=$(enc 'I wasn’t supposed to <em>post this</em>… 🙈')&sub=$(enc '…but I did it anyway 😈')&c=$(enc 'Tap “Learn More” before I regret it')"
shot 916-3-dont-tell.png    "ad-916.html?img=p9.png&s=1080&y=-60&tag=$(enc '🤫 Secret')&h=$(enc 'Don’t tell anyone <em>you saw this</em>')&sub=$(enc 'It stays just between us.')&c=$(enc 'Tap “Learn More” 👀')"
shot 916-4-alone.png        "ad-916.html?layout=grid&imgs=p9.png,p8.png,p7.png&ys=-130,-210,-80&h=$(enc 'Only open this<br><em>if you’re alone</em> 👀')&sub=$(enc 'Seriously. Don’t say I didn’t warn you.')&c=$(enc 'Tap “Learn More”')"
