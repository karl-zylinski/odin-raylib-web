#include <stdlib.h>
#include <emscripten/emscripten.h>
#include <emscripten/html5.h>

extern void wasm_init();
extern void wasm_update();
extern void wasm_window_size_changed(int w, int h);

void update_window_size() {
	double w, h;
	emscripten_get_element_css_size("#canvas", &w, &h);
	wasm_window_size_changed((int)w, (int)h);
}

static EM_BOOL on_web_display_size_changed(
	int event_type,
	const EmscriptenUiEvent *event,
	void *user_data
) {
	update_window_size();
	return 0;
}

int main(void) {
	emscripten_set_resize_callback(
		EMSCRIPTEN_EVENT_TARGET_WINDOW,
		0, 0, on_web_display_size_changed
	);

	wasm_init();
	update_window_size();
	emscripten_set_main_loop(wasm_update, 0, 1);
	
	// We don't really "shutdown" the game, since web browser tabs just close.

	return 0;
}