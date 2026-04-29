function _init()
    mode = "menu"
    initMenu()
    initStarfield()
    initProjectiles()
    initPlayer()
    initExplosions()
    initUi()
end


function _update()
    if mode == "menu" then
        updateStarfield()
        updateMenu()
    elseif mode == "game" then
        updateStarfield()
        updateProjectiles()
        updatePlayer()
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
        drawExplosions()
        drawUi()
        print(stat(1)*100,103,10,5)
    end
    
end