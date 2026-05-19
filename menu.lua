function initMenu()
   btnPressed = false
   minusY = 0
end

function updateMenu()
   if(btn(4)) then
       btnPressed = true
   end

   if btnPressed then
        if minusY < 45 then
            minusY += 2
        else
            minusY += 1
        end
   end

   --if the player has fully moved up, switch to game mode
   if minusY > 70 then
       mode = "game"
   end
end

function drawMenu()
    local titleY = 50 - minusY
    print("burned out", 40, titleY, 7)
    if btnPressed then
        local targetPY = max(160 - minusY, p1.y)
        spr(0, p1.x, targetPY) 
        spr(7 + p1.boosterFrame, p1.x, targetPY + 6)
    else
        blink_text("press ❎ to start", 28, 70, 0.5, 8)
    end
    
end