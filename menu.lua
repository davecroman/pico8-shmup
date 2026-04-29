function initMenu()
   blinkRate = 20
   blinkTimer = 0
   btnPressed = false
   minusY = 0
end

function updateMenu()
   blinkTimer = (blinkTimer + 1) % blinkRate

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
        local targetPY = max(160 - minusY, pY)
        spr(0, pX, targetPY)
        spr(7 + boosterFrame, pX, targetPY + 6)
    else
        if blinkTimer < blinkRate / 2 then
            print("PRESS ❎ TO START", 28, 70, 8)
        end
    end
    
end