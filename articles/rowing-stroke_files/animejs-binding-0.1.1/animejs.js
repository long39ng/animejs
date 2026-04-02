HTMLWidgets.widget({
	name: "animejs",
	type: "output",

	factory(el, width, height) {
		return {
			renderValue(x) {
				// 1. Inject SVG markup into the widget element.
				el.innerHTML = x.svg || "";

				// 2. Build and play the Anime.js timeline.
				const tl = buildTimeline(el, x.config);
				if (x.config.controls) {
					attachControls(el, tl, x.config.autoplay);
				}
			},

			resize(width, height) {
				// No-op: SVG viewBox handles scaling.
			},
		};
	},
});

// ---------------------------------------------------------------------------
// resolveEasing
// Converts a serialised easing string to the value Anime.js v4 expects.
// Built-in names ("outQuad", "linear", etc.) are passed through as strings.
// Parameterised easings ("cubicBezier(...)", "spring(...)", "steps(...)")
// must be passed as the result of the corresponding anime.* function call;
// Anime.js v4 does not parse these from strings.
// ---------------------------------------------------------------------------
function resolveEasing(str) {
	if (!str || typeof str !== "string") return str;

	const match = str.match(/^(\w+)\((.+)\)$/);
	if (!match) return str; // plain built-in name

	const fn = match[1];
	const args = match[2].split(",").map(Number);

	if (fn === "cubicBezier" && typeof anime.cubicBezier === "function") {
		return anime.cubicBezier(...args);
	}
	if (fn === "spring" && typeof anime.spring === "function") {
		return anime.spring(...args);
	}
	if (fn === "steps" && typeof anime.steps === "function") {
		return anime.steps(...args);
	}

	console.warn("[animejs widget] unknown parameterised easing: " + str);
	return str;
}

// ---------------------------------------------------------------------------
// buildTimeline
// ---------------------------------------------------------------------------
function buildTimeline(el, config) {
	// Shallow copy to avoid mutating the original config object when writing
	// back defaults.ease next and corrupting the state on any subsequent
	// renderValue call (e.g., in Shiny)
	const defaults = Object.assign({}, config.defaults || {});

	// Resolve any parameterised easing in the timeline defaults.
	if (defaults.ease != null) {
		defaults.ease = resolveEasing(defaults.ease);
	}

	const tl = anime.createTimeline({
		defaults: defaults,
		loop: config.loop ?? false,
		autoplay: config.autoplay ?? true,
		reversed: config.reversed ?? false,
		alternate: config.alternate ?? false,
	});

	for (const segment of config.segments || []) {
		const targets = el.querySelectorAll(segment.selector);
		const props = Object.assign({}, segment.props);

		if (segment.duration != null) props.duration = segment.duration;
		if (segment.ease != null) props.ease = resolveEasing(segment.ease);
		if (segment.delay != null) props.delay = segment.delay;
		if (segment.stagger != null) props.delay = resolveStagger(segment.stagger);

		tl.add(targets, props, segment.offset ?? "+=0");
	}

	// Event callbacks: values are names of globally scoped JS functions.
	if (config.events) {
		for (const [event, cbName] of Object.entries(config.events)) {
			if (typeof window[cbName] === "function") {
				tl[event] = window[cbName];
			} else {
				console.warn(
					"[animejs widget] event callback not found on window: " + cbName,
				);
			}
		}
	}

	return tl;
}

// ---------------------------------------------------------------------------
// resolveStagger
// Converts the serialised anime_stagger R object to an Anime.js stagger call.
// ---------------------------------------------------------------------------
function resolveStagger(s) {
	const opts = {};
	if (s.from != null) opts.from = s.from;
	if (s.ease != null) opts.ease = s.ease;
	if (s.grid != null && s.grid.length === 2) {
		opts.grid = s.grid;
		if (s.axis != null) opts.axis = s.axis;
	}
	return anime.stagger(s.value, opts);
}

// ---------------------------------------------------------------------------
// attachControls
// Injects a minimal play / pause / seek bar beneath the SVG.
// ---------------------------------------------------------------------------
function attachControls(el, tl, autoplay) {
	const bar = document.createElement("div");
	bar.className = "animejs-controls";

	const btn = document.createElement("button");
	btn.setAttribute("aria-label", autoplay ? "Pause" : "Play");

	const ICON_PLAY = `<svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" viewBox="0 0 16 16" aria-hidden="true">
		<polygon points="3,1 14,8 3,15" fill="currentColor"/>
	</svg>`;

	const ICON_PAUSE = `<svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" viewBox="0 0 16 16" aria-hidden="true">
		<rect x="2"  y="1" width="4" height="14" fill="currentColor"/>
		<rect x="10" y="1" width="4" height="14" fill="currentColor"/>
	</svg>`;

	function syncBtn() {
		btn.innerHTML = tl.paused ? ICON_PLAY : ICON_PAUSE;
		btn.setAttribute("aria-label", tl.paused ? "Play" : "Pause");
	}

	btn.innerHTML = autoplay ? ICON_PAUSE : ICON_PLAY;

	const scrubber = document.createElement("input");
	scrubber.type = "range";
	scrubber.min = 0;
	scrubber.max = 1000;
	scrubber.value = 0;

	bar.appendChild(btn);
	bar.appendChild(scrubber);
	el.appendChild(bar);

	// Keep the scrubber in sync while the timeline is playing.
	tl.onUpdate = function (self) {
		scrubber.value = Math.round(self.iterationProgress * 1000);
	};

	tl.onComplete = function () {
		scrubber.value = 0;
		syncBtn();
	};

	btn.addEventListener("click", () => {
		if (tl.paused) {
			if (tl.completed) {
				// Rewind before replaying; tl.play() alone does not reset position.
				tl.seek(0);
			}
			tl.play();
		} else {
			tl.pause();
		}
		syncBtn();
	});

	scrubber.addEventListener("input", () => {
		const fraction = scrubber.value / 1000;
		tl.seek(tl.iterationDuration * fraction);

		// Seeking to a mid-point after completion un-completes the timeline.
		if (tl.completed) {
			tl.completed = false;
		}
	});
}
