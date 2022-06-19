    .file   "find_max_template.c"
    .text
    .section .rodata
    .align 8
    .LC0:
    .string "The length of the array is %d\n"
    .text
    .globl Find_Max
    .type Find_Max, @function
Find_Max:
// prologue - write code for the prologue here
    endbr64  
//Push Calle Saved Regs
    pushq   %rbp 
    pushq   %r12
    pushq   %rbx
//Move stack pointer into base pointer
    movq    %rsp,       %rbp
//Seperate pointers by 40
    subq    $40,        %rsp
// printf("The length of the array is %d\n", n);
// update this code if necessary to print the length of the array
// this block prints the value of register %edi
// initially the parameter n
    movq    %rsi,       %rbx     #save original rsi
    movq    %rdi,       %r12     #save original rdi
    movl    %edi,       %eax
    movl    %eax,       %esi
    leaq .LC0(%rip),    %rdi
    movl    $0,         %eax
    call    printf@PLT
    movq    %rbx,       %rsi     #return value of rsi
    movq    %r12,       %rdi     #return value of rdi
// reserve space for local variables
    movq    %rdi,       %rbx      #move length or rbx
    movq    %rbx,       -28(%rbp) #move length to stack
    movl    $0,         %edx      #move zero for maximum index
    movl    %edx,       -8(%rbp)  #store on stack
    movl    $0,         %edx      #reset to zero
    movl    %edx,       -12(%rbp) #move zero to stack
    movl    $1,         -16(%rbp) #set index one for counter
    movq    %rsi,       -24(%rbp) #move base of array to stack
    
// write your code to find the index of the maximum value here
//SETUP FOR LOOP ITERATION 1
Top_Of_Loop:
    movq    -24(%rbp),  %rsi      #get array base
    movq    $0,         %rdx      #set top 32 bits of rdx to zero
    movl    -8(%rbp),   %edx      #load index value in; i
    movl    (%rsi, %rdx, 4), %eax #load value pf arr[max_index] in to eax
    movq    -24(%rbp),  %rsi      #reload array base
    movq    $0, %rdx              #set top bits to zero
    movl    -16(%rbp),  %edx      #load index in
    movl    (%rsi, %rdx, 4), %ecx #load array[i] in
    movq    -12(%rbp),  %rdx      #Literally does nothing important
   
Loop_Condition:
    movl    -16(%rbp),  %edx      #Load counter into edx
    movq    $0,         %rbx      #set top bits to zero
    movl    -28(%rbp),  %ebx      #move array length into ebx
//if counter == array length stop loop, otherwise continue with loop
    cmp     %edx,       %ebx
    je      End

Max_Condition:
//Same as earlier, move array values into registers for comparison
//Move array[i] in to ecx
    movq    $0,         %rdx 
    movl    -8(%rbp),   %edx
    movq    -24(%rbp),  %rsi
    movl    (%rsi, %rdx, 4), %ecx
//Load array[max_index] into eax
    movq    $0,         %rdx
    movl    -16(%rbp),  %edx
    movq    -24(%rbp),  %rsi
    movl    (%rsi, %rdx, 4), %eax
//if array[i] > array[max_index] than goto New_Max, otherwise go to iterate.
    cmp     %ecx,       %eax
    jg      New_Max
    jmp     Iterate

//IF arr[i] !> arr{max_index] only increment i by 1
Iterate:
    movq    $0,         %rdx        #Set top bits to zero
    movl    -16(%rbp),  %edx        #load in value of i
    addl    $1,         %edx        #add one to val
    movl    %edx,       -16(%rbp)   #move back into stack
    jmp     Loop_Condition          #goto recheck loop condition

//IF new max is found at next index than change the value of max_index and increment i
New_Max:
    movq    $0,         %rdx        #set top bits to zero
    movl    -16(%rbp),  %edx        #move i into reg
    movl    %edx,       -8(%rbp)    #move i into max_index location on stack
    addl    $1,         %edx        #add one to i(Counter)
    movl    %edx,       -16(%rbp)   #move i back onto stack
    jmp     Loop_Condition          #goto recheck loop condition

End:
    movl    -8(%rbp),   %eax        #move return value of max_index to eax
// epilogue - complete the epilogue below
    addq    $40,        %rsp        #add to move stack pointer back to base pointer
    popq    %rbx                    #pop base pointer back
    popq    %r12                    #pop r12 value back
    popq    %rbp                    #pop val of rbx back
    ret                             #return
.LFE0:
    .size Find_Max, .-Find_Max
    .ident "GCC: (Ubuntu 9.3.0-17ubuntu1~20.04) 9.3.0"
    .section .note.GNU-stack,"",@progbits
    .section .note.gnu.property,"a"
    .align 8
    .long  1f - 0f
    .long  4f - 1f
    .long  5
0:
    .string  "GNU"
1:
    .align 8
    .long  0xc0000002
    .long  3f - 2f
2:
    .long  0x3
3:
    .align 8
4:

