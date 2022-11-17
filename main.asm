!cpu 6510
!to "game.prg",cbm

 
lastkey=$21
position = $20
 
attdec   =$31
susrel   =$32
volume   =$33
hifreq   =$34
lofreq   =$35
wavefm   =$36
whiteblock =$37
appleblock =$38
positionh =$6044
positionl =$6045
character =$4006
 
bgchar =$022
charactertemporary = $026
charactercolour = $27
objectschar = $28
objectspositionh = $29
objectspositionl = $30
scoreones =$40ff
scoretens =$40fe
sheet = $31
scorehunds = $40fd
*=$0801
        !byte    $1E, $08, $0A, $00, $9E, $20, $28,  $32, $30, $38, $30, $29, $3a, $8f, $20, $28, $43, $29, $20, $32, $30, $32, $31, $20, $4D, $54, $53, $56, $00, $00, $00
 
*=$0820
              
init lda #0
sta $d020
sta $d021
lda #$04
sta positionh
lda #90
sta character
lda #20
sta positionl
lda #02
sta charactercolour

 
lda #$18
sta $d018
          
lda #76
sta bgchar 
 
lda $01    
and #251    
sta $01    
 
copyoriginalchartonewlocation
 
sei
lda $d000,x
sta $2000,x
lda $d100,x
sta $2100,x
lda $d200,x
sta $2200,x
lda $d300,x
sta $2300,x
lda $d400,x
sta $2400,x
lda $d500,x
sta $2500,x
lda $d600,x
sta $2600,x
lda $d700,x
sta $2700,x
 
inx
 
 
beq stopcpy
jmp copyoriginalchartonewlocation
 
stopcpy  
         lda $01
         ora #4
         sta $01



         
         
mainloop
lda positionl
sta sheet

jsr cls
jsr scanjoy
jsr movejoy
inc whiteblock
inc objectspositionl
jsr objectsrule         
inc objectspositionl
inc objectschar         
jsr displayobjects
jsr display
jsr collision
jsr printscore
jsr mainloop
rts
scanjoy            
     
           lda $dc00
            
           sta lastkey
            cmp #$7f
            beq setdirection
          ; cmp #$6f
          ; beq setdirection 
       
           sta lastkey

           rts
setdirection	

 rts
joylock 

  lda lastkey
  cmp $dc00
  beq counttounlock

counttounlock
 
  
  
inx
lda $400,x
 lda $400,x
 lda $400,x
 lda $400,x
 lda $400,x
 lda $400,x
 lda $400,x
 lda $400,x
lda $400,x
 lda $400,x
 lda $400,x
 lda $400,x
 lda $400,x
 lda $400,x
 lda $400,x
 lda $400,x
 lda $400,x
 lda $400,x
 lda $400,x
 lda $400,x
 lda $400,x
 lda $400,x
afewer
 lda $400,x
 lda $400,x
 lda $400,x
 lda $400,x
 lda $400,x
 lda $400,x
 lda $400,x
 lda $400,x

 cpx #$ff
 bne joylock
 

 rts



cls
 
lda bgchar 

sta $0400,y  
sta $0500,y  
sta $0600,y  
sta $06f0,y
;iny
 
 
;rts
clscol
lda #6
sta $d800,y  
sta $d900,y  
sta $da00,y  
sta $daf0,y 
iny 
 ;bne clscol
rts


movejoy 
                
                lda lastkey
               
                cmp #$7b   
				beq left ;
				cmp #$7e   
				beq up
				cmp #$77    
				beq right
				cmp #$7d   
				beq down
                cmp #$6f
                beq shoot
				rts
				





left 
 
  jsr tickingsound
   
    lda positionl
    sec
    sbc #01
    sta positionl
  bcc counterrecount
 
 jsr joylock
   
     jsr display
     
    rts
counterrecount
jsr decreasehibyte
lda #255
sta positionl
rts
right 
 
 
jsr tickingsound
 lda positionl
    clc
    adc #01
    sta positionl
  bcs recount
 jsr joylock
    jsr display
   
    rts
