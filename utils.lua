function isColliding(a, b)
  return a.x < b.x+b.w and a.x+a.w > b.x
     and a.y < b.y+b.h and a.y+a.h > b.y
end

-- Function to draw blinking text
-- text: the string to display
-- x, y: position on screen
-- period: blink period in seconds (default 1.0)
-- clr: color of the text (optional)
function blink_text(text, x, y, period, clr)
  period = period or 1.0
  if t() % period < period * 0.5 then
    print(text, x, y, clr)
  end
end

