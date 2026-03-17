// tools/build_js.js
// Bundles Anime.js v4 as an IIFE, attaching the API to window.anime.
// Run with: node tools/build_js.js
// Output:   inst/htmlwidgets/lib/anime.esm.min.js

const esbuild = require("esbuild");

esbuild
	.build({
		entryPoints: ["tools/anime_entry.js"],
		bundle: true,
		minify: true,
		format: "iife",
		globalName: "anime", // attaches to window.anime in the browser
		outfile: "inst/htmlwidgets/lib/anime.esm.min.js",
		platform: "browser",
		target: ["es2017"],
	})
	.then(() => {
		console.log(
			"Anime.js bundle written to inst/htmlwidgets/lib/anime.esm.min.js",
		);
	})
	.catch(() => process.exit(1));
