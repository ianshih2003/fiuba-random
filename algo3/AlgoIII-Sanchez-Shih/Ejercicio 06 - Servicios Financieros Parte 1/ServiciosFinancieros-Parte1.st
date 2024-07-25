!classDefinition: #PortfolioTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: 'anAccount aSecondAccount aThirdAccount'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!PortfolioTest methodsFor: 'extra' stamp: 'MS 6/9/2022 16:15:04'!
test12PortfolioCanNotBeCreatedWithRepeatedAccount
	

	self should: [Portfolio with: {anAccount. anAccount}] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError | anError messageText = Portfolio repeatedAccountErrorDescription ].
	! !

!PortfolioTest methodsFor: 'extra' stamp: 'MS 6/9/2022 16:15:04'!
test13PortfolioCanNotBeCreatedWithAccountThatIsAlreadyInChildPortfolioWithOneAccount

	| aChildPortfolio |

	aChildPortfolio := Portfolio with: {anAccount }.
	
	self should: [Portfolio with: {aChildPortfolio. anAccount}] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError | anError messageText = Portfolio repeatedAccountErrorDescription ].
	! !

!PortfolioTest methodsFor: 'extra' stamp: 'MS 6/9/2022 16:15:06'!
test14PortfolioCanNotBeCreatedWithAccountThatIsAlreadyInChildPortfolioWithMultipleAccounts

	| aChildPortfolio |
	
	aChildPortfolio := Portfolio with: {anAccount. aSecondAccount }.
	
	self should: [Portfolio with: {aChildPortfolio. aSecondAccount}] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError | anError messageText = Portfolio repeatedAccountErrorDescription ].
	! !

!PortfolioTest methodsFor: 'extra' stamp: 'MS 6/9/2022 16:15:04'!
test15PortfolioCanAddAnAccountAndHasItsTransactions

	| aPortfolio aDeposit |

	aDeposit := Deposit register: 20*peso on: anAccount.
	aPortfolio := Portfolio with: {}.
	aPortfolio add: anAccount.
	
	self assert: (OrderedCollection with: aDeposit) equals: aPortfolio transactions.
	! !

!PortfolioTest methodsFor: 'extra' stamp: 'MS 6/9/2022 16:15:06'!
test16PortfolioCanAddMultipleAccountAndHasTheirTransactions

	| aPortfolio aDeposit aWithdraw |
	
	aDeposit := Deposit register: 20*peso on: anAccount.
	aWithdraw := Withdraw register: 30*peso on: aSecondAccount .
	aPortfolio := Portfolio with: {}.
	
	aPortfolio add: anAccount.
	aPortfolio add: aSecondAccount.
	
	self assert: (OrderedCollection with: aDeposit with: aWithdraw) equals: aPortfolio transactions.
	! !

!PortfolioTest methodsFor: 'extra' stamp: 'MS 6/9/2022 15:39:48'!
test17PortfolioCanNotAddItself

	| aPortfolio |
	
	aPortfolio := Portfolio with: {}.
	
	
	self should: [aPortfolio add: aPortfolio.]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError | anError messageText = Portfolio addingSelfErrorDescription ].
	
	! !

!PortfolioTest methodsFor: 'extra' stamp: 'MS 6/9/2022 15:39:38'!
test18PortfolioCanNotAddParentPortfolio

	| aChildPortfolio aParentPortfolio |
	
	aChildPortfolio := Portfolio with: {}.
	aParentPortfolio := Portfolio with: {aChildPortfolio}.
	

	self should: [aChildPortfolio add: aParentPortfolio.]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError | anError messageText = Portfolio addingSelfErrorDescription ].
	
	! !

