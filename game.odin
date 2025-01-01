package raylib_wasm

import rl "vendor:raylib"
import "core:log"

TEXTURE_DATA :: #load("round_cat.png")
texture: rl.Texture

game_init :: proc() {
	rl.SetConfigFlags({.WINDOW_RESIZABLE, .VSYNC_HINT})
	rl.InitWindow(1280, 720, "Raylib Web Example")

	// Set up sample texture
	img := rl.LoadImageFromMemory(".png", raw_data(TEXTURE_DATA), i32(len(TEXTURE_DATA)))
	texture = rl.LoadTextureFromImage(img)
	rl.UnloadImage(img)
}

game_update :: proc() {
	rl.BeginDrawing()
	rl.ClearBackground({0, 120, 153, 255})
	rl.DrawTextureEx(texture, rl.GetMousePosition(), 0, 5, rl.WHITE)

	if rl.GuiButton({10, 10, 100, 20}, "raygui Button!") {
		log.info("Logging works!")
	}

	rl.EndDrawing()

	// Anything on temp allocator is invalid after end-of-frame
	free_all(context.temp_allocator)
}

game_shutdown :: proc() {
	log.info("shutting down")
	rl.CloseWindow()
}