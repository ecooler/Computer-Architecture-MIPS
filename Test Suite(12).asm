


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
#					Assert_Equal_Raw_Array													#
#					Assert_Null																#
#					Assert_Not_Null															#
#					Assert_Error															#
#					Assert_Equal_Long														#
#					Assert_Not_Equal_Long													#
#					Assert_Equal_Scheme_List												#
#  v. 1.3	Added primitive support for Scheme-style lists.									#
#			Improved support for raw arrays.												#
#  v. 1.2	Added the Print_Divider function.												#
#  v. 1.1	Bug fix in Assert_Null.															#
#			Added Initialize_Test_Suite as a sensible mnemonic.								#
#  v. 1		Initial release  (It appears to work.)											#
#############################################################################################

main:	addi	$sp, $sp, -4		#  Make space for $ra on stack
		sw		$ra, 0 ($sp)		#  Store the return address on the stack

#############################################################################################
#								array double raw Tests										#
		la		$a0, type1
		jal		Print_Divider
#############################################################################################
		#  Test #1
		#  A singleton.
		#######################################################################
		jal		Initialize_Test_Suite
		la		$a0, da1			#  Array
		li		$a1, 1				#  Length
		jal		array_double_raw
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Expected result
		li		$a2, 1				#  Test #1
		la		$a3, sa1a			#  Description of test
		jal		Assert_Equal_Integer
		la		$a0, da1			#  Modified array
		la		$a1, ra1			#  Expected result
		li		$a2, 1				#  Test #1
		la		$a3, sa1			#  Description of test
		li		$t0, 1				#  Length of the array
		sw		$t0, -4 ($sp)
		jal		Assert_Equal_Raw_Array	#  Check for equality.
		.data
da1:	.word	1
ra1:	.word	2
sa1a:	.asciiz	"Checking error code for success."
sa1:	.asciiz	"[1] => [2]"
		.text
		
		
		#  Test #2
		#  A singleton.
		#######################################################################
		jal		Initialize_Test_Suite
		la		$a0, da2			#  Array
		li		$a1, 1				#  Length
		jal		array_double_raw
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Expected result
		li		$a2, 2				#  Test #2
		la		$a3, sa1a			#  Description of test
		jal		Assert_Equal_Integer
		la		$a0, da2			#  Modified array
		la		$a1, ra2			#  Expected result
		li		$a2, 2				#  Test #2
		la		$a3, sa2			#  Description of test
		li		$t0, 1				#  Length of the array
		sw		$t0, -4 ($sp)
		jal		Assert_Equal_Raw_Array	#  Check for equality.
		.data
da2:	.word	5
ra2:	.word	10
sa2:	.asciiz	"[5] => [10]"
		.text


		#  Test #3
		#  A short array.
		#######################################################################
		jal		Initialize_Test_Suite
		la		$a0, da3			#  Array
		li		$a1, 2				#  Length
		jal		array_double_raw
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Expected result
		li		$a2, 3				#  Test #3
		la		$a3, sa1a			#  Description of test
		jal		Assert_Equal_Integer
		la		$a0, da3			#  Modified array
		la		$a1, ra3			#  Expected result
		li		$a2, 3				#  Test #3
		la		$a3, sa3			#  Description of test
		li		$t0, 2				#  Length of the array
		sw		$t0, -4 ($sp)
		jal		Assert_Equal_Raw_Array	#  Check for equality.
		.data
da3:	.word	2 6
ra3:	.word	4 12
sa3:	.asciiz	"[2 6] => [4 12]"
		.text


		#  Test #4
		#  A generic array.
		#######################################################################
		jal		Initialize_Test_Suite
		la		$a0, da4			#  Array
		li		$a1, 9				#  Length
		jal		array_double_raw
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Expected result
		li		$a2, 4				#  Test #4
		la		$a3, sa1a			#  Description of test
		jal		Assert_Equal_Integer
		la		$a0, da4			#  Modified array
		la		$a1, ra4			#  Expected result
		li		$a2, 4				#  Test #4
		la		$a3, sa4			#  Description of test
		li		$t0, 9				#  Length of the array
		sw		$t0, -4 ($sp)
		jal		Assert_Equal_Raw_Array	#  Check for equality.
		.data
da4:	.word	 5  3 18 -45 31  -9 21  5 -3
ra4:	.word	10  6 36 -90 62 -18 42 10 -6
sa4:	.asciiz	"[5 3 18 -45 31 -9 21 5 -3] => [10 6 36 -90 62 -18 42 10 -6]"
		.text


		#  Test #5
		#  A long array.
		#######################################################################
		jal		Initialize_Test_Suite
		la		$a0, da5			#  Array
		li		$a1, 26				#  Length
		jal		array_double_raw
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Expected result
		li		$a2, 5				#  Test #5
		la		$a3, sa1a			#  Description of test
		jal		Assert_Equal_Integer
		la		$a0, da5			#  Modified array
		la		$a1, ra5			#  Expected result
		li		$a2, 5				#  Test #5
		la		$a3, sa5			#  Description of test
		li		$t0, 26				#  Length of the array
		sw		$t0, -4 ($sp)
		jal		Assert_Equal_Raw_Array	#  Check for equality.
		.data
da5:	.word	 -5  9 10 48 -39 40  -85 -38  59 37 -48 37  -9 38  -9  -83 -2 39  58 -2 -4  -86 28 38 24 -3
ra5:	.word	-10 18 20 96 -78 80 -170 -76 118 74 -96 74 -18 76 -18 -166 -4 78 116 -4 -8 -172 56 76 48 -6
sa5:	.asciiz	"Testing with a long array."
		.text
		
		
#############################################################################################
		#  Test #101
		#  Try to read from a null array.
		#######################################################################
		jal		Initialize_Test_Suite
		li		$a0, 0				#  Array
		li		$a1, 1				#  Length
		jal		array_double_raw
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Unexpected result
		li		$a2, 101			#  Test #101
		la		$a3, c101			#  Description of test
		jal		Assert_Not_Equal_Integer	#  Check for an error.
		.data
c101:	.asciiz	"Null pointer check."
		.text
		
		
		#  Test #102
		#  Array begins outside of memory.
		#######################################################################
		jal		Initialize_Test_Suite
		li		$a0, -40			#  Array
		li		$a1, 1				#  Length
		jal		array_double_raw
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Unexpected result
		li		$a2, 102			#  Test #102
		la		$a3, c103			#  Description of test
		jal		Assert_Not_Equal_Integer	#  Check for an error
		.data
c103:	.asciiz	"Array pointer below zero."
		.text
		
		
		#  Test #103
		#  Pointer begins outside of memory
		#######################################################################
		jal		Initialize_Test_Suite
		li		$a0, 0x0FCDA890		#  Array
		li		$a1, 1				#  Length
		jal		array_double_raw
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Unexpected result
		li		$a2, 103			#  Test #103
		la		$a3, c105			#  Description of test
		jal		Assert_Not_Equal_Integer	#  Check for an error.
		.data
c105:	.asciiz	"Pointer in text range."
		.text
		
		
		#  Test #104
		#  Pointer outside of memory
		#######################################################################
		jal		Initialize_Test_Suite
		li		$a0, 0xC0000000		#  Array
		li		$a1, 1				#  Length
		jal		array_double_raw
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Unexpected result
		li		$a2, 104			#  Test #104
		la		$a3, c107			#  Description of test
		jal		Assert_Not_Equal_Integer	#  Check for an error.
		.data
c107:	.asciiz	"Pointer too high for dynamic data memory."
		.text
		
		
		#  Test #105
		#  Non-word aligned array
		#######################################################################
		jal		Initialize_Test_Suite
		li		$a0, 0x10000002		#  Array
		li		$a1, 1				#  Length
		jal		array_double_raw
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Unexpected result
		li		$a2, 105			#  Test #105
		la		$a3, c109			#  Description of test
		jal		Assert_Not_Equal_Integer	#  Check for an error.
		.data
c109:	.asciiz	"Pointer is not word aligned."
		.text
		
		
		
		#  Test #106
		#  Non-word aligned array
		#######################################################################
		jal		Initialize_Test_Suite
		li		$a0, 0x10000009		#  Array
		li		$a1, 1				#  Length
		jal		array_double_raw
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Unexpected result
		li		$a2, 106			#  Test #106
		la		$a3, c109			#  Description of test
		jal		Assert_Not_Equal_Integer	#  Check for an error.
		
		
		#  Test #107
		#  Non-word aligned array
		#######################################################################
		jal		Initialize_Test_Suite
		li		$a0, 0x10000013		#  Array
		li		$a1, 1				#  Length
		jal		array_double_raw
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Unexpected result
		li		$a2, 107			#  Test #107
		la		$a3, c109			#  Description of test
		jal		Assert_Not_Equal_Integer	#  Check for an error.
		
		
		#  Test #108
		#  Bad array length
		#######################################################################
		jal		Initialize_Test_Suite
		la		$a0, d115			#  Array
		li		$a1, -43				#  Length
		jal		array_double_raw
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Unexpected result
		li		$a2, 108			#  Test #108
		la		$a3, c115			#  Description of test
		jal		Assert_Not_Equal_Integer	#  Check for an error.
		.data
d115:	.word	134, 654
c115:	.asciiz	"Negative array length."
		.text
		
		
		#  Test #109
		#  Array extends outside of memory
		#######################################################################
		jal		Initialize_Test_Suite
		la		$a0, d119			#  Array
		li		$a1, 0x80000000		#  Length
		jal		array_double_raw
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Unexpected result
		li		$a2, 109			#  Test #109
		la		$a3, c119			#  Description of test
		jal		Assert_Not_Equal_Integer	#  Check for an error.
		.data
d119:	.word	134, 654
c119:	.asciiz	"Array extends outside of memory."
		.text
		
		
		#  Test #110
		#  Array extends outside of memory, but wraps around to the beginning of memory again.
		#######################################################################
		jal		Initialize_Test_Suite
		la		$a0, d121			#  Array
		li		$a1, 0xFFFFFFF8		#  Length
		jal		array_double_raw
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Unexpected result
		li		$a2, 110			#  Test #110
		la		$a3, c121			#  Description of test
		jal		Assert_Not_Equal_Integer	#  Check for an error.
		.data
d121:	.word	134, 654
c121:	.asciiz	"Array wraps around to the beginning of memory."
		.text
		
		
		#  Test #111
		#  Array remains inside of memory but attempts to cross from the heap to the stack.
		#######################################################################
		jal		Initialize_Test_Suite
		la		$a0, d123			#  Array
		sub		$a1, $sp, $a0
		srl		$a1, $a1, 2			#  Cracked length of the array.
		jal		array_double_raw
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Unexpected result
		li		$a2, 111			#  Test #111
		la		$a3, c123			#  Description of test
		jal		Assert_Not_Equal_Integer	#  Check for an error.
		.data
d123:	.word	134, 654
c123:	.asciiz	"Array is inside of the memory range, but attempts to cross from the heap to the stack."
		.text
		
		
		
		
		
		
		
#############################################################################################
#										array double Tests									#
		la		$a0, type2
		jal		Print_Divider
#############################################################################################
		#  Test #1
		#  A singleton.
		#######################################################################
		jal		Initialize_Test_Suite
		la		$a0, db1			#  Array
		jal		array_double
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Expected result
		li		$a2, 1				#  Test #1
		la		$a3, sb1a			#  Description of test
		jal		Assert_Equal_Integer
		la		$a0, db1			#  Modified array
		la		$a1, rb1			#  Expected result
		li		$a2, 1				#  Test #1
		la		$a3, sb1			#  Description of test
		jal		Assert_Equal_Array	#  Check for equality.
		.data
db1:	.word	1 1
rb1:	.word	1 2
sb1a:	.asciiz	"Checking error code for success."
sb1:	.asciiz	"[1] => [2]"
		.text
		
		
		#  Test #2
		#  A singleton.
		#######################################################################
		jal		Initialize_Test_Suite
		la		$a0, db2			#  Array
		jal		array_double
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Expected result
		li		$a2, 2				#  Test #2
		la		$a3, sb1a			#  Description of test
		jal		Assert_Equal_Integer
		la		$a0, db2			#  Modified array
		la		$a1, rb2			#  Expected result
		li		$a2, 2				#  Test #2
		la		$a3, sb2			#  Description of test
		jal		Assert_Equal_Array	#  Check for equality.
		.data
