# asmLibs
libraries meant for 32-bit freestanding gnu-assembly  
All functions below are represented as macros and can be used like normal instructions  
Each function is represented as the instruction, its parameter types, and the return register/variable  
## Stdin
---
## `read_keyboard -> al`
  * Returns a keycode in `al`
  * Note, this number is not ASCII  
## `k2char <byte> -> al`
  * Converts a keycode to a character
  * Returns in `al`
## `key_redge`
  
