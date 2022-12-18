
soundgo1
         lda attdec
         sta $d405
         lda susrel
         sta $d406
         lda volume
         sta $d418
         lda hifreq
         sta $d400
         lda lofreq
         sta $d401
         ldx wavefm
         inx
         txa
         sta $d404
         rts

soundgo2
         lda attdec
         sta $d40c
         lda susrel
         sta $d40d
         lda volume
         sta $d418
         lda hifreq
         sta $d407
         lda lofreq
         sta $d408
         ldx wavefm
         inx
         txa
         sta $d40b
         rts

soundgo3
         lda attdec
         sta $d413
         lda susrel
         sta $d414
         lda volume
         sta $d418
         lda hifreq
         sta $d40e
         lda lofreq
         sta $d40f
         ldy wavefm
         iny
         tya
         sta $d412
         rts

soundend1
         lda #0
         sta $d404     ; wf1
         rts

soundend2
         lda #0
         sta $d40b     ; wf2
         rts

soundend3
         lda #0
         sta $d412     ;wf3
         rts
         
         
tickingsound
         jsr soundend2
         lda #%00000011 ; 0 9
         sta attdec
         lda #%00000000 ; 0 0
         sta susrel
         lda #15        ; 15
         sta volume
      
         lda whiteblock; 12
         sta hifreq
         lda whiteblock         ; 8
         sta lofreq
         lda #%00010100       ; 32 saw
         sta wavefm

         jsr soundgo2
         rts
         
lazbeep1
         jsr soundend1
         lda #%00001011 ; 0 9
         sta attdec
         lda #%00000000 ; 0 0
         sta susrel
         lda #15        ; 15
         sta volume
      
         lda appleblock  
         sta hifreq
         lda appleblock       ; 8
         sta lofreq
         lda #%00010100       ; 32 saw
         sta wavefm

         jsr soundgo1
         rts

lazbeep2
         jsr soundend2
         lda #%00001001 ; 0 9
         sta attdec
         lda #%00000000 ; 0 0
         sta susrel
         lda #15        ; 15
         sta volume
         lda #13        ; 13
         sta hifreq
         lda $9001         ; 9 bit higher
         sta lofreq
         lda #128      ; 32 saw
         sta wavefm

         jsr soundgo2
         rts
lazbeep3
         jsr soundend2
         lda #%00000111 ; 0 9
         sta attdec
         lda #%00000111 ; 0 0
         sta susrel
         lda #15        ; 15
         sta volume
         
         lda objectspositionl
         ora positionl; 13
         sta hifreq
         lda objectspositionl   ; 9 bit higher
        
         ora positionl
         sta lofreq
         lda #25  ; 32 saw
         sta wavefm

         jsr soundgo2
         rts

expnoz
         jsr soundend3
         lda #%00001001 ; 1 9
         sta attdec
         lda #%00000000 ; 0 0
         sta susrel
         lda #15        ; 15
         sta volume
         lda #1         ; 1
         sta hifreq
         lda #16        ; 16
         sta lofreq
         lda #32       ; 128 noise
         sta wavefm

         jsr soundgo3
         rts
     ;      lda #0
        ; sta $d404     ; wf1
         ;     lda #0
       ;  sta $d40b     ; wf2
       

 
        ; lda #0
      ;   sta $d412     
         

