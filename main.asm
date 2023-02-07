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
oppbulletchar =$6635
opposebulletposl = $6249
opposebulletposh = $6250
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
objecbuffer = $6c00
clscount = $4a00
*=$0801
        !byte    $1E, $08, $0A, $00, $9E, $20, $28,  $32, $30, $38, $30, $29, $3a, $8f, $20, $28, $43, $29, $20, $32, $30, $32, $31, $20, $4D, $54, $53, $56, $00, $00, $00
 
*=$0820
              

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

copysomecharacters
ldy #0
copysomecharactersloop

lda theship,y
sta $2268,y
lda theship2,y
sta $2270,y
lda theship3,y
sta $2278,y
lda theship4,y
sta $2280,y
iny
 
bne copysomecharactersloop

 
init lda #0
sta $d020
sta $d021
lda #$04
sta positionh
lda #77
sta character
lda #79
sta character1
lda #78
sta character2
lda #80
sta character3
lda #21
sta positionl
lda #03
sta charactercolour
lda #0
sta scoreones
sta scoretens 
sta scorehunds
sta scorethous
lda #$18
sta $d018
 lda #02
 sta objectspositionh
lda #00
 sta bulletpositionl
 lda #02
 sta objectspositionl
  lda #$00
 sta bulletpositionh
   lda #$01
 sta opposebulletposh
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
 

ldx #0
clear6a00
inx
lda #0
sta $6a00,x
cpx #$ff
bne clear6a00
loadenemies 
lda #0
ldy #0  
 
loadenemiesloop  
lda somenum,y
iny

 
 sta objecbuffer,y
cmp #0
 bne loadenemiesloop
 
mainloop
lda opposebulletposl
adc #2

   
sta opposebulletposl
sta oppbulletchar

 
jsr wastetime
 
jsr cls

 jsr displaybullet

jsr display 


  
 
jsr displayobjects 
 

  jsr displayoppbullet
 jsr collision 
 jsr bullettobullet
 jsr printscore
 
 
objectsdisplayed

ror voicefreq
 
 inc objectschar1
  inc objectschar2
   inc objectschar3
    inc objectschar4

jsr scanjoy
  

 

jsr movejoy



inc charactercolour
 
jsr enemytrigger
 

jmp mainloop
rts
cls
 


ldx #0
ldy #0
clsloop
inx
inc clscount
 
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
  
 
 
 cpy #$0
 bne clsloop
 cpy #$ff
 beq clsloop
 rts


wastetime
 
 ldx #0
wastetimeloop
 inx
ror $2260 
ror $2261
ror $2262
ror $2263 
ror $2264
ror $2265
ror $2266
ror $2267

 
 
 cpx #255
 bne wastetimeloop
rts



charanim
 
 ldx #0
 
charanimloop
 inx
 
 
 
    
 cpx #$ff 
 
 
  rts
 
 
clscol
 ldx #0
 
clscolloop
inx
 
 
 
 
 
 
lda bgcolor
 
 
sta $d800,y  
sta $d900,y  
sta $da00,y
sta $daf0,y
 
 
 
 cpx #$0
 beq clscolloop
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
  lda positionl
sta bulletpositionl

 lda positionh
sta bulletpositionh
 

  inc bulletcolor
  jsr lazbeep1 


 
notascore
 

lda #$7f
sta lastkey
 

rts

storekey 
 
 sta lastkey
  
    
 
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
 
ldx #0
displaybulletloop

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

 
cpx #$ff
bne displaybulletloop
 
 
returntomain

 
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
incroppbulletpositionh


 

inc opposebulletposh
lda opposebulletposh
cmp #5
beq resetopposebulletposh
 
 
rts
resetopposebulletposh 

lda #1 
sta opposebulletposh
rts
 
 
 
 

displayoppbullet
 ldx #0

 
 ldy #0
displayoppbulletloop
inx
iny

 
clc
lda opposebulletposl
adc #38

  tax
stx opposebulletposl
  bcs incroppbulletpositionh
 stx opposebulletposl
 



    ldx opposebulletposl
lda opposebulletposh
cmp #$01
beq displayoppbulletpg1
cmp #$02
beq displayoppbulletpg2
cmp #$03
beq displayoppbulletpg3 
cmp #$04
beq displayoppbulletpg4

  
cpx #$ff
bne displayoppbulletloop
 
