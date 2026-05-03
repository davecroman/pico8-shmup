function initStarfield()
    starCount = 60
    stars = {}
    for i=1, starCount do
        add(stars, {x=flr(rnd(128)), y=flr(rnd(128)), dy=flr(rnd(3))+1})
    end
end

function updateStarfield()
    for s in all(stars) do
        s.y = s.y + s.dy
        if s.y > 128 then
            s.y = 0
            s.x = flr(rnd(128))
            s.dy = flr(rnd(3))+1
        end
    end
end

function drawStarfield()
    --  convert to for s in all(stars) do       
    for s in all(stars) do
        local clr = 7
        if s.dy == 2 then
            clr = 13
        elseif s.dy == 1 then
            clr = 5
        end
        pset(s.x, s.y, clr)
    end
end