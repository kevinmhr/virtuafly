!cpu 6510
!to "vois.prg",cbm
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
objcolour = $78
objectschar2 = $6689
objectschar3 = $6643
objectschar4 = $6699
bulletchar =$6634
oppbulletchar =$6635
opposebulletposl = $6249
opposebulletposl2 = $6252
opposebulletposh = $6250
opposebulletposh2 = $6253
opposebulletcolor = $6254
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
objecbuffer2 = $6c00
clscount = $4a00
currentcell = $03
scrollvalue = $37
scrolltrigger = $38
positionlbuffer = $39
positionlbuffer2 = $40
reversezp = $41
reversetrigger = $42
joysttrig = $43
bullettrigger = $44
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

copyshipcharacter
ldy #0
copyshipcharacterloop

lda theship,y
sta $2268,y
lda theship2,y
sta $2270,y
lda theship3,y
sta $2278,y
lda theship4,y
sta $2280,y
 

 
iny
cpy #8
bne copyshipcharacterloop
 

init 
lda #11
sta positionl
ldx #0
ldy #0
lda #41
sta reversezp
lda #1

sta $d021
lda #40
sta reversetrigger
lda #1
sta objecbuffer
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
lda #0
sta $d020
sta opposebulletcolor
lda #03
sta charactercolour

sta bullettrigger
lda #0
sta scoreones
sta scoretens 
sta scorehunds
sta scorethous
lda #$18
sta $d018
 lda #02
 sta objectspositionh
 lda #23
 sta joysttrig
lda positionl
 sta bulletpositionl
 
  lda positionh
 sta bulletpositionh
     lda #$44
 sta opposebulletposl
  lda #$01
 sta opposebulletposh
     lda #$44
 sta opposebulletposl2
  lda #$01
 sta opposebulletposh2
 
 lda #76
sta bgchar 
lda #2
sta bgcolor 
lda #81
sta objectschar1
lda #82
sta objectschar2
lda #84
sta objectschar3
lda #83
sta objectschar4
lda #231
sta bulletchar 
lda #220
sta oppbulletchar

lda #6
sta bulletcolor
sta charactercolour
ldx #0
 
startscreen

 
ldy #0

startscreenloop


lda startuptext,y
 
iny
sta $0550,y
lda #3
sta $d950,y
cpy #$4
bne startscreenloop 
ldy #0
startscreenloop2 

lda startuptext2,y
iny
sta $0750,y
lda #3
sta $db50,y
cpy #$16
bne startscreenloop2   
lda $dc00
cmp #$6f
bne startscreen
cmp #$6f
beq copyboxcharacter
rts
copyboxcharacter 
ldy #0
copyboxcharacterloop


lda thebox,y
sta $2288,y
lda thebox1,y
sta $2290,y
lda thebox2,y
sta $2298,y
lda thebox3,y
sta $22a0,y

iny
 
bne copyboxcharacterloop


copybulletcharacter 
ldy #0
copybulletcharacterloop





iny
 
bne copybulletcharacterloop
loadenemies 
                dec $d021
              
               inc opposebulletcolor
               inc charactercolour
               inc bulletcolor
               inc scoreones
               
ldx #0  
 
loadenemiesloop  
inx
lda somenum2,x
eor clscount
 

 
sta objecbuffer,x
cpx #21
 bne loadenemiesloop
 lda #21
sta joysttrig
 
mainloop
 
jsr displayroad 
displyobj 
 
lda $d012
cmp #255
bne displyobj
 

 ldy #0
 
 

   ldy #0
 

 
 ldx #$0
  
  jsr display  
   inc objcolour
 

 ldx #0
 
 jsr displaybullet

 ldx #0
ldy #$0
jsr displayoppbullet
ldy #$0
jsr displayoppbullet2
 ldx #0
ldy #$0


 
 ldx #$0

 jsr displayobjects 
displyobj2
  
 
lda $d012
cmp #255
bne displyobj2
 
 jsr printscore
  


 ldx #0
ldy #$0

jsr scrolling
 


dec clscount





 ldx #0
 
ldy #$0


 
 jsr collision 


 
 

objectsdisplayed
  ldx #0
 


 
 
 
 

jsr scanjoy
 


jsr movejoy
 
  lda scoreones
 cmp #0
 beq checkscoretens

;inc charactercolour
 
 

jmp mainloop

rts
scrolling