rts
 

displayoppbulletpg1

lda oppbulletchar
sta $0400,x
 sta $0401,x
lda bulletcolor
sta $d800,x
 sta $d801,x
 


rts
displayoppbulletpg2
 
lda oppbulletchar
sta $0500,x
sta $0501,x
lda bulletcolor
sta $d900,x
sta $d901,x
 
rts
displayoppbulletpg3
 
 
 
lda oppbulletchar

sta $0600,x
 sta $0601,x
lda bulletcolor
sta $da00,x
 sta $da01,x
  
 rts


displayoppbulletpg4
 

lda oppbulletchar
sta $0700,x
 
 sta $0701,x
lda bulletcolor
sta $db00,x
 sta $db01,x
 
 rts

bullettobullet
lda bulletpositionl
cmp opposebulletposl
beq bullettobulleth
rts
bullettobulleth
lda bulletpositionh
cmp opposebulletposh
beq score
rts

score

lda #255
sta objecbuffer,y

jsr addscore
tya 
cmp #0
beq showgameover
safearea 
 tya
 adc #1 
 tay



rts 

displayobjects 
 ldx #1
ldy #$1
objectsloop
iny 
clc
 
lda  bulletpositionl
cmp #255
beq safearea
cmp #0
beq safearea 
tya
tax
 
 
 
lda objecbuffer,y 
cmp bulletpositionl
beq score

 
lda objecbuffer,y
 
 tax
cpx #255
beq bypass
cpx #0
beq bypass
lda objectschar1
sta $0500,x
lda objectschar2
sta $0501,x
lda objectschar3
sta $0528,x
lda objectschar4
sta $0529,x
lda charactercolour
sta $d900,x
sta $d901,x
sta $d928,x
sta $d929,x


 cpx #255
 
 
 bne objectsloop
 
bypass

rts
 

showgameover 
jsr expnoz2
ldx #0
ldy #0
showgameoverloop
inx

 
lda gameovertex,x
 

sta $0550,x
sta $d850,x
cpx #$ff
bne showgameoverloop
 
lda $dc00
 
cmp #$6f
bne showgameoverloop
cmp #$6f
beq reset
 

rts
reset 
 
 
jsr init
rts


collision
lda positionl
adc #1
cmp opposebulletposl
beq forward

rts 
forward 
lda positionh
cmp opposebulletposh
beq showgameover
rts 
display 


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
 
 

 







 
zeroscore
lda #0 
sta scoreones
lda #0
sta scoretens
rts
enemytrigger
lda scoreones
cmp #3
beq backtostart
cmp #7
beq backtostart
 rts
backtostart
jsr clear6a00
rts

 
 
addscore		clc
			
				jsr expnoz
				inc scoreones
			 
			   inc bgcolor
              
               
			 
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
				
				sta $0408
				lda #01 
				sta $d808
				lda scoretens
				adc #$30
				sta $0407
				lda #01
				sta $d807
				lda scorehunds
				adc #$30
				sta $0406
				lda #01
				sta $d806
				lda scorethous
				adc #$30
				sta $0405
				lda #01
				sta $d805	
				rts
 
somenum
         !byte     50,75,100,125,150,175,200,225,250,0 
gameovertex

          !scr " gameover message once upon a time there was a lonely something in a lonely something area so you have to move his ass around and maybe do a little of interactions with some other things around to be continued also my name is keyvan mehrbakhsh  " 
 
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
 

 
theship   !byte   %00000001
          !byte   %00000001
          !byte   %00010001
          !byte   %00010011
          !byte   %00011101
          !byte   %00010111
          !byte   %00100001
          !byte   %11111111
          
theship2              
           !byte   %00000010
           !byte   %00001101
           !byte   %00000011
           !byte   %11111111
           !byte   %00000111
           !byte   %00000001
           !byte   %00000000
           !byte   %00000000
           
theship3              
            !byte  %10000000
            !byte  %10000000
            !byte  %10001000
            !byte  %11001000
            !byte  %10111000
            !byte  %11101000
            !byte  %10000100
            !byte  %11111111
theship4              
             
            !byte  %01000000
            !byte  %10110000
            !byte  %11000000
            !byte  %11111111
            !byte  %11100000
            !byte  %10000000
            !byte  %00000000
            !byte  %00000000
         
 !source "sounds.asm"

