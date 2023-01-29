!cpu 6510
!to "virtuafly.prg",cbm
;designed by keyvan mehrbakhsh 2023
;keyvanmehrbakhsh@gmail.com
;its free to alter 
 
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
character1 =$4007
character2 =$4008
character3 =$4009
fourty = $6387
bgchar =$022
bgcolor =$024
charactertemporary = $026
charactercolour = $27
objectschar1 = $6677
objectschar2 = $6689
objectschar3 = $6643
objectschar4 = $6699
bulletchar =$6634
objectspositionh = $29
objectspositionl = $30
bulletpositionh = $6848
bulletpositionl = $6248
scoreones =$40ff
scoretens =$40fe
voicefreq = $31
scorehunds = $40fd
scorethous = $40fa 
bulletcolor = $2055
objecbuffer = $6a00
clscount = $4a00
*=$0801
        !byte    $1E, $08, $0A, $00, $9E, $20, $28,  $32, $30, $38, $30, $29, $3a, $8f, $20, $28, $43, $29, $20, $32, $30, $32, $31, $20, $4D, $54, $53, $56, $00, $00, $00
 
*=$0820
              
init lda #0
sta $d020
sta $d021
lda #$04
sta positionh
lda #125
sta character
lda #109
sta character1
lda #105
sta character2
lda #95
sta character3
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
 lda #02
 sta objectspositionh
 lda #02
 sta objectspositionl
  lda #$04
 sta bulletpositionh
lda #76
sta bgchar 
lda #2
sta bgcolor 
lda #73
sta objectschar1
lda #85
sta objectschar2
lda #74
sta objectschar3
lda #75
sta objectschar4
lda #33
sta bulletchar
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
 

ldx #0
clear6a00
inx
lda #0
sta $6a00
cpx #$ff
bne clear6a00
   
loadenemies  
inx
lda somenum,x
 sta objecbuffer,x
 cpx #$ff
 bne loadenemies

mainloop
   jsr charanim
 ldy #0
 jsr cls
objectsdisplayed
lda clscount
 eor clscount
 sta clscount
   ror clscount

 
 


 
 inc objectschar1
  inc objectschar2
   inc objectschar3
    inc objectschar4
 
jsr scanjoy
 
 inc voicefreq
 

jsr movejoy

 

inc charactercolour
 

 jsr displaybullet
 
 


 
 
 

 
  



jsr printscore

 jsr displayobjects 
jsr display
 

 
jmp mainloop
rts
wastetime
  inx 
 
 
 cpx    #0
 bne wastetime
 
 
rts




charanim
 
 
 ror $2260 
 
         ror $2261
 ror $2262
 
  ror $2263 
 
  ror $2264
 ror $2265
  ror $2266
    ror $2267
 
  rts
  
cls
 
iny
 
 
 
 
 
 lda bgchar 
sta $0400,y  
sta $0500,y  
sta $0600,y  
sta $06f0,y
 
 
lda bgcolor
 
 
sta $d800,y  
sta $d900,y  
sta $da00,y 
sta $daf0,y 
 
 
 cpy #0
 bne cls

 rts
cls3
 
 
 
 iny
 lda bgchar 
sta $0400,y  
sta $0500,y  
sta $0600,y  
sta $06f0,y
 
 
lda bgcolor
 
 
sta $d800,y  
sta $d900,y  
sta $da00,y 
sta $daf0,y 
 
  
 iny
 lda bgchar 
sta $0400,y  
sta $0500,y  
sta $0600,y  
sta $06f0,y
 
 
lda bgcolor
 
 
sta $d800,y  
sta $d900,y  
sta $da00,y 
sta $daf0,y 
 
 
 
 

 rts
cls2
 
 iny
 tya 
 adc #40
 tay
 lda bgchar 
sta $0400,y  
sta $0500,y  
sta $0600,y  
sta $06f0,y
 
 
 
 
 
;rts
clscol
;lda #6
 
lda bgcolor
 
 
sta $d800,y  
sta $d900,y 
sta $da00,y 
sta $daf0,y 
 
 

 rts

scanjoy            
          
           lda $dc00
          
            sta lastkey
           
         cmp #$6f
               beq fire
            cmp #$7f
            beq storekey
               
           sta lastkey
 
           rts
fire	
   jsr collision
    jsr collision
  inc bulletcolor
  jsr lazbeep1 
 
 

 
notascore
  
 jsr wastetime
 
jsr displaybullet

lda #$7f
sta lastkey
 

rts

storekey 
 
 sta lastkey
  lda positionl
sta bulletpositionl

 lda positionh
sta bulletpositionh
    
 
rts

readyforshoot

 
 

 jsr lazbeep2

 
 
 jsr displaybullet
 

 
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
               
				rts
				



left 
  
 

  jsr tickingsound
   
    lda positionl
    sec
    sbc #01
    sta positionl
   
  bcc counterrecount
 
 
    
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
 
 
 
 jsr display
 
  
    rts
up
 
 
jsr tickingsound
  lda positionl
    sec
    sbc #40
    sta positionl
 
   
 
 bcc decreasehibyte
    
  jsr display
 
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
lda character1 
sta $0401,x
lda character2 
sta $0428,x
lda character3 
sta $0429,x
lda charactercolour
sta $d800,x
sta $d801,x
sta $d828,x
sta $d829,x
 
