BITS 16                 ; We're in 16-bit mode

start:                  ; Entry point
    mov ax, 0x07C0      ; Set up segment registers, sets valie of regiser AX to 0x07C0. The AX register is a 16-bit general-purpose register.
    mov ds, ax          ; Sets the Data Segment (DS) register to the value in AX.
    mov es, ax          ; Sets the Extra Segment (ES) register to the value in AX.
    mov ss, ax          ; Sets the Stack Segment (SS) register to the value in AX.
    mov sp, 0x7C00      ; Sets the Stack Pointer (SP) register to 0x7C00.

    ; Print "Hello, World!" on the screen
    mov si, hello_msg   ;  Load the address of hello_msg into the Source Index (SI) register. SI will be used to point to the message string.

print_char:             ; Label for the start of the loop that prints each character.
    lodsb               ; Load the byte at address [SI] into the AL register and increment SI.
    cmp al, 0           ; Check if it's the null terminator
    je done             ; If AL is 0, jump to the done label.

    mov ah, 0x0E        ; Set AH to 0x0E, which is the BIOS teletype output function.
    int 0x10            ; Call BIOS interrupt 0x10 to print the character in AL.

    jmp print_char      ; Jump back to print_char to print the next character.

done:                   ; Label to mark the end of the printing loop.
    hlt                 ; Halt the CPU

hello_msg db 'Hello, World!', 0     ; Define the string hello_msg with a null terminator.

times 510-($-$$) db 0   ; Fill the rest of the 512-byte sector with zeros. `510-($-)calculates the number of remaining bytes up to 510, anddb 0` fills those bytes with zeros.
dw 0xAA55               ; Add the boot signature 0xAA55 at the end of the sector. This is required for the BIOS to recognize the sector as bootable.