lda scrolltrigger
cmp #0
beq somelinedown
lda scrollvalue


adc #5

sta scrollvalue
somelinedown

lda scrollvalue
sbc positionlbuffer

sta scrollvalue
rts
 

 
 
 
scanjoy            
          
           lda $dc00
       sta lastkey
             
 
           rts
fire	
 lda bullettrigger
 cmp #0

 beq fire2 
 rts
fire2
 
lda positionl
sta bulletpositionl

 lda positionh
sta bulletpositionh
 
 
  jsr lazbeep1 
  
   
 


 
notascore
 

lda #$7f
sta lastkey
 

rts
checkscoretens

 lda scoretens
 
cmp #2
beq loadenemiesbrid
 
cmp #4
beq loadenemiesbrid
cmp #6
beq loadenemiesbrid
cmp #8
beq loadenemiesbrid
 lda scorehunds
 cmp #1
beq loadenemiesbrid
 jmp mainloop
 
rts
loadenemiesbrid
jsr loadenemies
rts
 
 

movejoy 
                
                lda lastkey
                cmp #$6f
                beq fire
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
  
 

 
   
    lda positionl
    sec
    sbc #01
    sta positionl
    sta positionlbuffer
  bcc counterrecount
   lda #01
 sta scrolltrigger
   
     
    rts
counterrecount
jsr decreasehibyte
lda #255
sta positionl
 
rts
right 
 
 
 lda positionl
    clc
    adc #01
    sta positionl
  sta positionlbuffer
  bcs recount
    
      lda #01
 sta scrolltrigger
   
    rts
recount
jsr incresehighbyte
lda #0
sta positionl
 
rts

down
 

 
   lda positionl
 
    clc
    adc #40
    sta positionl
    sta positionlbuffer
    
    bcs incresehighbyte
 
    lda #01
 sta scrolltrigger
 
ignored1
 
  
    rts
up
 
  lda positionl
    sec
    sbc #40
    sta positionl
 sta positionlbuffer
   
 
 bcc decreasehibyte
 
    lda #01
 sta scrolltrigger

ignored2
 rts

 

decreasehibyte   
 
 
  dec positionh
lda positionh
cmp #2
beq inchibyteagain
 
 
rts
 
 

incresehighbyte   
clc
 

inc positionh

lda positionh
cmp #5
beq dechibyteagain
 
 
rts
dechibyteagain
 
lda #03
sta positionh
increaselowbyte
 lda positionl
 adc #31
 sta positionl
 


rts


inchibyteagain
 
 
lda #04
sta positionh
decreaselowbyte

lda positionl
 sbc #32
sta positionl
 
rts


reloadposition

lda positionh
sta bulletpositionh
 
rts

decrbulletpositionh


lda bulletpositionh
cmp #0
beq putbulletback

dec bulletpositionh
 

 
rts
putbulletback
lda #0
sta bullettrigger
lda positionl
sta bulletpositionl
rts 
displaybullet
lda #1
sta bullettrigger
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
 

lda bulletchar
sta $0700,x
 
 sta $0701,x
lda bulletcolor
sta $db00,x
 sta $db01,x
 
 rts
incroppbulletpositionh
 
 


lda opposebulletposh
cmp #5
beq resetopposebulletposh
inc opposebulletposh
 
rts
resetopposebulletposh 
 
 
lda opposebulletposl2
sta opposebulletposl
lda objectspositionh
sta opposebulletposh
rts
 
 
  
 

 
displayoppbullet
 

displayoppbulletloop
clc
inx
iny
 
 

ldx opposebulletposl
 txa
adc #40
 
tax
 
 stx opposebulletposl
  bcs incroppbulletpositionh
 
 stx opposebulletposl
 
 
oppbulllab


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

 
 
rts

displayoppbulletloopbridge
jsr displayoppbulletloop
rts

displayoppbulletpg1

lda oppbulletchar
sta $0400,x
 
lda opposebulletcolor
sta $d800,x
 
 
 

rts
displayoppbulletpg2
 
lda oppbulletchar
sta $0500,x
 
lda opposebulletcolor
sta $d900,x
 
 
rts
displayoppbulletpg3
 
 
 
lda oppbulletchar

sta $0600,x
 
lda opposebulletcolor
sta $da00,x
 
  
 rts


displayoppbulletpg4
 