db2:	.word	1 5
rb2:	.word	1 10
sb2:	.asciiz	"[5] => [10]"
		.text


		#  Test #3
		#  A short array.
		#######################################################################
		jal		Initialize_Test_Suite
		la		$a0, db3			#  Array
		jal		array_double
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Expected result
		li		$a2, 3				#  Test #3
		la		$a3, sb1a			#  Description of test
		jal		Assert_Equal_Integer
		la		$a0, db3			#  Modified array
		la		$a1, rb3			#  Expected result
		li		$a2, 3				#  Test #3
		la		$a3, sb3			#  Description of test
		jal		Assert_Equal_Array	#  Check for equality.
		.data
db3:	.word	2 2 6
rb3:	.word	2 4 12
sb3:	.asciiz	"[2 6] => [4 12]"
		.text


		#  Test #4
		#  A generic array.
		#######################################################################
		jal		Initialize_Test_Suite
		la		$a0, db4			#  Array
		jal		array_double
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Expected result
		li		$a2, 4				#  Test #4
		la		$a3, sb1a			#  Description of test
		jal		Assert_Equal_Integer
		la		$a0, db4			#  Modified array
		la		$a1, rb4			#  Expected result
		li		$a2, 4				#  Test #4
		la		$a3, sb4			#  Description of test
		jal		Assert_Equal_Array	#  Check for equality.
		.data
db4:	.word	9  5  3 18 -45 31  -9 21  5 -3
rb4:	.word	9 10  6 36 -90 62 -18 42 10 -6
sb4:	.asciiz	"[5 3 18 -45 31 -9 21 5 -3] => [10 6 36 -90 62 -18 42 10 -6]"
		.text


		#  Test #5
		#  A long array.
		#######################################################################
		jal		Initialize_Test_Suite
		la		$a0, db5			#  Array
		jal		array_double
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Expected result
		li		$a2, 5				#  Test #5
		la		$a3, sb1a			#  Description of test
		jal		Assert_Equal_Integer
		la		$a0, db5			#  Modified array
		la		$a1, rb5			#  Expected result
		li		$a2, 5				#  Test #5
		la		$a3, sb5			#  Description of test
		jal		Assert_Equal_Array	#  Check for equality.
		.data
db5:	.word	26  -5  9 10 48 -39 40  -85 -38  59 37 -48 37  -9 38  -9  -83 -2 39  58 -2 -4  -86 28 38 24 -3
rb5:	.word	26 -10 18 20 96 -78 80 -170 -76 118 74 -96 74 -18 76 -18 -166 -4 78 116 -4 -8 -172 56 76 48 -6
sb5:	.asciiz	"Testing with a long array."
		.text
		
		
#############################################################################################
		#  Test #101
		#  Try to read from a null array.
		#######################################################################
		jal		Initialize_Test_Suite
		li		$a0, 0				#  Array
		jal		array_double
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Unexpected result
		li		$a2, 101			#  Test #101
		la		$a3, c101			#  Description of test
		jal		Assert_Not_Equal_Integer	#  Check for an error.
		
		
		#  Test #102
		#  Array begins outside of memory.
		#######################################################################
		jal		Initialize_Test_Suite
		li		$a0, -40			#  Array
		jal		array_double
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Unexpected result
		li		$a2, 102			#  Test #102
		la		$a3, c103			#  Description of test
		jal		Assert_Not_Equal_Integer	#  Check for an error
		
		
		#  Test #103
		#  Pointer begins outside of memory
		#######################################################################
		jal		Initialize_Test_Suite
		li		$a0, 0x0FCDA890		#  Array
		jal		array_double
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Unexpected result
		li		$a2, 103			#  Test #103
		la		$a3, c105			#  Description of test
		jal		Assert_Not_Equal_Integer	#  Check for an error.
		
		
		#  Test #104
		#  Pointer outside of memory
		#######################################################################
		jal		Initialize_Test_Suite
		li		$a0, 0xC0000000		#  Array
		jal		array_double
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Unexpected result
		li		$a2, 104			#  Test #104
		la		$a3, c107			#  Description of test
		jal		Assert_Not_Equal_Integer	#  Check for an error.
		
		
		#  Test #105
		#  Non-word aligned array
		#######################################################################
		jal		Initialize_Test_Suite
		li		$a0, 0x10000002		#  Array
		jal		array_double
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Unexpected result
		li		$a2, 105			#  Test #105
		la		$a3, c109			#  Description of test
		jal		Assert_Not_Equal_Integer	#  Check for an error.
		
		
		
		#  Test #106
		#  Non-word aligned array
		#######################################################################
		jal		Initialize_Test_Suite
		li		$a0, 0x10000009		#  Array
		jal		array_double
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Unexpected result
		li		$a2, 106			#  Test #106
		la		$a3, c109			#  Description of test
		jal		Assert_Not_Equal_Integer	#  Check for an error.
		
		
		#  Test #107
		#  Non-word aligned array
		#######################################################################
		jal		Initialize_Test_Suite
		li		$a0, 0x10000013		#  Array
		jal		array_double
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Unexpected result
		li		$a2, 107			#  Test #107
		la		$a3, c109			#  Description of test
		jal		Assert_Not_Equal_Integer	#  Check for an error.
		
		
		#  Test #108
		#  Bad array length
		#######################################################################
		jal		Initialize_Test_Suite
		la		$a0, db115			#  Array
		jal		array_double
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Unexpected result
		li		$a2, 108			#  Test #108
		la		$a3, c115			#  Description of test
		jal		Assert_Not_Equal_Integer	#  Check for an error.
		.data
db115:	.word	-43, 134, 654
		.text
		
		
		#  Test #109
		#  Array extends outside of memory
		#######################################################################
		jal		Initialize_Test_Suite
		la		$a0, db119			#  Array
		jal		array_double
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Unexpected result
		li		$a2, 109			#  Test #109
		la		$a3, c119			#  Description of test
		jal		Assert_Not_Equal_Integer	#  Check for an error.
		.data
db119:	.word	0x80000000, 134, 654
		.text
		
		
		#  Test #110
		#  Array extends outside of memory, but wraps around to the beginning of memory again.
		#######################################################################
		jal		Initialize_Test_Suite
		la		$a0, db121			#  Array
		jal		array_double
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Unexpected result
		li		$a2, 110			#  Test #110
		la		$a3, c121			#  Description of test
		jal		Assert_Not_Equal_Integer	#  Check for an error.
		.data
db121:	.word	0xFFFFFFF8, 134, 654
		.text
		
		
		#  Test #111
		#  Array remains inside of memory but attempts to cross from the heap to the stack.
		#######################################################################
		jal		Initialize_Test_Suite
		la		$a0, db123			#  Array
		sub		$t0, $sp, $a0
		srl		$t0, $t0, 2			#  Cracked length of the array.
		sw		$t0, 0 ($a0)
		jal		array_double
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Unexpected result
		li		$a2, 111			#  Test #111
		la		$a3, c123			#  Description of test
		jal		Assert_Not_Equal_Integer	#  Check for an error.
		.data
db123:	.word	3, 134, 654
		.text
		
		
		
		
		
		
		
#############################################################################################
#											increment Tests									#
		la		$a0, type3
		jal		Print_Divider
#############################################################################################
		#  Test #1
		#  A singleton.
		#######################################################################
		jal		Initialize_Test_Suite
		la		$a0, dc1			#  Array
		li		$a1, 0				#  Element to increment
		jal		increment
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Expected result
		li		$a2, 1				#  Test #1
		la		$a3, sb1a			#  Description of test
		jal		Assert_Equal_Integer
		la		$a0, dc1			#  Modified array
		la		$a1, rb1			#  Expected result
		li		$a2, 1				#  Test #1
		la		$a3, sb1			#  Description of test
		jal		Assert_Equal_Array	#  Check for equality.
		.data
dc1:	.word	1 1
		.text
		
		
		#  Test #2
		#  A singleton.
		#######################################################################
		jal		Initialize_Test_Suite
		la		$a0, dc2			#  Array
		li		$a1, 0				#  Element to increment
		jal		increment
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Expected result
		li		$a2, 2				#  Test #2
		la		$a3, sb1a			#  Description of test
		jal		Assert_Equal_Integer
		la		$a0, dc2			#  Modified array
		la		$a1, rc2			#  Expected result
		li		$a2, 2				#  Test #2
		la		$a3, sc2			#  Description of test
		jal		Assert_Equal_Array	#  Check for equality.
		.data
dc2:	.word	1 5
rc2:	.word	1 6
sc2:	.asciiz	"[5] => [6]"
		.text


		#  Test #3
		#  A short array.
		#######################################################################
		jal		Initialize_Test_Suite
		la		$a0, dc3			#  Array
		li		$a1, 1				#  Element to increment
		jal		increment
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Expected result
		li		$a2, 3				#  Test #3
		la		$a3, sb1a			#  Description of test
		jal		Assert_Equal_Integer
		la		$a0, dc3			#  Modified array
		la		$a1, rc3			#  Expected result
		li		$a2, 3				#  Test #3
		la		$a3, sc3			#  Description of test
		jal		Assert_Equal_Array	#  Check for equality.
		.data
dc3:	.word	2 2 6
rc3:	.word	2 2 7
sc3:	.asciiz	"[2 6] => [2 7]"
		.text


		#  Test #4
		#  A generic array.
		#######################################################################
		jal		Initialize_Test_Suite
		la		$a0, dc4			#  Array
		li		$a1, 2				#  Element to increment
		jal		increment
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Expected result
		li		$a2, 4				#  Test #4
		la		$a3, sb1a			#  Description of test
		jal		Assert_Equal_Integer
		la		$a0, dc4			#  Modified array
		la		$a1, rc4			#  Expected result
		li		$a2, 4				#  Test #4
		la		$a3, sc4			#  Description of test
		jal		Assert_Equal_Array	#  Check for equality.
		.data
dc4:	.word	9 5 3 18 -45 31 -9 21 5 -3
rc4:	.word	9 5 3 19 -45 31 -9 21 5 -3
sc4:	.asciiz	"[5 3 18 -45 31 -9 21 5 -3] => [5 3 19 -45 31 -9 21 5 -3]"
		.text


		#  Test #4
		#  A generic array.
		#######################################################################
		jal		Initialize_Test_Suite
		la		$a0, dc4			#  Array
		li		$a1, 3				#  Element to increment
		jal		increment
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Expected result
		li		$a2, 4				#  Test #4
		la		$a3, sb1a			#  Description of test
		jal		Assert_Equal_Integer
		la		$a0, dc4			#  Modified array
		la		$a1, rc4a			#  Expected result
		li		$a2, 4				#  Test #4
		la		$a3, sc4a			#  Description of test
		jal		Assert_Equal_Array	#  Check for equality.
		.data
rc4a:	.word	9 5 3 19 -44 31 -9 21 5 -3
sc4a:	.asciiz	"[5 3 19 -45 31 -9 21 5 -3] => [5 3 19 -44 31 -9 21 5 -3]"
		.text


		#  Test #4
		#  A generic array.
		#######################################################################
		jal		Initialize_Test_Suite
		la		$a0, dc4			#  Array
		li		$a1, 5				#  Element to increment
		jal		increment
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Expected result
		li		$a2, 4				#  Test #4
		la		$a3, sb1a			#  Description of test
		jal		Assert_Equal_Integer
		la		$a0, dc4			#  Modified array
		la		$a1, rc4b			#  Expected result
		li		$a2, 4				#  Test #4
		la		$a3, sc4b			#  Description of test
		jal		Assert_Equal_Array	#  Check for equality.
		.data
rc4b:	.word	9 5 3 19 -44 31 -8 21 5 -3
sc4b:	.asciiz	"[5 3 19 -44 31 -9 21 5 -3] => [5 3 19 -44 31 -8 21 5 -3]"
		.text


		#  Test #4
		#  A generic array.
		#######################################################################
		jal		Initialize_Test_Suite
		la		$a0, dc4			#  Array
		li		$a1, 7				#  Element to increment
		jal		increment
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Expected result
		li		$a2, 4				#  Test #4
		la		$a3, sb1a			#  Description of test
		jal		Assert_Equal_Integer
		la		$a0, dc4			#  Modified array
		la		$a1, rc4c			#  Expected result
		li		$a2, 4				#  Test #4
		la		$a3, sc4c			#  Description of test
		jal		Assert_Equal_Array	#  Check for equality.
		.data
