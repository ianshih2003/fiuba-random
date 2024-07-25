!classDefinition: #NumeroTest category: 'Numeros-Parte2-Ejercicio'!
TestCase subclass: #NumeroTest
	instanceVariableNames: 'zero one two four oneFifth oneHalf five twoFifth twoTwentyfifth fiveHalfs three eight negativeOne negativeTwo'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Parte2-Ejercicio'!
!NumeroTest commentStamp: '<historical>' prior: 0!
t!


!NumeroTest methodsFor: 'tests' stamp: 'LL 9/13/2020 16:17:50'!
test01isZeroReturnsTrueWhenAskToZero

	self assert: zero isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'LL 9/13/2020 16:17:58'!
test02isZeroReturnsFalseWhenAskToOthersButZero

	self deny: one isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:13'!
test03isOneReturnsTrueWhenAskToOne

	self assert: one isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:13'!
test04isOneReturnsFalseWhenAskToOtherThanOne

	self deny: zero isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:39:57'!
test05EnteroAddsWithEnteroCorrectly

	self assert: two equals: one + one! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:40:10'!
test06EnteroMultipliesWithEnteroCorrectly

	self assert: four equals: two * two! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:40:22'!
test07EnteroDividesEnteroCorrectly

	self assert: one equals: two / two! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:40:57'!
test08FraccionAddsWithFraccionCorrectly
"
    La suma de fracciones es:
	 
	a/b + c/d = (a.d + c.b) / (b.d)
	 
	SI ESTAN PENSANDO EN LA REDUCCION DE FRACCIONES NO SE PREOCUPEN!!
	TODAVIA NO SE ESTA TESTEANDO ESE CASO
"
	| sevenTenths |

	sevenTenths := (Entero with: 7) / (Entero with: 10).

	self assert: sevenTenths equals: oneFifth + oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:41:20'!
test09FraccionMultipliesWithFraccionCorrectly
"
    La multiplicacion de fracciones es:
	 
	(a/b) * (c/d) = (a.c) / (b.d)
"

	self assert: twoTwentyfifth equals: oneFifth * twoFifth! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:41:34'!
test10FraccionDividesFraccionCorrectly
"
    La division de fracciones es:
	 
	(a/b) / (c/d) = (a.d) / (b.c)
"

	self assert: fiveHalfs equals: oneHalf / oneFifth! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:41:58'!
test11EnteroAddsFraccionCorrectly
"
	Ahora empieza la diversion!!
"

	self assert: (Entero with: 6) / (Entero with: 5) equals: one + oneFifth! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:42:29'!
test12FraccionAddsEnteroCorrectly

	self assert: (Entero with: 6) / (Entero with: 5) equals: oneFifth + one! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:43:16'!
test13EnteroMultipliesFraccionCorrectly

	self assert: twoFifth equals: two * oneFifth! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:43:27'!
test14FraccionMultipliesEnteroCorrectly

	self assert: twoFifth equals: oneFifth * two! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:43:40'!
test15EnteroDividesFraccionCorrectly

	self assert: fiveHalfs equals: one / twoFifth! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:43:58'!
test16FraccionDividesEnteroCorrectly

	self assert: twoTwentyfifth equals: twoFifth / five! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:38'!
test17AFraccionCanBeEqualToAnEntero

	self assert: two equals: four / two! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:39'!
test18AparentFraccionesAreEqual

	self assert: oneHalf equals: two / four! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:44:53'!
test19AddingFraccionesCanReturnAnEntero

	self assert: one equals: oneHalf + oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:45:13'!
test20MultiplyingFraccionesCanReturnAnEntero

	self assert: one equals: (two/five) * (five/two)! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:45:27'!
test21DividingFraccionesCanReturnAnEntero

	self assert: one equals: oneHalf / oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:45:40'!
test22DividingEnterosCanReturnAFraccion

	self assert: oneHalf equals: two / four! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:50:17'!
