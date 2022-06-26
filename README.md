# asmLibs
libraries meant for 32-bit freestanding gnu-assembly  
* All functions below are represented as macros and can be used like normal instructions  
* Each function is represented as the instruction, its parameter types, and the return register/variable(s)  
* Each variable is represented by its type and name  
# Stdin
---
## --Variables--
#### `<char> keyboard_redge`
#### `<char> keyboard_out`

## --Functions--
#### `read_keyboard -> al, keyboard_out`
  * Returns a keycode, not character  
#### `k2char <byte> -> al`
  * Converts a keycode to a character
#### `key_redge -> keyboard_redge`
  * Checks if a key is being pushed or released
#### `getc -> al, keyboard_out`
  * Reads a keypress and waits for it to be released
  * Returns keycode, not character
#### `gets <label>`
  * Reads a string from the keyboard
  * Expects `enter` as termination
  * Does not display on screen
### `geti <r32 or integer>`
  * Same as `gets` but with numbers

# Stdout
---
## --Defined--
#### `VGA_ADDR`
  * VGA address in RAM

## --Variables--
#### `<long> ttypos`
todo rest
