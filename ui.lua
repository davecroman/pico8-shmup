function initUi()
   score = 0
   health = 3
   score_popups = {}
end

function addScorePopup(x, y)
    add(score_popups, {x=x, y=y, life=30})
end

function updateUi()
    health = max(0, 3)
    for p in all(score_popups) do
        p.y -= 0.25
        p.life -= 1
        if p.life <= 0 then del(score_popups, p) end
    end
end

function drawUi()
    print("score: "..score, 78, 2, 7)
    for i=1, health do
        spr(10, 2 + (i-1)*10, 2)
    end
    for i=health+1, 3 do
        spr(9, 2 + (i-1)*10, 2)
    end
    for p in all(score_popups) do
        print("+100", p.x, p.y, p.life%8<4 and 10 or 9)
    end
end
