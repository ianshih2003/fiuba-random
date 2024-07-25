!classDefinition: #CantSuspend category: 'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: 'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: 'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'private-testing' stamp: 'MS 5/2/2022 02:02:55'!
action: aClosure takesLessThan: duration

	| millisecondsBeforeRunning millisecondsAfterRunning |
	
	
	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
	aClosure value.
	millisecondsAfterRunning := Time millisecondClockValue * millisecond.
	
	^(millisecondsAfterRunning-millisecondsBeforeRunning) < duration.
	
! !

!CustomerBookTest methodsFor: 'private-testing' stamp: 'IM 4/30/2022 17:17:20'!
addSuspendedCustomer: aCustomer to: aCustomerBook
	aCustomerBook addCustomerNamed: aCustomer.
	aCustomerBook suspendCustomerNamed: aCustomer.
	
	! !

!CustomerBookTest methodsFor: 'private-testing' stamp: 'MS 5/2/2022 02:38:36'!
correctNumberOfActive: aNumberOfActiveCustomers andSuspended: aNumberOfSuspendedCustomers in: aCustomerBook

	| totalNumberOfCustomers |
	
	totalNumberOfCustomers  := aNumberOfActiveCustomers + aNumberOfSuspendedCustomers.

	^(aCustomerBook numberOfActiveCustomers = aNumberOfActiveCustomers) 
		and: [aCustomerBook numberOfSuspendedCustomers = aNumberOfSuspendedCustomers ] 
		and: [aCustomerBook numberOfCustomers = totalNumberOfCustomers]! !

!CustomerBookTest methodsFor: 'private-testing' stamp: 'MS 5/2/2022 02:40:49'!
correctNumberOfActive: aNumberOfActiveCustomers andSuspended: aNumberOfSuspendedCustomers including: aCustomerName in: aCustomerBook

	^(self correctNumberOfActive: aNumberOfActiveCustomers andSuspended: aNumberOfSuspendedCustomers in:  aCustomerBook) 
		and: [	aCustomerBook includesCustomerNamed: aCustomerName.].
	
	! !

!CustomerBookTest methodsFor: 'private-testing' stamp: 'MS 5/2/2022 02:37:12'!
correctNumberOfActive: aNumberOfActiveCustomers suspended: aNumberOfSuspendedCustomers total: aNumberOfCustomers in: aCustomerBook

	| totalNumberOfCustomers |
	
	totalNumberOfCustomers  := aNumberOfActiveCustomers + aNumberOfSuspendedCustomers.

	^(aCustomerBook numberOfActiveCustomers = aNumberOfActiveCustomers) 
		and: [aCustomerBook numberOfSuspendedCustomers = aNumberOfSuspendedCustomers ] 
		and: [aCustomerBook numberOfCustomers = totalNumberOfCustomers]! !

!CustomerBookTest methodsFor: 'private-testing' stamp: 'MS 5/2/2022 02:42:38'!
correctNumberOfCustomers: aNumber andIncludes: aCustomer in: aCustomerBook
	^(aCustomerBook numberOfCustomers = aNumber) and: [aCustomerBook includesCustomerNamed: aCustomer].
! !

!CustomerBookTest methodsFor: 'private-testing' stamp: 'IS 5/2/2022 16:18:40'!
try: aBlockThatFails on: anError  assert: aBlockToAssert 
	
	[ aBlockThatFails value.
	self fail ]
		on: anError 
		do: [ :error | self assert: (aBlockToAssert valueWithPossibleArgument: error )]
! !


