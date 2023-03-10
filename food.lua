food = {
    x = love.graphics.getWidth() / 2,
    y = love.graphics.getHeight() - 100,
    width = 30,
    height = 30,
}

function food.load()

end

function food.update(dt)

end

function food.draw()
    love.graphics.setColor(1, 0.2, 0.2)
    love.graphics.rectangle("fill", food.x, food.y, food.width, food.height)
    love.graphics.setColor(1, 1, 1)
end