!PortfolioTest methodsFor: 'extra' stamp: 'MS 6/9/2022 15:39:34'!
test19PortfolioCanNotAddGrandparentPortfolio

	| aChildPortfolio aParentPortfolio aGrandparentPortfolio |
	
	aChildPortfolio := Portfolio with: {}.
	aParentPortfolio := Portfolio with: {aChildPortfolio}.
	aGrandparentPortfolio := Portfolio with: {aParentPortfolio}.
	

	self should: [aChildPortfolio add: aGrandparentPortfolio.]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError | anError messageText = Portfolio addingSelfErrorDescription ].
	
	! !

!PortfolioTest methodsFor: 'extra' stamp: 'MS 6/9/2022 16:15:04'!
test20PortfolioCanNotAddPortfolioThatHasAccountThatIsAlreadyInSelf

	| aChildPortfolio aParentPortfolio |
	
	aChildPortfolio := Portfolio with: {anAccount}.
	aParentPortfolio := Portfolio with: {anAccount}.	

	self should: [aParentPortfolio add: aChildPortfolio.]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError | anError messageText = Portfolio repeatedAccountErrorDescription ].
	
	! !


!PortfolioTest methodsFor: 'private' stamp: 'MS 6/9/2022 16:15:07'!
setUp

	anAccount := ReceptiveAccount new.
	aSecondAccount := ReceptiveAccount new.
	aThirdAccount := ReceptiveAccount new.! !


!PortfolioTest methodsFor: 'tests' stamp: 'IS 6/6/2022 21:03:01'!
test01EmptyPortfolioHasZeroBalance
	| portfolio |
	
	portfolio := Portfolio with: {}.
	
	
	self assert: 0*peso equals: portfolio balance.! !

!PortfolioTest methodsFor: 'tests' stamp: 'MS 6/9/2022 16:15:04'!
test02PortfolioWithOneAccountHasSameBalanceAsAccount
	| portfolio |
	
	Deposit register: 100*peso on: anAccount.
	portfolio := Portfolio with: {anAccount}.
	
	self assert: anAccount balance equals: portfolio balance.! !

!PortfolioTest methodsFor: 'tests' stamp: 'MS 6/9/2022 16:15:07'!
test03PortfolioWithMultipleAccountsHasSameBalanceAsSumOfAccountBalances
	| portfolio |
	
	Deposit register: 100*peso on: anAccount.
	Deposit register: 200*peso on: aSecondAccount.
	Deposit register: 130*peso on: aThirdAccount.
	
	portfolio := Portfolio with: {anAccount. aSecondAccount. aThirdAccount}.
	
	
	self assert: 430*peso equals: portfolio balance.! !

!PortfolioTest methodsFor: 'tests' stamp: 'MS 6/9/2022 16:15:07'!
test04PortfolioWithAccountAndPortfolioHasSameBalanceAsSumOfAllAccountBalances
	| aPortfolio anotherPortfolio |

	Deposit register: 100*peso on: anAccount.
	Deposit register: 200*peso on: aSecondAccount.
	Deposit register: 130*peso on: aThirdAccount.
	
	aPortfolio := Portfolio with: {anAccount. aSecondAccount }.
	anotherPortfolio := Portfolio with: {aPortfolio. aThirdAccount}.
	
	self assert: 430*peso equals: anotherPortfolio balance.! !

!PortfolioTest methodsFor: 'tests' stamp: 'MS 6/9/2022 16:15:04'!
test05PortfolioWithNoAccountsHasNoTransactionsRegistered

	| aPortfolio aDeposit |
	
	aDeposit := Deposit register: 20*peso on: anAccount.
	aPortfolio := Portfolio with: {}.
	
	self assert: false equals: (aPortfolio hasRegistered: aDeposit).! !

!PortfolioTest methodsFor: 'tests' stamp: 'MS 6/9/2022 16:15:04'!
test06PortfolioWithAccountThatHasTransactionHasItRegistered

	| aPortfolio aDeposit |

	aDeposit := Deposit register: 20*peso on: anAccount.
	aPortfolio := Portfolio with: {anAccount }.
	
	self assert: true equals: (aPortfolio hasRegistered: aDeposit).! !