!CustomerBookTest methodsFor: 'testing' stamp: 'MS 5/2/2022 02:46:08'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	|customerBook|
	customerBook := CustomerBook new.
	
	self assert: (self action: [			customerBook addCustomerNamed: 'John Lennon'.		]		takesLessThan: (50 * millisecond)).
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'MS 5/2/2022 02:02:55'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds
	
	|customerBook paulMcCartney|
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	
	self assert: (self action: [			customerBook removeCustomerNamed: paulMcCartney.		]		takesLessThan: (100 * millisecond)).
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'IS 5/2/2022 16:18:40'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook |
			
	customerBook := CustomerBook new.
		
	self try: [ customerBook addCustomerNamed: '' ] on: Error 
		assert: [ :anError | (anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage) and: [customerBook isEmpty]].! !

!CustomerBookTest methodsFor: 'testing' stamp: 'IS 5/2/2022 16:18:40'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	self try: [ customerBook removeCustomerNamed: 'Paul McCartney' ] on: NotFound 
		assert: [ 	customerBook numberOfCustomers = 1 and: [		customerBook includesCustomerNamed: johnLennon ]].
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'MS 5/2/2022 02:14:56'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	self addSuspendedCustomer: paulMcCartney to: customerBook.
	
	self assert: (self correctNumberOfActive: 0 suspended: 1 total: 1 in: customerBook).
	
	self assert: (customerBook includesCustomerNamed: paulMcCartney).
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'MS 5/2/2022 02:14:34'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	self addSuspendedCustomer: paulMcCartney to: customerBook.
	customerBook removeCustomerNamed: paulMcCartney.
	
	self assert: (self correctNumberOfActive: 0 suspended: 0 total: 0 in: customerBook).
		
	self deny: (customerBook includesCustomerNamed: paulMcCartney).


	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'IS 5/2/2022 16:18:40'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
		
	self try: [ customerBook suspendCustomerNamed: 'Ringo Starr' ] on: CantSuspend assert: [self correctNumberOfCustomers: 1 andIncludes: johnLennon in: customerBook].
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'IS 5/2/2022 16:18:40'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook johnLennon |		
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	self addSuspendedCustomer: johnLennon to: customerBook.
	
	self try: [ customerBook suspendCustomerNamed: johnLennon.] on: CantSuspend assert: [self correctNumberOfCustomers: 1 andIncludes: johnLennon in: customerBook]
! !


!classDefinition: #CustomerBook category: 'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'initialization' stamp: 'NR 4/3/2019 10:14:26'!
initialize

	super initialize.
	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'MS 4/30/2022 16:09:36'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	(self includesCustomerNamed: aName) ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'MS 4/30/2022 16:11:43'!
numberOfCustomers
	
	^self numberOfActiveCustomers + self numberOfSuspendedCustomers! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'MS 4/30/2022 17:01:05'!
removeCustomerNamed: aName 
 
	(self includesCustomerNamed: aName) ifTrue: [
		active remove: aName ifAbsent: [nil].
		suspended remove: aName ifAbsent: [nil].
		^aName.
	].
	
	^ NotFound signal.
! !

!CustomerBook methodsFor: 'customer management' stamp: 'MS 5/2/2022 03:02:47'!
signalCustomerAlreadyExists 

	self signal: (#customerAlreadyExistsErrorMessage).! !

!CustomerBook methodsFor: 'customer management' stamp: 'MS 5/2/2022 03:06:31'!
signalCustomerNameCannotBeEmpty 

	self signal: #customerCanNotBeEmptyErrorMessage.! !

!CustomerBook methodsFor: 'customer management' stamp: 'MS 4/30/2022 17:00:30'!
suspendCustomerNamed: aName 
	
	active remove: aName ifAbsent: [^CantSuspend signal]. 
	
	suspended add: aName
! !


!CustomerBook methodsFor: 'private' stamp: 'MS 5/2/2022 03:07:19'!
signal: aClassMessageSymbol

	self error: (aClassMessageSymbol asMessage sendTo: (self class)).! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: 'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/30/2020 09:05:18'!
customerAlreadyExistsErrorMessage

	^'Customer Already Exists'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/30/2020 09:05:25'!
customerCanNotBeEmptyErrorMessage

	^'Customer Name Cannot Be Empty'! !
