e1_spr = {13,14,15}

function initEnemies()
    enemies = {}
    spawn_t = t()
    add(enemies,{x=flr(rnd(120)),y=-8,hp=30,hit_t=0,frame=0,anim_t=0,speed=rnd(2)+1,w=8,h=8})
end

function updateEnemies()
    if t()-spawn_t >= 0.5 then
        add(enemies,{x=flr(rnd(120)),y=-8,hp=30,hit_t=0,frame=0,anim_t=0,speed=rnd(2)+1,w=8,h=8})
        spawn_t = t()
    end
    for e in all(enemies) do
        e.anim_t+=1
        if e.anim_t>=8 then
            e.anim_t=0
            e.frame=(e.frame+1)%3
        end
        e.y+=e.speed
        if e.hit_t>0 then e.hit_t-=1 end
        if e.y>128 then
            del(enemies,e)
        end
    end
end

function drawEnemies()
    for e in all(enemies) do
        if e.hit_t>0 then
            for c=1,15 do pal(c,7) end
        end
        spr(e1_spr[e.frame+1],e.x,e.y)
        pal()
    end
end