!PortfolioTest methodsFor: 'tests' stamp: 'MS 6/9/2022 16:15:04'!
test07PortfolioWithOneAccountThatHasNoTransactionsHasNoTransactionsRegistered

	| aPortfolio aDeposit |
	
	aDeposit := Deposit for: 20*peso.
	aPortfolio := Portfolio with: {anAccount}.
	
	self deny: (aPortfolio hasRegistered: aDeposit).! !

!PortfolioTest methodsFor: 'tests' stamp: 'MS 6/9/2022 16:15:06'!
test08PortfolioWithMultipleAccountsHasTransactionRegistered

	| aPortfolio aDeposit |

	aDeposit := Deposit register: 20*peso on: aSecondAccount.
	aPortfolio := Portfolio with: {anAccount. aSecondAccount}.
	
	self assert: (aPortfolio hasRegistered: aDeposit).! !

!PortfolioTest methodsFor: 'tests' stamp: 'MS 6/8/2022 22:13:12'!
test09EmptyPortfolioHasNoTransactions

	| aPortfolio |
	
	aPortfolio := Portfolio with: {}.
	
	self assert: aPortfolio transactions isEmpty.! !

!PortfolioTest methodsFor: 'tests' stamp: 'MS 6/9/2022 16:15:04'!
test10PortfolioWithOneAccountHasItsTransactions

	| aPortfolio |

	Deposit register: 20*peso on: anAccount.
	aPortfolio := Portfolio with: {anAccount.}.
	
	self assert: anAccount transactions equals: (aPortfolio transactions)! !

!PortfolioTest methodsFor: 'tests' stamp: 'MS 6/9/2022 16:15:06'!
test11PortfolioWithMultipleAccountsHasItsTransactions

	| aPortfolio anotherPortfolio transactions |
	
	aPortfolio := Portfolio with: {anAccount }.
	anotherPortfolio := Portfolio with: {aPortfolio. aSecondAccount}.
	transactions := OrderedCollection new.
	
	transactions addAll: {Deposit register: 20*peso on: anAccount. Deposit register: 40*peso on: aSecondAccount. Withdraw register: 25*peso on: aSecondAccount.}.
	
	self assert: transactions equals: (anotherPortfolio transactions)! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PortfolioTest class' category: 'ServiciosFinancieros-Ejercicio'!
PortfolioTest class
	instanceVariableNames: ''!

!PortfolioTest class methodsFor: 'as yet unclassified' stamp: 'MS 6/9/2022 14:35:02'!
DoIt


	| anAccount aChildPortfolio |
	
	anAccount := ReceptiveAccount new.
	aChildPortfolio := Portfolio with: {anAccount }.
	Portfolio with: {aChildPortfolio. anAccount}.
	
	self should: [Portfolio with: {aChildPortfolio. anAccount}] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError | anError messageText = Portfolio repeatedAccountErrorDescription ].
	! !


!classDefinition: #ReceptiveAccountTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: 'account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'private' stamp: 'MS 6/9/2022 16:01:07'!
setUp
	
	account := ReceptiveAccount new.
! !


!ReceptiveAccountTest methodsFor: 'tests' stamp: 'MS 6/9/2022 16:01:07'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	self assert: 0 equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'MS 6/9/2022 16:01:07'!
test02DepositIncreasesBalanceOnTransactionValue 

	Deposit register: 100 * peso on: account.
		
	self assert: 100 * peso equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'MS 6/9/2022 16:01:07'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	Deposit register: 100 * peso on: account.
	Withdraw register: 50 * peso on: account.
		
	self assert: 50 * peso equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'MS 6/9/2022 16:01:07'!