rc4c:	.word	9 5 3 19 -44 31 -8 21 6 -3
sc4c:	.asciiz	"[5 3 19 -44 31 -8 21 5 -3] => [5 3 19 -44 31 -8 21 6 -3]"
		.text


		#  Test #4
		#  A generic array.
		#######################################################################
		jal		Initialize_Test_Suite
		la		$a0, dc4			#  Array
		li		$a1, 8				#  Element to increment
		jal		increment
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Expected result
		li		$a2, 4				#  Test #4
		la		$a3, sb1a			#  Description of test
		jal		Assert_Equal_Integer
		la		$a0, dc4			#  Modified array
		la		$a1, rc4d			#  Expected result
		li		$a2, 4				#  Test #4
		la		$a3, sc4d			#  Description of test
		jal		Assert_Equal_Array	#  Check for equality.
		.data
rc4d:	.word	9 5 3 19 -44 31 -8 21 6 -2
sc4d:	.asciiz	"[5 3 19 -44 31 -8 21 6 -3] => [9 5 3 19 -44 31 -8 21 6 -2]"
		.text


		#  Test #5
		#  A long array.
		#######################################################################
		jal		Initialize_Test_Suite
		la		$a0, dc5			#  Array
		li		$a1, 2				#  Element to increment
		jal		increment
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Expected result
		li		$a2, 5				#  Test #5
		la		$a3, sb1a			#  Description of test
		jal		Assert_Equal_Integer
		la		$a0, dc5			#  Modified array
		la		$a1, rc5			#  Expected result
		li		$a2, 5				#  Test #5
		la		$a3, sc5			#  Description of test
		jal		Assert_Equal_Array	#  Check for equality.
		.data
dc5:	.word	26 -5  9 10 48 -39 40 -85 -38 59 37 -48 37 -9 38 -9 -83 -2 39 58 -2 -4 -86 28 38 24 -3
rc5:	.word	26 -5  9 11 48 -39 40 -85 -38 59 37 -48 37 -9 38 -9 -83 -2 39 58 -2 -4 -86 28 38 24 -3
sc5:	.asciiz	"Testing with a long array."
		.text


		#  Test #5
		#  A long array.
		#######################################################################
		jal		Initialize_Test_Suite
		la		$a0, dc5			#  Array
		li		$a1, 2				#  Element to increment
		jal		increment
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Expected result
		li		$a2, 5				#  Test #5
		la		$a3, sb1a			#  Description of test
		jal		Assert_Equal_Integer
		la		$a0, dc5			#  Modified array
		la		$a1, rc5a			#  Expected result
		li		$a2, 5				#  Test #5
		la		$a3, sc5			#  Description of test
		jal		Assert_Equal_Array	#  Check for equality.
		.data
rc5a:	.word	26 -5  9 12 48 -39 40 -85 -38 59 37 -48 37 -9 38 -9 -83 -2 39 58 -2 -4 -86 28 38 24 -3
		.text


		#  Test #5
		#  A long array.
		#######################################################################
		jal		Initialize_Test_Suite
		la		$a0, dc5			#  Array
		li		$a1, 2				#  Element to increment
		jal		increment
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Expected result
		li		$a2, 5				#  Test #5
		la		$a3, sb1a			#  Description of test
		jal		Assert_Equal_Integer
		la		$a0, dc5			#  Modified array
		la		$a1, rc5b			#  Expected result
		li		$a2, 5				#  Test #5
		la		$a3, sc5			#  Description of test
		jal		Assert_Equal_Array	#  Check for equality.
		.data
rc5b:	.word	26 -5  9 13 48 -39 40 -85 -38 59 37 -48 37 -9 38 -9 -83 -2 39 58 -2 -4 -86 28 38 24 -3
		.text


		#  Test #5
		#  A long array.
		#######################################################################
		jal		Initialize_Test_Suite
		la		$a0, dc5			#  Array
		li		$a1, 25				#  Element to increment
		jal		increment
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Expected result
		li		$a2, 5				#  Test #5
		la		$a3, sb1a			#  Description of test
		jal		Assert_Equal_Integer
		la		$a0, dc5			#  Modified array
		la		$a1, rc5c			#  Expected result
		li		$a2, 5				#  Test #5
		la		$a3, sc5			#  Description of test
		jal		Assert_Equal_Array	#  Check for equality.
		.data
rc5c:	.word	26 -5  9 13 48 -39 40 -85 -38 59 37 -48 37 -9 38 -9 -83 -2 39 58 -2 -4 -86 28 38 24 -2
		.text


		#  Test #5
		#  A long array.
		#######################################################################
		jal		Initialize_Test_Suite
		la		$a0, dc5			#  Array
		li		$a1, 23				#  Element to increment
		jal		increment
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Expected result
		li		$a2, 5				#  Test #5
		la		$a3, sb1a			#  Description of test
		jal		Assert_Equal_Integer
		la		$a0, dc5			#  Modified array
		la		$a1, rc5d			#  Expected result
		li		$a2, 5				#  Test #5
		la		$a3, sc5			#  Description of test
		jal		Assert_Equal_Array	#  Check for equality.
		.data
rc5d:	.word	26 -5  9 13 48 -39 40 -85 -38 59 37 -48 37 -9 38 -9 -83 -2 39 58 -2 -4 -86 28 39 24 -2
		.text


		#  Test #5
		#  A long array.
		#######################################################################
		jal		Initialize_Test_Suite
		la		$a0, dc5			#  Array
		li		$a1, 25				#  Element to increment
		jal		increment
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Expected result
		li		$a2, 5				#  Test #5
		la		$a3, sb1a			#  Description of test
		jal		Assert_Equal_Integer
		la		$a0, dc5			#  Modified array
		la		$a1, rc5e			#  Expected result
		li		$a2, 5				#  Test #5
		la		$a3, sc5			#  Description of test
		jal		Assert_Equal_Array	#  Check for equality.
		.data
rc5e:	.word	26 -5  9 13 48 -39 40 -85 -38 59 37 -48 37 -9 38 -9 -83 -2 39 58 -2 -4 -86 28 39 24 -1
		.text


		#  Test #5
		#  A long array.
		#######################################################################
		jal		Initialize_Test_Suite
		la		$a0, dc5			#  Array
		li		$a1, 0				#  Element to increment
		jal		increment
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Expected result
		li		$a2, 5				#  Test #5
		la		$a3, sb1a			#  Description of test
		jal		Assert_Equal_Integer
		la		$a0, dc5			#  Modified array
		la		$a1, rc5f			#  Expected result
		li		$a2, 5				#  Test #5
		la		$a3, sc5			#  Description of test
		jal		Assert_Equal_Array	#  Check for equality.
		.data
rc5f:	.word	26 -4  9 13 48 -39 40 -85 -38 59 37 -48 37 -9 38 -9 -83 -2 39 58 -2 -4 -86 28 39 24 -1
		.text


		#  Test #5
		#  A long array.
		#######################################################################
		jal		Initialize_Test_Suite
		la		$a0, dc5			#  Array
		li		$a1, 25				#  Element to increment
		jal		increment
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Expected result
		li		$a2, 5				#  Test #5
		la		$a3, sb1a			#  Description of test
		jal		Assert_Equal_Integer
		la		$a0, dc5			#  Modified array
		la		$a1, rc5g			#  Expected result
		li		$a2, 5				#  Test #5
		la		$a3, sc5			#  Description of test
		jal		Assert_Equal_Array	#  Check for equality.
		.data
rc5g:	.word	26 -4  9 13 48 -39 40 -85 -38 59 37 -48 37 -9 38 -9 -83 -2 39 58 -2 -4 -86 28 39 24 0
		.text


		#  Test #5
		#  A long array.
		#######################################################################
		jal		Initialize_Test_Suite
		la		$a0, dc5			#  Array
		li		$a1, 25				#  Element to increment
		jal		increment
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Expected result
		li		$a2, 5				#  Test #5
		la		$a3, sb1a			#  Description of test
		jal		Assert_Equal_Integer
		la		$a0, dc5			#  Modified array
		la		$a1, rc5h			#  Expected result
		li		$a2, 5				#  Test #5
		la		$a3, sc5			#  Description of test
		jal		Assert_Equal_Array	#  Check for equality.
		.data
rc5h:	.word	26 -4  9 13 48 -39 40 -85 -38 59 37 -48 37 -9 38 -9 -83 -2 39 58 -2 -4 -86 28 39 24 1
		.text
		
		
#############################################################################################
		#  Test #101
		#  Try to read from a null array.
		#######################################################################
		jal		Initialize_Test_Suite
		li		$a0, 0				#  Array
		jal		increment
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Unexpected result
		li		$a2, 101			#  Test #101
		la		$a3, c101			#  Description of test
		jal		Assert_Not_Equal_Integer	#  Check for an error.
		
		
		#  Test #102
		#  Array begins outside of memory.
		#######################################################################
		jal		Initialize_Test_Suite
		li		$a0, -40			#  Array
		jal		increment
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Unexpected result
		li		$a2, 102			#  Test #102
		la		$a3, c103			#  Description of test
		jal		Assert_Not_Equal_Integer	#  Check for an error
		
		
		#  Test #103
		#  Pointer begins outside of memory
		#######################################################################
		jal		Initialize_Test_Suite
		li		$a0, 0x0FCDA890		#  Array
		jal		increment
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Unexpected result
		li		$a2, 103			#  Test #103
		la		$a3, c105			#  Description of test
		jal		Assert_Not_Equal_Integer	#  Check for an error.
		
		
		#  Test #104
		#  Pointer outside of memory
		#######################################################################
		jal		Initialize_Test_Suite
		li		$a0, 0xC0000000		#  Array
		jal		increment
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Unexpected result
		li		$a2, 104			#  Test #104
		la		$a3, c107			#  Description of test
		jal		Assert_Not_Equal_Integer	#  Check for an error.
		
		
		#  Test #105
		#  Non-word aligned array
		#######################################################################
		jal		Initialize_Test_Suite
		li		$a0, 0x10000002		#  Array
		jal		increment
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Unexpected result
		li		$a2, 105			#  Test #105
		la		$a3, c109			#  Description of test
		jal		Assert_Not_Equal_Integer	#  Check for an error.
		
		
		
		#  Test #106
		#  Non-word aligned array
		#######################################################################
		jal		Initialize_Test_Suite
		li		$a0, 0x10000009		#  Array
		jal		increment
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Unexpected result
		li		$a2, 106			#  Test #106
		la		$a3, c109			#  Description of test
		jal		Assert_Not_Equal_Integer	#  Check for an error.
		
		
		#  Test #107
		#  Non-word aligned array
		#######################################################################
		jal		Initialize_Test_Suite
		li		$a0, 0x10000013		#  Array
		jal		increment
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Unexpected result
		li		$a2, 107			#  Test #107
		la		$a3, c109			#  Description of test
		jal		Assert_Not_Equal_Integer	#  Check for an error.
		
		
		#  Test #108
		#  Bad array length
		#######################################################################
		jal		Initialize_Test_Suite
		la		$a0, db115			#  Array
		jal		increment
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Unexpected result
		li		$a2, 108			#  Test #108
		la		$a3, c115			#  Description of test
		jal		Assert_Not_Equal_Integer	#  Check for an error.
		
		
		#  Test #109
		#  Array extends outside of memory
		#######################################################################
		jal		Initialize_Test_Suite
		la		$a0, db119			#  Array
		jal		increment
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Unexpected result
		li		$a2, 109			#  Test #109
		la		$a3, c119			#  Description of test
		jal		Assert_Not_Equal_Integer	#  Check for an error.
		
		
		#  Test #110
		#  Array extends outside of memory, but wraps around to the beginning of memory again.
		#######################################################################
		jal		Initialize_Test_Suite
		la		$a0, db121			#  Array
		jal		increment
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Unexpected result
		li		$a2, 110			#  Test #110
		la		$a3, c121			#  Description of test
		jal		Assert_Not_Equal_Integer	#  Check for an error.
		
		
		#  Test #111
		#  Array remains inside of memory but attempts to cross from the heap to the stack.
		#######################################################################
		jal		Initialize_Test_Suite
		la		$a0, db123			#  Array
		jal		increment
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Unexpected result
		li		$a2, 111			#  Test #111
		la		$a3, c123			#  Description of test
		jal		Assert_Not_Equal_Integer	#  Check for an error.
		
		
		#  Test #112
		#  Element outside of the array.
		#######################################################################
		jal		Initialize_Test_Suite
		la		$a0, dc113			#  Array
		li		$a1, -1				#  Element to access
		jal		increment
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Unexpected result
		li		$a2, 112			#  Test #112
		la		$a3, c125			#  Description of test
		jal		Assert_Not_Equal_Integer	#  Check for an error.
		.data