test23CanNotDivideEnteroByZero

	self 
		should: [ one / zero ]
		raise: Error
		withExceptionDo: [ :anError | self assert: Numero canNotDivideByZeroErrorDescription equals: anError messageText ]
	! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:50:32'!
test24CanNotDivideFraccionByZero

	self 
		should: [ oneHalf / zero ]
		raise: Error
		withExceptionDo: [ :anError | self assert: Numero canNotDivideByZeroErrorDescription equals: anError messageText ]
	! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:50'!
test25AFraccionCanNotBeZero

	self deny: oneHalf isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:50'!
test26AFraccionCanNotBeOne

	self deny: oneHalf isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:46:21'!
test27EnteroSubstractsEnteroCorrectly

	self assert: two equals: three - one! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:46:36'!
test28FraccionSubstractsFraccionCorrectly
	
	self assert: oneFifth equals: twoFifth - oneFifth! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:46:50'!
test29EnteroSubstractsFraccionCorrectly

	self assert: oneHalf equals: one - oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:47:11'!
test30FraccionSubstractsEnteroCorrectly

	| sixFifth |
	
	sixFifth := (Entero with: 6) / (Entero with: 5).
	
	self assert: oneFifth equals: sixFifth - one! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:47:25'!
test31SubstractingFraccionesCanReturnAnEntero

	| threeHalfs |
	
	threeHalfs := (Entero with: 3) / (Entero with: 2).
	
	self assert: one equals: threeHalfs - oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:47:44'!
test32SubstractingSameEnterosReturnsZero

	self assert: zero equals: one - one! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:47:59'!
test33SubstractingSameFraccionesReturnsZero

	self assert: zero equals: oneHalf - oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:48:16'!
test34SubstractingAHigherValueToANumberReturnsANegativeNumber

	| negativeThreeHalfs |
	
	negativeThreeHalfs := (Entero with: -3) / (Entero with: 2).	

	self assert: negativeThreeHalfs equals: one - fiveHalfs! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:48:45'!
test35FibonacciZeroIsOne

	self assert: one equals: zero fibonacci! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:48:58'!
test36FibonacciOneIsOne

	self assert: one equals: one fibonacci! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:52:24'!
test37FibonacciEnteroReturnsAddingPreviousTwoFibonacciEnteros

	self assert: five equals: four fibonacci.
	self assert: three equals: three fibonacci. 
	self assert: five fibonacci equals: four fibonacci + three fibonacci! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:52:40'!
test38FibonacciNotDefinedForNegativeNumbers

	self 
		should: [negativeOne fibonacci]
		raise: Error
		withExceptionDo: [ :anError | self assert: Entero negativeFibonacciErrorDescription equals: anError messageText ]! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:52:17'!
test39NegationOfEnteroIsCorrect

	self assert: negativeTwo equals: two negated
		! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:53:27'!
test40NegationOfFraccionIsCorrect

	self assert: negativeOne / two equals: oneHalf negated ! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:11'!
test41SignIsCorrectlyAssignedToFractionWithTwoNegatives

	self assert: oneHalf equals: (negativeOne / negativeTwo)! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:17'!
test42SignIsCorrectlyAssignedToFractionWithNegativeDivisor

	self assert: oneHalf negated equals: (one / negativeTwo)! !


!NumeroTest methodsFor: 'setup' stamp: 'NR 9/23/2018 23:46:28'!
setUp

	zero := Entero with: 0.
	one := Entero with: 1.
	two := Entero with: 2.
	three:= Entero with: 3.
	four := Entero with: 4.
	five := Entero with: 5.
	eight := Entero with: 8.
	negativeOne := Entero with: -1.
	negativeTwo := Entero with: -2.
	
	oneHalf := one / two.
	oneFifth := one / five.
	twoFifth := two / five.
	twoTwentyfifth := two / (Entero with: 25).
	fiveHalfs := five / two.
	! !


