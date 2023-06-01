.model small
.stack 100h

.data
    msg1 db "ele336 Final Prework Code: Please enter the first letter of your firstname in uppercase$"
    msg2 db "You have entered "
    msg3 db 0
    msg4 db "Click one mouse button of your choice to display this letter with white color on the screen$"
    msg5 db 0

.code
    ; Entry point of the program
    mov ax, @data
    mov ds, ax    
     
    mov ax,0
    mov bx,1
    int 33h

userinput:
    ; Display the first message
    mov ah, 09h
    lea dx, msg1
    int 21h

    ; Read the user input
    mov ah, 01h
    int 21h
    mov bl, al
    
    
    cmp al,59h
    ; Display the second message with the entered letter
    jne userinput
    mov ah, 09h
    lea dx, msg2
    int 21h
    
    

    ; Display the entered letter
    mov ah, 02h
    mov dl, bl
    int 21h
 
    
    
    ; Set video mode 13h (320x200, 256 colors)
    mov ax, 0013h
    int 10h 
    ; Set mouse interrupt
    mov ax, 0
    int 33h
    je check_mouse_click
    


    
check_mouse_click:
    
    lea dx, msg4     ; Load address of message 4 to DX register
    mov ah, 09h      ; Move 09h (ASCII string output) to AH register
    int 21h          ; Generate interrupt 21h to display message 4

wait_for_mouse_click:
    ; Wait for mouse click
    mov ax, 3        ; Get mouse status
    int 33h          ; Generate interrupt 33h to get mouse status
    cmp bx, 1        ; Test if left mouse button was clicked (1 means clicked, 0 means not clicked)
    jne wait_for_mouse_click ; Jump back to wait_for_mouse_click label if the left mouse button was not clicked
    je first_letter_display

first_letter_display:
    mov ax, 0600h ; Scroll window up
    mov bh, 07h ; Normal display attribute
    mov cx, 0000h ; Coordinates of top left
    mov dx, 184Fh ; Coordinates of bottom right
    int 10h
    
    mov ah, 00h ; Set video mode
    mov al, 13h ; Set VGA Graphic mode
    int 10h
    
    mov cx, 150
    mov dx, 100
    
    A1: 
        mov ah, 0Ch
        mov al, 0Fh
        int 10h
        
        inc cx
        dec dx
        cmp cx, 175 
        jnz A1
        mov cx, 150
        mov dx, 100
    A2: 
        mov ah, 0Ch
        mov al, 0Fh
        int 10h
        
        dec cx
        dec dx
        cmp cx, 125 
        jnz A2
        mov cx, 150
        mov dx, 100
    A3: 
        mov ah, 0Ch
        mov al, 0Fh
        int 10h
        
        inc dx
        cmp dx, 125 
        jnz A3
        
        
exit_program:
    ; Halt the program
    mov ah, 4Ch     ; Exit program
    mov al, 0
    int 21h