recount
jsr incresehighbyte
lda #0
sta positionl
rts

down
 
  jsr tickingsound
   
   lda positionl
    clc
    adc #40
    sta positionl
    
    bcs incresehighbyte
 
 jsr joylock
 jsr display
 
  
    rts
up
 
 
jsr tickingsound
  lda positionl
    sec
    sbc #40
    sta positionl
   
 
 bcc decreasehibyte
 
 jsr joylock
  jsr display
 
rts
shoot

jsr expnoz
jsr display


lsr sheet

bcc decreasehibyte 
 

rts   			

decreasehibyte   
 
dec positionh
lda positionh
cmp #0
beq inchibyteagain
jsr display
 
rts




incresehighbyte   

inc positionh
lda positionh
cmp #5
beq dechibyteagain
jsr display
 
rts
dechibyteagain

lda #01
sta positionh
increaselowbyte
 lda positionl
adc #23
 sta positionl


rts


inchibyteagain
lda #04
sta positionh
decreaselowbyte

lda positionl
sbc #24
sta positionl
rts
display 

 
lda positionh
ldx positionl
cmp #$01
beq displaypageone
cmp #$02
beq displaypagetwo 
cmp #$03
beq displaypagethree  
cmp #$04
beq displaypagefour  
    
    
rts 
displaypageone

lda character
sta $0400,x
lda charactercolour
sta $d800,x
 
rts
displaypagetwo

lda character 
sta $0500,x
lda charactercolour
sta $d900,x
 
rts
displaypagethree
 
lda character 
sta $0600,x
lda charactercolour
sta $da00,x
 
rts


displaypagefour
 

lda character
sta $0700,x
lda charactercolour
sta $db00,x
 
rts
objectsrule
clc

jsr lazbeep3 

;lda positionl

inc objectspositionl
lda objectspositionl
adc sheet
adc objectspositionl
sta objectspositionl 
 
 
bcs increaseobjecthighbyte
 ;jsr counttounlock

rts
increaseobjecthighbyte
inc objectspositionh
cmp #04 
beq objecthighreset

rts
objecthighreset
lda #0
sta objectspositionh
rts

displayobjects 
lda objectspositionh
ldx objectspositionl
cmp #$01
beq displayobjectsone
cmp #$02
beq displayobjectstwo
cmp #$03
beq displayobjectsthree
cmp #$04
beq displayobjectsfour

rts



displayobjectsone

lda objectschar
sta $0400,x
ldx objectspositionl
lda #$03
sta $d800,x
 
rts
displayobjectstwo

lda objectschar
sta $0500,x
ldx objectspositionl
lda #$03
sta $d900,x
 
rts
displayobjectsthree
 
lda objectschar
sta $0600,x
ldx objectspositionl
lda #$03
sta $da00,x
 
rts


displayobjectsfour
 

lda objectschar
sta $0700,x
ldx objectspositionl
lda #$03
sta $db00,x
 
rts

collision
 ldx #$d0
jsr joylock
lsr sheet
lda objectspositionl

cmp positionl
beq addscore
 
 
decreasescore
 
rts
addscore		clc
				lsr objectspositionl
				inc scoreones
				jsr lazbeep1
			 
				 
				
 
				
				lda scoreones
				sec
				sbc #10
				 
				cmp #$ 
				beq addtens		
				rts

addtens			inc scoretens
				lda #00
				sta scoreones
			    lda scoretens
			    sec
				sbc #10
			    cmp #$
			    beq addhunds
				rts 
addhunds        inc scorehunds
                lda #00
				sta scoreones
				lda #00
				sta scoretens
				rts
				
printscore		 
				
			  
				clc
				lda scoreones
				adc #$30
				
				sta $0468
				lda #01 
				sta $d868
				lda scoretens
				adc #$30
				sta $0467
				lda #01
				sta $d867
				lda scorehunds
				adc #$30
				sta $0466
				lda #01
				sta $d866	
				rts


 
 !source "sounds.asm"

