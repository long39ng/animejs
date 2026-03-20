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
// buildTimeline
// ---------------------------------------------------------------------------
function buildTimeline(el, config) {
	const defaults = config.defaults || {};

	const tl = anime.createTimeline({
		defaults: defaults,
		loop: config.loop ?? false,
		autoplay: config.autoplay ?? false,
	});

	for (const segment of config.segments || []) {
		const targets = el.querySelectorAll(segment.selector);

		const props = Object.assign({}, segment.props);

		// Per-segment overrides supplement the timeline defaults.
		if (segment.duration != null) props.duration = segment.duration;
		if (segment.ease != null) props.ease = segment.ease;
		if (segment.delay != null) {
			// If a stagger object is present, delay is encoded there; otherwise
			// apply as a flat delay.
			props.delay = segment.delay;
		}
		if (segment.stagger != null) {
			props.delay = resolveStagger(segment.stagger);
		}

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
	btn.textContent = autoplay ? "⏸" : "▶";

	const scrubber = document.createElement("input");
	scrubber.type = "range";
	scrubber.min = 0;
	scrubber.max = 1000;
	scrubber.value = 0;

	bar.appendChild(btn);
	bar.appendChild(scrubber);
	el.appendChild(bar);

	function syncBtn() {
		btn.textContent = tl.paused ? "▶" : "⏸";
	}

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
