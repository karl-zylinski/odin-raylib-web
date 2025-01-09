/*
These procs are the ones that will be called from `main_wasm.c`.
*/

package main_web

import "base:runtime"
import "core:c"
import game ".."

@(private="file")
web_context: runtime.Context

// I'm not sure @thread_local works with WASM. We'll see if anyone makes a
// multi-threaded WASM game!
@(private="file")
@thread_local temp_allocator: Default_Temp_Allocator

@export
web_init :: proc "c" () {
	context = runtime.default_context()
	web_context = context

	game.init()
}

@export
web_update :: proc "c" () {
	context = web_context
	game.update()
}

@export
web_window_size_changed :: proc "c" (w: c.int, h: c.int) {
	context = web_context
	game.parent_window_size_changed(int(w), int(h))
}