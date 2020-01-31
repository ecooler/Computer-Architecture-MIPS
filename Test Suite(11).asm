






		#######################################################################
		#								make_empty
		#
		#  Returns an empty list.
		#
		#  Return Values:
		#	$v0:  The empty list data
		#	$v1:  The empty list data type
		#######################################################################
make_empty:
		li		$v0, 0
		li		$v1, 0
		jr		$ra

		#######################################################################
		#								empty
		#
		#  Checks to see if the data type corresponds to that of an empty list.
		#
		#  Parameters:
		#	$a1:  Data type to be considered
		#  Return Values:
		#	$v0:  1 if $a0 represents an empty list; 0 if not.
		#######################################################################
empty:	li		$v0, 0
		bne		$a1, $zero, return
		li		$v0, 1
return:	jr		$ra

		#######################################################################
		#								int
		#
		#  Checks to see if the data type corresponds to that of an empty list.
		#
		#  Parameters:
		#	$a1:  Data type to be considered
		#  Return Values:
		#	$v0:  1 if $a0 represents an integer; 0 if not.
		#######################################################################
int:	li		$v0, 0
		li		$t9, 1
		bne		$a1, $t9, return
		li		$v0, 1
		jr		$ra

		#######################################################################
		#								char
		#
		#  Checks to see if the data type corresponds to that of a character.
		#
		#  Parameters:
		#	$a1:  Data type to be considered
		#  Return Values:
		#	$v0:  1 if $a0 represents a character; 0 if not.
		#######################################################################
char:	li		$v0, 0
		li		$t9, 2
		bne		$a1, $t9, return
		li		$v0, 1
		jr		$ra
		
		#######################################################################
		#								list
		#
		#  Checks to see if the data type corresponds to that of a character.
		#
		#  Parameters:
		#	$a1:  Data type to be considered
		#  Return Values:
		#	$v0:  1 if $a0 represents a character; 0 if not.
		#######################################################################
list:	li		$v0, 0
		li		$t9, 3
		bne		$a1, $t9, return
		li		$v0, 1
		jr		$ra


#############################################################################################
#                               	Generic Test Suite										#
#																							#
#  Padraic Edgington                                                          26 Mar, 2017	#
#																							#
#																							#
#				Implemented print functions:												#
#					Print_Divider															#
#					Print_Integer_Array														#
#					Print_Raw_Integer_Array													#
#					Print_Hexadecimal														#
#				Implemented assertion functions:											#
#					Initialize_Test_Suite  (Call before every test case)					#
#					Assert_Equal_Integer													#
#					Assert_Not_Equal_Integer												#
#					Assert_Greater_Than_Integer												#
#					Assert_Less_Than_Integer												#
#					Assert_Greater_Than_Equal_Integer										#
#					Assert_Less_Than_Equal_Integer											#
#					Assert_Equal_Array														#
#					Assert_Null																#
#					Assert_Not_Null															#
#					Assert_Error															#
#					Assert_Equal_Long														#
#					Assert_Not_Equal_Long													#
#					Assert_Equal_Scheme_List												#
#  v. 1.3	Added primitive support for Scheme-style lists.									#
#  v. 1.2	Added the Print_Divider function.												#
#  v. 1.1	Bug fix in Assert_Null.															#
#			Added Initialize_Test_Suite as a sensible mnemonic.								#
#  v. 1		Initial release  (It appears to work.)											#
#############################################################################################

main:	addi	$sp, $sp, -4		#  Make space for $ra on stack
		sw		$ra, 0 ($sp)		#  Store the return address on the stack

#############################################################################################
#										car Tests											#
		la		$a0, type1
		jal		Print_Divider
#############################################################################################
		#  car test #1
		#  (car '(1 2)) = 1
		#####################################################################################
		jal		Initialize_Test_Suite
		la		$a0, car1d
		la		$a1, 3
		jal		car
		
		move	$a0, $v0
		move	$a1, $v1
		li		$a2, 1
		li		$a3, 1
		li		$t0, 1
		la		$t1, car1s
		sw		$t0, -4 ($sp)
		sw		$t1, -8 ($sp)
		jal		Assert_Equal_Scheme_List
		.data
car1d:	.word	1 2
		.byte	1 1
car1s:	.asciiz	"Testing (car '(1 2)) = 1."
		.text


		#  car test #2
		#  (car '(1 2 3)) = 1
		#####################################################################################
		jal		Initialize_Test_Suite
		la		$a0, car2d
		la		$a1, 3
		jal		car
		
		move	$a0, $v0
		move	$a1, $v1
		li		$a2, 1
		li		$a3, 1
		li		$t0, 2
		la		$t1, car2s
		sw		$t0, -4 ($sp)
		sw		$t1, -8 ($sp)
		jal		Assert_Equal_Scheme_List
		.data
car2d:	.word	1 car2da
		.byte	1 3
car2da:	.word	2 3
		.byte	1 1
car2s:	.asciiz	"Testing (car '(1 2 3)) = 1."
		.text


		#  car test #3
		#  (car '((1 2) 3)) = (1 2)
		#####################################################################################
		jal		Initialize_Test_Suite
		la		$a0, car3d
		la		$a1, 3
		jal		car
		
		move	$a0, $v0
		move	$a1, $v1
		la		$a2, car1d
		li		$a3, 3
		li		$t0, 3
		la		$t1, car3s
		sw		$t0, -4 ($sp)
		sw		$t1, -8 ($sp)
		jal		Assert_Equal_Scheme_List
		.data
car3d:	.word	car3da 3
		.byte	3 1
car3da:	.word	1 2
		.byte	1 1
car3s:	.asciiz	"Testing (car '((1 2) 3)) = (1 2)."
		.text


		#  car test #4
		#  (car '(((1 A) 3) C 5) (E 6 7 (8 F (G) 9))) = (((1 A) 3) C 5)
		#####################################################################################
		jal		Initialize_Test_Suite
		la		$a0, car4d
		la		$a1, 3
		jal		car
		
		move	$a0, $v0
		move	$a1, $v1
		la		$a2, car4da
		li		$a3, 3
		li		$t0, 4
		la		$t1, car4s
		sw		$t0, -4 ($sp)
		sw		$t1, -8 ($sp)
		jal		Assert_Equal_Scheme_List
		.data
car4s:	.asciiz	"Testing (car '(((1 A) 3) C 5) (E 6 7 (8 F (G) 9))) = (((1 A) 3) C 5)."
car4d:	.word	car4da car4db
		.byte	3 3
car4da:	.word	car4dc car4dd
		.byte	3 3
car4dc:	.word	car4de 3
		.byte	3 1
car4dd:	.word	67 5
		.byte	2 1
car4de:	.word	1 65
		.byte	1 2
car4db:	.word	69 car4df
		.byte	2 3
car4df:	.word	6 car4dg
		.byte	1 3
car4dg:	.word	7 car4dh
		.byte	1 3
car4dh:	.word	car4di 0
		.byte	3 0
car4di:	.word	8 car4dj
		.byte	1 3
car4dj:	.word	70 car4dk
		.byte	2 3
car4dk:	.word	car4dl 9
		.byte	3 1
car4dl:	.word	71 0
		.byte	2 0
		.text








