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

Paddle :: struct {
	x : f32,
	y : f32,
	width: f32,
	height: f32, 
	speed_y : i32,
}


DrawBall :: proc(ball : Ball) {
	rl.DrawCircle(i32(ball.x), i32(ball.y), ball.radius, rl.RED)
}

Update :: proc(ball : ^Ball) {
	ball.x += f32(ball.speed_x)
	ball.y += f32(ball.speed_y)
		// need to revisit this part to get a better understanding of it mentally
	if (ball.y + ball.radius >= f32(rl.GetScreenHeight()) || ball.y - ball.radius <= 0) {
		ball.speed_y *= -1
	}
	
	if (ball.x + ball.radius >= f32(rl.GetScreenWidth()) || ball.x - ball.radius <= 0){
		ball.speed_x *= -1
	}	
}

UpdatePlayer :: proc(player : ^Paddle){
	if (rl.IsKeyDown(.W)) {
		player.y = player.y - f32(player.speed_y) 
	}

	if(rl.IsKeyDown(.S)) {
		player.y = player.y + f32(player.speed_y)
	}

	if(player.y <= 0) {
		player.y = 0
	}

	if(player.y + player.height>= f32(rl.GetScreenHeight())){
		player.y = f32(rl.GetScreenHeight()) - player.height
	}
}


UpdateCpuPaddle :: proc(cpuPaddle: ^Paddle, ball: ^Ball) {
	if (cpuPaddle.y + cpuPaddle.height/2 > ball.y) {
		cpuPaddle.y = cpuPaddle.y - f32(cpuPaddle.speed_y)
	}

	if (cpuPaddle.y + cpuPaddle.height/2 <= ball.y) {
		cpuPaddle.y = cpuPaddle.y + f32(cpuPaddle.speed_y)
	}
}




player : Paddle
ball : Ball
cpuPaddle : Paddle

main ::proc() {
	fmt.println("Starting the Game")	
	rl.InitWindow(screen_width, screen_height, "Odin Pong")
	rl.SetTargetFPS(fps)

	// ball stats
	ball.radius = 32
	ball.x = f32(screen_width)/2
	ball.y = f32(screen_height) /2
	ball.speed_x = 7
	ball.speed_y = 7


	//paddle stats
	player.x = 25
	player.y = f32(screen_height) /2 - 60
	player.width = 15
	player.height = 125
	player.speed_y = 7


	cpuPaddle.x = f32(screen_width - 40)
	cpuPaddle.y = f32(screen_height) / 2 - 60
	cpuPaddle.height= 15
	cpuPaddle.width = 125
	cpuPaddle.speed_y = 7






	for !rl.WindowShouldClose(){
		rl.BeginDrawing()
		Update(&ball)
		UpdatePlayer(&player)
		UpdateCpuPaddle(&cpuPaddle,&ball)
		rl.ClearBackground(rl.RAYWHITE)	
		rl.DrawLine(screen_width/2, 0, screen_width/2, screen_height, rl.GRAY)
		DrawBall(ball)
		rl.DrawRectangle(i32(player.x), i32(player.y), i32(player.width), i32(player.height), rl.SKYBLUE)
		// Computer
		rl.DrawRectangle(i32(cpuPaddle.x), i32(cpuPaddle.y), i32(cpuPaddle.height), i32(cpuPaddle.width), rl.SKYBLUE)

		rl.EndDrawing()
			
	} 

	rl.CloseWindow()
}