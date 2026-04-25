function initPlayer()
    pX = 64
    pY = 80
    speed = 2
    frameCount = 1
    currSpr = 1
    fireCd = 0
    fireRate = 5
    fireSpeed = 6
    flash = 0
    boosterFrame = 0
end

function updatePlayer()
    if btn(0) then pX -= speed end
    if btn(1) then pX += speed end
    if btn(2) then pY -= speed end
    if btn(3) then pY += speed end
    
    pX = min(max(pX, 0), 128 - 8)
    pY = min(max(pY, 0), 128 - 8)

    -- sprite
    currSpr = 0
    if btn(0) then 
        currSpr = 1
    elseif btn(1) then
        currSpr = 2
    end

    -- animate flash
    if flash > 0 then
        flash -= 2
    end

    -- animate booster
    boosterFrame = (boosterFrame + 1) % 2

    --  FIRING CHECKS
    if btn(4) and fireCd == 0 then
        addProjectile(pX, pY -4, 0, -1*fireSpeed)
        sfx(0)
        flash = 6
        fireCd = fireRate
    end

    fireCd = max(0, fireCd - 1)
end

function drawPlayer()
    spr(currSpr, pX, pY)

    -- flash
    if(flash > 0) then
        circfill(pX + 4, pY - 2, flash, 7)
    end

    -- boster
    spr(7 + boosterFrame, pX, pY + 6)
end