#############################################################################################
#											cdr Tests										#
		la		$a0, type2
		jal		Print_Divider
#############################################################################################
		#  cdr test #1
		#  (cdr '(1 2)) = 2
		#####################################################################################
		jal		Initialize_Test_Suite
		la		$a0, car1d
		la		$a1, 3
		jal		cdr
		
		move	$a0, $v0
		move	$a1, $v1
		li		$a2, 2
		li		$a3, 1
		li		$t0, 1
		la		$t1, cdr1s
		sw		$t0, -4 ($sp)
		sw		$t1, -8 ($sp)
		jal		Assert_Equal_Scheme_List
		.data
cdr1s:	.asciiz	"Testing (cdr '(1 2)) = 2."
		.text


		#  cdr test #2
		#  (cdr '(1 2 3)) = (2 3)
		#####################################################################################
		jal		Initialize_Test_Suite
		la		$a0, car2d
		la		$a1, 3
		jal		cdr
		
		move	$a0, $v0
		move	$a1, $v1
		la		$a2, cdr2d
		li		$a3, 3
		li		$t0, 2
		la		$t1, cdr2s
		sw		$t0, -4 ($sp)
		sw		$t1, -8 ($sp)
		jal		Assert_Equal_Scheme_List
		.data
cdr2s:	.asciiz	"Testing (cdr '(1 2 3)) = (2 3)."
cdr2d:	.word	2 3
		.byte	1 1
		.text


		#  cdr test #3
		#  (cdr '((1 2) 3)) = 3
		#####################################################################################
		jal		Initialize_Test_Suite
		la		$a0, car3d
		la		$a1, 3
		jal		cdr
		
		move	$a0, $v0
		move	$a1, $v1
		li		$a2, 3
		li		$a3, 1
		li		$t0, 3
		la		$t1, cdr3s
		sw		$t0, -4 ($sp)
		sw		$t1, -8 ($sp)
		jal		Assert_Equal_Scheme_List
		.data
cdr3s:	.asciiz	"Testing (cdr '((1 2) 3)) = 3."
		.text


		#  cdr test #4
		#  (cdr '(((1 A) 3) C 5) (E 6 7 (8 F (G) 9))) = (E 6 7 (8 F (G) 9)
		#####################################################################################
		jal		Initialize_Test_Suite
		la		$a0, car4d
		la		$a1, 3
		jal		cdr
		
		move	$a0, $v0
		move	$a1, $v1
		la		$a2, car4db
		li		$a3, 3
		li		$t0, 4
		la		$t1, cdr4s
		sw		$t0, -4 ($sp)
		sw		$t1, -8 ($sp)
		jal		Assert_Equal_Scheme_List
		.data
cdr4s:	.asciiz	"Testing (cdr '(((1 A) 3) C 5) (E 6 7 (8 F (G) 9))) = (E 6 7 (8 F (G) 9)."
		.text




		
		
		


#############################################################################################
#											cons Tests										#
		la		$a0, type3
		jal		Print_Divider
#############################################################################################
		#  cons test #1
		#  (cons 1 2) = (1 2)
		#####################################################################################
		jal		Initialize_Test_Suite
		li		$a0, 1
		li		$a1, 1
		li		$a2, 2
		li		$a3, 1
		jal		cons
		
		move	$a0, $v0
		move	$a1, $v1
		la		$a2, car1d
		li		$a3, 3
		li		$t0, 1
		la		$t1, cons1s
		sw		$t0, -4 ($sp)
		sw		$t1, -8 ($sp)
		jal		Assert_Equal_Scheme_List
		.data
cons1s:	.asciiz	"Testing (cons 1 2) = (1 2)."
		.text


		#  cons test #2
		#  (cons 1 (2 3)) = (1 2 3)
		#####################################################################################
		jal		Initialize_Test_Suite
		li		$a0, 1
		li		$a1, 1
		la		$a2, car2da
		li		$a3, 3
		jal		cons
		
		move	$a0, $v0
		move	$a1, $v1
		la		$a2, car2d
		li		$a3, 3
		li		$t0, 2
		la		$t1, cons2s
		sw		$t0, -4 ($sp)
		sw		$t1, -8 ($sp)
		jal		Assert_Equal_Scheme_List
		.data
cons2s:	.asciiz	"Testing (cons 1 (2 3)) = (1 2 3)."
		.text


		#  cons test #3
		#  (cons (((1 A) 3) C 5) (E 6 7 (8 F (G) 9))) = ((((1 A) 3) C 5) (E 6 7 (8 F (G) 9)))
		#####################################################################################
		jal		Initialize_Test_Suite
		la		$a0, car4da
		li		$a1, 3
		la		$a2, car4db
		li		$a3, 3
		jal		cons
		
		move	$a0, $v0
		move	$a1, $v1
		la		$a2, car4d
		li		$a3, 3
		li		$t0, 3
		la		$t1, cons3s
		sw		$t0, -4 ($sp)
		sw		$t1, -8 ($sp)
		jal		Assert_Equal_Scheme_List
		.data
cons3s:	.asciiz	"Testing (cons (((1 A) 3) C 5) (E 6 7 (8 F (G) 9))) = ((((1 A) 3) C 5) (E 6 7 (8 F (G) 9)))."
		.text



		
		



#############################################################################################
#											double Tests									#
		la		$a0, type4
		jal		Print_Divider
#############################################################################################
		#  double test #1
		#  (double 1) = 2
		#####################################################################################
		jal		Initialize_Test_Suite
		la		$a0, 1
		li		$a1, 1
		jal		double
		
		move	$a0, $v0
		move	$a1, $v1
		li		$a2, 2
		li		$a3, 1
		li		$t0, 1
		la		$t1, d1s
		sw		$t0, -4 ($sp)
		sw		$t1, -8 ($sp)
		jal		Assert_Equal_Scheme_List
		.data
d1s:	.asciiz	"Testing (double 1) = 2."
		.text


		#  double test #2
		#  (double '(1 2)) = (2 4)
		#####################################################################################
		jal		Initialize_Test_Suite
		la		$a0, car1d
		li		$a1, 3
		jal		double
		
		move	$a0, $v0
		move	$a1, $v1
		la		$a2, d2d
		li		$a3, 3
		li		$t0, 2
		la		$t1, d2s
		sw		$t0, -4 ($sp)
		sw		$t1, -8 ($sp)
		jal		Assert_Equal_Scheme_List
		.data
d2s:	.asciiz	"Testing (double '(1 2)) = (2 4)."
d2d:	.word	2 4
		.byte	1 1
		.text


		#  double test #3
		#  (double '(1 2 3)) = (2 4 6)
		#####################################################################################
		jal		Initialize_Test_Suite
		la		$a0, car2d
		li		$a1, 3
		jal		double
		
		move	$a0, $v0
		move	$a1, $v1
		la		$a2, d3d
		li		$a3, 3
		li		$t0, 3
		la		$t1, d3s
		sw		$t0, -4 ($sp)
		sw		$t1, -8 ($sp)
		jal		Assert_Equal_Scheme_List
		.data
d3s:	.asciiz	"Testing (double '(1 2 3)) = (2 4 6)."
d3d:	.word	2 d3da
		.byte	1 3
