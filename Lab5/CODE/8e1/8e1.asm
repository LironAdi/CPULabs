        .data
val:    .word 5
res:    .word 0

        .text
        .globl main
main:
        la    $t0, val        # load address of val
        lw    $t1, 0($t0)     # t1 = val
        sll   $t2, $t1, 2     # t2 = t1 << 2  (shift using the shifter)
        la    $t0, res        # load address of res
        sw    $t2, 0($t0)     # store shifted result into res

finish:
        beq   $zero, $zero, finish   # infinite loop