package main

import "core:fmt"
import rl "vendor:raylib"

screen_width: i32 : 1280
screen_height : i32 : 800
fps : i32 = 60

Ball :: struct {
	x : f32,
	y : f32,
	speed_x : int,	
	speed_y : int,
	radius : int,

}





ball : Ball

fmt.println("Starting the Game")	
	rl.InitWindow(screen_width, screen_height, "Odin Pong")
	rl.SetTargetFPS(fps)
	ball.radius = 32
	ball.x = f32(screen_width)/2
	ball.y = f32(screen_height) /2

	/

main ::proc() {
	fmt.println("Starting the Game")	
	rl.InitWindow(screen_width, screen_height, "Odin Pong")
	rl.SetTargetFPS(fps)
	ball.radius = 32
	ball.x = f32(screen_width)/2
	ball.y = f32(screen_height) /2

	//test
	
	for !rl.WindowShouldClose(){
		rl.BeginDrawing()
		rl.DrawLine(screen_width/2, 0, screen_width/2, screen_height, rl.GRAY)
		rl.DrawCircle(ball.x, ball.y, ball.radius, rl.RED)
		rl.DrawRectangle(25, screen_height/2 - 60, 15, 125, rl.SKYBLUE)
		rl.DrawRectangle(screen_width - 40, screen_height/2 - 60, 15, 125, rl.LIME)
		rl.EndDrawing()
			
	} 

	rl.CloseWindow()
}