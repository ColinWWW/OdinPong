package main

import "core:fmt"
import rl "vendor:raylib"

screen_width: i32 : 1280
screen_height : i32 : 800
fps : i32 = 60

Ball :: struct {
	x : f32,
	y : f32,
	speed_x : i32,	
	speed_y : i32,
	radius : f32,

}


Draw :: proc(ball : Ball) {
	rl.DrawCircle(i32(ball.x), i32(ball.y), ball.radius, rl.RED)
}

Update :: proc(ball : ^Ball) {
	ball.x += f32(ball.speed_x)
	ball.y += f32(ball.speed_y)

	if (ball.y + ball.radius >= f32(rl.GetScreenHeight()) || ball.y - ball.radius <= 0) {
		ball.speed_y *= -1
	}
	
	if (ball.x + ball.radius >= f32(rl.GetScreenWidth()) || ball.x - ball.radius <= 0){
		ball.speed_x *= -1
	}	

}


ball : Ball

main ::proc() {
	fmt.println("Starting the Game")	
	rl.InitWindow(screen_width, screen_height, "Odin Pong")
	rl.SetTargetFPS(fps)
	ball.radius = 32
	ball.x = f32(screen_width)/2
	ball.y = f32(screen_height) /2
	ball.speed_x = 7
	ball.speed_y = 7


	for !rl.WindowShouldClose(){
		rl.BeginDrawing()
		Update(&ball)

		rl.ClearBackground(rl.RAYWHITE)	
		rl.DrawLine(screen_width/2, 0, screen_width/2, screen_height, rl.GRAY)
		Draw(ball)
		rl.DrawRectangle(25, screen_height/2 - 60, 15, 125, rl.SKYBLUE)
		rl.DrawRectangle(screen_width - 40, screen_height/2 - 60, 15, 125, rl.SKYBLUE)
		rl.EndDrawing()
			
	} 

	rl.CloseWindow()
}