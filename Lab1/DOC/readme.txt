Lab 1 

in the following code we implement system design Micro-Architecture on three sub-models, Adder\Subtractor, Shifter and Boolean logic.

input ALUFN[4:3] will define which operation will be performed by the system.

Adder\Subtractor when ALUFN[4:3]= "01" :
the following operation will be executed by ALUFN[2:0]:
"000" operation Res=Y+X 
"001" operation Res=Y-X
"010" operation Res=neg(X)
"011" operation Res= Y+1 
"100" operation Res=Y-1 

Shifter when ALUFN[4:3]="10": 
the following operation will be execute by ALUFN[2:0]:
"000" shift left
"001" shift right

Boolean Logic when ALUFN[4:3]="11":
the following operation will be execute by ALUFN[2:0]:
"000"  operation Res=not(Y)
"001"  operation Res=Y or X
"010"  operation Res=Y and X
"011" operation Res=Y xor X
"100" operation Res=Y nor X
"101"  operation Res=Y nand X
"111" operation Res=Y xnor X

inputs: 
Y length n
X length n
ALUFN length 5

outputs:
ALUout length n
flags: Overflow- V , Zero- Z, Carry- C, Negative- N

# done by Shahar Golombek and Liron Adi 