test04WithdrawValueMustBePositive 

	|  withdrawValue |
	
	withdrawValue := 50 * peso.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'MS 6/9/2022 16:01:07'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| deposit withdraw |
	
	deposit := Deposit register: 100 * peso on: account.
	withdraw := Withdraw register: 50 * peso on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'MS 6/9/2022 16:01:07'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| deposit withdraw |
	
	deposit :=  Deposit for: 100 * peso.
	withdraw := Withdraw for: 50 * peso.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'MS 6/9/2022 16:01:07'!
test07AccountKnowsItsTransactions 

	| deposit |
	
	deposit := Deposit register: 50 * peso on: account.
		
	self assert: 1 equals: account transactions size.
	self assert: (account transactions includes: deposit).
! !


!classDefinition: #TransferTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #TransferTest
	instanceVariableNames: 'senderAccount receiverAccount'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!TransferTest methodsFor: 'tests' stamp: 'MS 6/9/2022 16:03:19'!
test01TransferValueIsCorrect
	| transfer |
	
	transfer := Transfer register: 100*peso from: senderAccount to: receiverAccount .
	
	self assert: 100*peso equals: transfer value.
		
	! !

!TransferTest methodsFor: 'tests' stamp: 'MS 6/9/2022 16:03:42'!
test02TransferCanNotBeCreatedWithZeroValue

	self should: [Transfer register: 0*peso from: senderAccount to: receiverAccount.]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError | anError messageText = Transfer invalidValueTransferErrorDescription] 
		
		
	! !

!TransferTest methodsFor: 'tests' stamp: 'MS 6/9/2022 16:03:54'!
test03TransferCanNotBeCreatedWithNegativeValue

	self should: [Transfer register: -100*peso from: senderAccount to: receiverAccount .]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError | anError messageText = Transfer invalidValueTransferErrorDescription] 
		
		
	! !

!TransferTest methodsFor: 'tests' stamp: 'MS 6/9/2022 16:04:05'!
test04TransferCanNotBeBetweenTheSameAccounts

	self should: [Transfer register: 50*peso from: senderAccount to: senderAccount.]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError | anError messageText = Transfer invalidTransferAccountsErrorDescription ] 
		
		
	! !

!TransferTest methodsFor: 'tests' stamp: 'MS 6/9/2022 16:04:19'!
test05TransferDepositsMoneyOnDepositAccount
	| transferencia |
	
	transferencia := Transfer register: 150*peso from: senderAccount to: receiverAccount .
	
	self assert: transferencia value equals: receiverAccount balance.! !

!TransferTest methodsFor: 'tests' stamp: 'MS 6/9/2022 16:04:35'!
test06TransferWithdrawsMoneyFromExtractionAccount
	| transferencia |
		
	transferencia := Transfer register: 20*peso from: senderAccount to: receiverAccount.
	
	self assert: transferencia value negated equals: senderAccount balance.! !

!TransferTest methodsFor: 'tests' stamp: 'MS 6/9/2022 16:04:51'!
test07TransferWithdrawLegKnowsItsCounterpart
	| transferencia |
	
	transferencia := Transfer register: 50*peso from: senderAccount to: receiverAccount.
	
	self assert: transferencia depositLeg equals: transferencia withdrawLeg counterpart.! !

!TransferTest methodsFor: 'tests' stamp: 'MS 6/9/2022 16:05:07'!
test08TransferDepositLegKnowsItsCounterpart
	| transferencia |
	
	transferencia := Transfer register: 75*peso from: senderAccount to: receiverAccount.
	
	self assert: transferencia withdrawLeg equals: transferencia depositLeg counterpart.! !


!TransferTest methodsFor: 'private' stamp: 'MS 6/9/2022 16:02:56'!
setUp
	
	senderAccount := ReceptiveAccount new.
	receiverAccount := ReceptiveAccount new.! !


!classDefinition: #Account category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #Account
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Account methodsFor: 'main protocol' stamp: 'MS 6/9/2022 15:48:07'!
accounts
	self subclassResponsibility.! !

