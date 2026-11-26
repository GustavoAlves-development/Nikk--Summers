# Nikk Summers VSL

Projeto executado com Next.js 16 e App Router. As páginas HTML existentes foram mantidas como fonte da experiência, servidas pelas rotas do Next para preservar scripts, pixels, páginas de upsell/downsell e parâmetros de checkout durante a migração.

Os arquivos HTML originais continuam na raiz e nas pastas `upsell/` e `downsell/`; os Route Handlers leem esses arquivos no servidor. O rastreamento de saída do Next inclui explicitamente cada HTML necessário para deploys serverless.

## Rotas

- `/` — VSL principal.
- `/special.html` — oferta especial.
- `/upsell/tits-out.html` e `/upsell/fully-naked.html` — upsells.
- `/downsell/tits-out.html` e `/downsell/fully-naked.html` — downsells.
- `/checkout/...` — arquivos de checkout mantidos como assets públicos.

Os arquivos de mídia originais em `img/` continuam no projeto e também são publicados em `public/img/`, preservando os caminhos relativos já usados pelas páginas.

## Rodar localmente

```powershell
npm install
npm run dev
```

A prévia usa `http://127.0.0.1:3011` e procura uma porta seguinte se ela estiver ocupada. Produção: `npm run build` e `npm run start`.