!classDefinition: #Numero category: 'Numeros-Parte2-Ejercicio'!
Object subclass: #Numero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Parte2-Ejercicio'!

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:48'!
* aMultiplier

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:49'!
+ anAdder

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'NR 9/23/2018 22:21:28'!
- aSubtrahend

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:49'!
/ aDivisor

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'NR 9/23/2018 23:37:13'!
negated
	
	^self * (Entero with: -1)! !


!Numero methodsFor: 'testing' stamp: 'NR 9/23/2018 23:36:49'!
isNegative

	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:49'!
isOne

	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:49'!
isZero

	self subclassResponsibility ! !


!Numero methodsFor: 'private' stamp: 'IS 5/5/2022 20:04:51'!
beAddedToAFraccion: aFraccionAugend
	self subclassResponsibility.! !

!Numero methodsFor: 'private' stamp: 'IS 5/5/2022 20:04:57'!
beAddedToAnEntero: anEnteroAugend
	self subclassResponsibility.! !

!Numero methodsFor: 'private' stamp: 'IS 5/5/2022 20:43:34'!
beMultipliedToAFraccion: aFraccionMultiplier
	self subclassResponsibility ! !

!Numero methodsFor: 'private' stamp: 'IS 5/5/2022 20:42:57'!
beMultipliedToAnEntero: anEnteroMultiplier
	self subclassResponsibility ! !

!Numero methodsFor: 'private' stamp: 'IS 5/6/2022 17:27:34'!
beSubstractedToAFraccion: aFraccionMinuend
	self subclassResponsibility ! !

!Numero methodsFor: 'private' stamp: 'IS 5/6/2022 17:27:49'!
beSubstractedToAnEntero: anEnteroMinuend
	self subclassResponsibility ! !

!Numero methodsFor: 'private' stamp: 'IS 5/5/2022 21:23:49'!
divideAFraccion: aFraccionDividend
	self subclassResponsibility.! !

!Numero methodsFor: 'private' stamp: 'IS 5/5/2022 21:23:54'!
divideAnEntero: aEnteroDividend
	self subclassResponsibility.! !

!Numero methodsFor: 'private' stamp: 'HernanWilkinson 5/7/2016 22:48'!
invalidNumberType

	self error: self class invalidNumberTypeErrorDescription! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Numero class' category: 'Numeros-Parte2-Ejercicio'!
Numero class
	instanceVariableNames: ''!

!Numero class methodsFor: 'error descriptions' stamp: 'NR 5/7/2020 17:47:38'!
canNotDivideByZeroErrorDescription

	^'No se puede Dividir por Cero'! !

!Numero class methodsFor: 'error descriptions' stamp: 'NR 5/7/2020 17:46:56'!
invalidNumberTypeErrorDescription
	^ 'Tipo de Número Inválido'! !


!classDefinition: #Entero category: 'Numeros-Parte2-Ejercicio'!
Numero subclass: #Entero
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Parte2-Ejercicio'!

!Entero methodsFor: 'arithmetic operations' stamp: 'IS 5/5/2022 20:48:44'!
* aMultiplier 
	
	^aMultiplier beMultipliedToAnEntero: self
	! !

!Entero methodsFor: 'arithmetic operations' stamp: 'IS 5/5/2022 20:06:20'!
+ anAdder 
	
	^anAdder beAddedToAnEntero: self.
! !

!Entero methodsFor: 'arithmetic operations' stamp: 'IS 5/6/2022 17:28:41'!
- aSubtrahend 
	
	^aSubtrahend beSubstractedToAnEntero: self! !

!Entero methodsFor: 'arithmetic operations' stamp: 'IS 5/5/2022 21:13:46'!
/ aDivisor 
	
	^aDivisor divideAnEntero: self.! !

!Entero methodsFor: 'arithmetic operations' stamp: 'MS 5/9/2022 15:49:57'!
fibonacci

	self subclassResponsibility.
		! !

