function initExplosions()
   exps = {} 
end

function updateExplosions()
  for e in all(exps) do
    if e.frame < 3 then
        e.frame += 1
    else
        del(exps, e)
    end
  end
end

function drawExplosions()
  for e in all(exps) do
    spr(3 + e.frame, e.x, e.y)
  end
end

function addExplosion(x, y)
  add(exps, {x = x, y = y, frame = 0})
end