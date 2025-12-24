


| Ctrl + Shift + [] | # folding                       |
| ----------------- | ------------------------------- |
| Ctrl + Shift + L  | # multi-line                    |
| Alt + Shift + 2/1 | # window split                  |
| Shift + F3        | Find Prev; Shift Enter in Panel |
| F3                | Next                            |
| Alt + F3          | Find All                        |
| F9                | Sort                            |

# Change KeyBindings
Preferences → Key Bindings

```json
[
// changes so it's like VS Code vs ctrl+shift+(up/down)

    { "keys": ["alt+up"], "command": "swap_line_up" },

    { "keys": ["alt+down"], "command": "swap_line_down" }

]
```

Preferences → Package Settings → Logbook → Settings