dc113:	.word	5 1 2 3 4 5
c125:	.asciiz	"Requested element is outside of the array."
		.text
		
		
		#  Test #113
		#  Element outside of the array.
		#######################################################################
		jal		Initialize_Test_Suite
		la		$a0, dc113			#  Array
		li		$a1, 5				#  Element to access
		jal		increment
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Unexpected result
		li		$a2, 113			#  Test #113
		la		$a3, c125			#  Description of test
		jal		Assert_Not_Equal_Integer	#  Check for an error.
		
		
		#  Test #114
		#  Element outside of the array.
		#######################################################################
		jal		Initialize_Test_Suite
		la		$a0, dc113			#  Array
		li		$a1, 49				#  Element to access
		jal		increment
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Unexpected result
		li		$a2, 114			#  Test #114
		la		$a3, c125			#  Description of test
		jal		Assert_Not_Equal_Integer	#  Check for an error.
		
		
		#  Test #115
		#  Element outside of the array.
		#######################################################################
		jal		Initialize_Test_Suite
		la		$a0, dc113			#  Array
		li		$a1, 4096				#  Element to access
		jal		increment
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Unexpected result
		li		$a2, 115			#  Test #115
		la		$a3, c125			#  Description of test
		jal		Assert_Not_Equal_Integer	#  Check for an error.
		
		
		
		
		
		
		
#############################################################################################
#											swap Tests										#
		la		$a0, type4
		jal		Print_Divider
#############################################################################################
		#  Test #1
		#  A short array.
		#######################################################################
		jal		Initialize_Test_Suite
		la		$a0, dd3			#  Array
		li		$a1, 0				#  First element to swap
		li		$a2, 1				#  Second element to swap
		jal		swap
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Expected result
		li		$a2, 1				#  Test #1
		la		$a3, sb1a			#  Description of test
		jal		Assert_Equal_Integer
		la		$a0, dd3			#  Modified array
		la		$a1, rd3			#  Expected result
		li		$a2, 1				#  Test #1
		la		$a3, sd3			#  Description of test
		jal		Assert_Equal_Array	#  Check for equality.
		.data
dd3:	.word	2 2 6
rd3:	.word	2 6 2
sd3:	.asciiz	"[2 6] => [6 2]"
		.text


		#  Test #2
		#  A generic array.
		#######################################################################
		jal		Initialize_Test_Suite
		la		$a0, dd4			#  Array
		li		$a1, 1				#  First element to swap
		li		$a2, 3				#  Second element to swap
		jal		swap
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Expected result
		li		$a2, 2				#  Test #2
		la		$a3, sb1a			#  Description of test
		jal		Assert_Equal_Integer
		la		$a0, dd4			#  Modified array
		la		$a1, rd4			#  Expected result
		li		$a2, 2				#  Test #2
		la		$a3, sd4			#  Description of test
		jal		Assert_Equal_Array	#  Check for equality.
		.data
dd4:	.word	9 5 3 18 -45 31 -9 21 5 -3
rd4:	.word	9 5 -45 18 3 31 -9 21 5 -3
sd4:	.asciiz	"[5 3 18 -45 31 -9 21 5 -3] => [5 -45 18 3 31 -9 21 5 -3]"
		.text


		#  Test #3
		#  A generic array.
		#######################################################################
		jal		Initialize_Test_Suite
		la		$a0, dd4			#  Array
		li		$a1, 1				#  First element to swap
		li		$a2, 0				#  Second element to swap
		jal		swap
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Expected result
		li		$a2, 3				#  Test #3
		la		$a3, sb1a			#  Description of test
		jal		Assert_Equal_Integer
		la		$a0, dd4			#  Modified array
		la		$a1, rd4a			#  Expected result
		li		$a2, 3				#  Test #3
		la		$a3, sd4a			#  Description of test
		jal		Assert_Equal_Array	#  Check for equality.
		.data
rd4a:	.word	9 -45 5 18 3 31 -9 21 5 -3
sd4a:	.asciiz	"[5 -45 18 3 31 -9 21 5 -3] => [-45 5 18 3 31 -9 21 5 -3]"
		.text


		#  Test #4
		#  A generic array.
		#######################################################################
		jal		Initialize_Test_Suite
		la		$a0, dd4			#  Array
		li		$a1, 8				#  First element to swap
		li		$a2, 0				#  Second element to swap
		jal		swap
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Expected result
		li		$a2, 4				#  Test #4
		la		$a3, sb1a			#  Description of test
		jal		Assert_Equal_Integer
		la		$a0, dd4			#  Modified array
		la		$a1, rd4b			#  Expected result
		li		$a2, 4				#  Test #4
		la		$a3, sd4b			#  Description of test
		jal		Assert_Equal_Array	#  Check for equality.
		.data
rd4b:	.word	9 -3 5 18 3 31 -9 21 5 -45
sd4b:	.asciiz	"[-45 5 18 3 31 -9 21 5 -3] => [-3 5 18 3 31 -9 21 5 -45]"
		.text


		#  Test #4
		#  A generic array.
		#######################################################################
		jal		Initialize_Test_Suite
		la		$a0, dd4			#  Array
		li		$a1, 3				#  First element to swap
		li		$a2, 7				#  Second element to swap
		jal		swap
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Expected result
		li		$a2, 4				#  Test #4
		la		$a3, sb1a			#  Description of test
		jal		Assert_Equal_Integer
		la		$a0, dd4			#  Modified array
		la		$a1, rd4c			#  Expected result
		li		$a2, 4				#  Test #4
		la		$a3, sd4c			#  Description of test
		jal		Assert_Equal_Array	#  Check for equality.
		.data
rd4c:	.word	9 -3 5 18 5 31 -9 21 3 -45
sd4c:	.asciiz	"[-3 5 18 3 31 -9 21 5 -45] => [-3 5 18 5 31 -9 21 3 -45]"
		.text


		#  Test #5
		#  A generic array.
		#######################################################################
		jal		Initialize_Test_Suite
		la		$a0, dd4			#  Array
		li		$a1, 1				#  First element to swap
		li		$a2, 7				#  Second element to swap
		jal		swap
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Expected result
		li		$a2, 5				#  Test #5
		la		$a3, sb1a			#  Description of test
		jal		Assert_Equal_Integer
		la		$a0, dd4			#  Modified array
		la		$a1, rd4d			#  Expected result
		li		$a2, 5				#  Test #5
		la		$a3, sd4d			#  Description of test
		jal		Assert_Equal_Array	#  Check for equality.
		.data
rd4d:	.word	9 -3 3 18 5 31 -9 21 5 -45
sd4d:	.asciiz	"[-3 5 18 5 31 -9 21 3 -45] => [-3 3 18 5 31 -9 21 5 -45]"
		.text


		#  Test #6
		#  A long array.
		#######################################################################
		jal		Initialize_Test_Suite
		la		$a0, dd5			#  Array
		li		$a1, 3				#  First element to swap
		li		$a2, 6				#  Second element to swap
		jal		swap
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Expected result
		li		$a2, 6				#  Test #6
		la		$a3, sb1a			#  Description of test
		jal		Assert_Equal_Integer
		la		$a0, dd5			#  Modified array
		la		$a1, rd5			#  Expected result
		li		$a2, 6				#  Test #6
		la		$a3, sd5			#  Description of test
		jal		Assert_Equal_Array	#  Check for equality.
		.data
dd5:	.word	26 -5  9 10 48 -39 40 -85 -38 59 37 -48 37 -9 38 -9 -83 -2 39 58 -2 -4 -86 28 38 24 -3
rd5:	.word	26 -5  9 10 -85 -39 40 48 -38 59 37 -48 37 -9 38 -9 -83 -2 39 58 -2 -4 -86 28 38 24 -3
sd5:	.asciiz	"Testing with a long array."
		.text


		#  Test #7
		#  A long array.
		#######################################################################
		jal		Initialize_Test_Suite
		la		$a0, dd5			#  Array
		li		$a1, 16				#  First element to swap
		li		$a2, 2				#  Second element to swap
		jal		swap
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Expected result
		li		$a2, 7				#  Test #7
		la		$a3, sb1a			#  Description of test
		jal		Assert_Equal_Integer
		la		$a0, dd5			#  Modified array
		la		$a1, rd5a			#  Expected result
		li		$a2, 7				#  Test #7
		la		$a3, sd5			#  Description of test
		jal		Assert_Equal_Array	#  Check for equality.
		.data
rd5a:	.word	26 -5  9 -2 -85 -39 40 48 -38 59 37 -48 37 -9 38 -9 -83 10 39 58 -2 -4 -86 28 38 24 -3
		.text


		#  Test #8
		#  A long array.
		#######################################################################
		jal		Initialize_Test_Suite
		la		$a0, dd5			#  Array
		li		$a1, 13				#  First element to swap
		li		$a2, 5				#  Second element to swap
		jal		swap
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Expected result
		li		$a2, 8				#  Test #8
		la		$a3, sb1a			#  Description of test
		jal		Assert_Equal_Integer
		la		$a0, dd5			#  Modified array
		la		$a1, rd5b			#  Expected result
		li		$a2, 8				#  Test #8
		la		$a3, sd5			#  Description of test
		jal		Assert_Equal_Array	#  Check for equality.
		.data
rd5b:	.word	26 -5  9 -2 -85 -39 38 48 -38 59 37 -48 37 -9 40 -9 -83 10 39 58 -2 -4 -86 28 38 24 -3
		.text


		#  Test #9
		#  A long array.
		#######################################################################
		jal		Initialize_Test_Suite
		la		$a0, dd5			#  Array
		li		$a1, 25				#  First element to swap
		li		$a2, 19				#  Second element to swap
		jal		swap
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Expected result
		li		$a2, 9				#  Test #9
		la		$a3, sb1a			#  Description of test
		jal		Assert_Equal_Integer
		la		$a0, dd5			#  Modified array
		la		$a1, rd5c			#  Expected result
		li		$a2, 9				#  Test #9
		la		$a3, sd5			#  Description of test
		jal		Assert_Equal_Array	#  Check for equality.
		.data
rd5c:	.word	26 -5  9 -2 -85 -39 38 48 -38 59 37 -48 37 -9 40 -9 -83 10 39 58 -3 -4 -86 28 38 24 -2
		.text


		#  Test #10
		#  A long array.
		#######################################################################
		jal		Initialize_Test_Suite
		la		$a0, dd5			#  Array
		li		$a1, 19				#  First element to swap
		li		$a2, 2				#  Second element to swap
		jal		swap
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Expected result
		li		$a2, 10				#  Test #10
		la		$a3, sb1a			#  Description of test
		jal		Assert_Equal_Integer
		la		$a0, dd5			#  Modified array
		la		$a1, rd5d			#  Expected result
		li		$a2, 10				#  Test #10
		la		$a3, sd5			#  Description of test
		jal		Assert_Equal_Array	#  Check for equality.
		.data
rd5d:	.word	26 -5  9 -3 -85 -39 38 48 -38 59 37 -48 37 -9 40 -9 -83 10 39 58 -2 -4 -86 28 38 24 -2
		.text


		#  Test #11
		#  A long array.
		#######################################################################
		jal		Initialize_Test_Suite
		la		$a0, dd5			#  Array
		li		$a1, 0				#  First element to swap
		li		$a2, 1				#  Second element to swap
		jal		swap
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Expected result
		li		$a2, 11				#  Test #11
		la		$a3, sb1a			#  Description of test
		jal		Assert_Equal_Integer
		la		$a0, dd5			#  Modified array
		la		$a1, rd5e			#  Expected result
		li		$a2, 11				#  Test #11
		la		$a3, sd5			#  Description of test
		jal		Assert_Equal_Array	#  Check for equality.
		.data
rd5e:	.word	26 9 -5 -3 -85 -39 38 48 -38 59 37 -48 37 -9 40 -9 -83 10 39 58 -2 -4 -86 28 38 24 -2
		.text


		#  Test #12
		#  A long array.
		#######################################################################
		jal		Initialize_Test_Suite
		la		$a0, dd5			#  Array
		li		$a1, 5				#  First element to swap
		li		$a2, 7				#  Second element to swap
		jal		swap
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Expected result
		li		$a2, 12				#  Test #12
		la		$a3, sb1a			#  Description of test
		jal		Assert_Equal_Integer
		la		$a0, dd5			#  Modified array
		la		$a1, rd5f			#  Expected result
		li		$a2, 12				#  Test #12
		la		$a3, sd5			#  Description of test
		jal		Assert_Equal_Array	#  Check for equality.
		.data