d3da:	.word	4 6
		.byte	1 1
		.text


		#  double test #4
		#  (double 'A) = A
		#####################################################################################
		jal		Initialize_Test_Suite
		li		$a0, 65
		li		$a1, 2
		jal		double
		
		move	$a0, $v0
		move	$a1, $v1
		li		$a2, 65
		li		$a3, 2
		li		$t0, 4
		la		$t1, d4s
		sw		$t0, -4 ($sp)
		sw		$t1, -8 ($sp)
		jal		Assert_Equal_Scheme_List
		.data
d4s:	.asciiz	"Testing (double 'A) = A."
		.text


		#  double test #5
		#  (double '((((1 A) 3) C 5) (E 6 7 (8 F (G) 9)))) = ((((2 A) 6) C 10) (E 12 14 (16 F (G) 18)))
		#####################################################################################
		jal		Initialize_Test_Suite
		la		$a0, car4d
		li		$a1, 3
		jal		double
		
		move	$a0, $v0
		move	$a1, $v1
		la		$a2, d5d
		li		$a3, 3
		li		$t0, 5
		la		$t1, d5s
		sw		$t0, -4 ($sp)
		sw		$t1, -8 ($sp)
		jal		Assert_Equal_Scheme_List
		.data
d5s:	.asciiz	"Testing (double '((((1 A) 3) C 5) (E 6 7 (8 F (G) 9)))) = ((((2 A) 6) C 10) (E 12 14 (16 F (G) 18)))."
d5d:	.word	d5da d5db
		.byte	3 3
d5da:	.word	d5dc d5dd
		.byte	3 3
d5dc:	.word	d5de 6
		.byte	3 1
d5dd:	.word	67 10
		.byte	2 1
d5de:	.word	2 65
		.byte	1 2
d5db:	.word	69 d5df
		.byte	2 3
d5df:	.word	12 d5dg
		.byte	1 3
d5dg:	.word	14 d5dh
		.byte	1 3
d5dh:	.word	d5di 0
		.byte	3 0
d5di:	.word	16 d5dj
		.byte	1 3
d5dj:	.word	70 d5dk
		.byte	2 3
d5dk:	.word	d5dl 18
		.byte	3 1
d5dl:	.word	71 0
		.byte	2 0
		.text






#############################################################################################
#										All Tests Completed									#
Skip_Parameter_Validation_Tests:
		.data
type1:	.asciiz	"Starting car tests."
type2:	.asciiz	"Starting cdr tests."
type3:	.asciiz	"Starting cons tests."
type4:	.asciiz	"Starting double tests."
finish:	.asciiz	"Testing completed."
		.text
		la		$a0, finish
		jal		Print_Divider
		lw		$ra, 0 ($sp)		#  Load return address
		addi	$sp, $sp, 4			#  Pop the stack
		jr		$ra







##############################################################################################
##############################################################################################
##																							##
##									Printing Functions										##
##																							##
##############################################################################################
##############################################################################################


		#######################################################################
		#							Print Divider
		#
		#  Parameters:
		#	$a0:  A descriptive string to print.
		#
		#		Prints out a divider containing the provided string.
		#######################################################################
Print_Divider:
		#  Saving the existing data on the stack in case someone is carelessly
		#  calling this function.
		addi	$sp, $sp, -16
		sw		$t0,  0 ($sp)
		sw		$t1,  4 ($sp)
		sw		$t2,  8 ($sp)
		sw		$s0, 12 ($sp)

		move	$s0, $a0
		#  Count the number of characters in the string.
		li		$t0, 0
		move	$t1, $a0
PD_Loop:
		lb		$t2, 0 ($t1)
		beqz	$t2, PD_End_Loop
		addi	$t0, $t0, 1
		addi	$t1, $t1, 1
		j		PD_Loop
PD_End_Loop:
		li		$t1, 80
		sub		$t1, $t1, $t0
		srl		$t0, $t1, 1			#  The length of the left half of the divider.
		sub		$t1, $t1, $t0		#  The length of the right half of the divider.
		
		#  Adding a newline character.
		li		$v0, 4
		la		$a0, nl
		syscall
		
		#  Printing the left half of the divider
		li		$v0, 11
		li		$a0, 35
		syscall
		syscall
		li		$a0, 45
		syscall
		li		$t2, 3
PD_Left_Loop:
		beq		$t2, $t0, PD_Print_String
		syscall
		addi	$t2, $t2, 1
		j		PD_Left_Loop

		#  Printing the divider string.
PD_Print_String:
		li		$v0, 4
		move	$a0, $s0
		syscall
		
		#  Printing the right half of the divider.
		li		$t2, 3
		li		$v0, 11
		li		$a0, 45
PD_Right_Loop:
		beq		$t2, $t1, PD_Cleanup
		syscall
		addi	$t2, $t2, 1
		j		PD_Right_Loop
PD_Cleanup:
		syscall
		li		$a0, 35
		syscall
		syscall
		
		#  Adding a newline character.
		li		$v0, 4
		la		$a0, nl
		syscall
		
		lw		$s0, 12 ($sp)
		lw		$t2,  8 ($sp)
		lw		$t1,  4 ($sp)
		lw		$t0,  0 ($sp)
		addi	$sp, $sp, 16
		jr		$ra
		


		#######################################################################
		#						Print Integer Array
		#
		#  Parameters:
		#	$a0:  The array of integers to display.
		#
		#		Assumes that the first element in the data structure is the
		#  length of the array.
		#######################################################################
Print_Integer_Array:
		#  Saving the existing data on the stack in case someone is carelessly
		#  calling this function.
		addi	$sp, $sp, -20
		sw		$t0,  0 ($sp)
		sw		$t1,  4 ($sp)
		sw		$t2,  8 ($sp)
		sw		$t3, 12 ($sp)
		sw		$v0, 16 ($sp)

		#  Check for a valid array, print a simple error message if this is not an array.
		lui		$t0, 0x1000
		blt		$a0, $t0, PA_Outside_of_Memory
		li		$t0, 0xFFFFFFFC
		and		$t0, $a0, $t0						#  Set the last two bits to zero, to force it to be word aligned.
		bne		$a0, $t0, PA_Not_Word_Aligned

		move	$t0, $a0				#  Store the array address in $t0
		lw		$t1, 0 ($t0)			#  Store the length in $t1
		#  First, print the length
		li		$v0, 4
		la		$a0, Length
		syscall
		li		$v0, 1
		move	$a0, $t1
		syscall

		#  If the length is zero, just quit now.
		beqz	$t1, PA_Exit

		#  Next, print the contents of the array.
		li		$v0, 4
		la		$a0, Contents
		syscall

		li		$t2, 1					#  Loop counter is in $t2.
PA_Loop:
		bgt		$t2, $t1, PA_Exit

		li		$v0, 4
		la		$a0, Space
		syscall
		li		$v0, 1
		sll		$t3, $t2, 2				#  One variable is provided for in $t3.
		add		$t3, $t0, $t3
		lw		$a0, 0 ($t3)
		syscall

		addi	$t2, $t2, 1
		j		PA_Loop
		.data
Length:	.asciiz	"Length:  "
Contents:	.asciiz	"  Contents:"
Space:	.asciiz	"  "
		.text


		#  If the "array" is not within data memory, don't try to display it.