lda oppbulletchar
sta $0700,x
 
 
lda opposebulletcolor
sta $db00,x
 
 
 rts

bullettobullet

lda opposebulletposl
cmp bulletpositionl

beq bullettobulleth
rts
bullettobulleth
lda opposebulletposh
cmp bulletpositionh
lda opposebulletposh
;beq score
rts





bullettoboxcollision2
 
lda objecbuffer2
cmp positionl
;beq safearea
adc #1
cmp positionl
;beq safearea
sbc #1
cmp positionl
;beq safearea
lda objecbuffer2
cmp #255
;beq safearea
cmp #0
;beq safearea
cmp bulletpositionl
beq checkhigh
adc #1
cmp bulletpositionl
beq checkhigh
sbc #1
cmp bulletpositionl
beq checkhigh
sbc #2
cmp bulletpositionl
beq checkhigh
adc #2
cmp bulletpositionl
beq checkhigh
rts
checkhigh


lda bulletpositionh
cmp objectspositionh
beq score
 
rts


 

boxexp
ldy #0

boxexploop

 
lda thejack,y
sta $2288,y
lda thejack1,y
sta $2290,y
lda thejack2,y
sta $2298,y
lda thejack3,y
sta $22a0,y

iny
cpy #8
bne boxexploop
 
rts
score
lda bulletpositionh
cmp #1
beq score2
rts
score2

inc opposebulletposl

 
lda #0 
sta objecbuffer,x
lda #0
sta bulletpositionh
 
jsr addscore
lda scoretens
 adc scoreones
cmp #2 
beq butterflyload
cmp #4
beq boxexp
cmp #6
beq butterflyload
cmp #8
beq boxexp
  lda scorehunds
 cmp #1
 beq butterflyload
 



rts 
butterflyload
ldy #0
                
butterflyloadloop
lda thebuttfly1,y
sta $2288,y
lda thebuttfly2,y
sta $2290,y
lda thebuttfly3,y
sta $2298,y
lda thebuttfly4,y
sta $22a0,y 
iny
cpy #8
bne butterflyloadloop
 
rts


decobjecthibyte
 sec
lda objectspositionh
sbc #1
 
 
cmp #00
 beq objecthighresethi
 sta objectspositionh
 
 
 rts
incobjecthibyte 
 clc
lda objectspositionh
cmp #4
beq objecthighreset
inc objectspositionh
 
 
rts 
 

objecthighreset

ldx #1
stx objectspositionh
 
rts
objecthighresethi
lda #4
sta objectspositionh
 
rts 
 
displayobjects 


ldy #0
 
objectsloop
clc
  
inx 
 



 
 inc clscount
;

 
lda objecbuffer,x
 
 sta objecbuffer,x
 lda objecbuffer,x
cmp #255
beq safearea
cmp #0
beq safearea
cmp bulletpositionl

beq scorebridge
 
 

tay
bypass
 
 
         
lda objectschar1
sta $0400,y
lda objectschar2
sta $0401,y
lda objectschar3
sta $0428,y
lda objectschar4
sta $0429,y
lda objcolour
sta $d800,y
sta $d801,y
sta $d828,y
sta $d829,y
 
safearea
cpx #21
bne objectsloop

rts

scorebridge
jsr score
rts
objectanimate

lda objecbuffer,y
ora #1
sta objecbuffer,y
rts
displayobjecpg2
 
 

 lda objectschar1
sta $0500,x
lda objectschar2
sta $0501,x
lda objectschar3
sta $0528,x
lda objectschar4
sta $0529,x
lda objcolour
sta $d900,x
sta $d901,x
sta $d928,x
sta $d929,x
 
 rts

 
displayobjecpg3
 
 
lda objectschar1
sta $0600,x
lda objectschar2
sta $0601,x
lda objectschar3
sta $0628,x
lda objectschar4
sta $0629,x
lda objcolour
sta $da00,x
sta $da01,x
sta $da28,x
sta $da29,x
 
 
 
rts

 
displayobjecpg4
 
 
lda objectschar1
sta $0700,x
lda objectschar2
sta $0701,x
lda objectschar3
sta $0728,x
lda objectschar4
sta $0729,x
lda objcolour
sta $db00,x
sta $db01,x
 
 
 clc
  

rts

 


showgameover 

jsr expnoz2
showgameover2 
jsr smiley
jsr smiley2
jsr drawcircle
jsr lips
ldy #0
showgameoverloop

 
lda gameovertex,y
 


