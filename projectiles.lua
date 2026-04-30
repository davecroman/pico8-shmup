function initProjectiles()
    projs = {}
end

function updateProjectiles()
  for p in all(projs) do
    p.x += p.dx
    p.y += p.dy
    addExplosion(p.x, p.y + rnd(10))
    if p.x < 0 or p.x > 128 or p.y < 0 or p.y > 128 then
      del(projs, p)
    end
  end
end

function drawProjectiles()
    for p in all(projs) do
        spr(3, p.x, p.y)
    end
end

function addProjectile(x, y, dx, dy)
    add(projs, {x = x, y = y, dx = dx, dy = dy})
end