!Entero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 21:00'!
greatestCommonDivisorWith: anEntero 
	
	^self class with: (value gcd: anEntero integerValue)! !


!Entero methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 21:01'!
= anObject

	^(anObject isKindOf: self class) and: [ value = anObject integerValue ]! !

!Entero methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:17'!
hash

	^value hash! !


!Entero methodsFor: 'initialization' stamp: 'JS 5/5/2022 03:55:37'!
initializeWith: aValue 
	
	value := aValue! !


!Entero methodsFor: 'accessing' stamp: 'HernanWilkinson 5/7/2016 21:02'!
integerValue

	"Usamos integerValue en vez de value para que no haya problemas con el mensaje value implementado en Object - Hernan"
	
	^value! !


!Entero methodsFor: 'printing' stamp: 'HAW 9/24/2018 08:53:19'!
printOn: aStream

	aStream print: value ! !


!Entero methodsFor: 'testing' stamp: 'NR 9/23/2018 22:17:55'!
isNegative
	
	^value < 0! !

!Entero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 20:14'!
isOne
	
	^value = 1! !

!Entero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 20:12'!
isZero
	
	^value = 0! !


!Entero methodsFor: 'arithmetic operations - private' stamp: 'HernanWilkinson 5/7/2016 21:55'!
// aDivisor 
	
	^self class with: value // aDivisor integerValue! !

!Entero methodsFor: 'arithmetic operations - private' stamp: 'MS 5/6/2022 18:31:43'!
beAddedToAFraccion: aFraccionAugend
	| newNumerator newDenominator |

	newNumerator  := (self * aFraccionAugend denominator) + aFraccionAugend numerator.
	newDenominator  := aFraccionAugend  denominator.

	^newNumerator / newDenominator .! !

!Entero methodsFor: 'arithmetic operations - private' stamp: 'MS 5/9/2022 16:03:12'!
beAddedToAnEntero: anEnteroAugend

	^Entero with: anEnteroAugend integerValue + self integerValue.! !

!Entero methodsFor: 'arithmetic operations - private' stamp: 'MS 5/6/2022 18:28:06'!
beMultipliedToAFraccion: aFraccionMultiplier
	| newNumerator newDenominator |
	
	newNumerator := aFraccionMultiplier numerator * self.
	newDenominator := aFraccionMultiplier denominator.
	
	^newNumerator / newDenominator! !

!Entero methodsFor: 'arithmetic operations - private' stamp: 'MS 5/9/2022 16:41:49'!
beMultipliedToAnEntero: anEnteroMultiplier

	^Entero with: anEnteroMultiplier integerValue * self integerValue.! !

!Entero methodsFor: 'arithmetic operations - private' stamp: 'IS 5/6/2022 17:35:46'!
beSubstractedToAFraccion: aFraccionMinuend
	| newDenominator newNumerator |
	
	newNumerator := aFraccionMinuend numerator - (self * aFraccionMinuend denominator).
	newDenominator := aFraccionMinuend denominator.
	
	^newNumerator / newDenominator.! !

!Entero methodsFor: 'arithmetic operations - private' stamp: 'MS 5/9/2022 16:43:00'!
beSubstractedToAnEntero: anEnteroMinuend

	^Entero with: anEnteroMinuend integerValue - self integerValue.! !

!Entero methodsFor: 'arithmetic operations - private' stamp: 'IS 5/5/2022 21:16:14'!
divideAFraccion: aFraccionDividend
	| newNumerator newDenominator |
	
	newNumerator := aFraccionDividend numerator .
	newDenominator := self * aFraccionDividend denominator.

	^ newNumerator / newDenominator.! !

!Entero methodsFor: 'arithmetic operations - private' stamp: 'MS 5/6/2022 18:28:56'!
divideAnEntero: anEnteroDividend

	^Fraccion with: anEnteroDividend over: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Entero class' category: 'Numeros-Parte2-Ejercicio'!
