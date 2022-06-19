.intel_syntax

VGA_ADDR = 0xB8000 # address of VGA in RAM
BG_COLOR = 0
FG_COLOR = 0
.section .data

ttypos: .long VGA_ADDR # current tty position

.section .text
/* #region VGA handlers */
// The correct format for displaying characters
format_VGA_proc:
    /* 
    Clobbers: 
        EAX = character 
        EBX
    
    Return: AX

    VGA format:
       4    4     8
    | BG | FG | CHAR |
    */
    mov %bh, BG_COLOR
    mov %bl, FG_COLOR
    shl %ebx, 8
    or %eax, %ebx # Append the format with the character
    ret 

// Adding a new line
newline_proc:
    // newline = position  + (80 - (position % 80))
    push %eax; push %ebx; push %edx
   
    addw ttypos, 160
    mov %eax, [ttypos] - VGA_ADDR
    mov %ebx, 160
    div %ebx
    sub ttypos, %edx

    pop %edx; pop %ebx; pop %eax
    ret

.macro put_line
    call newline_proc
.endm
/* #endregion */

/* #region Character Out */
// Displaying a character on screen

put_char_proc:
    /* 
    Clobbers: 
        EAX = character 
        EBX
    */
    push %ebx
    
    or %eax, 3840 # Equivalent of BG = 0, FG = 15
    mov %ebx, ttypos
    mov [%ebx], %ax # Move the character into the tty pointer

    addw ttypos, 2 # Increment to the next character spot
    pop %ebx
    ret

// QOL macros

.macro put_char_al char
    call put_char_proc
.endm

.macro put_char char
    xor %eax, %eax
    mov %al, \char
    put_char_al \char
.endm

.macro put_char_safe char
    push %eax
    put_char \char
    pop %eax
.endm
/* #endregion */

/* #region String Out */
// Displaying a string on screen
put_string_proc:
    /* Clobbers
        EDX = String Address
    */
    cmpb [%edx], 0
    je _ps_proc_fin
    put_char [%edx] # Print at the address of the pointer
    inc %edx
    jmp put_string_proc
    _ps_proc_fin:
    ret

.macro put_string label
    lea %edx, \label
    call put_string_proc
.endm

.macro put_string_safe label
    push %ecx
    push %edx
    put_string \label
    pop %edx
    pop %ecx
.endm
/* #endregion */

/* #region UInteger Out */
// Displaying uints on screen
put_int_proc:
    /*
    Clobbers:
        EAX = number
        ECX
        EDX
    */
    push %ecx; push %edx

    push 10 # know when to stop, ten is the first 2 digit number (will never show up)
    _pip_slice:
    mov %ecx, 10
    xor %edx, %edx
    div %ecx # eax = number / 10, edx = number % 10
    push %edx # push remainder
    cmp %eax, 0 # check if zero
    jne _pip_slice
    
    _pip_print:
    pop %edx
    cmp %edx, 10
    je _pip_ret 
    add %dl, 48 # convert to char
    put_char %dl
    jmp _pip_print
    _pip_ret: 

    pop %edx; pop %ecx
    ret

.macro put_int num
    mov %eax, \num
    call put_int_proc
.endm

.macro put_int_safe num
    push %eax
    put_int \num
    pop %eax
.endm
/* #endregion */

.att_syntax