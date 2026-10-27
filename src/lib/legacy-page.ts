import { readFile } from "node:fs/promises";
import { join } from "node:path";

const pageReaders: Record<string, () => Promise<string>> = {
  "index.html": () => readFile(join(process.cwd(), "index.html"), "utf8"),
  "special.html": () => readFile(join(process.cwd(), "special.html"), "utf8"),
  "upsell/tits-out.html": () => readFile(join(process.cwd(), "upsell", "tits-out.html"), "utf8"),
  "upsell/fully-naked.html": () => readFile(join(process.cwd(), "upsell", "fully-naked.html"), "utf8"),
  "downsell/tits-out.html": () => readFile(join(process.cwd(), "downsell", "tits-out.html"), "utf8"),
  "downsell/fully-naked.html": () => readFile(join(process.cwd(), "downsell", "fully-naked.html"), "utf8"),
};

export async function legacyPage(file: string): Promise<Response> {
  const readPage = pageReaders[file];
  if (!readPage) return new Response("Not found", { status: 404 });

  const html = await readPage();
  return new Response(html, {
    headers: {
      "Content-Type": "text/html; charset=utf-8",
      "Cache-Control": "no-store",
    },
  });
}
