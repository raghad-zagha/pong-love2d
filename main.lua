
function love.load()
    love.window.setTitle("Pong Game")
    love.window.setMode(800, 600)
    
     local PADDLE_WIDTH = 20
     local PADDLE_HEIGHT = 100
     local BALL_SIZE = 20

     score1 = 0
     score2 = 0

    player1 = {
        x = 50,
        y = 240,
        width =PADDLE_WIDTH,
        height = PADDLE_HEIGHT,
        speed = 300
    }

    player2 = {
        x = 800 - 50 - PADDLE_WIDTH,
        y = 250,
       width =PADDLE_WIDTH,
       height = PADDLE_HEIGHT,
       speed = 300
    }

    ball = {
        x = 400 - BALL_SIZE/2 ,
        y = 300 - BALL_SIZE/2 ,
        size =BALL_SIZE
    }
    ball.dx = 200 
    ball.dy = 200

end

function love.draw ()
    love.graphics.setBackgroundColor(0.1,0.1,0.1)
    love.graphics.setColor(1,1,1)
    for i = 0 ,600,30 do 
        love.graphics.rectangle("fill",395,i,10,15)

end
love.graphics.rectangle("fill",
    player1.x,
    player1.y,
    player1.width,
    player1.height
)
love.graphics.rectangle("fill",
    player2.x,
    player2.y,
    player2.width,
    player2.height
)
love.graphics.rectangle("fill",
    ball.x,
    ball.y,
    ball.size,
    ball.size
)

local scoreFont = love.graphics.newFont(40)
love.graphics.setFont(scoreFont)

love.graphics.print(score1,300,50)
love.graphics.print(score2,470,50)

end

local function chackCollision (ball,paddle)
    return ball.x<=paddle.x + paddle.width and 
    ball.x + ball.size >= paddle.x and 
    ball.y <= paddle.y + paddle.height and 
    ball.y + ball.size >= paddle.y
  
end
local function resetBall()
    ball.x = 400 - ball.size / 2
    ball.y = 300 - ball.size / 2

    ball.dx = 150 * (math.random(2) == 1 and 1 or -1)
    ball.dy = 150 * (math.random(2) == 1 and 1 or -1)
end

function love.update(dt)

if love.keyboard.isDown("w") then
    player1.y = player1.y - player1.speed * dt
elseif love.keyboard.isDown("s") then
    player1.y = player1.y + player1.speed * dt
end

if love.keyboard.isDown("up") then
    player2.y = player2.y - player2.speed * dt
elseif love.keyboard.isDown("down") then
    player2.y = player2.y + player2.speed * dt
end

    player1.y = math.max(
        0,
        math.min(player1.y, 600 - player1.height)
    )

    player2.y = math.max(
        0,
        math.min(player2.y, 600 - player2.height)
    )
    -- move  ball :)

    ball.x = ball.x + ball.dx * dt 
    ball.y = ball.y + ball.dy * dt
    if ball.y <=0 then 
        ball.y = 0
        ball.dy = -ball.dy
        elseif ball.y + ball.size>=600 then
            ball.y= 600 - ball.size
            ball.dy = -ball.dy 

            end

           
            if ball.dx < 0 and chackCollision(ball, player1) then
            ball.x = player1.x + player1.width
            ball.dx = math.abs(ball.dx) * 1.05
end


            if ball.dx > 0 and chackCollision(ball, player2) then
            ball.x = player2.x - ball.size
            ball.dx = -math.abs(ball.dx) * 1.05
end

            if ball.x + ball.size < 0 then
            score2 = score2 + 1
            resetBall()

            elseif ball.x > 800 then
            score1 = score1 + 1
            resetBall()
end


end 

