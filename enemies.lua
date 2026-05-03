e1_spr = {13,14,15}
e2_spr = {29,30,31}

function initEnemies()
    enemies = {}
    for i=1,5 do
        add(enemies,{x=flr((i-0.5)*25.6)-4,y=8,hp=30,frame=0,anim_t=0, speed = rnd(3)})
    end
end

function updateEnemies()
    for e in all(enemies) do
        e.anim_t+=1
        if e.anim_t>=8 then
            e.anim_t=0
            e.frame=(e.frame+1)%3
        end
        e.y+=e.speed
        if e.y>128 then
            del(enemies,e)
        end
    end
end

function drawEnemies()
    for e in all(enemies) do
        spr(e1_spr[e.frame+1],e.x,e.y)
    end
end