PA_Outside_of_Memory:
		li		$v0, 4
		la		$a0, PAOM
		syscall
		j		PA_Exit
		.data
PAOM:	.asciiz	"The provided \"array\" is not inside the viable range for data and thus cannot be displayed."
		.text

		#  If the "array" is not word aligned, don't try to display it.
PA_Not_Word_Aligned:
		li		$v0, 4
		la		$a0, PANWA
		syscall
		j		PA_Exit
		.data
PANWA:	.asciiz	"The provided \"array\" is not word aligned and thus cannot be displayed."
		.text

PA_Exit:#  We've reached the end of the print function, so restore all the registers that we changed
		#  and return to the calling function.
		li		$v0, 4
		la		$a0, nl
		syscall
		lw		$t0,  0 ($sp)
		lw		$t1,  4 ($sp)
		lw		$t2,  8 ($sp)
		lw		$t3, 12 ($sp)
		lw		$v0, 16 ($sp)
		addi	$sp, $sp, 20
		jr		$ra






		#######################################################################
		#					Print Raw Integer Array
		#
		#  Parameters:
		#	$a0:  The array of integers to display.
		#	$a1:  The length of the array.
		#######################################################################
Print_Raw_Integer_Array:
		#  Saving the existing data on the stack in case someone is carelessly
		#  calling this function.
		addi	$sp, $sp, -20
		sw		$t0,  0 ($sp)
		sw		$t1,  4 ($sp)
		sw		$t2,  8 ($sp)
		sw		$t3, 12 ($sp)
		sw		$v0, 16 ($sp)

		#  Check for a valid array, print a simple error message if this is not an array.
		lui		$t0, 0x1000
		blt		$a0, $t0, PA_Outside_of_Memory
		li		$t0, 0xFFFFFFFC
		and		$t0, $a0, $t0						#  Set the last two bits to zero, to force it to be word aligned.
		bne		$a0, $t0, PA_Not_Word_Aligned

		move	$t0, $a0				#  Store the array address in $t0
		move	$t1, $a1				#  Store the length in $t1
		#  First, print the length
		li		$v0, 4
		la		$a0, Length
		syscall
		li		$v0, 1
		move	$a0, $t1
		syscall

		#  If the length is zero, just quit now.
		beqz	$t1, PRIA_Exit

		#  Next, print the contents of the array.
		li		$v0, 4
		la		$a0, Contents
		syscall

		li		$t2, 0					#  Loop counter is in $t2.
PRIA_Loop:
		bge		$t2, $t1, PRIA_Exit

		li		$v0, 4
		la		$a0, Space
		syscall
		li		$v0, 1
		sll		$t3, $t2, 2				#  One variable is provided for in $t3.
		add		$t3, $t0, $t3
		lw		$a0, 0 ($t3)
		syscall

		addi	$t2, $t2, 1
		j		PRIA_Loop


PRIA_Exit:#  We've reached the end of the print function, so restore all the registers that we changed
		#  and return to the calling function.
		li		$v0, 4
		la		$a0, nl
		syscall
		lw		$t0,  0 ($sp)
		lw		$t1,  4 ($sp)
		lw		$t2,  8 ($sp)
		lw		$t3, 12 ($sp)
		lw		$v0, 16 ($sp)
		addi	$sp, $sp, 20
		jr		$ra






		#######################################################################
		#  Print Hexadecimal Number
		#
		#      This function takes a 32-bit integer as a parameter and prints
		#  it to the console in hexadecimal format.
		#
		#  Parameters:
		#  $a0:  32-bit number
		#######################################################################
		.data
hex:	.ascii	"0123456789ABCDEF"
nbsp:	.asciiz	" "
		.text
Print_Hexadecimal:
		addi	$sp, $sp, -4
		sw		$s0, 0 ($sp)
		move	$s0, $a0


		#  Use a mask to select four bits at a time; move the selected four bits
		#  into the least significant bit positions and use them as an index to
		#  select a hexadecimal character from the hex array and print the character.
		li		$t0, 0				#  Counter
HexLoop:
		bge		$t0, 32, HexEndLoop
		li		$a0, 0xF0000000
		srlv	$a0, $a0, $t0		#  Create a mask for the current 4 bits
		and		$a0, $a0, $s0		#  Apply the mask
		li		$t1, 28
		sub		$t1, $t1, $t0
		srlv	$a0, $a0, $t1		#  Shift the selected 4 bits into the LSB positions
		la		$t1, hex
		add		$a0, $t1, $a0
		lbu		$a0, 0 ($a0)		#  Read the indexed character from the string
		li		$v0, 11
		syscall						#  Print the selected character
		addi	$t0, $t0, 4			#  Increment to the next four bits
		bne		$t0, 16, HexLoop
		li		$v0, 4
		la		$a0, nbsp
		syscall						#  Print a space after the first four characters
		j		HexLoop


HexEndLoop:
		lw		$s0, 0 ($sp)
		addi	$sp, $sp, 4
		jr		$ra






##############################################################################################
##############################################################################################
##																							##
##									Assertion Functions										##
##																							##
##############################################################################################
##############################################################################################


		#######################################################################
		#  Assert equality for integers
		#	$a0:  Observed
		#	$a1:  Expected
		#	$a2:  Test #
		#	$a3:  Test description
		#######################################################################
Assert_Equal_Integer:
		#  Integers are easy to compare
		bne		$a0, $a1, AEIFail

		#  Correct solution.
		li		$a0, 1
		j		Results



		#  Failed because the observed value did not match the expected result.
AEIFail:
		addi	$sp, $sp, -8					#  Storing the observed and expected values on the stack.
		sw		$a0, 0 ($sp)
		sw		$a1, 4 ($sp)

		li		$a0, 0
		la		$a1, AEIF
		j		Results
		#  Error description print routine.
AEIF:	lw		$t0, 0 ($sp)					#  We can now retrieve the observed and expected values to print.
		lw		$t1, 4 ($sp)
		addi	$sp, $sp, 8

		li		$v0, 4
		la		$a0, AEIF1
		syscall
		la		$a0, Observed
		syscall
		li		$v0, 1
		move	$a0, $t0
		syscall
		li		$v0, 4
		la		$a0, nl
		syscall
		la		$a0, Expected
		syscall
		li		$v0, 1
		move	$a0, $t1
		syscall
		li		$v0, 4
		la		$a0, nl
		syscall
		syscall
		jr		$ra


		.data
AEIF1:	.asciiz	"The observed value did not match the expected result.\n"
Observed:	.asciiz	"Observed:  "
Expected:	.asciiz	"Expected:  "
		.text







		#######################################################################
		#  Assert inequality for integers
		#	$a0:  Observed
		#	$a1:  Undesired
		#	$a2:  Test #
		#	$a3:  Test description
		#######################################################################
Assert_Not_Equal_Integer:
		#  Integers are easy to compare
		beq		$a0, $a1, ANEIFail

		#  Correct solution.
		li		$a0, 1
		j		Results



		#  Failed because the observed value did not match the expected result.
ANEIFail:
		addi	$sp, $sp, -8					#  Storing the observed and expected values on the stack.
		sw		$a0, 0 ($sp)
		sw		$a1, 4 ($sp)

		li		$a0, 0
		la		$a1, ANEIF
		j		Results
		#  Error description print routine.
