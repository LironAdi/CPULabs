        .data
Mat1:   .word  1,2,3,4, 5,6,7,8, 9,10,11,12, 13,14,15,16
Mat2:   .word  13,14,15,16, 9,10,11,12, 5,6,7,8, 1,2,3,4
resMat: .space 64          # 16 words × 4 bytes

        .text
        .globl main
main:
        la    $a0,Mat1       # &Mat1
        la    $a1,Mat2       # &Mat2
        la    $a2,resMat     # &resMat
        jal   addMats
finish:
        beq   $zero,$zero,finish

addMats:
        # אין צורך בשמירה על ra או s-registers—chorus פשוטים
        add   $s0,$a0,$zero  # s0 =&Mat1
        add   $s1,$a1,$zero  # s1 =&Mat2
        add   $s2,$a2,$zero  # s2 =&resMat

        addi  $t0,$zero,0    # i = 0
        addi  $t3,$zero,4    # M = 4

outer:
        addi  $t1,$zero,0    # j = 0

inner:
        sll   $t2,$t0,2      # t2 = i*4
        add   $t2,$t2,$t1    # t2 = i*4 + j
        sll   $t2,$t2,2      # t2 = (i*4+j)*4

        add   $t4,$s0,$t2
        lw    $t5,0($t4)     # Mat1[i][j]
        add   $t4,$s1,$t2
        lw    $t6,0($t4)     # Mat2[i][j]
        add   $t5,$t5,$t6    # sum
        add   $t4,$s2,$t2
        sw    $t5,0($t4)     # resMat[i][j]

        addi  $t1,$t1,1
        slt   $at,$t1,$t3
        bne   $at,$zero,inner

        addi  $t0,$t0,1
        slt   $at,$t0,$t3
        bne   $at,$zero,outer

        jr    $ra            # חזור ל־main