Entero class
	instanceVariableNames: ''!

!Entero class methodsFor: 'instance creation' stamp: 'MS 5/9/2022 16:43:57'!
negativeFibonacciErrorDescription
	^ ' Fibonacci no está definido aquí para Enteros Negativos'! !

!Entero class methodsFor: 'instance creation' stamp: 'MS 5/9/2022 16:37:54'!
with: aValue 
	
	"Esta verificacion esta puesta por si se equivocan y quieren crear un Entero pasando otra cosa que un Integer - Hernan"
	aValue isInteger ifFalse: [  self error: 'aValue debe ser anInteger' ].
	
	aValue = 0 ifTrue: [^Cero new].
	aValue = 1 ifTrue: [^Uno new].
	aValue > 0 ifTrue: [^PositivoSinElUno new initializeWith: aValue].
	^Negativo new initializeWith: aValue! !


!classDefinition: #Cero category: 'Numeros-Parte2-Ejercicio'!
Entero subclass: #Cero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Parte2-Ejercicio'!

!Cero methodsFor: 'arithmetic operations' stamp: 'MS 5/9/2022 18:38:07'!
absoluteValue
	^self! !

!Cero methodsFor: 'arithmetic operations' stamp: 'MS 5/9/2022 15:49:35'!
fibonacci
	
	^ Entero with: 1
		! !


!Cero methodsFor: 'initialization' stamp: 'MS 5/9/2022 15:54:48'!
initialize
	
	value := 0! !


!Cero methodsFor: 'other (private)' stamp: 'MS 5/9/2022 18:36:10'!
generateValidNumeratorWithDividend: aDividend

	self error: Entero canNotDivideByZeroErrorDescription.! !


!Cero methodsFor: 'testing' stamp: 'MS 5/9/2022 18:57:48'!
evaluateBlockIfIsOne: aBlockToEvaluate

	^nil ! !

!Cero methodsFor: 'testing' stamp: 'MS 5/9/2022 19:04:01'!
evaluateBlockIfIsZero: aBlockToEvaluate

	^aBlockToEvaluate value! !


!classDefinition: #Negativo category: 'Numeros-Parte2-Ejercicio'!
Entero subclass: #Negativo
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Parte2-Ejercicio'!

!Negativo methodsFor: 'arithmetic operations' stamp: 'MS 5/9/2022 18:37:59'!
absoluteValue
	^self*(Entero with: -1).! !

!Negativo methodsFor: 'arithmetic operations' stamp: 'MS 5/9/2022 16:44:07'!
fibonacci

	self error: Entero negativeFibonacciErrorDescription.	
! !


!Negativo methodsFor: 'testing' stamp: 'MS 5/9/2022 18:57:35'!
evaluateBlockIfIsOne: aBlockToEvaluate

	^nil ! !

!Negativo methodsFor: 'testing' stamp: 'MS 5/9/2022 18:57:32'!
evaluateBlockIfIsZero: aBlockToEvaluate

	^nil ! !


!Negativo methodsFor: 'other (private)' stamp: 'MS 5/9/2022 18:34:26'!
generateValidNumeratorWithDividend: aDividend

	^aDividend * (Entero with: -1)! !


!classDefinition: #PositivoSinElUno category: 'Numeros-Parte2-Ejercicio'!
Entero subclass: #PositivoSinElUno
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Parte2-Ejercicio'!

!PositivoSinElUno methodsFor: 'other (private)' stamp: 'MS 5/9/2022 18:33:32'!
generateValidNumeratorWithDividend: aDividend
	^aDividend! !


!PositivoSinElUno methodsFor: 'arithmetic operations' stamp: 'MS 5/9/2022 18:37:43'!
absoluteValue
	^self! !

!PositivoSinElUno methodsFor: 'arithmetic operations' stamp: 'MS 5/9/2022 15:49:48'!
fibonacci

	| one two |
	
	one := Entero with: 1.
	two := Entero with: 2.
	
	^ (self - one) fibonacci + (self - two) fibonacci
		! !


