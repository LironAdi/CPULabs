        .data
arr:    .word 2,4,6,8,10
sum:    .word 0

        .text
        .globl main
main:
        la    $t0,arr
        li    $t1,5
        li    $t2,0

loop:
        lw    $t3,0($t0)
        add   $t2,$t2,$t3
        addi  $t0,$t0,4
        addi  $t1,$t1,-1
        bne   $t1,$zero,loop
        la    $t0,sum
        sw    $t2,0($t0)
finish:
        beq   $zero,$zero,finish
