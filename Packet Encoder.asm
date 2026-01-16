.data

.align 4
OUTBUF:    .space 128      # output packet buffer

PromptLen: .asciiz "\nPacket length (v0): "
Newline:   .asciiz "\n"

LengthPrompt: .asciiz "Enter the length of the domain name "
DomainPrompt: .asciiz "Enter the domain name "

.text
main:
    # Set up inputs
    la  $a0, LengthPrompt      # input domain name length
    li $v0, 4
    syscall                     #print prompt
    li $v0, 5
    syscall                     #reads int into $v0
    move $a1, $v0            
    la $a0, Newline               
    li $v0, 4                   # Creates a new line
    syscall
    la $a0, DomainPrompt         
    li $v0, 4
    syscall                     #print domain name prompt
    li $v0, 8
    syscall                     #read string into $a0
    la  $a1, OUTBUF       # output buffer start
    li  $a2, 0x1234       # transaction ID (low 16 bits used)

    # -------------------------------------------------
    # Call your DNS encoding code here
    # Either:




    #Header
    move $t5, $a1 # copies contents of $a1 to $t5
    srl $t0, $a2, 8 
    sb $t0, 0($t5)
    addiu $t5, $t5, 1

    sll $t0, $t0, 8
    sub $t0, $a2, $t0
    sb $t0, 0($t5)

    addiu $t5, $t5, 1  

    addiu $t0, $zero, 0x01 
    sb $t0, 0($t5)
    addiu $t5, $t5, 1

    addiu $t0, $zero, 0x00
    sb $t0, 0($t5)
    addiu $t5, $t5, 1


    addiu $t0, $zero, 0x00 
    sb $t0, 0($t5)
    addiu $t5, $t5, 1

    addiu $t0, $zero, 0x01
    sb $t0, 0($t5)
    addiu $t5, $t5, 1


    addiu $t0, $zero, 0x00
    sb $t0, 0($t5)
    addiu $t5, $t5, 1
 

    sb $t0, 0($t5)
    addiu $t5, $t5, 1
 

    sb $t0, 0($t5)
    addiu $t5, $t5, 1

    sb $t0, 0($t5)
    addiu $t5, $t5, 1

    sb $t0, 0($t5)
    addiu $t5, $t5, 1

    sb $t0, 0($t5)
    addiu $t5, $t5, 1
 

    li $t7, 16 # total bytes of packets (header(12) + QNAME + QTYPE(2) + QCLASS(2))
    li $t0, 0x2e
    li $t1, 0 # length pointer
    move $t2, $t5 #reserves address for length
    move $t4, $a0 # copies contents of $a0 to $t4
    
    addiu $t5, $t5, 1
    b loop

next:
    sb $t1, 0($t2)
    addu $t7, $t7, $t1
    addiu $t7, $t7, 1 # adds byte storing length of the label
    move $t2, $t5 #reserves address for length
    addiu $t5, $t5, 1 #points to next letter in domain name
    addiu $t4, $t4, 1
    li $t1, 0
    b loop 

loop:
    lb $t3, 0($t4)
    beq $t3, $t0, next
    beq $t3, $zero, exitloop
    addiu $t1, $t1, 1
    sb $t3, 0($t5)
    addiu $t5, $t5, 1
    addiu $t4, $t4, 1
    
    b loop

exitloop:
    sb $t1, 0($t2)
    addu $t7, $t7, $t1 # updates total number of bytes after last section is complete
    addiu $t7, $t7, 2 # adds length of null pointer (1 byte) and length of final label (1 byte)
    move $v0, $t7
    li $t6, 0x00 #null pointer
    sb $t6, 0($t5)
    addiu $t5, $t5, 1
    #QTYPE
    li $t6, 0x00
    sb $t6, 0($t5)
    addiu $t5, $t5, 1

    li $t6, 0x01
    sb $t6, 0($t5)
    addiu $t5, $t5, 1

    #QCLASS
    li $t6, 0x00
    sb $t6, 0($t5)
    addiu $t5, $t5, 1

    li $t6, 0x01
    sb $t6, 0($t5)
    addiu $t5, $t5, 1
    
    





   
    # -------------------------------------------------
    # delete this line and insert your code / jal
               # placeholder, REMOVE THIS
    # -------------------------------------------------

    move $s0, $v0         # save packet length

    # Print packet length
    la   $a0, PromptLen
    li   $v0, 4
    syscall

    li   $v0, 1           # print integer
    move $a0, $s0
    syscall

    la   $a0, Newline
    li   $v0, 4
    syscall

    li   $v0, 10          # exit
    syscall