ANEIF:	lw		$t0, 0 ($sp)					#  We can now retrieve the observed and expected values to print.
		lw		$t1, 4 ($sp)
		addi	$sp, $sp, 8

		li		$v0, 4
		la		$a0, ANEIF1
		syscall
		la		$a0, Observed
		syscall
		li		$v0, 1
		move	$a0, $t0
		syscall
		li		$v0, 4
		la		$a0, nl
		syscall
		la		$a0, Undesired
		syscall
		li		$v0, 1
		move	$a0, $t1
		syscall
		li		$v0, 4
		la		$a0, nl
		syscall
		syscall
		jr		$ra


		.data
ANEIF1:	.asciiz	"The observed value should not match the undesired value.\n"
Undesired:	.asciiz	"Undesired:  "
		.text







		#######################################################################
		#  Assert greater than for integers
		#	$a0:  Observed
		#	$a1:  Greater than
		#	$a2:  Test #
		#	$a3:  Test description
		#######################################################################
Assert_Greater_Than_Integer:
		#  Integers are easy to compare
		ble		$a0, $a1, AGTIFail

		#  Correct solution.
		li		$a0, 1
		j		Results



		#  Failed because the observed value was not greater than the minimum value.
AGTIFail:
		addi	$sp, $sp, -8					#  Storing the observed and expected values on the stack.
		sw		$a0, 0 ($sp)
		sw		$a1, 4 ($sp)

		li		$a0, 0
		la		$a1, AGTIF
		j		Results
		#  Error description print routine.
AGTIF:	lw		$t0, 0 ($sp)					#  We can now retrieve the observed and expected values to print.
		lw		$t1, 4 ($sp)
		addi	$sp, $sp, 8

		li		$v0, 4
		la		$a0, AGTIF1
		syscall
		li		$v0, 1
		move	$a0, $t0
		syscall
		li		$v0, 4
		la		$a0, AGTIF2
		syscall
		li		$v0, 1
		move	$a0, $t1
		syscall
		li		$v0, 4
		la		$a0, $AGTIF3
		syscall
		jr		$ra


		.data
AGTIF1:	.asciiz	"The result ("
AGTIF2:	.asciiz	") should be greater than "
AGTIF3:	.asciiz	".\n\n"
		.text







		#######################################################################
		#  Assert less than for integers
		#	$a0:  Observed
		#	$a1:  Less than
		#	$a2:  Test #
		#	$a3:  Test description
		#######################################################################
Assert_Less_Than_Integer:
		#  Integers are easy to compare
		bge		$a0, $a1, ALTIFail

		#  Correct solution.
		li		$a0, 1
		j		Results



		#  Failed because the observed value was not less than the minimum value.
ALTIFail:
		addi	$sp, $sp, -8					#  Storing the observed and expected values on the stack.
		sw		$a0, 0 ($sp)
		sw		$a1, 4 ($sp)

		li		$a0, 0
		la		$a1, ALTIF
		j		Results
		#  Error description print routine.
ALTIF:	lw		$t0, 0 ($sp)					#  We can now retrieve the observed and expected values to print.
		lw		$t1, 4 ($sp)
		addi	$sp, $sp, 8

		li		$v0, 4
		la		$a0, AGTIF1
		syscall
		li		$v0, 1
		move	$a0, $t0
		syscall
		li		$v0, 4
		la		$a0, ALTIF2
		syscall
		li		$v0, 1
		move	$a0, $t1
		syscall
		li		$v0, 4
		la		$a0, $AGTIF3
		syscall
		jr		$ra


		.data
ALTIF2:	.asciiz	") should be less than "
		.text







		#######################################################################
		#  Assert greater than or equal to for integers
		#	$a0:  Observed
		#	$a1:  Greater than or equal to
		#	$a2:  Test #
		#	$a3:  Test description
		#######################################################################
Assert_Greater_Than_Equal_Integer:
		#  Integers are easy to compare
		blt		$a0, $a1, AGTEIFail

		#  Correct solution.
		li		$a0, 1
		j		Results



		#  Failed because the observed value was not greater than or equal to the minimum value.
AGTEIFail:
		addi	$sp, $sp, -8					#  Storing the observed and expected values on the stack.
		sw		$a0, 0 ($sp)
		sw		$a1, 4 ($sp)

		li		$a0, 0
		la		$a1, AGTEIF
		j		Results
		#  Error description print routine.
AGTEIF:	lw		$t0, 0 ($sp)					#  We can now retrieve the observed and expected values to print.
		lw		$t1, 4 ($sp)
		addi	$sp, $sp, 8

		li		$v0, 4
		la		$a0, AGTIF1
		syscall
		li		$v0, 1
		move	$a0, $t0
		syscall
		li		$v0, 4
		la		$a0, AGTEIF2
		syscall
		li		$v0, 1
		move	$a0, $t1
		syscall
		li		$v0, 4
		la		$a0, $AGTIF3
		syscall
		jr		$ra


		.data
AGTEIF2:	.asciiz	") should be greater than or equal to "
		.text







		#######################################################################
		#  Assert less than or equal to for integers
		#	$a0:  Observed
		#	$a1:  Less than or equal to
		#	$a2:  Test #
		#	$a3:  Test description
		#######################################################################
Assert_Less_Than_Equal_Integer:
		#  Integers are easy to compare
		bgt		$a0, $a1, ALTEIFail

		#  Correct solution.
		li		$a0, 1
		j		Results



		#  Failed because the observed value was not less than the minimum value.
ALTEIFail:
		addi	$sp, $sp, -8					#  Storing the observed and expected values on the stack.
		sw		$a0, 0 ($sp)
		sw		$a1, 4 ($sp)

		li		$a0, 0
		la		$a1, ALTEIF
		j		Results
		#  Error description print routine.
ALTEIF:	lw		$t0, 0 ($sp)					#  We can now retrieve the observed and expected values to print.
		lw		$t1, 4 ($sp)
		addi	$sp, $sp, 8

		li		$v0, 4
		la		$a0, AGTIF1
		syscall
		li		$v0, 1
		move	$a0, $t0
		syscall
		li		$v0, 4
		la		$a0, ALTEIF2
		syscall
		li		$v0, 1
		move	$a0, $t1
		syscall
		li		$v0, 4
		la		$a0, $AGTIF3
		syscall
		jr		$ra


		.data
ALTEIF2:	.asciiz	") should be less than or equal to "
		.text







		#######################################################################
		#  Assert equality for 64-bit integers
		#	$a0:  Observed upper 32 bits
		#	$a1:  Observed lower 32 bits
		#	$a2:  Expected upper 32 bits
		#	$a3:  Expected lower 32 bits
		#	$sp-4:  Test #
		#	$sp-8:  Test description
		#######################################################################
Assert_Equal_Long:
		bne		$a0, $a2, AELFail		#  Comparing longs is almost as easy as ints.
		bne		$a1, $a3, AELFail

		#  Correct solution
		li		$a0, 1
		lw		$a2, -4 ($sp)
		lw		$a3, -8 ($sp)
		j		Results

		#  Failed because the long integers did not match.