!Account methodsFor: 'main protocol' stamp: 'MS 6/8/2022 22:17:43'!
balance
	self subclassResponsibility.! !

!Account methodsFor: 'main protocol' stamp: 'MS 6/9/2022 16:16:15'!
hasRegistered: aTransactionToVerify
	self subclassResponsibility.! !

!Account methodsFor: 'main protocol' stamp: 'MS 6/8/2022 22:18:03'!
transactions
	self subclassResponsibility.! !


!Account methodsFor: 'comparing' stamp: 'MS 6/9/2022 16:42:04'!
isOrIncludes: anAccountToCheck
	self subclassResponsibility.! !


!classDefinition: #Portfolio category: 'ServiciosFinancieros-Ejercicio'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Portfolio methodsFor: 'private' stamp: 'MS 6/9/2022 16:18:50'!
accounts
	| auxiliaryAccountCollection | 
	auxiliaryAccountCollection := OrderedCollection new.

	^accounts do: [:anAccount | auxiliaryAccountCollection addAll: anAccount accounts].
	
! !


!Portfolio methodsFor: 'main protocol' stamp: 'MS 6/9/2022 15:53:08'!
add: anAccountToAdd
	
	self assertAccountToAddDoesNotInvolveSelf: anAccountToAdd.
	self assertAccountToAddIsNotAlreadyInPortfolio: anAccountToAdd.

	accounts add: anAccountToAdd.! !

!Portfolio methodsFor: 'main protocol' stamp: 'IS 6/6/2022 21:12:33'!
balance
	
	^accounts sum: [:anAccountOrPortfolio | anAccountOrPortfolio balance ] ifEmpty: [0*peso].! !

!Portfolio methodsFor: 'main protocol' stamp: 'MS 6/9/2022 16:16:22'!
hasRegistered: aTransactionToVerify

	^accounts anySatisfy: [:anAccount | anAccount hasRegistered: aTransactionToVerify ].! !

!Portfolio methodsFor: 'main protocol' stamp: 'MS 6/8/2022 22:05:42'!
transactions
	| transactions |

	transactions := OrderedCollection new.
	accounts do: [:anAccount | transactions addAll: anAccount transactions ].
	
	^transactions ! !


!Portfolio methodsFor: 'initialization' stamp: 'MS 6/9/2022 14:58:49'!
initializeWith: anArrayOfAccounts 
	accounts := anArrayOfAccounts asOrderedCollection.
! !


!Portfolio methodsFor: 'comparing' stamp: 'MS 6/9/2022 16:52:30'!
includes: anAccountToCheck
	
	^(accounts anySatisfy: [:anAccount | anAccount isOrIncludes: anAccountToCheck ]) 
! !

!Portfolio methodsFor: 'comparing' stamp: 'MS 6/9/2022 16:52:30'!
isOrIncludes: anAccountToCheck

	^(anAccountToCheck == self) or: (self includes: anAccountToCheck)! !


!Portfolio methodsFor: 'asserting' stamp: 'MS 6/9/2022 16:52:30'!
assertAccountToAddDoesNotInvolveSelf: anAccountToAdd

	(anAccountToAdd isOrIncludes: self) ifTrue: [self error: self class addingSelfErrorDescription ].

! !

!Portfolio methodsFor: 'asserting' stamp: 'MS 6/9/2022 16:57:52'!
assertAccountToAddIsNotAlreadyInPortfolio: anAccountToAdd

	(accounts anySatisfy: [:anAccount | anAccountToAdd isOrIncludes: anAccount ]) ifTrue: [self error: self class repeatedAccountErrorDescription ].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'ServiciosFinancieros-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'error handling' stamp: 'MS 6/9/2022 15:02:12'!
addingSelfErrorDescription
	^'Can not add portfolio in itself.'! !

