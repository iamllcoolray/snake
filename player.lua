player = {
    x = love.graphics.getWidth() / 2,
    y = love.graphics.getHeight() / 2,
    width = 30,
    height = 30,
    speed = 2999,
    isMoving = false,
    outOfBounds = -30,
    tail_length = 0,
    isDead = false,
}

function player.load()
    direction = {
        x = 0,
        y = 0,
        UP = false,
        DOWN = false,
        LEFT = false,
        RIGHT = false,
    }

    playerBodys = {}
end

function player.update(dt)
    if direction.UP then
        direction.x = 0
        direction.y = -1
    elseif direction.DOWN then
        direction.x = 0
        direction.y = 1
    elseif direction.LEFT then
        direction.x = -1
        direction.y = 0
    elseif direction.RIGHT then
        direction.x = 1
        direction.y = 0
    else
        direction.x = 0
        direction.y = 1
    end

    local oldPlayerX = player.x - direction.x
    local oldPlayerY = player.y - direction.y

    player.x = player.x + direction.x * player.speed * dt
    player.y = player.y + direction.y * player.speed * dt

    if player.x < player.outOfBounds then
        player.x = love.graphics.getWidth()
    elseif player.x > love.graphics.getWidth() then
        player.x = player.outOfBounds
    elseif player.y < player.outOfBounds then
        player.y = love.graphics.getHeight()
    elseif player.y > love.graphics.getHeight() then
        player.y = player.outOfBounds
    end

    if player.tail_length > 0 then
        for i, b in ipairs(playerBodys) do
            local x = b.x
            local y = b.y
            b.x = oldPlayerX
            b.y = oldPlayerY
            oldPlayerX = x
            oldPlayerY = y
        end
    end
end

function player.draw()
    love.graphics.setColor(1, 0.1, 1)
    love.graphics.rectangle("fill", player.x, player.y, player
        .width,
        player.height)
    love.graphics.setColor(1, 0.1, 1, 0.5)
    for i, b in ipairs(playerBodys) do
        love.graphics.rectangle("fill", b.x, b.y, player
            .width,
            player.height)
    end
    love.graphics.setColor(1, 1, 1)
end

function player.spawnBody()
    local playerBody = {
        x = 0,
        y = 0,
    }
    table.insert(playerBodys, playerBody)
end
