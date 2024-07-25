!classDefinition: #AccountSummaryTests category: 'ServiciosFinancieros-Solucion'!
TestCase subclass: #AccountSummaryTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!AccountSummaryTests methodsFor: 'tests' stamp: 'IS 6/13/2022 20:57:31'!
test01AccountWithNoTransactionsHasZeroBalanceInAccountSummary
	| anAccount expectedSummary summary |
	
	anAccount := ReceptiveAccount new.
	expectedSummary := OrderedCollection with: 'Balance = 0 * pesos'.
	summary := AccountSummary for: anAccount.
	
	self assert: expectedSummary equals: summary generate.! !

!AccountSummaryTests methodsFor: 'tests' stamp: 'MS 6/12/2022 19:47:18'!
test02ReceptiveAccountWithDepositHasDepositAndBalanceInAccountSummary
	| anAccount expectedSummary summary |
	
	anAccount := ReceptiveAccount new.
	Deposit register: 20*peso on: anAccount.
	
	expectedSummary := OrderedCollection with: 'Depósito por 20 * pesos' with: 'Balance = 20 * pesos'.
	summary := AccountSummary for: anAccount.
	
	self assert: expectedSummary equals: summary generate.! !

!AccountSummaryTests methodsFor: 'tests' stamp: 'MS 6/12/2022 19:47:10'!
test03ReceptiveAccountWithWithdrawHasWithdrawAndBalanceInAccountSummary
	| anAccount expectedSummary summary |
	
	anAccount := ReceptiveAccount new.
	Withdraw register: 30*peso on: anAccount.
	
	expectedSummary := OrderedCollection with: 'Extracción por 30 * pesos' with: 'Balance = -30 * pesos'.
	summary := AccountSummary for: anAccount.
	
	self assert: expectedSummary equals: summary generate.! !

!AccountSummaryTests methodsFor: 'tests' stamp: 'MS 6/12/2022 19:47:14'!
test04ReceptiveAccountWithOutgoingTransferHasOutgoingTransferAndBalanceInAccountSummary
	| aSenderAccount aReceiverAccount expectedSummary summary |
	
	aReceiverAccount := ReceptiveAccount new.
	aSenderAccount := ReceptiveAccount new.
	Transfer amount: 20*peso from: aSenderAccount to: aReceiverAccount.
		
	expectedSummary := OrderedCollection with: 'Salida por transferencia de 20 * pesos' with: 'Balance = -20 * pesos'.
	summary := AccountSummary for: aSenderAccount .
	
	self assert: expectedSummary equals: summary generate.! !

!AccountSummaryTests methodsFor: 'tests' stamp: 'MS 6/12/2022 19:47:05'!
test05ReceptiveAccountWithIncomingTransferHasIncomingTransferAndBalanceInAccountSummary
	| aSenderAccount aReceiverAccount expectedSummary summary |
	
	aReceiverAccount := ReceptiveAccount new.
	aSenderAccount := ReceptiveAccount new.
	Transfer amount: 30*peso from: aSenderAccount to: aReceiverAccount.
		
	expectedSummary := OrderedCollection with: 'Entrada por transferencia de 30 * pesos' with: 'Balance = 30 * pesos'.
	summary := AccountSummary for: aReceiverAccount.
	
	self assert: expectedSummary equals: summary generate.! !

!AccountSummaryTests methodsFor: 'tests' stamp: 'MS 6/12/2022 19:47:00'!
test06ReceptiveAccountWithMultipleTransactionsHasThemIncludedInSummary
	| anAccount anotherAccount expectedSummary summary |
	
	anAccount := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.
	
	Deposit register: 30*peso on: anAccount.
	Withdraw register: 20*peso on: anAccount.
	Transfer amount: 50*peso from: anAccount to: anotherAccount.
	Transfer amount: 100*peso from: anotherAccount to: anAccount.
		
	expectedSummary := OrderedCollection newFrom: 	{
		'Depósito por 30 * pesos'.
		'Extracción por 20 * pesos'.
		'Salida por transferencia de 50 * pesos'.
		'Entrada por transferencia de 100 * pesos'.
		'Balance = 60 * pesos'.
	}.
	
	summary := AccountSummary for: anAccount.
	
	self assert: expectedSummary equals: summary generate.! !

!AccountSummaryTests methodsFor: 'tests' stamp: 'IS 6/13/2022 20:31:56'!
test07PortfolioWithMultipleTransactionsHasThemIncludedInSummary
	| aPortfolio anAccount expectedSummary summary anotherAccount |
	
	anAccount := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.
	aPortfolio := Portfolio with: anAccount with: anotherAccount.
	
	Deposit register: 30*peso on: anAccount .
	Withdraw register: 20*peso on: anAccount .
	Transfer amount: 50*peso from: anAccount to: anotherAccount.
	Transfer amount: 100*peso from: anotherAccount to: anAccount.
		
	expectedSummary := OrderedCollection newFrom: 	{
		'Depósito por 30 * pesos'.
		'Extracción por 20 * pesos'.
		'Salida por transferencia de 50 * pesos'.
		'Entrada por transferencia de 100 * pesos'.
		'Entrada por transferencia de 50 * pesos'.
		'Salida por transferencia de 100 * pesos'.
		'Balance = 10 * pesos'.
	}.
	
	summary := AccountSummary for: aPortfolio.
	
	self assert: expectedSummary equals: summary generate.! !