!PositivoSinElUno methodsFor: 'testing' stamp: 'MS 5/9/2022 18:56:49'!
evaluateBlockIfIsOne: aBlockToEvaluate

	^nil ! !

!PositivoSinElUno methodsFor: 'testing' stamp: 'MS 5/9/2022 18:56:43'!
evaluateBlockIfIsZero: aBlockToEvaluate

	^nil ! !


!classDefinition: #Uno category: 'Numeros-Parte2-Ejercicio'!
Entero subclass: #Uno
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Parte2-Ejercicio'!

!Uno methodsFor: 'arithmetic operations' stamp: 'MS 5/9/2022 18:37:38'!
absoluteValue
	^self! !

!Uno methodsFor: 'arithmetic operations' stamp: 'MS 5/9/2022 15:49:42'!
fibonacci
	
	^ Entero with: 1
		! !


!Uno methodsFor: 'initialization' stamp: 'MS 5/9/2022 15:55:22'!
initialize 
	
	value := 1! !


!Uno methodsFor: 'testing' stamp: 'MS 5/9/2022 19:03:58'!
evaluateBlockIfIsOne: aBlockToEvaluate

	^aBlockToEvaluate value! !

!Uno methodsFor: 'testing' stamp: 'MS 5/9/2022 18:57:06'!
evaluateBlockIfIsZero: aBlockToEvaluate

	^nil ! !


!Uno methodsFor: 'other (private)' stamp: 'MS 5/9/2022 18:35:36'!
generateValidNumeratorWithDividend: aDividend! !


!classDefinition: #Fraccion category: 'Numeros-Parte2-Ejercicio'!
Numero subclass: #Fraccion
	instanceVariableNames: 'numerator denominator'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Parte2-Ejercicio'!

!Fraccion methodsFor: 'arithmetic operations' stamp: 'IS 5/5/2022 20:43:59'!
* aMultiplier 
	
	^aMultiplier beMultipliedToAFraccion: self.
	! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'IS 5/5/2022 20:20:46'!
+ anAdder 
	^anAdder beAddedToAFraccion: self.! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'IS 5/6/2022 17:31:53'!
- aSubtrahend 
	
	^aSubtrahend beSubstractedToAFraccion: self
! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'IS 5/5/2022 21:19:53'!
/ aDivisor 
	
	^aDivisor divideAFraccion: self! !


!Fraccion methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:42'!
= anObject

	^(anObject isKindOf: self class) and: [ (numerator * anObject denominator) = (denominator * anObject numerator) ]! !

!Fraccion methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:50'!
hash

	^(numerator hash / denominator hash) hash! !


!Fraccion methodsFor: 'accessing' stamp: 'HernanWilkinson 5/7/2016 21:56'!
denominator

	^ denominator! !

!Fraccion methodsFor: 'accessing' stamp: 'HernanWilkinson 5/7/2016 21:56'!
numerator

	^ numerator! !


!Fraccion methodsFor: 'initialization' stamp: 'HernanWilkinson 5/7/2016 22:54'!
initializeWith: aNumerator over: aDenominator

	"Estas precondiciones estan por si se comenten errores en la implementacion - Hernan"
	aNumerator isZero ifTrue: [ self error: 'una fraccion no puede ser cero' ].
	aDenominator isOne ifTrue: [ self error: 'una fraccion no puede tener denominador 1 porque sino es un entero' ].
	
	numerator := aNumerator.
	denominator := aDenominator ! !


!Fraccion methodsFor: 'testing' stamp: 'NR 9/23/2018 23:41:38'!
isNegative
	
	^numerator < 0! !

!Fraccion methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:51'!
isOne
	
	^false! !

!Fraccion methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:51'!
isZero
	
	^false! !


