function _init()
    mode = "game"
    initMenu()
    initStarfield()
    initProjectiles()
    initPlayer()
    initExplosions()
    initUi()
    initEnemies()
end


function _update()
    if mode == "menu" then
        updateStarfield()
        updateMenu()
    elseif mode == "game" then
        updateStarfield()
        updateProjectiles()
        updatePlayer()
        updateEnemies()
        updateExplosions()
        updateUi()
    end
end

function _draw()
    cls()
    if mode == "menu" then
        drawStarfield()
        drawMenu()
    elseif mode == "game" then
        drawStarfield()
        drawProjectiles()
        drawPlayer()
        drawEnemies()
        drawExplosions()
        drawUi()
        print(stat(1)*100,103,10,5)
    end
    
end