package main

import "core:fmt"
import "core:time"

import gl "vendor:OpenGL"
import sdl "vendor:sdl2"

main :: proc() {
    if (sdl.Init(sdl.INIT_EVERYTHING) != 1) {

    }

    window := sdl.CreateWindow("Title", 
    	sdl.WINDOWPOS_UNDEFINED, 
    	sdl.WINDOWPOS_UNDEFINED, 
    	800, 600, {.OPENGL, .RESIZABLE})
    if window == nil {
    	fmt.eprintln("Failed to create window")
    	return
    }
    defer sdl.DestroyWindow(window)

    gl_context := sdl.GL_CreateContext(window)
	sdl.GL_MakeCurrent(window, gl_context)
	gl.load_up_to(3, 3, sdl.gl_set_proc_address)

	start_tick := time.tick_now()
    loop: for {
    	duration := time.tick_since(start_tick)
		t := f32(time.duration_seconds(duration))

    	event: sdl.Event
		for sdl.PollEvent(&event) != false {
			#partial switch event.type {
			case .KEYDOWN:
				#partial switch event.key.keysym.sym {
				case .ESCAPE:
					break loop
				}
			case .QUIT:
				break loop
			}
		}


		gl.ClearColor(0.5, 0.7, 1.0, 1.0)
		gl.Clear(gl.COLOR_BUFFER_BIT)


		sdl.GL_SwapWindow(window)
    }
}