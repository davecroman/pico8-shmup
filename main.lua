function _init()
    mode = "menu"
    initMenu()
    initStarfield()
    initProjectiles()
    initPlayer()
    initExplosions()
    initUi()
    initEnemies()
end

function checkCollisions()
    for e in all(enemies) do
        for p in all(projs) do
            if(isColliding(e, p)) then

                addExplosion(e.x + flr(rnd(11)) - 5, e.y + flr(rnd(11)) - 5)
                del(projs, p)
                e.hp -= p1.pow
                e.hit_t = 6
                if e.hp <= 0 then
                    score += 100
                    addScorePopup(e.x, e.y)
                    del(enemies, e)
                    sfx(1)
                    for i=1,5 do
                        addExplosion(e.x + flr(rnd(20)) - 10, e.y + flr(rnd(20)) - 10)
                    end
                    break
                end
            end
        end 
    end
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
        checkCollisions()
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