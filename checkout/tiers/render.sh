#!/bin/bash
# Gera os PNGs das categorias. Rode: bash checkout/tiers/render.sh
cd "$(dirname "$0")"
CH="/c/Program Files/Google/Chrome/Application/chrome.exe"; M=$(cygpath -m "$PWD")
shot() {
  "$CH" --headless=new --user-data-dir="$M/.chrome-$2" --disable-gpu --hide-scrollbars --allow-file-access-from-files \
    --virtual-time-budget=5000 --window-size="$1" --screenshot="$M/$2" "file:///$M/$3" 2>/dev/null
  rm -rf ".chrome-$2"
}
shot 500,500  tits-out-capa-500x500.png       "cover.html?img=p3.png&y=-200&b=330&t=TITS%20OUT&p=%2434"
shot 1200,400 tits-out-banner-1200x400.png    "banner.html?i1=p3.png&y1=-110&i2=p5.png&y2=-200&i3=p6.png&y3=-90&b=195&t=TITS%20OUT&s=Top%20off.%20Nothing%20hiding.%20Unlock%20it%20for%20%2434%20%F0%9F%94%A5"
shot 500,500  fully-naked-capa-500x500.png    "cover.html?img=p2.png&y=-104&b=280&t=FULLY%20NAKED&p=%2447"
shot 1200,400 fully-naked-banner-1200x400.png "banner.html?i1=p2.png&y1=-90&i2=p4.png&y2=-110&i3=p1.png&y3=-90&b=195&t=FULLY%20NAKED&s=Every%20inch.%20Nothing%20covering%20her.%20%2447%20%F0%9F%94%A5"
# capa sem preço (usada nas páginas de upsell)
shot 500,500  tits-out-capa-sem-preco.png     "cover.html?img=p3.png&y=-200&b=330&t=TITS%20OUT"
# comparação "você tem × está perdendo" (página de upsell Tits Out)
shot 800,600  tits-out-comparacao-800x600.png "compare.html"
shot 800,600  fully-naked-comparacao-800x600.png "compare.html?l=p7.png&ly=-40&r=p2.png&ry=-40&b=240&t=Fully%20Naked"
# grade 2x2 bloqueada (página de upsell Fully Naked)
shot 800,600  fully-naked-grade-800x600.png "grid.html"
# progressão sensual → quase sem roupa → sem nada (página de upsell Fully Naked)
shot 800,600  fully-naked-progressao-800x600.png "steps.html"