rd5f:	.word	26 9 -5 -3 -85 -39 -38 48 38 59 37 -48 37 -9 40 -9 -83 10 39 58 -2 -4 -86 28 38 24 -2
		.text


		#  Test #13
		#  A long array.
		#######################################################################
		jal		Initialize_Test_Suite
		la		$a0, dd5			#  Array
		li		$a1, 0				#  First element to swap
		li		$a2, 25				#  Second element to swap
		jal		swap
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Expected result
		li		$a2, 13				#  Test #13
		la		$a3, sb1a			#  Description of test
		jal		Assert_Equal_Integer
		la		$a0, dd5			#  Modified array
		la		$a1, rd5g			#  Expected result
		li		$a2, 13				#  Test #13
		la		$a3, sd5			#  Description of test
		jal		Assert_Equal_Array	#  Check for equality.
		.data
rd5g:	.word	26 -2 -5 -3 -85 -39 -38 48 38 59 37 -48 37 -9 40 -9 -83 10 39 58 -2 -4 -86 28 38 24 9
		.text


		#  Test #14
		#  A long array.
		#######################################################################
		jal		Initialize_Test_Suite
		la		$a0, dd5			#  Array
		li		$a1, 3				#  First element to swap
		li		$a2, 5				#  Second element to swap
		jal		swap
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Expected result
		li		$a2, 14				#  Test #14
		la		$a3, sb1a			#  Description of test
		jal		Assert_Equal_Integer
		la		$a0, dd5			#  Modified array
		la		$a1, rd5h			#  Expected result
		li		$a2, 14				#  Test #14
		la		$a3, sd5			#  Description of test
		jal		Assert_Equal_Array	#  Check for equality.
		.data
rd5h:	.word	26 -2 -5 -3 -38 -39 -85 48 38 59 37 -48 37 -9 40 -9 -83 10 39 58 -2 -4 -86 28 38 24 9
		.text
		
		
#############################################################################################
		#  Test #101
		#  Try to read from a null array.
		#######################################################################
		jal		Initialize_Test_Suite
		li		$a0, 0				#  Array
		jal		swap
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Unexpected result
		li		$a2, 101			#  Test #101
		la		$a3, c101			#  Description of test
		jal		Assert_Not_Equal_Integer	#  Check for an error.
		
		
		#  Test #102
		#  Array begins outside of memory.
		#######################################################################
		jal		Initialize_Test_Suite
		li		$a0, -40			#  Array
		jal		swap
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Unexpected result
		li		$a2, 102			#  Test #102
		la		$a3, c103			#  Description of test
		jal		Assert_Not_Equal_Integer	#  Check for an error
		
		
		#  Test #103
		#  Pointer begins outside of memory
		#######################################################################
		jal		Initialize_Test_Suite
		li		$a0, 0x0FCDA890		#  Array
		jal		swap
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Unexpected result
		li		$a2, 103			#  Test #103
		la		$a3, c105			#  Description of test
		jal		Assert_Not_Equal_Integer	#  Check for an error.
		
		
		#  Test #104
		#  Pointer outside of memory
		#######################################################################
		jal		Initialize_Test_Suite
		li		$a0, 0xC0000000		#  Array
		jal		swap
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Unexpected result
		li		$a2, 104			#  Test #104
		la		$a3, c107			#  Description of test
		jal		Assert_Not_Equal_Integer	#  Check for an error.
		
		
		#  Test #105
		#  Non-word aligned array
		#######################################################################
		jal		Initialize_Test_Suite
		li		$a0, 0x10000002		#  Array
		jal		swap
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Unexpected result
		li		$a2, 105			#  Test #105
		la		$a3, c109			#  Description of test
		jal		Assert_Not_Equal_Integer	#  Check for an error.
		
		
		
		#  Test #106
		#  Non-word aligned array
		#######################################################################
		jal		Initialize_Test_Suite
		li		$a0, 0x10000009		#  Array
		jal		swap
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Unexpected result
		li		$a2, 106			#  Test #106
		la		$a3, c109			#  Description of test
		jal		Assert_Not_Equal_Integer	#  Check for an error.
		
		
		#  Test #107
		#  Non-word aligned array
		#######################################################################
		jal		Initialize_Test_Suite
		li		$a0, 0x10000013		#  Array
		jal		swap
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Unexpected result
		li		$a2, 107			#  Test #107
		la		$a3, c109			#  Description of test
		jal		Assert_Not_Equal_Integer	#  Check for an error.
		
		
		#  Test #108
		#  Bad array length
		#######################################################################
		jal		Initialize_Test_Suite
		la		$a0, db115			#  Array
		jal		swap
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Unexpected result
		li		$a2, 108			#  Test #108
		la		$a3, c115			#  Description of test
		jal		Assert_Not_Equal_Integer	#  Check for an error.
		
		
		#  Test #109
		#  Array extends outside of memory
		#######################################################################
		jal		Initialize_Test_Suite
		la		$a0, db119			#  Array
		jal		swap
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Unexpected result
		li		$a2, 109			#  Test #109
		la		$a3, c119			#  Description of test
		jal		Assert_Not_Equal_Integer	#  Check for an error.
		
		
		#  Test #110
		#  Array extends outside of memory, but wraps around to the beginning of memory again.
		#######################################################################
		jal		Initialize_Test_Suite
		la		$a0, db121			#  Array
		jal		swap
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Unexpected result
		li		$a2, 110			#  Test #110
		la		$a3, c121			#  Description of test
		jal		Assert_Not_Equal_Integer	#  Check for an error.
		
		
		#  Test #111
		#  Array remains inside of memory but attempts to cross from the heap to the stack.
		#######################################################################
		jal		Initialize_Test_Suite
		la		$a0, db123			#  Array
		jal		swap
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Unexpected result
		li		$a2, 111			#  Test #111
		la		$a3, c123			#  Description of test
		jal		Assert_Not_Equal_Integer	#  Check for an error.
		
		
		#  Test #112
		#  Element outside of the array.
		#######################################################################
		jal		Initialize_Test_Suite
		la		$a0, dc113			#  Array
		li		$a1, -1				#  First element to swap
		li		$a2, 0				#  Second element to swap
		jal		swap
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Unexpected result
		li		$a2, 112			#  Test #112
		la		$a3, c125			#  Description of test
		jal		Assert_Not_Equal_Integer	#  Check for an error.
		
		
		#  Test #113
		#  Element outside of the array.
		#######################################################################
		jal		Initialize_Test_Suite
		la		$a0, dc113			#  Array
		li		$a1, 5				#  First element to swap
		li		$a2, 0				#  Second element to swap
		jal		swap
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Unexpected result
		li		$a2, 113			#  Test #113
		la		$a3, c125			#  Description of test
		jal		Assert_Not_Equal_Integer	#  Check for an error.
		
		
		#  Test #114
		#  Element outside of the array.
		#######################################################################
		jal		Initialize_Test_Suite
		la		$a0, dc113			#  Array
		li		$a1, 49				#  First element to swap
		li		$a2, 0				#  Second element to swap
		jal		swap
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Unexpected result
		li		$a2, 114			#  Test #114
		la		$a3, c125			#  Description of test
		jal		Assert_Not_Equal_Integer	#  Check for an error.
		
		
		#  Test #115
		#  Element outside of the array.
		#######################################################################
		jal		Initialize_Test_Suite
		la		$a0, dc113			#  Array
		li		$a1, 4096				#  First element to swap
		li		$a2, 0				#  Second element to swap
		jal		swap
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Unexpected result
		li		$a2, 115			#  Test #115
		la		$a3, c125			#  Description of test
		jal		Assert_Not_Equal_Integer	#  Check for an error.
		
		
		#  Test #116
		#  Element outside of the array.
		#######################################################################
		jal		Initialize_Test_Suite
		la		$a0, dc113			#  Array
		li		$a1, 0				#  First element to swap
		li		$a2, -1				#  Second element to swap
		jal		swap
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Unexpected result
		li		$a2, 116			#  Test #116
		la		$a3, c125			#  Description of test
		jal		Assert_Not_Equal_Integer	#  Check for an error.
		
		
		#  Test #117
		#  Element outside of the array.
		#######################################################################
		jal		Initialize_Test_Suite
		la		$a0, dc113			#  Array
		li		$a1, 0				#  First element to swap
		li		$a2, 5				#  Second element to swap
		jal		swap
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Unexpected result
		li		$a2, 117			#  Test #117
		la		$a3, c125			#  Description of test
		jal		Assert_Not_Equal_Integer	#  Check for an error.
		
		
		#  Test #118
		#  Element outside of the array.
		#######################################################################
		jal		Initialize_Test_Suite
		la		$a0, dc113			#  Array
		li		$a1, 0				#  First element to swap
		li		$a2, 49				#  Second element to swap
		jal		swap
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Unexpected result
		li		$a2, 118			#  Test #118
		la		$a3, c125			#  Description of test
		jal		Assert_Not_Equal_Integer	#  Check for an error.
		
		
		#  Test #119
		#  Element outside of the array.
		#######################################################################
		jal		Initialize_Test_Suite
		la		$a0, dc113			#  Array
		li		$a1, 0				#  First element to swap
		li		$a2, 4096				#  Second element to swap
		jal		swap
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Unexpected result
		li		$a2, 119			#  Test #119
		la		$a3, c125			#  Description of test
		jal		Assert_Not_Equal_Integer	#  Check for an error.
		
		
		
		
		
		
		






#############################################################################################
#										addition Tests										#
		la		$a0, type5
		jal		Print_Divider
#############################################################################################
		#  Test #1
		#  A singleton.
		#######################################################################
		jal		Initialize_Test_Suite
		la		$a0, de1a			#  Left array
		la		$a1, de1b			#  Right array
		jal		addition
		
		move	$a0, $v0			#  Result
		la		$a1, re1			#  Expected result
		li		$a2, 1				#  Test #1
		la		$a3, se1			#  Description of test
		jal		Assert_Equal_Array	#  Check for equality.
		.data
de1a:	.word	1 1
de1b:	.word	1 5
re1:	.word	1 6
se1:	.asciiz	"[1] + [5] => [6]"
		.text
		
		
		#  Test #2
		#  A singleton.
		#######################################################################
		jal		Initialize_Test_Suite
		la		$a0, de2a			#  Left array
		la		$a1, de2b			#  Right array
		jal		addition
		
		move	$a0, $v0			#  Result
		la		$a1, re2			#  Expected result
		li		$a2, 2				#  Test #2
		la		$a3, se2			#  Description of test
		jal		Assert_Equal_Array	#  Check for equality.
		.data
de2a:	.word	1 5
de2b:	.word	1 7
re2:	.word	1 12
se2:	.asciiz	"[5] + [7] => [12]"
		.text


		#  Test #3
		#  A short array.
		#######################################################################
		jal		Initialize_Test_Suite
		la		$a0, de3a			#  Left array
		la		$a1, de3b			#  Right array
		jal		addition
		
		move	$a0, $v0			#  Result
		la		$a1, re3			#  Expected result
		li		$a2, 3				#  Test #3
		la		$a3, se3			#  Description of test
		jal		Assert_Equal_Array	#  Check for equality.
		.data
de3a:	.word	2 2 6
de3b:	.word	2 5 3
re3:	.word	2 7 9
se3:	.asciiz	"[2 6] + [5 3] => [7 9]"
		.text


		#  Test #4
		#  A generic array.
		#######################################################################
		jal		Initialize_Test_Suite
		la		$a0, de4a			#  Left array
		la		$a1, de4b			#  Right array
		jal		addition
		
		move	$a0, $v0			#  Result
		la		$a1, re4			#  Expected result
		li		$a2, 4				#  Test #4
		la		$a3, se4			#  Description of test
		jal		Assert_Equal_Array	#  Check for equality.
		.data
de4a:	.word	9 5 3 18 -45 31 -9 21  5 -3
de4b:	.word	9 2 4  9  -5  9  2  5  9 -7
re4:	.word	9 7 7 27 -50 40 -7 26 14 -10
se4:	.asciiz	"[5 3 18 -45 31 -9 21 5 -3] + [2 4  9  -5  9  2  5  9 -7] => [7 7 27 -50 40 -7 26 14 -10]"
		.text


		#  Test #5
		#  A long array.
		#######################################################################
		jal		Initialize_Test_Suite
		la		$a0, de5a			#  Left array
		la		$a1, de5b			#  Right array
		jal		addition
		
		move	$a0, $v0			#  Result
		la		$a1, re5			#  Expected result
		li		$a2, 5				#  Test #5
		la		$a3, se5			#  Description of test
		jal		Assert_Equal_Array	#  Check for equality.
		.data
