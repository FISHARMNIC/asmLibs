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
  * Returns a keycode in `al`
  * Note, this number is not ASCII  
#### `k2char <byte> -> al`
  * Converts a keycode to a character
#### `key_redge -> keyboard_redge`
  * Checks if a key is being pushed or released