!Portfolio class methodsFor: 'error handling' stamp: 'MS 6/9/2022 17:08:13'!
assertAccountsAreNotRepeated: anArrayOfAccounts

	| auxiliaryCollectionOfAccounts |
	
	auxiliaryCollectionOfAccounts := OrderedCollection new.
	anArrayOfAccounts do: [:anAccount | auxiliaryCollectionOfAccounts addAll: anAccount accounts].
	(auxiliaryCollectionOfAccounts asSet size = auxiliaryCollectionOfAccounts size) ifFalse: [self error: self repeatedAccountErrorDescription ]! !

!Portfolio class methodsFor: 'error handling' stamp: 'MS 6/9/2022 14:24:00'!
repeatedAccountErrorDescription
	^'Account is already in the portfolio'! !


!Portfolio class methodsFor: 'instance creation' stamp: 'MS 6/9/2022 15:55:16'!
with: anArrayOfAccounts 

	self assertAccountsAreNotRepeated: anArrayOfAccounts.

	^self new initializeWith: anArrayOfAccounts ! !


!classDefinition: #ReceptiveAccount category: 'ServiciosFinancieros-Ejercicio'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'NR 10/17/2019 15:06:56'!
initialize

	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'main protocol' stamp: 'MS 6/8/2022 23:38:04'!
balance
	^transactions inject: 0*peso into: [:aBalance :aTransaction | aTransaction beAddedTo: aBalance. ] 

! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'MS 6/9/2022 16:16:27'!
hasRegistered: aTransactionToVerify

	^ transactions includes: aTransactionToVerify 
! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'MS 6/9/2022 16:17:35'!
register: aTransactionToRegister

	transactions add: aTransactionToRegister 
! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'private' stamp: 'MS 6/9/2022 15:48:08'!
accounts
	^OrderedCollection with: self.! !


!ReceptiveAccount methodsFor: 'comparing' stamp: 'MS 6/9/2022 16:52:30'!
isOrIncludes: anAccountToCheck

	^anAccountToCheck == self.! !


!classDefinition: #AccountTransaction category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'MS 6/6/2022 12:43:58'!
beAddedTo: aBalance 
	self subclassResponsibility.! !

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/17/2019 03:22:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'MS 6/6/2022 12:44:16'!
beAddedTo: aBalance 

	^aBalance + self value.! !

!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'ServiciosFinancieros-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'MS 6/6/2022 12:44:22'!
beAddedTo: aBalance 

	^aBalance - self value.! !

!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'ServiciosFinancieros-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Transfer category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #Transfer
	instanceVariableNames: 'value deposit withdraw depositLeg withdrawLeg'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Transfer methodsFor: 'initialization' stamp: 'MS 6/8/2022 23:28:03'!
initializeRegister: aValue from: anExtractionAccount to: aDepositAccount 
	
	value := aValue.
	
	withdrawLeg := TransferWithdraw register: aValue on: anExtractionAccount in: self.
	depositLeg := TransferDeposit register: aValue on: aDepositAccount in: self.! !


!Transfer methodsFor: 'accessing' stamp: 'MS 6/8/2022 23:10:37'!
depositLeg
	^depositLeg.! !

!Transfer methodsFor: 'accessing' stamp: 'MS 6/8/2022 22:37:51'!
value
	^value! !

!Transfer methodsFor: 'accessing' stamp: 'MS 6/8/2022 23:17:36'!
withdrawLeg
	^withdrawLeg.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'ServiciosFinancieros-Ejercicio'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'asserting' stamp: 'MS 6/8/2022 22:22:15'!
assertAccount: anAccount isDifferentFrom: anotherAccount

	^ (anAccount == anotherAccount) ifTrue: [self error: self invalidTransferAccountsErrorDescription.]! !

!Transfer class methodsFor: 'asserting' stamp: 'IS 6/6/2022 20:44:26'!
assertValueIsValid: aValue

	^ (aValue <= (0*peso)) ifTrue: [self error: self invalidValueTransferErrorDescription.]! !


