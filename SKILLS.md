# SKILLS.md

Practical techniques learned while working on this project.

---

## Editing Sprites in `__gfx__`

### Format

The `__gfx__` section is a flat pixel grid, 128×128 px. Each character is one pixel, encoded as a single hex digit (0–f) matching PICO-8's 16-colour palette.

- Each line = one horizontal pixel row across the full 128-px-wide sheet
- Every line must be **exactly 128 characters**
- The section ends at the next `__` tag (e.g. `__sfx__`)

### Sprite index → pixel position

The sheet is a 16×16 grid of 8×8 sprites (sprites 0–255).

```
sprite_row = N // 16          -- which row of sprites (0–15)
sprite_col = N % 16           -- which column of sprites (0–15)

pixel_rows = sprite_row*8  to  sprite_row*8 + 7
char_start = sprite_col*8  (within each of those pixel rows)
char_end   = char_start + 7
```

Examples:
| Sprite | Pixel rows | Char range |
|--------|-----------|------------|
| 13     | 0–7       | 104–111    |
| 29     | 8–15      | 104–111    |
| 30     | 8–15      | 112–119    |
| 31     | 8–15      | 120–127    |

### Adding sprites in a new sprite row

If the sprite row doesn't exist yet in `__gfx__`, append 8 new pixel-row lines before the next `__` tag. A line with only sprites at positions 29–31 (chars 104–127) looks like:

```
[104 zeros][spr29_row][spr30_row][spr31_row]
```

**Always use a script to generate and verify line lengths before editing.** Manual counting is error-prone.

```python
zeros = '0' * 104   # sprites 16–28 empty
spr29 = ['00155100', '01566510', ...]  # 8 rows of 8 chars each
spr30 = [...]
spr31 = [...]
for i in range(8):
    row = zeros + spr29[i] + spr30[i] + spr31[i]
    assert len(row) == 128, f"row {i} is {len(row)} chars"
    print(row)
```

Run this with `python -c "..."` in Bash before writing the edit.

---

## Designing Metallic / Futuristic Sprites

### Colour layering for a metallic sheen

Work outward-in (edge → core):

| Layer       | Colour | Index |
|-------------|--------|-------|
| Deep shadow | dark blue  | `1` |
| Mid shadow  | dark grey  | `5` |
| Surface     | light grey | `6` |
| Highlight   | white      | `7` |
| Energy core | blue / orange / yellow | `c` / `9` / `a` |

### Animating an energy core (3 frames)

Cycle the core colour across the three animation frames to convey power:

| Frame | Core colour | Index |
|-------|-------------|-------|
| 1     | Blue        | `c` (12) |
| 2     | Orange      | `9` |
| 3     | Yellow      | `a` (10) |

### Example 8×8 frame (symmetric armoured ship, frame 1)

```
00155100   -- deep shadow rim
01566510   -- dark grey shell
15677651   -- light grey + highlight
567cc765   -- surface + blue core
567cc765
15677651
01566510
00155100
```

Replace `cc` with `99` (frame 2) and `aa` (frame 3) for the animation cycle.
