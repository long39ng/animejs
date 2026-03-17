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
					attachControls(el, tl);
				}
				if (x.config.autoplay !== false) {
					tl.play();
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
		autoplay: false,
	});

	for (const segment of config.segments || []) {
		const targets = el.querySelectorAll(segment.selector);

		const props = Object.assign({}, segment.props);

		// Per-segment overrides supplement the timeline defaults.
		if (segment.duration != null) props.duration = segment.duration;
		if (segment.easing != null) props.easing = segment.easing;
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
	if (s.easing != null) opts.easing = s.easing;
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
function attachControls(el, tl) {
	const bar = document.createElement("div");
	bar.className = "animejs-controls";
	bar.style.cssText = [
		"display:flex",
		"align-items:center",
		"gap:8px",
		"padding:4px 0",
		"font-family:sans-serif",
		"font-size:12px",
	].join(";");

	const btn = document.createElement("button");
	btn.textContent = "▶";
	btn.style.cssText = "cursor:pointer;padding:2px 6px";

	const scrubber = document.createElement("input");
	scrubber.type = "range";
	scrubber.min = 0;
	scrubber.max = 1000;
	scrubber.value = 0;
	scrubber.style.cssText = "flex:1";

	let playing = false;

	btn.addEventListener("click", () => {
		if (playing) {
			tl.pause();
			btn.textContent = "▶";
		} else {
			tl.play();
			btn.textContent = "⏸";
		}
		playing = !playing;
	});

	scrubber.addEventListener("input", () => {
		const fraction = scrubber.value / 1000;
		tl.seek(tl.duration * fraction);
	});

	// Keep the scrubber in sync while the timeline is playing.
	tl.onUpdate = function (self) {
		scrubber.value = Math.round((self.currentTime / self.duration) * 1000);
	};

	tl.onComplete = function () {
		playing = false;
		btn.textContent = "▶";
	};

	bar.appendChild(btn);
	bar.appendChild(scrubber);
	el.appendChild(bar);
}