AELFail:
		addi	$sp, $sp -24
		sw		$a0,  0 ($sp)			#  Observed upper 32 bits
		sw		$a1,  4 ($sp)			#  Observed lower 32 bits
		sw		$a2,  8 ($sp)			#  Expected upper 32 bits
		sw		$a3, 12 ($sp)			#  Expected lower 32 bits
		#  Test # is at 16 ($sp)
		#  Test description is at 20 ($sp)

		li		$a0, 0
		la		$a1, AELF
		lw		$a2, 16 ($sp)
		lw		$a3, 20 ($sp)
		j		Results
		#  Error description print routine.
AELF:	li		$v0, 4
		la		$a0, AEIF1				#  "The observed value did not match the expected result.\n"
		syscall
		la		$a0, Observed			#  "Observed:  "
		syscall
		lw		$a0, 0 ($sp)
		jal		Print_Hexadecimal
		li		$v0, 4
		la		$a0, nbsp
		syscall
		lw		$a0, 4 ($sp)
		jal		Print_Hexadecimal
		li		$v0, 4
		la		$a0, nl
		syscall

		la		$a0, Expected			#  "Expected:  "
		syscall
		lw		$a0, 8 ($sp)
		jal		Print_Hexadecimal
		li		$v0, 4
		la		$a0, nbsp
		syscall
		lw		$a0, 12 ($sp)
		jal		Print_Hexadecimal
		lw		$v0, 4
		la		$a0, nbsp
		syscall
		syscall

		addi	$sp, $sp, 24
		jr		$ra








		#######################################################################
		#  Assert inequality for 64-bit integers
		#	$a0:  Observed upper 32 bits
		#	$a1:  Observed lower 32 bits
		#	$a2:  Undesired upper 32 bits
		#	$a3:  Undesired lower 32 bits
		#	$sp-4:  Test #
		#	$sp-8:  Test description
		#######################################################################
Assert_Not_Equal_Long:
		bne		$a0, $a2, ANELPass		#  Comparing longs is almost as easy as ints.
		bne		$a1, $a3, ANELPass
		j		ANELFail

ANELPass:
		#  Correct solution
		li		$a0, 1
		lw		$a2, -4 ($sp)
		lw		$a3, -8 ($sp)
		j		Results

		#  Failed because the long integers matched.
ANELFail:
		addi	$sp, $sp -24
		sw		$a0,  0 ($sp)			#  Observed upper 32 bits
		sw		$a1,  4 ($sp)			#  Observed lower 32 bits
		sw		$a2,  8 ($sp)			#  Undesired upper 32 bits
		sw		$a3, 12 ($sp)			#  Undesired lower 32 bits
		#  Test # is at 16 ($sp)
		#  Test description is at 20 ($sp)

		li		$a0, 0
		la		$a1, ANELF
		lw		$a2, 16 ($sp)
		lw		$a3, 20 ($sp)
		j		Results
		#  Error description print routine.
ANELF:	li		$v0, 4
		la		$a0, ANEIF1				#  "The observed value should not match the undesired value.\n"
		syscall
		la		$a0, Observed			#  "Observed:  "
		syscall
		lw		$a0, 0 ($sp)
		jal		Print_Hexadecimal
		li		$v0, 4
		la		$a0, nbsp
		syscall
		lw		$a0, 4 ($sp)
		jal		Print_Hexadecimal
		li		$v0, 4
		la		$a0, nl
		syscall

		la		$a0, Undesired			#  "Undesired:  "
		syscall
		lw		$a0, 8 ($sp)
		jal		Print_Hexadecimal
		li		$v0, 4
		la		$a0, nbsp
		syscall
		lw		$a0, 12 ($sp)
		jal		Print_Hexadecimal
		lw		$v0, 4
		la		$a0, nbsp
		syscall
		syscall

		addi	$sp, $sp, 24
		jr		$ra








		#######################################################################
		#  Assert equality for integer arrays with included size parameter
		#	$a0:  Observed
		#	$a1:  Expected
		#	$a2:  Test #
		#	$a3:  Test description
		#######################################################################
Assert_Equal_Array:
		#  1.  Check for a valid observed array.
		#      It should be a pointer to the data region of memory.
		lui		$t0, 0x1000								#  All data should be above 0x1000 0000 and not negative.
		blt		$a0, $t0, AEA_Failed_Outside_of_Memory
		#      It should also be word aligned, since the first value is an integer.
		li		$t0, 0xFFFFFFFC
		and		$t0, $a0, $t0						#  Set the last two bits to zero, to force it to be word aligned.
		bne		$a0, $t0, AEA_Failed_Not_Word_Aligned	#  The results should be equal.
		#  2.  Check to make sure the student isn't trying to pass off the expected array as the observed array.
		beq		$a0, $a1, AEA_Failed_Cheating
		#  These should pass unless the student has done something catastrophic.

		#  Assume that the data inside the array has been changed improperly and use the expected data for the length of the array.
		li		$t0, 0
		lw		$t1, 0 ($a1)
AEA_Loop:
		bgt		$t0, $t1, AEA_End_Loop

		sll		$t9, $t0, 2
		add		$t2, $a0, $t9
		lw		$t2, 0 ($t2)
		add		$t3, $a1, $t9
		lw		$t3, 0 ($t3)
		bne		$t2, $t3, AEA_Failed_Not_Equal

		addi	$t0, $t0, 1
		j		AEA_Loop
AEA_End_Loop:
		#  All elements are equal, so the arrays are equivalent.
		li		$a0, 1			#  Correct result.
		j		Results

AEA_Failed_Outside_of_Memory:
		li		$a0, 0			#  Incorrect result.
		la		$a1, AEAFOM		#  Description of failure.
		j		Results
		.data
AEAFOM:	.asciiz	"The array pointer is no longer within the data memory range.\nThis is bad, I do not know how you managed to accomplish this.\n"
		.text

AEA_Failed_Not_Word_Aligned:
		li		$a0, 0			#  Incorrect result.
		la		$a1, AEAFNWA	#  Description of failure.
		j		Results
		.data
AEAFNWA:	.asciiz	"The array pointer is no longer word aligned.\nThis is bad, I do now know how you managed to accomplish this.\n"
		.text

AEA_Failed_Cheating:
		li		$a0, 0			#  Incorrect result.
		la		$a1, AEAFC		#  Description of failure.
		j		Results
		.data
AEAFC:	.asciiz	"Cheating is bad, mmmkay?\nQuit trying to game the test suite.\n"
		.text

AEA_Failed_Not_Equal:
		addi	$sp, $sp, -12
		sw		$a0, 0 ($sp)	#  Store the observed array on the stack.
		sw		$a1, 4 ($sp)	#  Store the expected array on the stack.
		sw		$ra, 8 ($sp)	#  Store the return address on the stack.

		beq		$t0, $zero, AEA_Failed_Wrong_Length
		li		$a0, 0			#  Incorrect result.
		la		$a1, AEAFNE		#  Description of failure.
		j		Results
AEAFNE:	li		$v0, 4
		la		$a0, AEAFNE1
		syscall
		j		AEA_Print_Array
		.data
AEAFNE1:	.asciiz	"The observed array does not match the expected array.\n"
		.text