sta $0459,y
lda #3
sta $d859,y
iny
cpy #$17
bne showgameoverloop
 
lda $dc00
cmp #$6f
bne showgameover2
lda $dc00
cmp #$6f
beq reset
 
jmp mainloop
rts
reset 

 
jsr init
rts


collision
 

lda opposebulletposl
sbc #1  
cmp positionl
beq forward
lda opposebulletposl
 
cmp positionl
beq forward

lda opposebulletposl2
sbc #1
cmp positionl
beq forward2
 
lda opposebulletposl2
 
cmp positionl
beq forward2
rts 
forward 
lda opposebulletposh
cmp positionh
beq showgameover
rts
forward2

lda opposebulletposh2
cmp positionh
beq showgameover
rts 
displayroad 

ldx #0

displayroadloop
clc



 

lda wallpix,x
 
cmp #255
beq bypass3
adc scoreones
 
 ror
 ror
 ror
 adc scrollvalue
 
 
tay
 
 lda #76
sta $0400,y
 
lda #76
sta $0500,y
 

lda #76
sta $0600,y
 
lda #76
sta $0700,y
 
 lda scoreones
sta $d800,y
 
 lda scoreones
sta $d900,y 
 
 lda scoreones
sta $da00,y 
 
 lda scoreones
sta $db00,y
inx
 cpx #255

 bne displayroadloop 
;lda positionh
;cmp #$01
;beq displaypageone
;cmp #$02
;beq displaypagetwo 
;cmp #$03
;beq displaypagethree  
;cmp #$04
;sbeq displaypagefour  

 
bypass3 
rts 
 
 
 


  
scorecorrection
lda scoreones
cmp #0 
beq zeroscoreone
rts
zeroscoreone
lda #0 
sta scoreones
rts
 
 
zeroscore
lda #0 
sta scoreones
lda #0
sta scoretens
rts
 
backtostart
jsr loadenemies
rts
 
addscore		
                 
                
              
             
           
            inc bgcolor
              

   inc objcolour
                 clc
			    lda #0
			    ldx #0
			    ldy #0
				jsr expnoz
				inc scoreones
			 
               
			 
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
				lda opposebulletcolor
				sta $d808
				lda scoretens
				adc #$30
				sta $0407
				lda opposebulletcolor
				sta $d807
				lda scorehunds
				adc #$30
				sta $0406
				lda opposebulletcolor
				sta $d806
				lda scorethous
				adc #$30
				sta $0405
				lda opposebulletcolor
				sta $d805	
				rts
 
somenum
         !byte     0,0,0,0,0,0,0,0,0,0 
abitmove   !byte 0,1,2,3,2,1,0
startuptext !scr "vois"
startuptext2   !scr "keyvan mehrbakhsh 2023"
gameovertex

          !scr " you are hit press fire " 
;objecbuffer
   ;      !byte     0,0,0,0,0,0,0,0,0,0 
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
 
wallpix !byte 0,1,2,3,4,5,6,7,8,9,10,41,42,43,44,45,46,47,48,49,50,81,82,83,84,85,86,87,88,89,90,121,122,123,124,125,126,127,128,129,130,161,162,163,164,165,166,167,168,169,170,201,202,203,204,205,206,207,208,209,210,241,242,243,244,245,246,247,248,249,250,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255, 255,255,255,255,255,255,255,255,255,255, 255,255,255,255,255,255,255,255,255,255, 255,255,255,255,255,255,255,255,255,255, 255,255,255,255,255,255,255,255,255,255, 255,255,255,255,255,255,255,255,255,255, 255,255,255,255,255,255,255,255,255,255, 255,255,255,255,255,255,255,255,255,255, 255,255,255,255,255,255,255,255,255,255, 255,255,255,255,255,255,255,255,255,255, 255,255,255,255,255,255,255,255,255,255, 255,255,255,255,255,255,255,255,255,255, 255,255,255,255,255,255,255,255,255,255, 255,255,255,255,255,255,255,255,255,255, 255,255,255,255,255,255,255,255,255,255, 255,255,255,255,255,255,255,255,255,255, 255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255  
somenum2
!byte 15,20,35,40,55,60,75,80,95,100,115,120,135,140,155,160,175,180,195,200,215,220,235,240
objecbuffer !byte 15,20,35,40,55,60,75,80,95,100,115,120,135,140,155,160,175,180,195,200,215,220,235,240