de5a:	.word	26  -5  9 10 48 -39 40 -85 -38 59  37 -48 37 -9 38  -9  -83 -2 39 58 -2  -4  -86 28 38  24 -3
de5b:	.word	26   8 -3  9 -3   4 12  -4 -19 23 -71  17 26 83 -9 -15  -21 23 41 14 28 -19  -17 25 31 -31  8
re5:	.word	26   3  6 19 45 -35 52 -89 -57 82 -34 -31 63 74 29 -24 -104 21 80 72 26 -23 -103 53 69  -7  5
se5:	.asciiz	"Testing with a long array."
		.text
		
		
#############################################################################################
		#  Test #101
		#  Try to read from a null array.
		#######################################################################
		jal		Initialize_Test_Suite
		li		$a0, 0				#  Array
		la		$a1, de5b			#  Right array
		jal		addition
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Unexpected result
		li		$a2, 101			#  Test #101
		la		$a3, c101			#  Description of test
		jal		Assert_Null			#  Check for an error.
		
		
		#  Test #102
		#  Array begins outside of memory.
		#######################################################################
		jal		Initialize_Test_Suite
		li		$a0, -40			#  Array
		la		$a1, de5b			#  Right array
		jal		addition
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Unexpected result
		li		$a2, 102			#  Test #102
		la		$a3, c103			#  Description of test
		jal		Assert_Null			#  Check for an error.
		
		
		#  Test #103
		#  Pointer begins outside of memory
		#######################################################################
		jal		Initialize_Test_Suite
		li		$a0, 0x0FCDA890		#  Array
		la		$a1, de5b			#  Right array
		jal		addition
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Unexpected result
		li		$a2, 103			#  Test #103
		la		$a3, c105			#  Description of test
		jal		Assert_Null			#  Check for an error.
		
		
		#  Test #104
		#  Pointer outside of memory
		#######################################################################
		jal		Initialize_Test_Suite
		li		$a0, 0xC0000000		#  Array
		la		$a1, de5b			#  Right array
		jal		addition
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Unexpected result
		li		$a2, 104			#  Test #104
		la		$a3, c107			#  Description of test
		jal		Assert_Null			#  Check for an error.
		
		
		#  Test #105
		#  Non-word aligned array
		#######################################################################
		jal		Initialize_Test_Suite
		li		$a0, 0x10000002		#  Array
		la		$a1, de5b			#  Right array
		jal		addition
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Unexpected result
		li		$a2, 105			#  Test #105
		la		$a3, c109			#  Description of test
		jal		Assert_Null			#  Check for an error.
		
		
		
		#  Test #106
		#  Non-word aligned array
		#######################################################################
		jal		Initialize_Test_Suite
		li		$a0, 0x10000009		#  Array
		la		$a1, de5b			#  Right array
		jal		addition
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Unexpected result
		li		$a2, 106			#  Test #106
		la		$a3, c109			#  Description of test
		jal		Assert_Null			#  Check for an error.
		
		
		#  Test #107
		#  Non-word aligned array
		#######################################################################
		jal		Initialize_Test_Suite
		li		$a0, 0x10000013		#  Array
		la		$a1, de5b			#  Right array
		jal		addition
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Unexpected result
		li		$a2, 107			#  Test #107
		la		$a3, c109			#  Description of test
		jal		Assert_Null			#  Check for an error.
		
		
		#  Test #108
		#  Bad array length
		#######################################################################
		jal		Initialize_Test_Suite
		la		$a0, db115			#  Array
		la		$a1, de5b			#  Right array
		jal		addition
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Unexpected result
		li		$a2, 108			#  Test #108
		la		$a3, c115			#  Description of test
		jal		Assert_Null			#  Check for an error.
		
		
		#  Test #109
		#  Array extends outside of memory
		#######################################################################
		jal		Initialize_Test_Suite
		la		$a0, db119			#  Array
		la		$a1, de5b			#  Right array
		jal		addition
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Unexpected result
		li		$a2, 109			#  Test #109
		la		$a3, c119			#  Description of test
		jal		Assert_Null			#  Check for an error.
		
		
		#  Test #110
		#  Array extends outside of memory, but wraps around to the beginning of memory again.
		#######################################################################
		jal		Initialize_Test_Suite
		la		$a0, db121			#  Array
		la		$a1, de5b			#  Right array
		jal		addition
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Unexpected result
		li		$a2, 110			#  Test #110
		la		$a3, c121			#  Description of test
		jal		Assert_Null			#  Check for an error.
		
		
		#  Test #111
		#  Array remains inside of memory but attempts to cross from the heap to the stack.
		#######################################################################
		jal		Initialize_Test_Suite
		la		$a0, db123			#  Array
		sub		$t0, $sp, $a0
		srl		$t0, $t0, 2			#  Cracked length of the array.
		sw		$t0, 0 ($a0)
		la		$a1, de5b			#  Right array
		jal		addition
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Unexpected result
		li		$a2, 111			#  Test #111
		la		$a3, c123			#  Description of test
		jal		Assert_Null			#  Check for an error.
		
		
		#  Test #112
		#  Try to read from a null array.
		#######################################################################
		jal		Initialize_Test_Suite
		li		$a1, 0				#  Array
		la		$a0, de5b			#  Right array
		jal		addition
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Unexpected result
		li		$a2, 112			#  Test #112
		la		$a3, c101			#  Description of test
		jal		Assert_Null			#  Check for an error.
		
		
		#  Test #113
		#  Array begins outside of memory.
		#######################################################################
		jal		Initialize_Test_Suite
		li		$a1, -40			#  Array
		la		$a0, de5b			#  Right array
		jal		addition
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Unexpected result
		li		$a2, 113			#  Test #113
		la		$a3, c103			#  Description of test
		jal		Assert_Null			#  Check for an error.
		
		
		#  Test #114
		#  Pointer begins outside of memory
		#######################################################################
		jal		Initialize_Test_Suite
		li		$a1, 0x0FCDA890		#  Array
		la		$a0, de5b			#  Right array
		jal		addition
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Unexpected result
		li		$a2, 114			#  Test #114
		la		$a3, c105			#  Description of test
		jal		Assert_Null			#  Check for an error.
		
		
		#  Test #115
		#  Pointer outside of memory
		#######################################################################
		jal		Initialize_Test_Suite
		li		$a1, 0xC0000000		#  Array
		la		$a0, de5b			#  Right array
		jal		addition
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Unexpected result
		li		$a2, 115			#  Test #115
		la		$a3, c107			#  Description of test
		jal		Assert_Null			#  Check for an error.
		
		
		#  Test #116
		#  Non-word aligned array
		#######################################################################
		jal		Initialize_Test_Suite
		li		$a1, 0x10000002		#  Array
		la		$a0, de5b			#  Right array
		jal		addition
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Unexpected result
		li		$a2, 116			#  Test #116
		la		$a3, c109			#  Description of test
		jal		Assert_Null			#  Check for an error.
		
		
		
		#  Test #117
		#  Non-word aligned array
		#######################################################################
		jal		Initialize_Test_Suite
		li		$a1, 0x10000009		#  Array
		la		$a0, de5b			#  Right array
		jal		addition
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Unexpected result
		li		$a2, 117			#  Test #117
		la		$a3, c109			#  Description of test
		jal		Assert_Null			#  Check for an error.
		
		
		#  Test #118
		#  Non-word aligned array
		#######################################################################
		jal		Initialize_Test_Suite
		li		$a1, 0x10000013		#  Array
		la		$a0, de5b			#  Right array
		jal		addition
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Unexpected result
		li		$a2, 118			#  Test #118
		la		$a3, c109			#  Description of test
		jal		Assert_Null			#  Check for an error.
		
		
		#  Test #119
		#  Bad array length
		#######################################################################
		jal		Initialize_Test_Suite
		la		$a1, db115			#  Array
		la		$a0, de5b			#  Right array
		jal		addition
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Unexpected result
		li		$a2, 119			#  Test #119
		la		$a3, c115			#  Description of test
		jal		Assert_Null			#  Check for an error.
		
		
		#  Test #120
		#  Array extends outside of memory
		#######################################################################
		jal		Initialize_Test_Suite
		la		$a1, db119			#  Array
		la		$a0, de5b			#  Right array
		jal		addition
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Unexpected result
		li		$a2, 120			#  Test #120
		la		$a3, c119			#  Description of test
		jal		Assert_Null			#  Check for an error.
		
		
		#  Test #121
		#  Array extends outside of memory, but wraps around to the beginning of memory again.
		#######################################################################
		jal		Initialize_Test_Suite
		la		$a1, db121			#  Array
		la		$a0, de5b			#  Right array
		jal		addition
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Unexpected result
		li		$a2, 121			#  Test #121
		la		$a3, c121			#  Description of test
		jal		Assert_Null			#  Check for an error.
		
		
		#  Test #122
		#  Array remains inside of memory but attempts to cross from the heap to the stack.
		#######################################################################
		jal		Initialize_Test_Suite
		la		$a1, db123			#  Array
		sub		$t0, $sp, $a0
		srl		$t0, $t0, 2			#  Cracked length of the array.
		sw		$t0, 0 ($a1)
		la		$a0, de5b			#  Right array
		jal		addition
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Unexpected result
		li		$a2, 122			#  Test #122
		la		$a3, c123			#  Description of test
		jal		Assert_Null			#  Check for an error.
		
		
		#  Test #123
		#  Arrays have mismatched sizes.
		#######################################################################
		jal		Initialize_Test_Suite
		la		$a0, ed123a			#  Array
		la		$a1, ed123b			#  Right array
		jal		addition
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Unexpected result
		li		$a2, 123			#  Test #123
		la		$a3, et123			#  Description of test
		jal		Assert_Null			#  Check for an error.
		.data
ed123a:	.word	2 3 4
ed123b:	.word	3 4 5 6
et123:	.asciiz	"Mismatched array sizes."
		.text
		
		
		#  Test #124
		#  Array extends outside of memory, but wraps around to the beginning of memory again.
		#######################################################################
		jal		Initialize_Test_Suite
		la		$a1, ed123a			#  Array
		la		$a0, ed123b			#  Right array
		jal		addition
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Unexpected result
		li		$a2, 123			#  Test #123
		la		$a3, et123			#  Description of test
		jal		Assert_Null			#  Check for an error.
		
		
		#  Test #125
		#  Arrays have mismatched sizes.
		#######################################################################
		jal		Initialize_Test_Suite
		la		$a0, ed125a			#  Array
		la		$a1, ed125b			#  Right array
		jal		addition
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Unexpected result
		li		$a2, 125			#  Test #125
		la		$a3, et123			#  Description of test
		jal		Assert_Null			#  Check for an error.
		.data
ed125a:	.word	5 1 2 3 4 5
ed125b:	.word	6 1 2 3 4 5 6
		.text
		
		
		#  Test #124
		#  Array extends outside of memory, but wraps around to the beginning of memory again.
		#######################################################################
		jal		Initialize_Test_Suite
		la		$a1, ed125a			#  Array
		la		$a0, ed125b			#  Right array
		jal		addition
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Unexpected result
		li		$a2, 123			#  Test #123
		la		$a3, et123			#  Description of test
		jal		Assert_Null			#  Check for an error.
		
		
		
		
		
		
		
#############################################################################################
#										subtract Tests										#
		la		$a0, type6
		jal		Print_Divider
#############################################################################################
		#  Test #1
		#  A singleton.
		#######################################################################
		jal		Initialize_Test_Suite
		la		$a0, de1a			#  Left array
		la		$a1, de1b			#  Right array
		jal		subtract
		
		move	$a0, $v0			#  Result
		la		$a1, rf1			#  Expected result
		li		$a2, 1				#  Test #1
		la		$a3, sf1			#  Description of test
		jal		Assert_Equal_Array	#  Check for equality.
		.data
rf1:	.word	1 -4
sf1:	.asciiz	"[1] - [5] => [-4]"
		.text
		
		
		#  Test #2
		#  A singleton.
		#######################################################################
		jal		Initialize_Test_Suite
		la		$a0, de2a			#  Left array
		la		$a1, de2b			#  Right array
		jal		subtract
		
		move	$a0, $v0			#  Result
		la		$a1, rf2			#  Expected result
		li		$a2, 2				#  Test #2
		la		$a3, sf2			#  Description of test
		jal		Assert_Equal_Array	#  Check for equality.
		.data
