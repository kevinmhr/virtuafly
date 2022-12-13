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
scorethous = $40fa 
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
lda #03
sta charactercolour
lda #0
sta scoreones
sta scoretens 
sta scorehunds
lda #$18
sta $d018
 lda #01
 sta objectspositionh
lda #76
sta bgchar 
sta objectschar
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


lda circle1 
sta $2260 
lda circle2 
sta $2261 
lda circle3 
sta $2262 
lda circle4 
sta $2263  
lda circle5 
sta $2264 
lda circle6 
sta $2265  
lda circle7 
sta $2266 
 lda circle8 
sta $2267         
         
mainloop
 
 jsr charanim
 
 
 jsr cls
 

jsr scanjoy

jsr movejoy
 jsr cls

inc objectschar      

jsr objectsrule       
 
 
jsr display
jsr displayobjects
jsr printscore
 
jsr mainloop
rts
 
charanim

 inc $2260 
 
         inc $2261
 inc $2262
 
  inc $2263 
 
  inc $2264
  inc $2265
  inc $2266
    inc $2267
 
 
  rts
  
        


scanjoy            
     
           lda $dc00
            
           sta lastkey
            cmp #$7f
            beq setdirection
          ; cmp #$6f
          ; beq setdirection 
    inc $2260 
 
         inc $2261
 inc $2262
 
  inc $2263 
 
  inc $2264
  inc $2265
  inc $2266
    inc $2267
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
 
 
;rts
clscol
;lda #6
adc #3
inx
sta $d800,x  
sta $d900,x  
sta $da00,x  
sta $daf0,x 
iny 
inx
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
 jsr collision
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
 jsr collision
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
 jsr collision
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
 jsr collision
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
 

 
 
 jsr lazbeep3 
 

 iny
 iny
 iny
 
 
  
lda objectspositionl  
jsr increaseobjecthighbyte
 
sta objectspositionl  
 
 
 

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
 inc charactercolour
 
 
ldy positionl
     
cpy objectspositionl
 

 
beq addscore
  ldx #$d0
 jsr joylock
rts 
 
zeroscore
lda #0
sta scoreones
rts
addscore		clc
				 
				
				inc scoreones
				jsr expnoz
			 
                lda objectspositionl
                adc #122
              
                 sta objectspositionl
 
               inc objectschar
				
				lda scoreones
				sec
				sbc #10
			 
				cmp #$ 
				beq addtens
			     jsr joylock
				jsr mainloop
				rts

addtens			 
                inc scoretens
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
				lda scorehunds
			    sec
				sbc #10
			    cmp #$
			    beq addthous
			 
				rts 

				rts
addthous        inc scorethous
                lda #00
				sta scoreones
				lda #00
				sta scoretens
			    lda #00
				sta scorehunds
			 
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
				lda scorethous
				adc #$30
				sta $0465
				lda #01
				sta $d865	
				rts
 
charboxscr
         !byte 1,2,3,4,41,42,43,44,81,82,83,84,121,122,123,124

circle1
 !byte %0011100
circle2 
 !byte %0100010
circle3 
 !byte %1000001
circle4 
 !byte %1000001
circle5 
 !byte %1000001
circle6 
 !byte %0100010
circle7 
 !byte %0011100
circle8 
 !byte %0000000
 
 !source "sounds.asm"

