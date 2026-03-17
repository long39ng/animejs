# JavaScript build tools

## Requirements

- Node.js ≥ 18
- npm ≥ 9

## Rebuilding the Anime.js bundle

From the repository root:
```bash
pnpm install # installs esbuild and animejs (dev dependencies only)
node tools/build_js.js
```

The output is written to `inst/htmlwidgets/lib/anime.esm.min.js`. This file
is committed to the repository so that CRAN users require no Node toolchain.

## Pinning the Anime.js version

The version is pinned in `package.json` under `devDependencies`. Update it
there and rebuild to upgrade.
