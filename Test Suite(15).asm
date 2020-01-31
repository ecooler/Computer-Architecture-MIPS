###########################################################################################
#                     		   Unit Tests for Tic-Tac-Toe		                          #
#                                                                                         #
###########################################################################################
		.data
		#  Matrices are specified by # of rows and # of cols followed by elements listed in row major format.
Empty:	.word	3, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0
X1:		.word	3, 3, 0, 1, 0, 0, 0, 0, 0, 0, 0
X2:		.word	3, 3, 0, 1, 0, 0, 0, 0, 0, 1, 0
O1:		.word	3, 3, 0, 1, 0, 0, 0, 2, 0, 1, 0
O2:		.word	3, 3, 0, 1, 2, 0, 0, 2, 0, 1, 0
WinX:	.word	3, 3, 1, 0, 0, 0, 1, 0, 0, 0, 1
WinO:	.word	3, 3, 0, 0, 0, 2, 2, 2, 0, 0, 0
		.text
		
main:	addi	$sp, $sp, 4			#  Make space for $ra on stack
		sw		$ra, 0 ($sp)		#  Store the return address on the stack


		#  Test #1
		#  Initialize
		#######################################################################
		jal		initialize			#  Call initialize() function
		
		li		$a3, 1				#  Test #1
		move	$a0, $v0			#  Result
		la		$a1, Empty			#  Expected result
		jal		assertEqual			#  Check for equality
		
		
		#  Test #2
		#  Initialize
		#######################################################################
		jal		initialize			#  Call initialize() function
		
		li		$a3, 2				#  Test #2
		move	$a0, $v0			#  Result
		la		$a1, Empty			#  Expected result
		jal		assertEqual			#  Check for equality
		
		
		#  Test #3
		#  Play_X(1, 0)
		#######################################################################
		la		$a0, Empty			#  grid
		li		$a1, 1				#  x
		li		$a2, 0				#  y
		jal		play_X				#  Call play_X function
		
		li		$a3, 3				#  Test #3
		move	$a0, $v0			#  Result
		la		$a1, X1				#  Expected result
		jal		assertEqual			#  Check for equality
		
		
		#  Test #4
		#  Play_X(1, 2)
		#######################################################################
		la		$a0, X1				#  grid
		li		$a1, 1				#  x
		li		$a2, 2				#  y
		jal		play_X				#  Call play_X function
		
		li		$a3, 4				#  Test #4
		move	$a0, $v0			#  Result
		la		$a1, X2				#  Expected result
		jal		assertEqual			#  Check for equality
		
		
		#  Test #5
		#  Play_O(2, 1)
		#######################################################################
		la		$a0, X2				#  grid
		li		$a1, 2				#  x
		li		$a2, 1				#  y
		jal		play_O				#  Call Play_O function
		
		li		$a3, 5				#  Test #5
		move	$a0, $v0			#  Result
		la		$a1, O1				#  Expected result
		jal		assertEqual			#  Check for equality
		
		
		#  Test #6
		#  Play_O(2, 0)
		#######################################################################
		la		$a0, O1				#  grid
		li		$a1, 2				#  x
		li		$a2, 0				#  y
		jal		play_O				#  Call Play_O function
		
		li		$a3, 6				#  Test #6
		move	$a0, $v0			#  Result
		la		$a1, O2				#  Expected result
		jal		assertEqual			#  Check for equality
		
		
		#  Test #7
		#  Win X
		#######################################################################
		jal		Initialize_Test_Suite
		la		$a0, WinX			#  grid
		jal		win					#  Call win function
		
		move	$a0, $v0			#  Result
		li		$a1, 1				#  Expected result
		li		$a2, 7				#  Test #7
		la		$a3, s7				#  Test description
		jal		Assert_Equal_Integer	#  Check for equality
		.data
s7:		.asciiz	"Testing a win condition for player X"
		.text
		
		
		#  Test #8
		#  Win O
		#######################################################################
		jal		Initialize_Test_Suite
		la		$a0, WinO			#  grid
		jal		win					#  Call win function
		
		move	$a0, $v0			#  Result
		li		$a1, 1				#  Expected result
		li		$a2, 8				#  Test #8
		la		$a3, s9				#  Test description
		jal		Assert_Equal_Integer	#  Check for equality
		.data
s8:		.asciiz	"Testing a win condition for player O"
		.text


		#  Quit unit testing
		#######################################################################
		li		$v0, 10
		syscall
		
		
		#  Assert Equality
		#######################################################################
assertEqual:
		.data