rts
displaypagetwo

lda character 
sta $0500,x
lda character1 
sta $0501,x
lda character2 
sta $0528,x
lda character3 
sta $0529,x
lda charactercolour
sta $d900,x
sta $d901,x
sta $d928,x
sta $d929,x
 
rts
displaypagethree
 
lda character
sta $0600,x
lda character1 
sta $0601,x
lda character2 
sta $0628,x
lda character3 
sta $0629,x
lda charactercolour
sta $da00,x
sta $da01,x
sta $da28,x
sta $da29,x
 
rts


displaypagefour
 

lda character
sta $0700,x
lda character1 
sta $0701,x
lda character2 
sta $0728,x
lda character3 
sta $0729,x
lda charactercolour
sta $db00,x
sta $db01,x
sta $db28,x
sta $db29,x
rts
 
 

 
 

 
 
 
 
 
resetobjecthighbyte 
inc objectspositionh
lda objectspositionh
cmp #04 
beq objecthighreset
inc objectspositionh
rts
objecthighreset
lda #0
sta objectspositionh
inc objectspositionh
rts
 
 
 

 
reloadposition

lda positionh
sta bulletpositionh
 
rts

decrbulletpositionh




dec bulletpositionh
 
 
 
rts
displaybullet
 


ldx bulletpositionl
sec
txa
sbc #40
  tax
stx bulletpositionl
  bcc decrbulletpositionh
 stx bulletpositionl
 
 
  

 ldx bulletpositionl
   
lda bulletpositionh
cmp #$01
beq displaybulletpg1
cmp #$02
beq displaybulletpg2
cmp #$03
beq displaybulletpg3 
cmp #$04
beq displaybulletpg4

 

 
 
returntomain
 
rts
collision
inx
lda bulletpositionl
cmp #$0
beq jumptonotascore
cmp objecbuffer,x
beq score
cpx #$ff
bne collision
rts
score
lda #0
sta objecbuffer,x

jsr addscore

rts 
jumptonotascore
jsr notascore
rts
displaybulletpg1

lda bulletchar
sta $0400,x
 sta $0401,x
lda bulletcolor
sta $d800,x
 sta $d801,x
 


rts
displaybulletpg2
 
lda bulletchar
sta $0500,x
sta $0501,x
lda bulletcolor
sta $d900,x
sta $d901,x
 
rts
displaybulletpg3
 
 
 
lda bulletchar

sta $0600,x
 sta $0601,x
lda bulletcolor
sta $da00,x
 sta $da01,x
  
 rts


displaybulletpg4
ldx bulletpositionl

lda bulletchar
sta $0700,x
 
 sta $0701,x
lda bulletcolor
sta $db00,x
 sta $db01,x
 
 rts

 
displayobjects 
 
 
iny 
 
ldx objecbuffer,y 

 
lda objectschar1

lda objectschar1
sta $0500,x
lda objectschar2
sta $0501,x
lda objectschar3
sta $04d8,x
lda objectschar4
sta $04d9,x
lda charactercolour
sta $d900,x
sta $d901,x
sta $d8d8,x
sta $d8d9,x
 
 cpy #$20
 
 
 bne displayobjects
 

rts
backtoloop
jsr objectsdisplayed
rts
 
displayobjectstwo

lda objectschar1
sta $0500,x
lda objectschar2
sta $0501,x
lda objectschar3
sta $04d8,x
lda objectschar4
sta $04d9,x
lda charactercolour
sta $d900,x
sta $d901,x
sta $d8d8,x
sta $d8d9,x
 
rts
displayobjectsthree
 
lda objectschar1
sta $0600,x
lda objectschar2
sta $0601,x
lda objectschar3
sta $05d8,x
lda objectschar4
sta $05d9,x
lda charactercolour
sta $da00,x
sta $da01,x
sta $d9d8,x
sta $d9d9,x
 
rts


displayobjectsfour
 

lda objectschar1
sta $0700,x
lda objectschar2
sta $0701,x
lda objectschar3
sta $06d8,x
lda objectschar4
sta $06d9,x
lda charactercolour
sta $db00,x
sta $db01,x
sta $dad8,x
sta $dad9,x
rts
 

     
 
 

 

 
zeroscore
lda #0 
sta scoreones
lda #0
sta scoretens
rts
addscore		clc
			
				inc bgcolor
				inc scoreones
				jsr expnoz
			
              
                jsr charanim
			 
				lda scoreones
			 
				sec
				sbc #10
			 
				cmp #$ 
				beq addtens
			    
           
        
			 
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
 
somenum
         !byte  0,25,50,75,100,125,150,175,200,225,250,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0                

circle1
 !byte %0000000
circle2 
 !byte %0000000
circle3 
 !byte %0000000
circle4 
 !byte %0001000
circle5 
 !byte %0000000
circle6 
 !byte %0000000
circle7 
 !byte %0000000
circle8 
 !byte %0000000
 
 
 


  
 
 !source "sounds.asm"