AEA_Failed_Wrong_Length:
		li		$a0, 0			#  Incorrect result.
		la		$a1, AEAFWL		#  Description of failure.
		j		Results
AEAFWL:	li		$v0, 4
		la		$a0, AEAFWL1
		syscall
		.data
AEAFWL1:	.asciiz	"The length of the array has been changed.\nYou should not need to modify the first element in the array.\n"
		.text

		#  Print out the contents of the array to show the student what (s)he did wrong.
AEA_Print_Array:
		lw		$t0, 0 ($sp)	#  Restore the observed array from the stack.
		lw		$t1, 4 ($sp)	#  Restore the expected array from the stack.

		li		$v0, 4
		la		$a0, Observed
		syscall
		move	$a0, $t0
		jal		Print_Integer_Array

		li		$v0, 4
		la		$a0, Expected
		syscall
		move	$a0, $t1
		jal		Print_Integer_Array

		lw		$ra, 8 ($sp)	#  Restore the return address from the stack.
		addi	$sp, $sp, 12
		jr		$ra






		#######################################################################
		#  Assert equal n-dimensional matrix of integers
		#	$a0:  Observed
		#	$a1:  Expected
		#	$a2:  Test #
		#	$a3:  Test description
		#
		#		The expected format has a top-level array where the first
		#  integer specifies the number of dimensions in the matrix.  The next
		#  n integers specify the size of each dimension.  The last value in
		#  the array is a pointer to the first level of the matrix.  Each level
		#  of the matrix contains pointers to an array at the next lower level
		#  until the last, which contains the actual data for that row.
		#######################################################################
Assert_Equal_nD_Matrix:
		#  1.  Check for a valid observed array.
		#      It should be a pointer to the data region of memory.
		lui		$t0, 0x1000								#  All data should be above 0x1000 0000 and not negative.
		blt		$a0, $t0, AEA_Failed_Outside_of_Memory
		#      It should also be word aligned, since the first value is an integer.
		li		$t0, 0xFFFFFFFC
		and		$t0, $a0, $t0						#  Set the last two bits to zero, to force it to be word aligned.
		bne		$a0, $t0, AEA_Failed_Not_Word_Aligned	#  The results should be equal.
		#  2.  Check to make sure the student isn't trying to pass off the expected array as the observed array.
		beq		$a0, $a1, AEA_Failed_Cheating
		#  These should pass unless the student has done something catastrophic.

		lw		$t0, 0 ($a0)
		lw		$t1, 0 ($a1)
		#  3.  Check to see that both data structures report the same number of dimensions.
		bne		$t0, $t1, AEnM_Mismatched_Dimensions

		#  4.  Iterate over the dimension sizes to make sure they all match.
		sll		$t0, $t0, 4
		li		$t1, 4
AEnM_Dimension_Loop:
		bgt		$t1, $t0, AEnMDL_End
		add		$t2, $a0, $t1
		add		$t3, $a1, $t1
		lw		$t2, 0 ($t2)
		lw		$t3, 0 ($t3)
		bne		$t2, $t3, AEnM_Mismatched_Sizes
		addi	$t1, $t1, 4
		j		AEnM_Dimension_Loop
AEnMDL_End:

		#  5.  Check to make sure the student isn't trying to pass off the expected array as the observed array.
		add		$t2, $a0, $t1
		add		$t3, $a0, $t1
		lw		$t2, 0 ($t2)
		lw		$t3, 0 ($t3)
		beq		$t2, $t3, AEA_Failed_Cheating

		#  6.  Iterate over the dimensions loading data and comparing it.
		#	   Data should always be equal, but pointers should never be equal.

#  TODO:  Add code to programmatically walk across the pair of n-dimensional arrays and compare the results.

		#  Failed because the number of dimensions did not match.
AEnM_Mismatched_Dimensions:
		addi	$sp, $sp, -8
		sw		$t0, 0 ($sp)		#  Observed number of dimensions
		sw		$t1, 4 ($sp)		#  Expected number of dimensions

		li		$a0, 0				#  Incorrect result
		la		$a1, AEnMMD_Print_Failure
		j		Results
		#  Display reason for failure.
AEnMMD_Print_Failure:
		li		$v0, 4
		la		$a0, AEnMMD
		syscall
		la		$a0, Observed
		syscall
		li		$v0, 1
		lw		$a0, 0 ($sp)
		syscall
		li		$v0, 4
		la		$a0, nl
		syscall
		la		$a0, Expected
		syscall
		li		$v0, 1
		lw		$a0, 4 ($sp)
		syscall
		li		$v0, 4
		la		$a0, nl
		syscall
		syscall

		addi	$sp, $sp, 8
		jr		$ra

		#  Failed because the size of one or more dimensions did not match.
AEnM_Mismatched_Sizes:
		addi	$sp, $sp, -12
		sw		$a0, 0 ($sp)			#  Observered matrix
		sw		$a1, 4 ($sp)			#  Expected matrix
		sw		$ra, 8 ($sp)			#  Return address

		li		$a0, 0					#  Incorrect result
		la		$a1, AEnMMS_Print_Failure
		j		Results
		#  Display reason for failure.
AEnMMS_Print_Failure:
		li		$v0, 4
		la		$a0, AEnMMS
		syscall

		la		$a0, Observed
		syscall
		lw		$a0, 0 ($sp)
		jal		Print_Integer_Array

		li		$v0, 4
		la		$a0, Expected
		syscall
		lw		$a0, 4 ($sp)
		jal		Print_Integer_Array

		li		$v0, 4
		la		$a0, nl
		syscall
		syscall

		lw		$ra, 8 ($sp)
		addi	$sp, $sp, 12
		jr		$ra

		#  Failed because one or more elements did not match the expected value.
AEnM_Data:
		addi	$sp, $sp, -12
		sw		$a0, 0 ($sp)			#  Observed matrix
		sw		$a1, 4 ($sp)			#  Expected matrix
		sw		$ra, 8 ($sp)			#  Return address

		li		$a0, 0					#  Incorrect result
		la		$a1, AEnMD_Print_Failure
		j		Results
		#  Display reason for failure.
AEnMD_Print_Failure:
#  TODO:  Add code to walk over the matrices and display the data.

		.data
AEnMMD:	.asciiz	"The number of dimensions in the matrix is incorrect.\n"
AEnMMS:	.asciiz	"The size of the matrix is incorrect.\n"
AEnMD:	.asciiz	"The data in the matrix does not match the expected result.\n"
		.text






		#######################################################################
		#  Assert equal for Scheme-style lists
		#	$a0:	Observed data
		#	$a1:	Observed data type
		#	$a2:	Expected data
		#	$a3:	Expected data type
		#	$sp-4:	Test #
		#	$sp-8:	Test description
		#######################################################################
Assert_Equal_Scheme_List:
		move	$t0, $a0
		move	$t1, $a1
		move	$t2, $a2
		move	$t3, $a3
		lw		$a2, -4 ($sp)
		lw		$a3, -8 ($sp)
		move	$fp, $sp
		
		#  Push top level data.
		addi	$sp, $sp, -16
		sw		$t0,  0 ($sp)
		sw		$t1,  4 ($sp)
		sw		$t2,  8 ($sp)
		sw		$t3, 12 ($sp)
		
