# AGENTS.md
 
Guidelines for AI agents working on this PICO-8 Lua project.
 
---
 
## What is PICO-8?
 
PICO-8 is a fantasy console with strict hardware constraints. All code runs inside a `.p8` cartridge file. The runtime is a **subset of Lua 5.4** with PICO-8-specific globals and APIs. Agents must respect every constraint below — there is no way to work around them at runtime.
 
---
 
## Hard Constraints
 
| Resource        | Limit                        |
|-----------------|------------------------------|
| Spritesheet     | 128×128 px (256 8×8 sprites) |
| Map             | 128×64 tiles                 |
| Sound effects   | 64 SFX                       |
| Music patterns  | 64 patterns                  |
| Code            | **32,768 tokens** (not bytes) |
| RAM             | 32KB addressable              |
| Display         | 128×128 px, 16 colours       |
| CPU             | ~4M cycles / frame (target 30fps) |
 
**The token limit is the most important constraint.** Every keyword, identifier, number, and symbol counts. Agents must keep code small.
 
---
 
## Project Structure
 
```
mygame.p8          # single cartridge file — source of truth
README.md          # human-readable notes
AGENTS.md          # this file
assets/            # exported spritesheets, map CSVs (for reference only)
```
 
All runnable code lives inside `mygame.p8`. Do **not** split logic across multiple `.p8` files expecting them to be linked — PICO-8 does not support that.
 
---
 
## PICO-8 Lua Dialect Rules
 
PICO-8 supports standard Lua with the following additions and restrictions:
 
### Supported Additions
- `!=` as an alias for `~=`
- `//` integer division operator
- `^^` bitwise XOR
- `>>` / `<<` bitwise shift
- `@`, `%`, `$` memory peek shortcuts
- `print()`, `printh()` (not standard Lua I/O)
- All PICO-8 globals: `_update`, `_draw`, `_init`, `btn`, `spr`, `map`, `sfx`, `music`, `stat`, etc.
### Not Supported
- `require()` — no module system
- `io`, `os`, `package`, `debug` libraries
- `string.format` (use `tostr()` / `\`...\`` instead where possible)
- Metatables work but have overhead — use them sparingly
- `goto` is available but rarely needed
### Coding Style for Token Efficiency
Token count matters more than line count. Prefer:
 
```lua
-- Compact assignment
local x,y,w,h=0,0,8,8
 
-- Ternary pattern
local v=cond and a or b
 
-- Inline if for simple guards
if dead then return end
 
-- Avoid redundant locals; reuse variables when safe
```
 
Do **not** add type annotations, module wrappers, or OOP boilerplate unless it fits within the token budget.
 
---
 
## Entry Points
 
PICO-8 calls three special functions each frame. Always define them at the top level:
 
```lua
function _init()
  -- called once at cart start
end
 
function _update()   -- or _update60() for 60fps
  -- game logic, runs every frame
end
 
function _draw()
  -- rendering, runs every frame after _update
  cls()
  -- draw calls here
end
```
 
Do not rename these. Do not call them manually unless you have a specific reason.
 
---
 
## Coordinate System & Drawing
 
- Origin `(0,0)` is **top-left**.
- X increases right, Y increases **down**.
- All drawing functions clip to the 128×128 screen automatically.
- Always call `cls()` at the start of `_draw()` unless you intentionally want frame trails.
Common drawing functions to use:
 
```lua
cls([col])           -- clear screen
spr(n,x,y,[w],[h])   -- draw sprite n at x,y
map(cx,cy,sx,sy,cw,ch) -- draw map region
print(str,x,y,col)  -- draw text
rectfill(x0,y0,x1,y1,col) -- filled rectangle
circ(x,y,r,col)     -- circle outline
pset(x,y,col)       -- set pixel
```
 
---
 
## Input
 
```lua
btn(b)        -- true if button b held this frame
btnp(b)       -- true if button b just pressed (with autorepeat)
```
 
Button indices:
 
| Index | Button  |
|-------|---------|
| 0     | ← left  |
| 1     | → right |
| 2     | ↑ up    |
| 3     | ↓ down  |
| 4     | ❎ (z/n) |
| 5     | 🅾️ (x/m) |
 
For 2-player, add 8 to the index (e.g., `btn(8)` = P2 left).
 
---
 
## Audio
 
```lua
sfx(n)           -- play sound effect n (0–63), -1 to stop
music(n)         -- play music pattern n (0–63), -1 to stop
```
 
Do not hardcode SFX/music indices as magic numbers. Use named constants:
 
```lua
SFX_JUMP=0
SFX_DIE=1
MUSIC_TITLE=0
```
 
---
 
## Memory & Performance Tips
 
- Avoid allocating tables every frame — pre-allocate pools.
- Prefer `for i=1,#t do` over `for k,v in pairs(t)` for arrays (faster).
- Use `poke`/`peek` for bulk data or pixel manipulation when needed.
- Profile with `stat(1)` (CPU usage) — keep it below 1.0.
- `stat(0)` returns memory usage in bytes.
---
 
## Colours
 
PICO-8 has exactly 16 colours (indices 0–15):
 
```
0  black       4  dark_grey    8  red         12 blue
1  dark_blue   5  grey         9  orange      13 indigo
2  dark_purple 6  white       10  yellow      14 pink
3  dark_green  7  white(2)    11  green       15 peach
```
 
Use numeric literals directly. Do not import colour palettes from external libraries.
 
---
 
## What Agents Should Do
 
- **Read the token count** before and after every edit. Stay well under 32,768.
- **Preserve existing entry points** (`_init`, `_update`, `_draw`). Do not refactor them away.
- **Test logic mentally against the constraints** — no filesystem, no networking, no external libraries.
- **Keep functions short.** PICO-8 games are typically one flat file; deeply nested abstractions are expensive in tokens and harder to debug.
- **Use comments sparingly** — comments cost tokens.
- **Never introduce `require()` or multi-file imports.**
- **Ask before adding new SFX or sprite indices** — these are shared resources and may conflict with existing assets.
---
 
## What Agents Should Not Do
 
- Do not use standard Lua libraries (`io`, `os`, `math.huge` is fine, but avoid others).
- Do not write unit test harnesses — PICO-8 has no test runner.
- Do not produce multiple files expecting a build step.
- Do not exceed the 128×128 draw surface.
- Do not add dependencies or package managers.
---
 
## Submitting Changes
 
1. Edit `mygame.p8` directly.
2. Verify the token count estimate stays under 32,768.
3. Describe what was changed and why in your PR/commit message.
4. Note any sprite, SFX, or map indices added or changed.