rf2:	.word	1 -2
sf2:	.asciiz	"[5] - [7] => [-2]"
		.text


		#  Test #3
		#  A short array.
		#######################################################################
		jal		Initialize_Test_Suite
		la		$a0, de3a			#  Left array
		la		$a1, de3b			#  Right array
		jal		subtract
		
		move	$a0, $v0			#  Result
		la		$a1, rf3			#  Expected result
		li		$a2, 3				#  Test #3
		la		$a3, sf3			#  Description of test
		jal		Assert_Equal_Array	#  Check for equality.
		.data
rf3:	.word	2 -3 3
sf3:	.asciiz	"[2 6] - [5 3] => [-3 3]"
		.text


		#  Test #4
		#  A generic array.
		#######################################################################
		jal		Initialize_Test_Suite
		la		$a0, de4a			#  Left array
		la		$a1, de4b			#  Right array
		jal		subtract
		
		move	$a0, $v0			#  Result
		la		$a1, rf4			#  Expected result
		li		$a2, 4				#  Test #4
		la		$a3, sf4			#  Description of test
		jal		Assert_Equal_Array	#  Check for equality.
		.data
rf4:	.word	9 3 -1 9 -40 22 -11 16 -4 4
sf4:	.asciiz	"[5 3 18 -45 31 -9 21 5 -3] - [2 4  9  -5  9  2  5  9 -7] => [3 -1 9 -40 22 -11 16 -4 4]"
		.text


		#  Test #5
		#  A long array.
		#######################################################################
		jal		Initialize_Test_Suite
		la		$a0, de5a			#  Left array
		la		$a1, de5b			#  Right array
		jal		subtract
		
		move	$a0, $v0			#  Result
		la		$a1, rf5			#  Expected result
		li		$a2, 5				#  Test #5
		la		$a3, sf5			#  Description of test
		jal		Assert_Equal_Array	#  Check for equality.
		.data
rf5:	.word	26 -13 12 1 51 -43 28 -81 -19 36 108 -65 11 -92 47 6 -62 -25 -2 44 -30 15 -69 3 7 55 -11
sf5:	.asciiz	"Testing with a long array."
		.text
		
		
#############################################################################################
		#  Test #101
		#  Try to read from a null array.
		#######################################################################
		jal		Initialize_Test_Suite
		li		$a0, 0				#  Array
		la		$a1, de5b			#  Right array
		jal		subtract
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Unexpected result
		li		$a2, 101			#  Test #101
		la		$a3, c101			#  Description of test
		jal		Assert_Null			#  Check for an error.
		
		
		#  Test #102
		#  Array begins outside of memory.
		#######################################################################
		jal		Initialize_Test_Suite
		li		$a0, -40			#  Array
		la		$a1, de5b			#  Right array
		jal		subtract
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Unexpected result
		li		$a2, 102			#  Test #102
		la		$a3, c103			#  Description of test
		jal		Assert_Null			#  Check for an error.
		
		
		#  Test #103
		#  Pointer begins outside of memory
		#######################################################################
		jal		Initialize_Test_Suite
		li		$a0, 0x0FCDA890		#  Array
		la		$a1, de5b			#  Right array
		jal		subtract
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Unexpected result
		li		$a2, 103			#  Test #103
		la		$a3, c105			#  Description of test
		jal		Assert_Null			#  Check for an error.
		
		
		#  Test #104
		#  Pointer outside of memory
		#######################################################################
		jal		Initialize_Test_Suite
		li		$a0, 0xC0000000		#  Array
		la		$a1, de5b			#  Right array
		jal		subtract
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Unexpected result
		li		$a2, 104			#  Test #104
		la		$a3, c107			#  Description of test
		jal		Assert_Null			#  Check for an error.
		
		
		#  Test #105
		#  Non-word aligned array
		#######################################################################
		jal		Initialize_Test_Suite
		li		$a0, 0x10000002		#  Array
		la		$a1, de5b			#  Right array
		jal		subtract
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Unexpected result
		li		$a2, 105			#  Test #105
		la		$a3, c109			#  Description of test
		jal		Assert_Null			#  Check for an error.
		
		
		
		#  Test #106
		#  Non-word aligned array
		#######################################################################
		jal		Initialize_Test_Suite
		li		$a0, 0x10000009		#  Array
		la		$a1, de5b			#  Right array
		jal		subtract
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Unexpected result
		li		$a2, 106			#  Test #106
		la		$a3, c109			#  Description of test
		jal		Assert_Null			#  Check for an error.
		
		
		#  Test #107
		#  Non-word aligned array
		#######################################################################
		jal		Initialize_Test_Suite
		li		$a0, 0x10000013		#  Array
		la		$a1, de5b			#  Right array
		jal		subtract
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Unexpected result
		li		$a2, 107			#  Test #107
		la		$a3, c109			#  Description of test
		jal		Assert_Null			#  Check for an error.
		
		
		#  Test #108
		#  Bad array length
		#######################################################################
		jal		Initialize_Test_Suite
		la		$a0, db115			#  Array
		la		$a1, de5b			#  Right array
		jal		subtract
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Unexpected result
		li		$a2, 108			#  Test #108
		la		$a3, c115			#  Description of test
		jal		Assert_Null			#  Check for an error.
		
		
		#  Test #109
		#  Array extends outside of memory
		#######################################################################
		jal		Initialize_Test_Suite
		la		$a0, db119			#  Array
		la		$a1, de5b			#  Right array
		jal		subtract
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Unexpected result
		li		$a2, 109			#  Test #109
		la		$a3, c119			#  Description of test
		jal		Assert_Null			#  Check for an error.
		
		
		#  Test #110
		#  Array extends outside of memory, but wraps around to the beginning of memory again.
		#######################################################################
		jal		Initialize_Test_Suite
		la		$a0, db121			#  Array
		la		$a1, de5b			#  Right array
		jal		subtract
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Unexpected result
		li		$a2, 110			#  Test #110
		la		$a3, c121			#  Description of test
		jal		Assert_Null			#  Check for an error.
		
		
		#  Test #111
		#  Array remains inside of memory but attempts to cross from the heap to the stack.
		#######################################################################
		jal		Initialize_Test_Suite
		la		$a0, db123			#  Array
		sub		$t0, $sp, $a0
		srl		$t0, $t0, 2			#  Cracked length of the array.
		sw		$t0, 0 ($a0)
		la		$a1, de5b			#  Right array
		jal		subtract
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Unexpected result
		li		$a2, 111			#  Test #111
		la		$a3, c123			#  Description of test
		jal		Assert_Null			#  Check for an error.
		
		
		#  Test #112
		#  Try to read from a null array.
		#######################################################################
		jal		Initialize_Test_Suite
		li		$a1, 0				#  Array
		la		$a0, de5b			#  Right array
		jal		subtract
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Unexpected result
		li		$a2, 112			#  Test #112
		la		$a3, c101			#  Description of test
		jal		Assert_Null			#  Check for an error.
		
		
		#  Test #113
		#  Array begins outside of memory.
		#######################################################################
		jal		Initialize_Test_Suite
		li		$a1, -40			#  Array
		la		$a0, de5b			#  Right array
		jal		subtract
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Unexpected result
		li		$a2, 113			#  Test #113
		la		$a3, c103			#  Description of test
		jal		Assert_Null			#  Check for an error.
		
		
		#  Test #114
		#  Pointer begins outside of memory
		#######################################################################
		jal		Initialize_Test_Suite
		li		$a1, 0x0FCDA890		#  Array
		la		$a0, de5b			#  Right array
		jal		subtract
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Unexpected result
		li		$a2, 114			#  Test #114
		la		$a3, c105			#  Description of test
		jal		Assert_Null			#  Check for an error.
		
		
		#  Test #115
		#  Pointer outside of memory
		#######################################################################
		jal		Initialize_Test_Suite
		li		$a1, 0xC0000000		#  Array
		la		$a0, de5b			#  Right array
		jal		subtract
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Unexpected result
		li		$a2, 115			#  Test #115
		la		$a3, c107			#  Description of test
		jal		Assert_Null			#  Check for an error.
		
		
		#  Test #116
		#  Non-word aligned array
		#######################################################################
		jal		Initialize_Test_Suite
		li		$a1, 0x10000002		#  Array
		la		$a0, de5b			#  Right array
		jal		subtract
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Unexpected result
		li		$a2, 116			#  Test #116
		la		$a3, c109			#  Description of test
		jal		Assert_Null			#  Check for an error.
		
		
		
		#  Test #117
		#  Non-word aligned array
		#######################################################################
		jal		Initialize_Test_Suite
		li		$a1, 0x10000009		#  Array
		la		$a0, de5b			#  Right array
		jal		subtract
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Unexpected result
		li		$a2, 117			#  Test #117
		la		$a3, c109			#  Description of test
		jal		Assert_Null			#  Check for an error.
		
		
		#  Test #118
		#  Non-word aligned array
		#######################################################################
		jal		Initialize_Test_Suite
		li		$a1, 0x10000013		#  Array
		la		$a0, de5b			#  Right array
		jal		subtract
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Unexpected result
		li		$a2, 118			#  Test #118
		la		$a3, c109			#  Description of test
		jal		Assert_Null			#  Check for an error.
		
		
		#  Test #119
		#  Bad array length
		#######################################################################
		jal		Initialize_Test_Suite
		la		$a1, db115			#  Array
		la		$a0, de5b			#  Right array
		jal		subtract
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Unexpected result
		li		$a2, 119			#  Test #119
		la		$a3, c115			#  Description of test
		jal		Assert_Null			#  Check for an error.
		
		
		#  Test #120
		#  Array extends outside of memory
		#######################################################################
		jal		Initialize_Test_Suite
		la		$a1, db119			#  Array
		la		$a0, de5b			#  Right array
		jal		subtract
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Unexpected result
		li		$a2, 120			#  Test #120
		la		$a3, c119			#  Description of test
		jal		Assert_Null			#  Check for an error.
		
		
		#  Test #121
		#  Array extends outside of memory, but wraps around to the beginning of memory again.
		#######################################################################
		jal		Initialize_Test_Suite
		la		$a1, db121			#  Array
		la		$a0, de5b			#  Right array
		jal		subtract
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Unexpected result
		li		$a2, 121			#  Test #121
		la		$a3, c121			#  Description of test
		jal		Assert_Null			#  Check for an error.
		
		
		#  Test #122
		#  Array remains inside of memory but attempts to cross from the heap to the stack.
		#######################################################################
		jal		Initialize_Test_Suite
		la		$a1, db123			#  Array
		sub		$t0, $sp, $a0
		srl		$t0, $t0, 2			#  Cracked length of the array.
		sw		$t0, 0 ($a1)
		la		$a0, de5b			#  Right array
		jal		subtract
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Unexpected result
		li		$a2, 122			#  Test #122
		la		$a3, c123			#  Description of test
		jal		Assert_Null			#  Check for an error.
		
		
		#  Test #123
		#  Arrays have mismatched sizes.
		#######################################################################
		jal		Initialize_Test_Suite
		la		$a0, ed123a			#  Array
		la		$a1, ed123b			#  Right array
		jal		subtract
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Unexpected result
		li		$a2, 123			#  Test #123
		la		$a3, et123			#  Description of test
		jal		Assert_Null			#  Check for an error.
		
		
		#  Test #124
		#  Array extends outside of memory, but wraps around to the beginning of memory again.
		#######################################################################
		jal		Initialize_Test_Suite
		la		$a1, ed123a			#  Array
		la		$a0, ed123b			#  Right array
		jal		subtract
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Unexpected result
		li		$a2, 123			#  Test #123
		la		$a3, et123			#  Description of test
		jal		Assert_Null			#  Check for an error.
		
		
		#  Test #125
		#  Arrays have mismatched sizes.
		#######################################################################
		jal		Initialize_Test_Suite
		la		$a0, ed125a			#  Array
		la		$a1, ed125b			#  Right array
		jal		subtract
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Unexpected result
		li		$a2, 125			#  Test #125
		la		$a3, et123			#  Description of test
		jal		Assert_Null			#  Check for an error.
		
		
		#  Test #124
		#  Array extends outside of memory, but wraps around to the beginning of memory again.
		#######################################################################
		jal		Initialize_Test_Suite
		la		$a1, ed125a			#  Array
		la		$a0, ed125b			#  Right array
		jal		subtract
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Unexpected result
		li		$a2, 123			#  Test #123
		la		$a3, et123			#  Description of test
		jal		Assert_Null			#  Check for an error.
		
		
		
		
		
		
		