theship   !byte   %00000001
          !byte   %00000001
          !byte   %00110001
          !byte   %00110011
          !byte   %00111101
          !byte   %00010111
          !byte   %00100001
          !byte   %00011111
          
theship2              
           !byte   %00000010
           !byte   %00000101
           !byte   %00000011
           !byte   %00111111
           !byte   %00100111
           !byte   %01000000
           !byte   %01000000
           !byte   %01111111
           
theship3              
            !byte  %10000000
            !byte  %10000000
            !byte  %10001100
            !byte  %11001100
            !byte  %10111100
            !byte  %11101000
            !byte  %10000100
            !byte  %11111000
theship4              
             
            !byte  %01000000
            !byte  %10100000
            !byte  %11000000
            !byte  %11111100
            !byte  %11100100
            !byte  %00000010
            !byte  %00000010
            !byte  %11111110
            
            
thebox   !byte    %11111111
          !byte   %11000000
          !byte   %10100000
          !byte   %10010000
          !byte   %10001111
          !byte   %10001000
          !byte   %10001001
          !byte   %10001011
          
thebox1              
           !byte   %00000000
           !byte   %10000000
           !byte   %01000000
           !byte   %00100000
           !byte   %11110000
           !byte   %00010000
           !byte   %10010000
           !byte   %11010000
           
thebox2              
           !byte   %11010000
           !byte   %10010000
           !byte   %00010000
           !byte   %11110000
           !byte   %00000000
           !byte   %00000000
           !byte   %00000000
           !byte   %00000000
thebox3              
             
           !byte   %01001011
           !byte   %00101001
           !byte   %00011000
           !byte   %00001111
           !byte   %00000000
           !byte   %00000000
           !byte   %00000000
           !byte   %00000000  

           
thebuttfly1 !byte  %11110000
          !byte   %01111110
          !byte   %00110111
          !byte   %00010111
          !byte   %00001111
          !byte   %00000011
          !byte   %00000111
          !byte   %00011111
          
thebuttfly2             
           !byte   %00001111
           !byte   %01111110
           !byte   %11101100
           !byte   %11101000
           !byte   %11110000
           !byte   %11000000
           !byte   %11100000
           !byte   %11111000
           
thebuttfly3               
           !byte   %11110000
           !byte   %11111000
           !byte   %01111000
           !byte   %00010000
           !byte   %00001000
           !byte   %00101000
           !byte   %00010000
           !byte   %00000000
thebuttfly4               
             
           !byte   %00001111
           !byte   %00011111
           !byte   %00011110
           !byte   %00001000
           !byte   %00010000
           !byte   %00010100
           !byte   %00001000
           !byte   %00000000  
            
              
thejack  !byte    %00000000
          !byte   %00000000
          !byte   %00000111
          !byte   %00011111
          !byte   %00111000
          !byte   %11100000
          !byte   %11100110
          !byte   %11100110
          
thejack1              
          !byte   %00000000
          !byte   %00000000
          !byte   %11100000
          !byte   %11111000
          !byte   %00011100
          !byte   %00000111
          !byte   %01100111
          !byte   %01100111

thejack2              
             
          !byte   %00000111
          !byte   %11100111
          !byte   %11001110
          !byte   %00011100
          !byte   %11111000
          !byte   %11100000
          !byte   %00000000
          !byte   %00000000    
thejack3              
          !byte   %11100000
          !byte   %11100111
          !byte   %01110011
          !byte   %00111000
          !byte   %00011111
          !byte   %00000111
          !byte   %00000000
          !byte   %00000000
          
          
bulletchardata              
          !byte   %00000000
          !byte   %00011000
          !byte   %00011000
          !byte   %00011000
          !byte   %00011000
          !byte   %00011000
          !byte   %00111100
          !byte   %00000000
          
oppbulletchardata              
          !byte   %00111000
          !byte   %00111000
          !byte   %00111000
          !byte   %00111000
          !byte   %00111000
          !byte   %00111000
          !byte   %00111000
          !byte   %00111000
          
sidebulletchardata              
          !byte   %00011000
          !byte   %00011000
          !byte   %00111100
          !byte   %11111111
          !byte   %00111100
          !byte   %00011000
          !byte   %00000000
          !byte   %00000000          


  !source "two.asm"                  
 !source "sounds.asm"