!Transfer class methodsFor: 'instance creation' stamp: 'MS 6/9/2022 16:20:13'!
register: aValue from: aSenderAccount to: aReceiverAccount

	self assertValueIsValid: aValue.
	self assertAccount: aSenderAccount isDifferentFrom: aReceiverAccount.

	^self new initializeRegister: aValue from: aSenderAccount to: aReceiverAccount ! !


!Transfer class methodsFor: 'error handling' stamp: 'IS 6/6/2022 20:46:48'!
invalidTransferAccountsErrorDescription
	^'Extraction account and deposit account cant be the same account'.! !

!Transfer class methodsFor: 'error handling' stamp: 'IS 6/6/2022 20:27:22'!
invalidValueTransferErrorDescription
	^'Value cant be negative or zero'.! !


!classDefinition: #TransferTransaction category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #TransferTransaction
	instanceVariableNames: 'transfer value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!TransferTransaction methodsFor: 'initialization' stamp: 'MS 6/8/2022 23:32:17'!
initializeFor: aValue in: aTransfer

	transfer := aTransfer.
	value := aValue.! !


!TransferTransaction methodsFor: 'main protocol' stamp: 'MS 6/8/2022 23:42:53'!
counterpart
	self subclassResponsibility.! !


!TransferTransaction methodsFor: 'value' stamp: 'MS 6/8/2022 23:29:03'!
beAddedTo: aBalance
	self subclassResponsibility.! !

!TransferTransaction methodsFor: 'value' stamp: 'MS 6/8/2022 23:39:49'!
value
	^value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferTransaction class' category: 'ServiciosFinancieros-Ejercicio'!
TransferTransaction class
	instanceVariableNames: ''!

!TransferTransaction class methodsFor: 'instance creation' stamp: 'MS 6/8/2022 23:43:10'!
for: aValue in: aTransfer

	self subclassResponsibility.! !

!TransferTransaction class methodsFor: 'instance creation' stamp: 'MS 6/9/2022 16:20:33'!
register: aValue on: anAccount in: aTransfer

	| transaction |
	
	transaction := self for: aValue in: aTransfer.
	anAccount register: transaction.
		
	^ transaction! !


!classDefinition: #TransferDeposit category: 'ServiciosFinancieros-Ejercicio'!
TransferTransaction subclass: #TransferDeposit
	instanceVariableNames: 'counterpart'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!TransferDeposit methodsFor: 'main protocol' stamp: 'MS 6/8/2022 23:41:39'!
counterpart
	^transfer withdrawLeg.! !


!TransferDeposit methodsFor: 'value' stamp: 'MS 6/8/2022 23:30:43'!
beAddedTo: aBalance

	^aBalance + self value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferDeposit class' category: 'ServiciosFinancieros-Ejercicio'!
TransferDeposit class
	instanceVariableNames: ''!

!TransferDeposit class methodsFor: 'instance creation' stamp: 'MS 6/8/2022 23:27:21'!
for: aValue in: aTransfer

	^ self new initializeFor: aValue in: aTransfer. ! !


!classDefinition: #TransferWithdraw category: 'ServiciosFinancieros-Ejercicio'!
TransferTransaction subclass: #TransferWithdraw
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!TransferWithdraw methodsFor: 'value' stamp: 'MS 6/8/2022 23:30:49'!
beAddedTo: aBalance

	^aBalance - self value.! !


!TransferWithdraw methodsFor: 'main protocol' stamp: 'MS 6/8/2022 23:29:58'!
counterpart

	^transfer depositLeg.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferWithdraw class' category: 'ServiciosFinancieros-Ejercicio'!
TransferWithdraw class
	instanceVariableNames: ''!

!TransferWithdraw class methodsFor: 'instance creation' stamp: 'MS 6/8/2022 23:27:31'!
for: aValue in: aTransfer

	^ self new initializeFor: aValue in: aTransfer.! !