!classDefinition: #PortfolioTest category: 'ServiciosFinancieros-Solucion'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:16:26'!
test01BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:00'!
test02BalanceOfPortfolioWithOneAccountIsAccountBalance

	| account portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 100 * peso on: account.
	portfolio := Portfolio with: account.
	
	self assert: account balance equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:06'!
test03BalanceOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio |
	
	simplePortfolioAccount := ReceptiveAccount new.
	Deposit register: 100 * peso on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	Withdraw register: 50 * peso on: composedPortfolioAccount.
	composedPortofolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolioAccount balance + simplePortfolio balance) equals: composedPortofolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:12'!
test04PortfolioWithoutAccountsHasNoRegisteredTransaction

	self deny: (Portfolio new hasRegistered: (Deposit for: 100 * peso))! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:18'!
test05PortfolioHasRegisteredItsAccountsTransactions

	| account portfolio deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 * peso on: account.
	portfolio := Portfolio with: account.
	
	self assert: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:26'!
test06PortfolioLooksForRegisteredTransactionsRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 * peso on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 * peso on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolio hasRegistered: simplePortfolioAccountDeposit).
	self assert: (composedPortfolio hasRegistered: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:10'!
test07PortfolioHasNoTransactionWhenHasNoAccounts

	self assert: Portfolio new transactions isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:28:08'!
test08PortfolioTransactionsIncludesAllItsAccountsTransactions

	| account portfolio accountDeposit portfolioTransactions anotherAccountWithdraw |
	
	account := ReceptiveAccount new.
	accountDeposit := Deposit register: 100 * peso on: account.
	anotherAccountWithdraw := Withdraw register: 100 * peso on: account.
	portfolio := Portfolio with: account.
	
	portfolioTransactions := portfolio transactions.
	
	self assert: 2 equals: portfolioTransactions size.
	self assert: (portfolioTransactions includes: accountDeposit).
	self assert: (portfolioTransactions includes: anotherAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:28:20'!
test09PortfolioTransactionsAreCalculatedRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit composedPortfolioTransactions |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 * peso on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 * peso on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	composedPortfolioTransactions := composedPortfolio transactions.
	self assert: 2 equals: composedPortfolioTransactions size.
	self assert: (composedPortfolioTransactions includes: simplePortfolioAccountDeposit).
	self assert: (composedPortfolioTransactions includes: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:24'!
test10PortfolioCanNotIncludeTheSameAccountMoreThanOnce

	| account portfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: portfolio accountsSize.
			self assert: (portfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:28'!
test11PortfolioCanNotIncludeAccountOfItsPortfolios

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	composedPortfolio := Portfolio with: simplePortfolio.
	
	self 
		should: [ composedPortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: composedPortfolio accountsSize.
			self assert: (composedPortfolio accountsIncludes: simplePortfolio) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 11/29/2021 18:55:37'!
test12PortfolioCanNotIncludeItself

	| simplePortfolio |
	
	simplePortfolio := Portfolio new.
	
	self 
		should: [ simplePortfolio add: simplePortfolio ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 0 equals: simplePortfolio accountsSize. ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:01:51'!
test13ComposedPortfolioCanNotHaveParentPortfolioAccount

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio new.
	composedPortfolio := Portfolio with: simplePortfolio.
	composedPortfolio add: account.
	
	self 
		should: [ simplePortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: simplePortfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:12:16'!
test14ComposedPortfolioCanNotHaveAccountOfAnyRootParentRecursively

	| account leftParentPortfolio leftRootParentPortfolio portfolio rightParentPortfolio rightRootParentPortfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	leftParentPortfolio := Portfolio with: portfolio .
	leftRootParentPortfolio := Portfolio with: leftParentPortfolio.
	leftRootParentPortfolio add: account.
	
	rightParentPortfolio := Portfolio with: portfolio .
	rightRootParentPortfolio := Portfolio with: rightParentPortfolio.
	rightRootParentPortfolio add: account.

	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/29/2019 16:31:18'!
test15PortfolioCanNotIncludeAnyOfTheComposedAccountOfPortfolioToAdd

	| portfolioToAdd portfolioToModify rootPortfolio sharedAccount |
	
	sharedAccount := ReceptiveAccount new.
	portfolioToModify := Portfolio new.
	rootPortfolio := Portfolio with: sharedAccount with: portfolioToModify.
	portfolioToAdd := Portfolio with: sharedAccount.
	
	self 
		should: [ portfolioToModify add: portfolioToAdd ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolioToModify accountsIsEmpty ]! !


!classDefinition: #PortfolioTreePrinterTests category: 'ServiciosFinancieros-Solucion'!
TestCase subclass: #PortfolioTreePrinterTests
	instanceVariableNames: 'indent'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!PortfolioTreePrinterTests methodsFor: 'setUp/tearDown' stamp: 'IS 6/16/2022 00:35:02'!
setUp
	indent := '    '! !


!PortfolioTreePrinterTests methodsFor: 'tests' stamp: 'IS 6/16/2022 01:07:15'!
test01PortfolioTreePrinterOnlyPrintsEmptyPortfolioName
	| aPortfolio expectedPortfolioStructure portfolioTreePrinter |

	aPortfolio := Portfolio named: 'Portfolio de Juan'.
	
	expectedPortfolioStructure := OrderedCollection with: 'Portfolio de Juan'.
	
	portfolioTreePrinter := PortfolioTreePrinter with: aPortfolio.
	
	self assert: expectedPortfolioStructure equals: portfolioTreePrinter generate.
	
	! !

!PortfolioTreePrinterTests methodsFor: 'tests' stamp: 'IS 6/16/2022 01:07:38'!
test02PortfolioTreePrinterPrintsPortfolioNameWithPortfolioAccount
	| anAccount aPortfolio expectedPortfolioStructure portfolioTreePrinter |

	anAccount := ReceptiveAccount named: 'Cuenta de Juan'.
	aPortfolio := Portfolio named: 'Portfolio de Juan' with: anAccount .
	
	expectedPortfolioStructure := OrderedCollection with: 'Portfolio de Juan' with: indent,'Cuenta de Juan'.
	
	portfolioTreePrinter := PortfolioTreePrinter with: aPortfolio.
	
	self assert: expectedPortfolioStructure equals: portfolioTreePrinter generate.
	
	! !

!PortfolioTreePrinterTests methodsFor: 'tests' stamp: 'IS 6/16/2022 01:08:11'!
test03PortfolioTreePrinterPrintsPortfolioNameWithPortfolioAccounts
	| anAccount aPortfolio expectedPortfolioStructure portfolioTreePrinter anotherAccount |

	anAccount := ReceptiveAccount named: 'Cuenta de Juan'.
	anotherAccount := ReceptiveAccount named: 'Cuenta de Maria'.
	aPortfolio := Portfolio named: 'Portfolio de Juan y Maria' with: anAccount with: anotherAccount .
	
	expectedPortfolioStructure := OrderedCollection with: 'Portfolio de Juan y Maria' with: indent,'Cuenta de Juan' with: indent,'Cuenta de Maria'.
	
	portfolioTreePrinter := PortfolioTreePrinter with: aPortfolio.
	
	self assert: expectedPortfolioStructure equals: portfolioTreePrinter generate.
	
	! !

!PortfolioTreePrinterTests methodsFor: 'tests' stamp: 'IS 6/16/2022 01:08:29'!
test04NestedPortfolioIsPrintedCorrectly
	| juanAccount aPortfolio expectedPortfolioStructure portfolioTreePrinter mariaAccount mariaPortfolio manuAccount |

	juanAccount := ReceptiveAccount named: 'Cuenta de Juan'.
	mariaAccount := ReceptiveAccount named: 'Cuenta de Maria'.
	manuAccount := ReceptiveAccount named: 'Cuenta de Manu'.
	
	mariaPortfolio := Portfolio named: 'Portfolio de Maria y Manu' with: mariaAccount with: manuAccount .
	
	aPortfolio := Portfolio named: 'Portfolio de Familia' with: juanAccount with: mariaPortfolio .
	
	expectedPortfolioStructure := OrderedCollection newFrom: {
		'Portfolio de Familia'.
		indent,'Cuenta de Juan'.
		indent,'Portfolio de Maria y Manu'.
		indent,indent,'Cuenta de Maria'.
		indent,indent,'Cuenta de Manu'.
	}.
	
	portfolioTreePrinter := PortfolioTreePrinter with: aPortfolio.
	
	self assert: expectedPortfolioStructure equals: portfolioTreePrinter generate.
	
	! !


!classDefinition: #ReceptiveAccountTest category: 'ServiciosFinancieros-Solucion'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'MS 6/12/2022 19:34:40'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0*peso equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:14:20'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 * peso on: account.
		
	self assert: 100 * peso equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:14:24'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 * peso on: account.
	Withdraw register: 50 * peso on: account.
		
	self assert: 50 * peso equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:10:14'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50 * peso.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:10:22'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 * peso on: account.
	withdraw := Withdraw register: 50 * peso on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:12:14'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100 * peso.
	withdraw := Withdraw for: 50 * peso.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:12:23'!
test07AccountKnowsItsTransactions 

	| account deposit |
	
	account := ReceptiveAccount new.
	
	deposit := Deposit register: 50 * peso on: account.
		
	self assert: 1 equals: account transactions size.
	self assert: (account transactions includes: deposit).
! !


!classDefinition: #TransferNetTests category: 'ServiciosFinancieros-Solucion'!
TestCase subclass: #TransferNetTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!TransferNetTests methodsFor: 'tests' stamp: 'IS 6/16/2022 00:15:46'!
test01AccountWithNoTransfersHasZeroTransferNetValue
	| anAccount summary |
	
	anAccount := ReceptiveAccount new.
	summary := TransferNet for: anAccount.
	
	self assert: 0 * peso equals: summary generate.! !

!TransferNetTests methodsFor: 'tests' stamp: 'IS 6/16/2022 00:15:58'!
test02AccountWithTransferDepositHasTransferValueAsTransferNetValue
	| anAccount summary anotherAccount |
	
	anAccount := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.
	
	Transfer amount: 10 * peso from: anotherAccount to: anAccount .
	summary := TransferNet for: anAccount.
	
	self assert: 10 * peso equals: summary generate.! !

!TransferNetTests methodsFor: 'tests' stamp: 'IS 6/16/2022 00:16:08'!
test03AccountWithTransferWithdrawHasNegativeTransferValueAsTransferNetValue
	| anAccount summary anotherAccount |
	
	anAccount := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.
	
	Transfer amount: 10 * peso from: anAccount to: anotherAccount .
	summary := TransferNet for: anAccount.
	
	self assert: -10 * peso equals: summary generate.! !

!TransferNetTests methodsFor: 'tests' stamp: 'IS 6/16/2022 00:16:18'!
test04AccountWithMultipleTransfersHasCorrectNetTransferValue
	| anAccount summary anotherAccount |
	
	anAccount := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.
	
	Transfer amount: 10 * peso from: anAccount to: anotherAccount .
	Transfer amount: 20 * peso from: anotherAccount to: anAccount .
	summary := TransferNet for: anAccount.
	
	self assert: 10 * peso equals: summary generate.! !

!TransferNetTests methodsFor: 'tests' stamp: 'IS 6/16/2022 00:16:28'!
test05TransferNetIgnoresNonTransferTransactions
	| anAccount summary |
	
	anAccount := ReceptiveAccount new.
	
	Deposit register: 400 * peso on: anAccount.
	summary := TransferNet for: anAccount .
	
	self assert: 0 * peso equals: summary generate.! !

!TransferNetTests methodsFor: 'tests' stamp: 'IS 6/16/2022 00:16:37'!
test06PortfolioWithMultipleTransfersHasCorrectNetTransferValue
	| anAccount summary anotherAccount aPortfolio externalAccount |
	
	anAccount := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.
	externalAccount := ReceptiveAccount new.
	
	aPortfolio := Portfolio with: anAccount with: anotherAccount.
	
	Transfer amount: 10 * peso from: anAccount to: anotherAccount .
	Transfer amount: 20 * peso from: anotherAccount to: externalAccount .
	summary := TransferNet for: aPortfolio.
	
	self assert: -20 * peso equals: summary generate.! !


!classDefinition: #TransferTest category: 'ServiciosFinancieros-Solucion'!
TestCase subclass: #TransferTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!TransferTest methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 21:07:03'!
test01ATransferDecreasesBalanceFromOriginAccountAndIncreasesItForDestinationAccount

	| destinationAccount originAccount |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: destinationAccount.
	
	Transfer amount: 2 * peso from: originAccount to: destinationAccount.
	
	self assert: 8 * peso equals: originAccount balance.
	self assert: 12 * peso equals: destinationAccount balance.! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 21:12:28'!
test02ATransferKnowsItsValue

	| destinationAccount originAccount transfer |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: destinationAccount.
	
	transfer := Transfer amount: 2 * peso from: originAccount to: destinationAccount.
	
	self assert: 2 * peso equals: transfer value.! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 23:01:44'!
test03DepositLegKnowsItsWithdrawCounterpart

	| destinationAccount originAccount transfer |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: destinationAccount.
	
	transfer := Transfer amount: 2 * peso from: originAccount to: destinationAccount.
	
	self assert: transfer withdrawLeg equals: transfer depositLeg withdrawLeg! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 23:01:51'!
test04WithdrawLegKnowsItsDepositCounterpart

	| destinationAccount originAccount transfer |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: destinationAccount.
	
	transfer := Transfer amount: 2 * peso from: originAccount to: destinationAccount.
	
	self assert: transfer depositLeg equals: transfer withdrawLeg depositLeg! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 23:02:36'!
test05OriginAndDestinationAccountsCannotBeTheSame

	| originAccount |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	self should: [ Transfer amount: 2 * peso from: originAccount to: originAccount ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Transfer cannotTransferToOriginErrorDescription equals: anError messageText.
			self assert: 10 * peso equals: originAccount balance.
		]
! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 23:02:44'!
test06CannotTransferAZeroAmount

	| originAccount destinationAccount |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 5 * peso on: destinationAccount.
	
	self should: [ Transfer amount: 0 from: originAccount to: destinationAccount ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Transfer cannotTransferZeroErrorDescription equals: anError messageText.
			self assert: 10 * peso equals: originAccount balance.
		]
! !


!classDefinition: #Account category: 'ServiciosFinancieros-Solucion'!
Object subclass: #Account
	instanceVariableNames: 'name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!Account methodsFor: 'main protocol' stamp: 'IS 6/15/2022 23:05:42'!
balance

	self subclassResponsibility ! !

!Account methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 12:23:47'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Account methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !

!Account methodsFor: 'main protocol' stamp: 'IS 6/16/2022 00:11:17'!
visitTransactionsWith: aTransactionVisitor
	self transactions do: [ :aTransaction | aTransaction accept: aTransactionVisitor ]! !


!Account methodsFor: 'composition' stamp: 'LL 7/8/2021 21:45:50'!
addedTo: aPortfolio

	self subclassResponsibility! !

!Account methodsFor: 'composition' stamp: 'LL 7/8/2021 21:46:48'!
isComposedBy: anAccount

	self subclassResponsibility! !


!Account methodsFor: 'private' stamp: 'HAW 5/25/2019 12:23:27'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !


!Account methodsFor: 'accessing' stamp: 'IS 6/16/2022 00:29:32'!
name
	^name! !


!Account methodsFor: 'visitor' stamp: 'IS 6/16/2022 00:46:29'!
accept: anAccountVisitor
	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Account class' category: 'ServiciosFinancieros-Solucion'!
Account class
	instanceVariableNames: ''!


!Account class methodsFor: 'as yet unclassified' stamp: 'IS 6/16/2022 00:12:16'!
named: aName
	
	^self new initializeWithName: aName.! !


!classDefinition: #Portfolio category: 'ServiciosFinancieros-Solucion'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!Portfolio methodsFor: 'initialization' stamp: 'HAW 5/25/2019 12:03:18'!
initialize

	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !

!Portfolio methodsFor: 'initialization' stamp: 'IS 6/15/2022 23:39:40'!
initializeWithName: aName
	name := aName.
	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !


!Portfolio methodsFor: 'main protocol' stamp: 'IS 6/13/2022 20:25:25'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0* peso ]! !

!Portfolio methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 11:28:29'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 11:38:32'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	accounts do: [ :anAccount | anAccount addTransactionsTo: transactions ].
	
	^transactions ! !


!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:20'!
accountsIncludes: anAccount

	^accounts includes: anAccount ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:05:04'!
accountsIsEmpty
	
	^accounts isEmpty ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:06'!
accountsSize
	
	^accounts size! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:19:20'!
add: accountToAdd

	self assertCanAdd: accountToAdd.
		
	accounts add: accountToAdd.
	accountToAdd addedTo: self 
	! !


!Portfolio methodsFor: 'private' stamp: 'HAW 5/25/2019 11:42:55'!
addTransactionsTo: aCollectionOfTransactions

	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !


!Portfolio methodsFor: 'visitor' stamp: 'IS 6/16/2022 01:21:36'!
accept: anAccountVisitor
	^anAccountVisitor visitPortfolio: self! !

!Portfolio methodsFor: 'visitor' stamp: 'IS 6/16/2022 01:28:57'!
visitAccounts
	^accounts collect: [ :anAccount | 
		(anAccount accept: self) collect: [ :subAccount | '    ',subAccount]
	]
	! !

!Portfolio methodsFor: 'visitor' stamp: 'IS 6/16/2022 01:31:44'!
visitAccountsWith: anAccountVisitor
 	| names |
	names := OrderedCollection new.
	
	accounts collect: [ :anAccount | 
		names addAll: ((anAccount accept: anAccountVisitor) collect: [ :subAccount | '    ',subAccount])
	].

	^names
	! !


!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:17:31'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:02:59'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:20:56'!
anyRootParentIsComposedBy: accountToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: accountToAdd]! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:20:36'!
assertCanAdd: accountToAdd

	(self anyRootParentIsComposedBy: accountToAdd) ifTrue: [ self signalCanNotAddAccount ].
! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/29/2019 16:24:54'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | (composedAccount isComposedBy: anAccount) or: [ anAccount isComposedBy: composedAccount ]]]! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:17:31'!
rootParents
	
	| rootParents |
	
	rootParents := Set new.
	self addRootParentsTo: rootParents.
	
	^ rootParents! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 11:48:34'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'ServiciosFinancieros-Solucion'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'IS 6/16/2022 00:13:23'!
named: aPortfolioName with: anAccount	
	| aPortfolio |
	aPortfolio := self new initializeWithName: aPortfolioName.
	
	^aPortfolio
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'IS 6/16/2022 00:13:28'!
named: aPortfolioName with: anAccount with: anotherAccount
	| aPortfolio |
	aPortfolio := self new initializeWithName: aPortfolioName.

	^aPortfolio 
		add: anAccount;
		add: anotherAccount;
		yourself! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:18:21'!
with: anAccount

	^self new 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:23:59'!
with: anAccount with: anotherAccount

	^self new 
		add: anAccount;
		add: anotherAccount;
		yourself! !


!classDefinition: #ReceptiveAccount category: 'ServiciosFinancieros-Solucion'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !

!ReceptiveAccount methodsFor: 'initialization' stamp: 'IS 6/16/2022 00:12:49'!
initializeWithName: aName

	name := aName.
	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'main protocol' stamp: 'MS 6/12/2022 19:34:48'!
balance

	^transactions 
		inject: 0*peso
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance ]! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'NR 10/21/2019 18:55:56'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'private' stamp: 'HAW 5/25/2019 11:38:52'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions ! !


!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !

!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !


!ReceptiveAccount methodsFor: 'visitor' stamp: 'IS 6/16/2022 01:21:31'!
accept: anAccountVisitor
	^anAccountVisitor visitReceptiveAccount: self! !


!classDefinition: #AccountTransaction category: 'ServiciosFinancieros-Solucion'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'visitor' stamp: 'IS 6/15/2022 23:04:57'!
accept: aTransactionVisitor
	self subclassResponsibility ! !


!classDefinition: #Deposit category: 'ServiciosFinancieros-Solucion'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:02'!
affectBalance: aBalance

	^aBalance + value ! !


!Deposit methodsFor: 'visitor' stamp: 'IS 6/16/2022 00:06:03'!
accept: aTransactionVisitor
	aTransactionVisitor visitDeposit: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'ServiciosFinancieros-Solucion'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!Deposit class methodsFor: 'as yet unclassified' stamp: 'LL 7/8/2021 21:45:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #TransferLeg category: 'ServiciosFinancieros-Solucion'!
AccountTransaction subclass: #TransferLeg
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!TransferLeg methodsFor: 'value' stamp: 'LL 9/20/2020 22:27:32'!
value

	^transfer value! !


!TransferLeg methodsFor: 'initialization' stamp: 'LL 9/20/2020 22:28:14'!
initializeWith: aTransfer

	transfer := aTransfer! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferLeg class' category: 'ServiciosFinancieros-Solucion'!
TransferLeg class
	instanceVariableNames: ''!

!TransferLeg class methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 22:45:01'!
of: aTransfer on: anAccount

	| transaction |
	
	transaction := self new initializeWith: 	aTransfer.
	anAccount register: transaction.	
	
	^transaction! !


!classDefinition: #TransferDepositLeg category: 'ServiciosFinancieros-Solucion'!
TransferLeg subclass: #TransferDepositLeg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!TransferDepositLeg methodsFor: 'accessing' stamp: 'LL 9/20/2020 22:26:10'!
withdrawLeg

	^transfer withdrawLeg! !


!TransferDepositLeg methodsFor: 'balance' stamp: 'LL 9/20/2020 22:27:49'!
affectBalance: aBalance

	^aBalance + self value! !


!TransferDepositLeg methodsFor: 'visitor' stamp: 'IS 6/16/2022 00:06:11'!
accept: aTransferVisitor
	aTransferVisitor visitTransferDepositLeg: self! !


!classDefinition: #TransferWithdrawLeg category: 'ServiciosFinancieros-Solucion'!
TransferLeg subclass: #TransferWithdrawLeg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!TransferWithdrawLeg methodsFor: 'accessing' stamp: 'LL 9/20/2020 22:25:47'!
depositLeg

	^transfer depositLeg! !


!TransferWithdrawLeg methodsFor: 'balance' stamp: 'LL 9/20/2020 22:27:55'!
affectBalance: aBalance

	^aBalance - self value! !


!TransferWithdrawLeg methodsFor: 'visitor' stamp: 'IS 6/16/2022 00:06:15'!
accept: aTransferVisitor
	aTransferVisitor visitTransferWithdrawLeg: self! !


!classDefinition: #Withdraw category: 'ServiciosFinancieros-Solucion'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:15'!
affectBalance: aBalance

	^aBalance - value! !


!Withdraw methodsFor: 'visitor' stamp: 'IS 6/16/2022 00:06:18'!
accept: aTransferVisitor

	aTransferVisitor visitWithdraw: self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'ServiciosFinancieros-Solucion'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!Withdraw class methodsFor: 'as yet unclassified' stamp: 'LL 7/8/2021 21:45:05'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #PortfolioTreePrinter category: 'ServiciosFinancieros-Solucion'!
Object subclass: #PortfolioTreePrinter
	instanceVariableNames: 'portfolio'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!PortfolioTreePrinter methodsFor: 'initialization' stamp: 'IS 6/16/2022 01:21:51'!
initializeWith: aPortfolio 
	portfolio := aPortfolio.! !


!PortfolioTreePrinter methodsFor: 'visits' stamp: 'IS 6/16/2022 01:30:30'!
visitPortfolio: aPortfolio
	| names |
	names := OrderedCollection with: aPortfolio name.
	
	names addAll: (aPortfolio visitAccountsWith: self).
	
	^names! !

!PortfolioTreePrinter methodsFor: 'visits' stamp: 'IS 6/16/2022 01:22:30'!
visitReceptiveAccount: aReceptiveAccount
	^OrderedCollection with: aReceptiveAccount name! !


!PortfolioTreePrinter methodsFor: 'main protocol' stamp: 'IS 6/16/2022 01:22:05'!
generate	
	^portfolio accept: self.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PortfolioTreePrinter class' category: 'ServiciosFinancieros-Solucion'!
PortfolioTreePrinter class
	instanceVariableNames: ''!

!PortfolioTreePrinter class methodsFor: 'instance creation' stamp: 'IS 6/16/2022 00:14:01'!
with: aPortfolio 
	^self new initializeWith: aPortfolio ! !


!classDefinition: #Report category: 'ServiciosFinancieros-Solucion'!
Object subclass: #Report
	instanceVariableNames: 'account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!Report methodsFor: 'visits' stamp: 'IS 6/16/2022 00:10:08'!
visitAccountTransactions
	account visitTransactionsWith: self! !

!Report methodsFor: 'visits' stamp: 'IS 6/16/2022 00:06:45'!
visitDeposit: aDeposit
	self subclassResponsibility ! !

!Report methodsFor: 'visits' stamp: 'IS 6/16/2022 00:06:42'!
visitTransferDepositLeg: aTransferDepositLeg
	self subclassResponsibility ! !

!Report methodsFor: 'visits' stamp: 'IS 6/16/2022 00:06:49'!
visitTransferWithdrawLeg: aTransferWithdrawLeg
	self subclassResponsibility ! !

!Report methodsFor: 'visits' stamp: 'IS 6/16/2022 00:06:54'!
visitWithdraw: aWithdraw
	self subclassResponsibility ! !


!Report methodsFor: 'main protocol' stamp: 'IS 6/15/2022 23:15:02'!
generate
	self subclassResponsibility ! !


!Report methodsFor: 'initialization' stamp: 'IS 6/15/2022 23:15:47'!
initializeFor: anAccountToBeReported
	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Report class' category: 'ServiciosFinancieros-Solucion'!
Report class
	instanceVariableNames: ''!

!Report class methodsFor: 'instance creation' stamp: 'IS 6/15/2022 23:17:24'!
for: anAccountToBeReported
	self subclassResponsibility ! !


!classDefinition: #AccountSummary category: 'ServiciosFinancieros-Solucion'!
Report subclass: #AccountSummary
	instanceVariableNames: 'summary'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!AccountSummary methodsFor: 'initialization' stamp: 'IS 6/15/2022 23:00:21'!
initializeFor: anAccountToBeSummarized 
	account := anAccountToBeSummarized.
	summary := OrderedCollection new.! !


!AccountSummary methodsFor: 'main protocol' stamp: 'IS 6/15/2022 23:14:20'!
generate
	
	
	self visitAccountTransactions.
	summary add: ('Balance = ' append: account balance asString).

	^summary ! !


!AccountSummary methodsFor: 'visits' stamp: 'IS 6/16/2022 00:07:00'!
visitDeposit: aDeposit
	summary add: ('Depósito por ' append: aDeposit value asString).! !

!AccountSummary methodsFor: 'visits' stamp: 'IS 6/16/2022 00:07:06'!
visitTransferDepositLeg: aTransferDepositLeg
	
	summary add: ('Entrada por transferencia de ' append: aTransferDepositLeg value asString).! !

!AccountSummary methodsFor: 'visits' stamp: 'IS 6/16/2022 00:07:13'!
visitTransferWithdrawLeg: aTransferWithdrawLeg

	summary add: ('Salida por transferencia de ' append: aTransferWithdrawLeg value asString).! !

!AccountSummary methodsFor: 'visits' stamp: 'IS 6/16/2022 00:07:19'!
visitWithdraw: aWithdraw
	
	summary add: ('Extracción por ' append: aWithdraw value asString).! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountSummary class' category: 'ServiciosFinancieros-Solucion'!
AccountSummary class
	instanceVariableNames: ''!

!AccountSummary class methodsFor: 'instance creation' stamp: 'IS 6/16/2022 00:00:00'!
for: anAccountToBeReported
	^self new initializeFor: anAccountToBeReported ! !


!classDefinition: #TransferNet category: 'ServiciosFinancieros-Solucion'!
Report subclass: #TransferNet
	instanceVariableNames: 'netValue'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!TransferNet methodsFor: 'main protocol' stamp: 'IS 6/16/2022 00:15:25'!
generate
	
	self visitAccountTransactions.
	
	^netValue
	! !


!TransferNet methodsFor: 'initialization' stamp: 'IS 6/15/2022 22:40:03'!
initializeFor: anAccount 
	account := anAccount.
	netValue := 0* peso.! !


!TransferNet methodsFor: 'visits' stamp: 'IS 6/16/2022 00:07:28'!
visitDeposit: aDeposit
	! !

!TransferNet methodsFor: 'visits' stamp: 'IS 6/16/2022 00:07:32'!
visitTransferDepositLeg: aTransferDepositLeg
	netValue := netValue + aTransferDepositLeg value
	! !

!TransferNet methodsFor: 'visits' stamp: 'IS 6/16/2022 00:07:39'!
visitTransferWithdrawLeg: aTransferWithdrawLeg
	netValue := netValue - aTransferWithdrawLeg value
	! !

!TransferNet methodsFor: 'visits' stamp: 'IS 6/16/2022 00:07:42'!
visitWithdraw: aWithdraw
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferNet class' category: 'ServiciosFinancieros-Solucion'!
TransferNet class
	instanceVariableNames: ''!

!TransferNet class methodsFor: 'instance creation' stamp: 'IS 6/15/2022 23:18:11'!
for: anAccountToBeReported
	^self new initializeFor: anAccountToBeReported ! !


!classDefinition: #Transfer category: 'ServiciosFinancieros-Solucion'!
Object subclass: #Transfer
	instanceVariableNames: 'value withdrawLeg depositLeg'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!Transfer methodsFor: 'value' stamp: 'LL 9/20/2020 21:13:00'!
value

	^value! !


!Transfer methodsFor: 'accessing' stamp: 'LL 9/20/2020 22:39:46'!
depositLeg

	^depositLeg! !

!Transfer methodsFor: 'accessing' stamp: 'LL 9/20/2020 21:25:56'!
withdrawLeg
	
	^withdrawLeg! !


!Transfer methodsFor: 'initialization' stamp: 'LL 9/20/2020 21:25:21'!
initializeWith: aValue withdrawLeg: aWithdraw depositLeg: aDeposit

	value := aValue.
	withdrawLeg := aWithdraw.
	depositLeg := aDeposit! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'ServiciosFinancieros-Solucion'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'errors' stamp: 'LL 9/20/2020 22:57:30'!
cannotTransferToOriginErrorDescription
	
	^'Transfer destionation cannot be the origin account'! !

!Transfer class methodsFor: 'errors' stamp: 'LL 9/20/2020 23:00:53'!
cannotTransferZeroErrorDescription

	^'Transfer amount should be positive'! !

!Transfer class methodsFor: 'errors' stamp: 'LL 9/20/2020 22:56:35'!
signalCannotTransferToOrigin
	
	self error: self cannotTransferToOriginErrorDescription! !

!Transfer class methodsFor: 'errors' stamp: 'LL 9/20/2020 23:06:17'!
signalCannotTransferZero

	self error: self cannotTransferZeroErrorDescription! !


!Transfer class methodsFor: 'assertions' stamp: 'LL 9/20/2020 23:05:22'!
assert: anAmountOfMoney canBeTransferedTo: destinationAccount from: originAccount

	self assertCanTransferTo: destinationAccount from: originAccount.
	self assertCanTransfer: anAmountOfMoney! !

!Transfer class methodsFor: 'assertions' stamp: 'LL 9/20/2020 23:11:50'!
assertCanTransfer: anAmountOfMoney

	^ anAmountOfMoney isZero ifTrue: [ self signalCannotTransferZero ]! !

!Transfer class methodsFor: 'assertions' stamp: 'LL 9/20/2020 23:04:58'!
assertCanTransferTo: destinationAccount from: originAccount

	^ originAccount = destinationAccount ifTrue: [ self signalCannotTransferToOrigin ]! !


!Transfer class methodsFor: 'instance creation' stamp: 'LL 9/20/2020 23:11:34'!
amount: anAmountOfMoney from: originAccount to: destinationAccount 
	
	| transfer depositLeg withdrawLeg |
	
	self assert: anAmountOfMoney canBeTransferedTo: destinationAccount from: originAccount.
	
	transfer := self new.
	
	withdrawLeg := TransferWithdrawLeg of: transfer on: originAccount.
	depositLeg := TransferDepositLeg of: transfer on: destinationAccount.
	
	^transfer initializeWith: anAmountOfMoney withdrawLeg: withdrawLeg depositLeg: depositLeg
	
	
	! !
