smiley 
ldx #0
smileyloop
inx
      lda #170
      sta $059d,x
      sta $05a5,x
      lda #2
      sta $d99d,x
      sta $d9a5,x
     lda #126
     sta $061b
      sta $0643
      sta $066b
       lda #7
       sta $da1b
      sta $da43
      sta $da6b
      
    
      lda #128
       sta $061d
       sta $0619
        sta $da1d
       sta $da19
cpx #4

bne smileyloop
rts
smiley2
ldx #0
smileyloop2
inx
     lda #171
     sta $05ee,x
      sta $05f6,x
         lda #3
        sta $d9ee,x
      sta $d9f6,x
    lda #127
     sta $05c4,x
      sta $05c9,x
      sta $05cc,x
      sta $05d1,x
      lda #2
      sta $d9c4,x
      sta $d9c9,x
      sta $d9cc,x
      sta $d9d1,x

cpx #2

bne smileyloop
rts
circle !byte 0,2,40,81,122,162,178,138,99,59,19

drawcircle
ldx #0
ldy #0
drawcircleloop

ldx circle,y
iny
      lda #126
      sta $059a,x
      sta $d99a,x
    sta $054a,x
      sta $d94a,x
      cpy #11
      bne drawcircleloop
     rts

lips 
ldx #0
lipsloop
inx
lda #128
sta $06b8,x
sta $06e0,x
cpx #5
bne lipsloop
rts
face 
jsr smiley
jsr smiley2
jsr drawcircle
jsr lips
rts
display 
ldx #$0
ldy #0

displayloop
inx
lda positionh
ldy positionl
cmp #$01
beq displaypageone
cmp #$02
beq displaypagetwo 
cmp #$03
beq displaypagethree  
cmp #$04
beq displaypagefour  
 cpx #$ff
 bne displayloop
    
rts 
displaypageone

lda character 
sta $0400,y
lda character1 
sta $0401,y
lda character2 
sta $0428,y
lda character3 
sta $0429,y
lda charactercolour
sta $d800,y
sta $d801,y
sta $d828,y
sta $d829,y

rts
displaypagetwo

lda character 
sta $0500,y
lda character1 
sta $0501,y
lda character2 
sta $0528,y
lda character3 
sta $0529,y
lda charactercolour
sta $d900,y
sta $d901,y
sta $d928,y
sta $d929,y
 
rts
displaypagefour
 

lda character
sta $0700,y
lda character1 
sta $0701,y
lda character2 
sta $0728,y
lda character3 
sta $0729,y
lda charactercolour
sta $db00,y
sta $db01,y
sta $db28,y
sta $db29,y

rts

displaypagethree
 
lda character
sta $0600,y
lda character1 
sta $0601,y
lda character2 
sta $0628,y
lda character3 
sta $0629,y
lda charactercolour
sta $da00,y 
sta $da01,y
sta $da28,y
sta $da29,y
 
rts



 
 
