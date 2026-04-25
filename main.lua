function _init()
    cls(0)
    initProjectiles()
    initPlayer()
    initExplosions()
    initUi()
end

function _update()
    updateProjectiles()
    updatePlayer()
    updateExplosions()
    updateUi()
end

function _draw()
    cls()
    drawProjectiles()
    drawPlayer()
    drawExplosions()
    drawUi()
    -- rect(0, 0, 128-1, 128-1, 13)
end