	
	; Author: Iarla Scaife
	; Assignment: Convert a string representation of a hex number into 
	; true hex and store resulting value in memory.
	
	; Written as part of 3D1 Microprocessor Systems I module at Trinity College Dublin.
	
	
	AREA	FirstProgram, CODE, READONLY
	IMPORT	main
	EXPORT	start

start
	    
           LDR r1, =str		   ; string
		   LDR r0, =0           ;destination
		   LDR r6, =4          ; four
		   LDR r8, =0          ; sign flag

		   LDRB r2, [r1]	   ;Load byte from pointer
		   ADD r1, r1, #2	   ;pointer = pointer+2
		   CMP r2, #"-"		   ;check if current character is -
		   ADDEQ r1, r1, #1	   ;if so, pointer++
		   LDREQ r8, =1  		;set sign flag
		   CMP r2, #"+"		   ;check if current character is +
		   ADDEQ r1, r1, #1    ;If so, pointer++      
	   		   		                  
loop       LDRB r2, [r1]
                               ; convert ASCII code in r1 to numerical value   CONVERT START 
		   SUB r2, r2, #48	   ; take 48 from ascii code
		   CMP r2, #9		   ; check if 0-9
		   BLE skip			   ; if so, keep the value
		   SUB r2, r2, #7      ; else, convert to hex from ASCII letter		    CONVERT END
skip       
           MOV r0, r0, LSL #4  ;Shift the destination register left four times  
		   ORR r0, r2  		   ;OR the number with the destination register
 		   ADD r1, r1, #1     ;increment pointer to next character		                    
		   LDRB	 r2, [r1]	  ;Load byte from next character

		   CMP r2, #0		  ; check for null character
		   BNE loop 		  ; if not null, repeat loop
		   
		   CMP r8, #1		  ; Check sign flag
		   MVNEQ r0, r0		  ; if negative, invert the final number...
		   ADDEQ r0, r0, #1	  ;  ...and add 1
		   LDR r5, =lable     ; 
		   STR r0, [r5]		  ;  store final number in memory
stop	B	stop

     AREA TestData, DATA, READWRITE
str         DCB  "-0xDEADBEEF",0
lable       SPACE 100     
     END



