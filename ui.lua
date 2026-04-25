function initUi()
   score = 30000
   health = 3
end

function updateUi()
    health = max(0, 3)

end

function drawUi()
    -- score
    print("score: " ..score, 78, 2, 7)

    --health
    for i=1, health do
        spr(10, 2 + (i-1)*10, 2)
    end

    for i=health+1, 3 do
        spr(9, 2 + (i-1)*10, 2)
    end
end
