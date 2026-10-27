import type { NextConfig } from "next";

const config: NextConfig = {
  poweredByHeader: false,
  turbopack: { root: process.cwd() },
  devIndicators: false,
  outputFileTracingIncludes: {
    "/*": [
      "./index.html",
      "./special.html",
      "./upsell/tits-out.html",
      "./upsell/fully-naked.html",
      "./downsell/tits-out.html",
      "./downsell/fully-naked.html",
    ],
  },
};

export default config;
