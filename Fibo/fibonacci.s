global  _start
extern  printf, scanf

section .data
    message db "Choisis un nombre", 0x0a
    message2 db "Edouard Lucas 1842-1891", 0x0a
    outFormat db  "%d", 0x0a, 0x00
    inFormat db  "%d", 0x00

section .bss
    userInput resb 1

section .text
_start:
    call printMessage   ; print intro message
    call getInput       ; get max number
    call initFib        ; set initial Fib values
    call loopFib        ; calculate Fib numbers
    call printEnd       ;Tribute to the man who named Fibonacci Sequence
    call Exit           ; Exit the program

printMessage:
    mov rax, 1          ; rax: syscall number 1
    mov rdi, 1          ; rdi: fd 1 for stdout
    mov rsi, message    ; rsi: pointer to message
    mov rdx, 18         ; rdx: print length of 29 bytes
    syscall             ; call write syscall to the intro message
    ret

getInput:
    sub rsp, 8          ; align stack to 16-bytes
    mov rdi, inFormat   ; set 1st parameter (inFormat)
    mov rsi, userInput  ; set 2nd parameter (userInput)
    call scanf          ; scanf(inFormat, userInput)
    add rsp, 8          ; restore stack alignment
    ret


initFib:
    xor rax, rax        ; initialize rax to 0
    xor rbx, rbx        ; initialize rbx to 0
    inc rbx             ; increment rbx to 1
    ret

printFib:
    push rax            ; push registers to stack
    push rbx
    mov rdi, outFormat  ; set 1st argument (Print Format)
    mov rsi, rbx        ; set 2nd argument (Fib Number)
    call printf         ; printf(outFormat, rbx)
    pop rbx             ; restore registers from stack
    pop rax
    ret

loopFib:
    call printFib       ; print current Fib number
    add rax, rbx        ; get the next number
    xchg rax, rbx       ; swap values
    cmp rbx, [userInput] ; do rbx userinput
    js loopFib		    ; jump if result is <0
    ret

printEnd:
     mov rax, 1          ; rax: syscall number 1
     mov rdi, 1          ; rdi: fd 1 for stdout
     mov rsi, message2    ; rsi: pointer to message
     mov rdx, 24         ; rdx: print length of 29 bytes
     syscall             ; call write syscall to the intro message
     ret

Exit:
    mov rax, 60
    mov rdi, 0
    syscall