#############################################################################################
#										scalar_multiplication Tests									#
		la		$a0, type7
		jal		Print_Divider
#############################################################################################
		#  Test #1
		#  A singleton.
		#######################################################################
		jal		Initialize_Test_Suite
		li		$a0, 1				#  Scalar multiplier
		la		$a1, dg1			#  Array
		jal		scalar_multiplication
		
		move	$a0, $v0			#  Result
		la		$a1, rg1			#  Expected result
		li		$a2, 1				#  Test #1
		la		$a3, sg1			#  Description of test
		jal		Assert_Equal_Array	#  Check for equality.
		.data
dg1:	.word	1 1
rg1:	.word	1 1
sg1:	.asciiz	"1 x [1] => [1]"
		.text
		
		
		#  Test #2
		#  A singleton.
		#######################################################################
		jal		Initialize_Test_Suite
		li		$a0, 20				#  Scalar multiplier
		la		$a1, dg2			#  Array
		jal		scalar_multiplication
		
		move	$a0, $v0			#  Result
		la		$a1, rg2			#  Expected result
		li		$a2, 2				#  Test #2
		la		$a3, sg2			#  Description of test
		jal		Assert_Equal_Array	#  Check for equality.
		.data
dg2:	.word	1 5
rg2:	.word	1 100
sg2:	.asciiz	"20 x [5] => [100]"
		.text


		#  Test #3
		#  A short array.
		#######################################################################
		jal		Initialize_Test_Suite
		li		$a0, 7				#  Scalar multiplier
		la		$a1, dg3			#  Array
		jal		scalar_multiplication
		
		move	$a0, $v0			#  Result
		la		$a1, rg3			#  Expected result
		li		$a2, 3				#  Test #3
		la		$a3, sg3			#  Description of test
		jal		Assert_Equal_Array	#  Check for equality.
		.data
dg3:	.word	2 2 6
rg3:	.word	2 14 42
sg3:	.asciiz	"7 x [2 6] => [14 42]"
		.text


		#  Test #4
		#  A generic array.
		#######################################################################
		jal		Initialize_Test_Suite
		li		$a0, 5				#  Scalar multiplier
		la		$a1, dg4			#  Array
		jal		scalar_multiplication
		
		move	$a0, $v0			#  Result
		la		$a1, rg4			#  Expected result
		li		$a2, 4				#  Test #4
		la		$a3, sg4			#  Description of test
		jal		Assert_Equal_Array	#  Check for equality.
		.data
dg4:	.word	9  5  3 18 -45 31  -9 21  5 -3
rg4:	.word	9 25 15 90 -225 155 -45 105 25 -15
sg4:	.asciiz	"5 x [5 3 18 -45 31 -9 21 5 -3] => [25 15 90 -225 155 -45 105 25 -15]"
		.text


		#  Test #5
		#  A long array.
		#######################################################################
		jal		Initialize_Test_Suite
		li		$a0, -3				#  Scalar multiplier
		la		$a1, dg5			#  Array
		jal		scalar_multiplication
		
		move	$a0, $v0			#  Result
		la		$a1, rg5			#  Expected result
		li		$a2, 5				#  Test #5
		la		$a3, sg5			#  Description of test
		jal		Assert_Equal_Array	#  Check for equality.
		.data
dg5:	.word	26  -5  9 10 48 -39 40  -85 -38  59 37 -48 37  -9 38  -9  -83 -2 39  58 -2 -4  -86 28 38 24 -3
rg5:	.word	26 15 -27 -30 -144 117 -120 255 114 -177 -111 144 -111 27 -114 27 249 6 -117 -174 6 12 258 -84 -114 -72 9
sg5:	.asciiz	"Testing with a long array."
		.text
		
		
#############################################################################################
		#  Test #101
		#  Try to read from a null array.
		#######################################################################
		jal		Initialize_Test_Suite
		li		$a1, 0				#  Array
		jal		scalar_multiplication
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Unexpected result
		li		$a2, 101			#  Test #101
		la		$a3, c101			#  Description of test
		jal		Assert_Null			#  Check for an error.
		
		
		#  Test #102
		#  Array begins outside of memory.
		#######################################################################
		jal		Initialize_Test_Suite
		li		$a1, -40			#  Array
		jal		scalar_multiplication
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Unexpected result
		li		$a2, 102			#  Test #102
		la		$a3, c103			#  Description of test
		jal		Assert_Null			#  Check for an error.
		
		
		#  Test #103
		#  Pointer begins outside of memory
		#######################################################################
		jal		Initialize_Test_Suite
		li		$a1, 0x0FCDA890		#  Array
		jal		scalar_multiplication
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Unexpected result
		li		$a2, 103			#  Test #103
		la		$a3, c105			#  Description of test
		jal		Assert_Null			#  Check for an error.
		
		
		#  Test #104
		#  Pointer outside of memory
		#######################################################################
		jal		Initialize_Test_Suite
		li		$a1, 0xC0000000		#  Array
		jal		scalar_multiplication
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Unexpected result
		li		$a2, 104			#  Test #104
		la		$a3, c107			#  Description of test
		jal		Assert_Null			#  Check for an error.
		
		
		#  Test #105
		#  Non-word aligned array
		#######################################################################
		jal		Initialize_Test_Suite
		li		$a1, 0x10000002		#  Array
		jal		scalar_multiplication
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Unexpected result
		li		$a2, 105			#  Test #105
		la		$a3, c109			#  Description of test
		jal		Assert_Null			#  Check for an error.
		
		
		
		#  Test #106
		#  Non-word aligned array
		#######################################################################
		jal		Initialize_Test_Suite
		li		$a1, 0x10000009		#  Array
		jal		scalar_multiplication
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Unexpected result
		li		$a2, 106			#  Test #106
		la		$a3, c109			#  Description of test
		jal		Assert_Null			#  Check for an error.
		
		
		#  Test #107
		#  Non-word aligned array
		#######################################################################
		jal		Initialize_Test_Suite
		li		$a1, 0x10000013		#  Array
		jal		scalar_multiplication
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Unexpected result
		li		$a2, 107			#  Test #107
		la		$a3, c109			#  Description of test
		jal		Assert_Null			#  Check for an error.
		
		
		#  Test #108
		#  Bad array length
		#######################################################################
		jal		Initialize_Test_Suite
		la		$a1, db115			#  Array
		jal		scalar_multiplication
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Unexpected result
		li		$a2, 108			#  Test #108
		la		$a3, c115			#  Description of test
		jal		Assert_Null			#  Check for an error.
		
		
		#  Test #109
		#  Array extends outside of memory
		#######################################################################
		jal		Initialize_Test_Suite
		la		$a1, db119			#  Array
		jal		scalar_multiplication
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Unexpected result
		li		$a2, 109			#  Test #109
		la		$a3, c119			#  Description of test
		jal		Assert_Null			#  Check for an error.
		
		
		#  Test #110
		#  Array extends outside of memory, but wraps around to the beginning of memory again.
		#######################################################################
		jal		Initialize_Test_Suite
		la		$a1, db121			#  Array
		jal		scalar_multiplication
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Unexpected result
		li		$a2, 110			#  Test #110
		la		$a3, c121			#  Description of test
		jal		Assert_Null			#  Check for an error.
		
		
		#  Test #111
		#  Array remains inside of memory but attempts to cross from the heap to the stack.
		#######################################################################
		jal		Initialize_Test_Suite
		la		$a1, db123			#  Array
		sub		$t0, $sp, $a1
		srl		$t0, $t0, 2			#  Cracked length of the array.
		sw		$t0, 0 ($a1)
		jal		scalar_multiplication
		
		move	$a0, $v0			#  Result
		li		$a1, 0				#  Unexpected result
		li		$a2, 111			#  Test #111
		la		$a3, c123			#  Description of test
		jal		Assert_Null			#  Check for an error.
		
		
		
		
		
		
		
#############################################################################################
#										All Tests Completed									#
Skip_Parameter_Validation_Tests:
		.data
type1:	.asciiz	"Testing the array_double_raw function."
type2:	.asciiz	"Testing the array_double function."
type3:	.asciiz	"Testing the increment function."
type4:	.asciiz	"Testing the swap function."
type5:	.asciiz	"Testing the add function."
type6:	.asciiz	"Testing the subtract function."
type7:	.asciiz	"Testing the scalar_multiplication function."
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
		#  Assert equality for integer arrays without included size parameter
		#	$a0:	Observed
		#	$a1:	Expected
		#	$a2:	Test #
		#	$a3:	Test description
		#	$sp-4:	Array length
		#######################################################################
Assert_Equal_Raw_Array:
		#  1.  Check for a valid observed array.
		#      It should be a pointer to the data region of memory.
		lui		$t0, 0x1000								#  All data should be above 0x1000 0000 and not negative.
		blt		$a0, $t0, AERA_Failed_Outside_of_Memory
		#      It should also be word aligned, since the first value is an integer.
		li		$t0, 0xFFFFFFFC
		and		$t0, $a0, $t0						#  Set the last two bits to zero, to force it to be word aligned.
		bne		$a0, $t0, AERA_Failed_Not_Word_Aligned	#  The results should be equal.
		#  2.  Check to make sure the student isn't trying to pass off the expected array as the observed array.
		beq		$a0, $a1, AERA_Failed_Cheating
		#  These should pass unless the student has done something catastrophic.

		#  Get the length of the array.
		li		$t0, 0
		lw		$t1, -4 ($sp)
AERA_Loop:
		beq		$t0, $t1, AERA_End_Loop

		sll		$t9, $t0, 2
		add		$t2, $a0, $t9
		lw		$t2, 0 ($t2)
		add		$t3, $a1, $t9
		lw		$t3, 0 ($t3)
		bne		$t2, $t3, AERA_Failed_Not_Equal

		addi	$t0, $t0, 1
		j		AERA_Loop
AERA_End_Loop:
		#  All elements are equal, so the arrays are equivalent.
		li		$a0, 1			#  Correct result.
		j		Results

AERA_Failed_Outside_of_Memory:
		li		$a0, 0			#  Incorrect result.
		la		$a1, AERAFOM		#  Description of failure.
		j		Results
		.data
AERAFOM:	.asciiz	"The array pointer is no longer within the data memory range.\nThis is bad, I do not know how you managed to accomplish this.\n"
		.text

AERA_Failed_Not_Word_Aligned:
		li		$a0, 0			#  Incorrect result.
		la		$a1, AEAFNWA	#  Description of failure.
		j		Results
		.data
AERAFNWA:	.asciiz	"The array pointer is no longer word aligned.\nThis is bad, I do now know how you managed to accomplish this.\n"
		.text

AERA_Failed_Cheating:
		li		$a0, 0			#  Incorrect result.
		la		$a1, AERAFC		#  Description of failure.
		j		Results
		.data
AERAFC:	.asciiz	"Cheating is bad, mmmkay?\nQuit trying to game the test suite.\n"
		.text

AERA_Failed_Not_Equal:
		addi	$sp, $sp, -16
		sw		$a0,  0 ($sp)	#  Store the observed array on the stack.
		sw		$a1,  4 ($sp)	#  Store the expected array on the stack.
		sw		$ra,  8 ($sp)	#  Store the return address on the stack.
		sw		$t1, 12 ($sp)	#  Store the length of the array on the stack.

		li		$a0, 0			#  Incorrect result.
		la		$a1, AERAFNE	#  Description of failure.
		j		Results
AERAFNE:	li		$v0, 4
		la		$a0, AERAFNE1
		syscall
		j		AERA_Print_Raw_Array
		.data
AERAFNE1:	.asciiz	"The observed array does not match the expected array.\n"
		.text

		#  Print out the contents of the array to show the student what (s)he did wrong.
AERA_Print_Raw_Array:
		lw		$t0,  0 ($sp)	#  Restore the observed array from the stack.
		lw		$t1,  4 ($sp)	#  Restore the expected array from the stack.
		lw		$t2, 12 ($sp)	#  Restore the length of the array from the stack.

		li		$v0, 4
		la		$a0, Observed
		syscall
		move	$a0, $t0
		move	$a1, $t2
		jal		Print_Raw_Integer_Array

		li		$v0, 4
		la		$a0, Expected
		syscall
		move	$a0, $t1
		move	$a1, $t2
		jal		Print_Raw_Integer_Array

		lw		$ra, 8 ($sp)	#  Restore the return address from the stack.
		addi	$sp, $sp, 16
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