AESL_Test_Loop:
		beq		$sp, $fp, AESL_Correct
		
		#  Pop the requisite data from the stack.
		lw		$t0,  0 ($sp)	#  Observed.data
		lw		$t1,  4 ($sp)	#  Observed.datatype
		lw		$t2,  8 ($sp)	#  Expected.data
		lw		$t3, 12 ($sp)	#  Expected.datatype
		addi	$sp, $sp, 16
		
		#  If the data types do not match, then give up immediately.
		bne		$t1, $t3, AESL_Datatype_Mismatch
		
		#  If the data type is a list, then begin processing it.
		li		$t9, 3
		beq		$t3, $t9, AESL_Test_List
		
		#  Since the data type isn't a list, just compare the data.
		bne		$t0, $t2, AESL_Data_Failed
		
		#  Found another correct entry.
		j		AESL_Test_Loop
		
AESL_Test_List:
		#  TODO:  Add code to make sure the observed list does not point to the expected list.
		addi	$sp, $sp, -32
		#  Push the head onto the stack.
		lw		$t4,  0 ($t0)	#  car(observed)
		lb		$t5,  8 ($t0)
		lw		$t6,  0 ($t2)	#  car(expected)
		lb		$t7,  8 ($t2)
		sw		$t4,  0 ($sp)
		sw		$t5,  4 ($sp)
		sw		$t6,  8 ($sp)
		sw		$t7, 12 ($sp)
		#  Push the tail onto the stack
		lw		$t4,  4 ($t0)	#  cdr(observed)
		lb		$t5,  9 ($t0)
		lw		$t6,  4 ($t2)	#  cdr(expected)
		lb		$t7,  9 ($t2)
		sw		$t4, 16 ($sp)
		sw		$t5, 20 ($sp)
		sw		$t6, 24 ($sp)
		sw		$t7, 28 ($sp)
		
		j		AESL_Test_Loop

AESL_Correct:	#  Having run out of stuff to test, the result should be correct.
		li		$a0, 1			#  Correct result.
		j		Results
		
AESL_Datatype_Mismatch:
		move	$sp, $fp
		li		$a0, 0			#  Incorrect result.
		la		$a1, AESLDM
		j		Results
#  TODO:  Implement a fancy dynamic error message...  Probably never.

AESL_Data_Failed:
		move	$sp, $fp
		li		$a0, 0			#  Incorrect result.
		la		$a1, AESLDF
		j		Results
#  TODO:  Implement a fancy dynamic error message...  Probably never.
		.data
AESLDM:	.asciiz	"Observed data type does not match the expected result.\n"
AESLDF:	.asciiz	"Observed data does not match the expected result.\n"
		.text
		
		





		#######################################################################
		#  Assert null pointer
		#	$a0:  Observed
		#	   :  Expect a null pointer (0).
		#	$a2:  Test #
		#	$a3:  Test description
		#######################################################################
Assert_Null:
		bne		$a0, $zero, AN_Failed

		li		$a0, 1			#  Correct result.
		j		Results

AN_Failed:
		li		$a0, 0			#  Incorrect result.
		la		$a1, ANF		#  Description of failure.
		j		Results
		.data
ANF:	.asciiz	"Null pointer expected.\n"
		.text





		#######################################################################
		#  Assert valid pointer
		#	$a0:  Observed
		#	   :  Expect a null pointer (0).
		#	$a2:  Test #
		#	$a3:  Test description
		#######################################################################
Assert_Not_Null:
		beq		$t0, $zero, ANN_Failed

		li		$a0, 1			#  Correct result.
		j		Results

ANN_Failed:
		li		$a0, 0			#  Incorrect result.
		la		$a1, ANF		#  Description of failure.
		j		Results
		.data
ANNF:	.asciiz	"Null pointer not expected.\n"
		.text





		#######################################################################
		#  Assert error
		#	$a0:  Observed
		#	   :  Expect an error signal (0x8000 0001).
		#	$a2:  Test #
		#	$a3:  Test description
		#######################################################################
Assert_Error:
		li		$t0, 0x80000001
		bne		$a0, $t0, AE_Failed

		li		$a0, 1			#  Correct result.
		j		Results

AE_Failed:
		li		$a0, 0			#  Incorrect result.
		la		$a1, AEF		#  Description of failure.
		j		Results
		.data
AEF:	.asciiz	"The parameters were not parsable, the function should have returned an error (0x8000 0001).\n"
		.text





		#######################################################################
		#  Results
		#
		#  Display the results of the test.
		#	$a0:  Pass (1) or fail (0).
		#	$a1:  Description of failure if needed.
		#	$a2:  Test #
		#	$a3:  Test description
		#######################################################################
Results:
		bnez		$a0, checkSavedRegisters
Res1:	move		$t0, $a0
		move		$t1, $a1
		move		$t2, $a2
		move		$t3, $a3
		#  Print the header.
		li		$v0, 4
		la		$a0, R1
		syscall
		li		$v0, 1
		move	$a0, $t2
		syscall

		bnez		$t0, RPass

		#  Failed the test.
		li		$v0, 4
		la		$a0, RF
		syscall
		move	$a0, $t3
		syscall
		la		$a0, nl
		syscall
		blt		$t1, 0x10000000, RPrintFunction
		move	$a0, $t1			#  Displaying a simple error message.
		syscall
		la		$a0, nl
		syscall
		jr		$ra
RPrintFunction:						#  Calling a print function for extra detail.
		jr		$t1

		#  Passed the test.
RPass:	li		$v0, 4
		la		$a0, RP
		syscall
		move	$a0, $t3
		syscall
		la		$a0, nl
		syscall
		jr		$ra

		.data
R1:		.asciiz	"Test #"
nl:		.asciiz	"\n"
RP:		.asciiz	" passed:  "
RF:		.asciiz	" failed:  "
		.text




		#  Set Saved Registers
		#######################################################################
Initialize_Test_Suite:
setSavedRegisters:
		li		$s0, 14
		li		$s1, 73
		li		$s2, 69
		li		$s3, 46
		li		$s4, 79
		li		$s5, 92
		li		$s6, 37
		li		$s7, 96
		li		$t0, 14
		li		$t1, -72
		li		$t2, 12331
		li		$t3, 18
		li		$t4, 456
		li		$t5, 09876
		li		$t6, 6789
		li		$t7, 3443
		li		$t8, 2343
		li		$t9, 98
		li		$v0, 3876
		li		$v1, 3443
		li		$a0, 23453
		li		$a1, 34432
		li		$a2, 543
		li		$a3, -234543
		jr		$ra

		#  Check Saved Registers
		#######################################################################
checkSavedRegisters:
		bne		$s0, 14, regFail
		bne		$s1, 73, regFail
		bne		$s2, 69, regFail
		bne		$s3, 46, regFail
		bne		$s4, 79, regFail
		bne		$s5, 92, regFail
		bne		$s6, 37, regFail
		bne		$s7, 96, regFail
		j		Res1

regFail:
		.data
rf:		.asciiz	"Your function returned the correct value, but has changed the saved registers.\nYou must follow the conventions and restore the state of any saved register ($s0-$s7) when you're finished with it.\n"
		.text
		li		$a0, 0
		la		$a1, rf
		j		Res1
