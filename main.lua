require("player")
require("food")

function love.load()
    math.randomseed(os.time())

    gameFont = love.graphics.newFont(30)

    player.load()
    food.load()

    maxInterval = 15
    interval = maxInterval
    score = 0
    gameState = 1
    timer = 0
end

function love.update(dt)
    if gameState == 2 then
        timer = timer + dt
        interval = interval - 1
        if interval < 0 then
            player.update(dt)
            interval = maxInterval
        end
        food.update(dt)
    end

    if distanceBetween(player.x, player.y, food.x, food.y) < 30 then
        score = score + 1
        player.tail_length = player.tail_length + 1

        player.spawnBody()

        food.x = math.random(food.width, love.graphics.getWidth() - food.width)
        food.y = math.random(food.height, love.graphics.getHeight() - food.height)
    end

    for i, b in ipairs(playerBodys) do
        if distanceBetween(food.x, food.y, b.x, b.y) < 30 then
            food.x = math.random(food.width, love.graphics.getWidth() - food.width)
            food.y = math.random(food.height, love.graphics.getHeight() - food.height)
        end
    end

    for i, b in ipairs(playerBodys) do
        if distanceBetween(player.x, player.y, b.x, b.y) < 30 then
            gameState = 1
            player.tail_length = 0
            player.x = love.graphics.getWidth() / 2
            player.y = love.graphics.getHeight() / 2
            food.x = love.graphics.getWidth() / 2
            food.y = love.graphics.getHeight() - 100
            player.isDead = true
        end
    end

    for i = #playerBodys, 1, -1 do
        local b = playerBodys[i]
        if player.isDead == true then
            table.remove(playerBodys, i)
        end
    end
end

function love.draw()
    love.graphics.setFont(gameFont)
    if gameState == 1 then
        love.graphics.printf("Press enter to start!", 0, 250, love.graphics.getWidth(),
            "center")
    end

    player.draw()
    food.draw()

    love.graphics.printf("Timer: " .. math.ceil(timer), 0, 30, love.graphics.getWidth(), "left")
    love.graphics.printf("Score: " .. score, 0, 30, love.graphics.getWidth(), "center")
end

function love.keypressed(key)
    if key == "return" and gameState == 1 then
        gameState = 2
        score = 0
        timer = 0
        interval = maxInterval
        player.isDead = false
    end
end

function love.keyreleased(key)
    if key == "escape" then
        love.event.quit()
    elseif key == "left" or key == "a" then
        direction.LEFT = true
        direction.RIGHT = false
        direction.UP = false
        direction.DOWN = false
    elseif key == "right" or key == "d" then
        direction.LEFT = false
        direction.RIGHT = true
        direction.UP = false
        direction.DOWN = false
    elseif key == "up" or key == "w" then
        direction.LEFT = false
        direction.RIGHT = false
        direction.UP = true
        direction.DOWN = false
    elseif key == "down" or key == "s" then
        direction.LEFT = false
        direction.RIGHT = false
        direction.UP = false
        direction.DOWN = true
    end
end

function distanceBetween(x1, y1, x2, y2)
    return math.sqrt((x2 - x1) ^ 2 + (y2 - y1) ^ 2)
end