eq1:	.asciiz	"Test #"
eq2:	.asciiz " failed:  Expected value:  "
eq3:	.asciiz	" \tObserved value:  "
eq4:	.asciiz "\n"
eq5:	.asciiz " failed:  The result matrix was not the correct size.\n"
		.text
		
		move	$s7, $a3			#  Save test #
		beq		$a0, $0, default	#  If the result pointer is null, then just fail.
		
		lw		$t0, 0 ($a0)		#  Result # of rows
		lw		$t1, 4 ($a0)		#  Result # of columns
		lw		$s0, 0 ($a1)		#  Expected # of rows
		lw		$s1, 4 ($a1)		#  Expected # of columns
		
		bne		$t0, $s0, failSize	#  If the number of rows does not match, then fail
		bne		$t1, $s1, failSize	#  If the number of columns does not match, then fail
		li		$t3, 8				#  Initialize array counter
		mult	$t0, $t1			#  Calculate number of elements in the matrix
		mflo	$t4
		addi	$t4, $t4, 2	
		sll		$t4, $t4, 2			#  Termination condition
		
aeLoop:	beq		$t3, $t4, Pass		#  If all elements are correct, then the result is correct
		add		$t5, $t3, $a0
		lw		$t5, 0 ($t5)		#  Fetch current element in the result matrix
		add		$t6, $t3, $a1
		lw		$t6, 0 ($t6)		#  Fetch current element in the expected matrix
		
		bne		$t5, $t6, aeFail	#  If the elements are not the same, then fail
		addi	$t3, $t3, 4			#  Increment array counter
		j		aeLoop				#  Check next element
		
aeFail:	li		$v0, 4				#  Print string
		la		$a0, eq1			#  "Test #"
		syscall
		
		li		$v0, 1				#  Print test number
		move	$a0, $s7
		syscall
		
		li		$v0, 4				#  Print string
		la		$a0, eq2			#  " failed:  Expected value:  "
		syscall
		
		li		$v0, 1				#  Print expected value
		move	$a0, $t6
		syscall
		
		li		$v0, 4				#  Print string
		la		$a0, eq3			#  " Observed value:  "
		syscall
		
		li		$v0, 1				#  Print observed value
		move	$a0, $t5
		syscall
		
		li		$v0, 4				#  Print string
		la		$a0, eq4			#  "\n"
		syscall

#  Switch commenting on the next three lines to continue checking after finding inequal numbers.
#  This may help in debugging at the cost of many more lines of error text.
#		addi	$t3, $t3, 4			#  Incerement the array counter
#		j		aeLoop				#  Check next element
		jr		$ra					#  Quit processing this matrix
		
failSize:
		li		$v0, 4				#  Print string
		la		$a0, eq1			#  "Test #"
		syscall
		
		li		$v0, 1				#  Print test number
		move	$a0, $s7
		syscall
		
		li		$v0, 4				#  Print string
		la		$a0, eq5			#  " failed:  The result matrix was not the correct size.\n"
		syscall
		
#  If the matrices are the wrong size, then we should not continue to attempt to read the matrices.
		jr		$ra					#  Incorrect matrix size
		
		
		#  Assert Failure
		#######################################################################
assertFail:
		.data
fail1:	.asciiz	"Test #"
fail2:	.asciiz " failed.  The function returned a pointer.\n"
		.text
		
		move	$s7, $a3			#  Store test number
		bne		$a0, $zero, fFail	#  If the pointer is not null, then fail
		j		Pass

fFail:	li		$v0, 4				#  Print string
		la		$a0, fail1			#  "Test #"
		syscall
		
		li		$v0, 1				#  Print test number
		move	$a0, $s7
		syscall
		
		li		$v0, 4				#  Print string
		la		$a0, fail2			#  " failed.  The function returned a pointer.\n"
		syscall
		
		jr		$ra					#  Failed null pointer check
		
		
		#  Default Failure
		#######################################################################
		.data
d1:		.asciiz	" has not yet been implemented (or for some other reason received a null pointer.)\n"
		.text
default:
		li		$v0, 4				#  Print string
		la		$a0, eq1			#  "Test #"
		syscall
		
		li		$v0, 1				#  Print test number
		move	$a0, $s7
		syscall
		
		li		$v0, 4				#  Print string
		la		$a0, d1				#  " has not yet been implemented.\n"
		syscall
		
		jr		$ra					#  Procedure has not yet been implemented
		
		
		#  Assertion Success
		#######################################################################
		.data
s1:		.asciiz	" passed.\n"
		.text
Pass:	li		$v0, 4				#  Print string
		la		$a0, eq1			#  "Test #"
		syscall
		
		li		$v0, 1				#  Print test number
		move	$a0, $s7
		syscall
		
		li		$v0, 4				#  Print string
		la		$a0, s1				#  " passed.\n"
		syscall
		
		jr		$ra					#  Successfully checked all numbers in the matrix
		
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
