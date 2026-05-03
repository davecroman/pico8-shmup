function initPlayer()
    p1 = {
        x=60, y=90,
        vel=2,
        currSpr=0,
        fireCd=0,
        fireRate=5,
        fireSpeed=6,
        boosterFrame=0
    }
    frameCount = 1
    flash = 0
end

function updatePlayer()
    if btn(0) then p1.x -= p1.vel end
    if btn(1) then p1.x += p1.vel end
    if btn(2) then p1.y -= p1.vel end
    if btn(3) then p1.y += p1.vel end

    p1.x = min(max(p1.x, 0), 128 - 8)
    p1.y = min(max(p1.y, 0), 128 - 8)

    -- sprite
    p1.currSpr = 0
    if btn(0) then
        p1.currSpr = 1
    elseif btn(1) then
        p1.currSpr = 2
    end

    -- animate flash
    if flash > 0 then
        flash -= 2
    end

    -- animate booster
    p1.boosterFrame = (p1.boosterFrame + 1) % 2

    --  FIRING CHECKS
    if btn(4) and p1.fireCd == 0 then
        addProjectile(p1.x, p1.y - 4, 0, -1 * p1.fireSpeed)
        sfx(0)
        flash = 6
        p1.fireCd = p1.fireRate
    end

    p1.fireCd = max(0, p1.fireCd - 1)
end

function drawPlayer()
    spr(p1.currSpr, p1.x, p1.y)

    -- flash
    if(flash > 0) then
        circfill(p1.x + 4, p1.y - 2, flash, 7)
    end

    -- booster
    spr(7 + p1.boosterFrame, p1.x, p1.y + 6)
end