!Fraccion methodsFor: 'arithmetic operations - private' stamp: 'IS 5/5/2022 20:26:26'!
beAddedToAFraccion: aFraccionAugend
	| newNumerator newDenominator |
	
	newNumerator := (numerator * aFraccionAugend denominator) + (denominator * aFraccionAugend numerator).
	newDenominator := denominator * aFraccionAugend denominator.
	
	^newNumerator / newDenominator ! !

!Fraccion methodsFor: 'arithmetic operations - private' stamp: 'MS 5/6/2022 18:34:10'!
beAddedToAnEntero: anEnteroAugend

	^((anEnteroAugend * denominator) + numerator) / denominator ! !

!Fraccion methodsFor: 'arithmetic operations - private' stamp: 'MS 5/6/2022 18:33:59'!
beMultipliedToAFraccion: aFraccionMultiplier
	| newNumerator newDenominator |
	
	newNumerator := numerator * aFraccionMultiplier numerator.
	newDenominator := denominator * aFraccionMultiplier denominator.
	
	^newNumerator / newDenominator! !

!Fraccion methodsFor: 'arithmetic operations - private' stamp: 'MS 5/6/2022 18:34:02'!
beMultipliedToAnEntero: anEnteroMultiplier
	| newNumerator |
	
	newNumerator := anEnteroMultiplier * numerator.
	
	^newNumerator / denominator.! !

!Fraccion methodsFor: 'arithmetic operations - private' stamp: 'IS 5/6/2022 17:31:29'!
beSubstractedToAFraccion: aFraccionMinuend
	| newNumerator newDenominator |
	
	newNumerator := (denominator * aFraccionMinuend numerator) - (numerator * aFraccionMinuend denominator).
	newDenominator := denominator * aFraccionMinuend denominator.
	
	^newNumerator / newDenominator ! !

!Fraccion methodsFor: 'arithmetic operations - private' stamp: 'IS 5/6/2022 17:38:51'!
beSubstractedToAnEntero: anEnteroMinuend
	| newNumerator newDenominator |
	
	newNumerator := (anEnteroMinuend * self denominator) - self numerator.
	newDenominator := denominator.
	
	^newNumerator / newDenominator ! !

!Fraccion methodsFor: 'arithmetic operations - private' stamp: 'IS 5/5/2022 21:19:35'!
divideAFraccion: aFraccionDividend
	| newNumerator newDenominator |
	
	newNumerator := self denominator * aFraccionDividend numerator.
	newDenominator := self numerator * aFraccionDividend denominator.
	
	^newNumerator / newDenominator.! !

!Fraccion methodsFor: 'arithmetic operations - private' stamp: 'IS 5/5/2022 21:18:51'!
divideAnEntero: anEnteroDividend
	| newNumerator newDenominator |
	
	newNumerator := anEnteroDividend * self denominator .
	newDenominator := self numerator.
	
	^newNumerator / newDenominator.! !


!Fraccion methodsFor: 'printing' stamp: 'HAW 9/24/2018 08:54:46'!
printOn: aStream

	aStream 
		print: numerator;
		nextPut: $/;
		print: denominator ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Fraccion class' category: 'Numeros-Parte2-Ejercicio'!
Fraccion class
	instanceVariableNames: ''!

!Fraccion class methodsFor: 'intance creation' stamp: 'MS 5/9/2022 19:01:02'!
with: aDividend over: aDivisor

	| greatestCommonDivisor numerator denominator |
	
	numerator := aDivisor generateValidNumeratorWithDividend: aDividend.
	denominator := aDivisor absoluteValue.
	
	
	
	greatestCommonDivisor := aDividend greatestCommonDivisorWith: aDivisor. 
	numerator := aDividend // greatestCommonDivisor.
	denominator := aDivisor // greatestCommonDivisor.
	
	aDividend evaluateBlockIfIsZero: [ ^aDividend ].
	denominator evaluateBlockIfIsOne: [ ^numerator ].


	^self new initializeWith: numerator over: denominator
	! !
