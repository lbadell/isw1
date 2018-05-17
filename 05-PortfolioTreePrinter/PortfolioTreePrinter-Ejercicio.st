!classDefinition: #PortfolioTest category: #'PortfolioTreePrinter-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/13/2011 18:44'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	account := ReceptiveAccount new.

	self assert: 0 = account balance .
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/13/2011 18:45'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 = account balance .
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/14/2011 05:34'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 = account balance .
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 9/28/2017 15:22:46'!
test03_01WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	self assert: (Withdraw register: withdrawValue on: account) value equals: withdrawValue 
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/13/2011 18:48'!
test04PortfolioBalanceIsSumOfManagedAccountsBalance

	| account1 account2 complexPortfolio |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	complexPortfolio := Portfolio with: account1 with: account2.
	 	
	Deposit register: 100 on: account1.
	Deposit register: 200 on: account2.
		
	self assert:300 = complexPortfolio balance .
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/13/2011 18:53'!
test05PortfolioCanManagePortfolios

	| account1 account2 account3 complexPortfolio composedPortfolio |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	complexPortfolio := Portfolio with: account1 with: account2.
	composedPortfolio := Portfolio with: complexPortfolio with: account3.
		
	Deposit register: 100 on:account1.
	Deposit register: 200 on: account2.
	Deposit register: 300 on: account3.

	self assert: 600 = composedPortfolio balance .! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 9/25/2017 20:14:36'!
test06ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account registers: deposit).
	self assert: (account registers: withdraw).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 9/25/2017 20:14:30'!
test07ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (account registers: deposit).
	self deny: (account registers:withdraw).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 9/26/2011 16:51'!
test08PortfolioKnowsTransactionsRegisteredByItsManagedAccounts 

	| account1 account2 account3 complexPortfolio composedPortfolio deposit1 deposit2 deposit3 |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	complexPortfolio := Portfolio with: account1 with: account2.
	composedPortfolio := Portfolio with: complexPortfolio with: account3.
		
	deposit1 := Deposit register: 100 on: account1.
	deposit2 := Deposit register: 200 on: account2.
	deposit3 := Deposit register: 300 on: account3.
		
 	self assert: (composedPortfolio registers: deposit1).
	self assert: (composedPortfolio registers: deposit2).
	self assert: (composedPortfolio registers: deposit3).! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 9/12/2011 13:25'!
test08PortofolioKnowsTransactionsRegisteredByItsManagedAccounts 

	| account1 account2 account3 complexPortfolio composedPortfolio deposit1 deposit2 deposit3 |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	complexPortfolio := Portfolio with: account1 with: account2.
	composedPortfolio := Portfolio with: complexPortfolio with: account3.
		
	deposit1 := Deposit register: 100 on: account1.
	deposit2 := Deposit register: 200 on: account2.
	deposit3 := Deposit register: 300 on: account3.
		
 	self assert: (composedPortfolio registers: deposit1).
	self assert: (composedPortfolio registers: deposit2).
	self assert: (composedPortfolio registers: deposit3).! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/13/2011 19:00'!
test10ReceptiveAccountManageItSelf 

	| account1 |
	account1 := ReceptiveAccount new.
		
	self assert: (account1 manages:account1).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/13/2011 19:01'!
test11ReceptiveAccountDoNotManageOtherAccount

	| account1 account2 |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
		
	self deny: (account1 manages: account2).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/13/2011 19:02'!
test12PortfolioManagesComposedAccounts

	| account1 account2 account3 complexPortfolio |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	complexPortfolio := Portfolio with: account1 with: account2.
		
	self assert: (complexPortfolio manages: account1).
	self assert: (complexPortfolio manages: account2).
	self deny: (complexPortfolio manages: account3).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/13/2011 19:03'!
test13PortfolioManagesComposedAccountsAndPortfolios 

	| account1 account2 account3 complexPortfolio composedPortfolio |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	complexPortfolio := Portfolio with: account1 with: account2.
	composedPortfolio := Portfolio with: complexPortfolio with: account3.
		
	self assert: (composedPortfolio manages: account1).
	self assert: (composedPortfolio manages: account2).
	self assert: (composedPortfolio manages: account3).
	self assert: (composedPortfolio manages: complexPortfolio).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 9/26/2011 16:28'!
test14AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 100 on:account1.
		
	self assert: 1=account1 transactions size .
	self assert: (account1 transactions includes: deposit1).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 9/18/2011 17:15'!
test15PortfolioTransactionsIsTheUnionOftsAccountsTransactions 

	| account1 account2 account3 complexPortfolio account composedPortfolio deposit1 deposit2 deposit3 |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	complexPortfolio := Portfolio with: account1 with: account2.
	composedPortfolio := Portfolio with: complexPortfolio with: account3.
		
	deposit1 := Deposit register: 100 on: account1.
	deposit2 := Deposit register: 200 on: account2.
	deposit3 := Deposit register: 300 on: account3.
		
	self assert: 3 = composedPortfolio transactions size .
	self assert: (composedPortfolio transactions includes: deposit1).
	self assert: (composedPortfolio transactions includes: deposit2).
	self assert: (composedPortfolio transactions includes: deposit3).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 9/12/2011 13:23'!
test16PortfolioKnowsItsAccountsTransactions 

	| account1 account2 account3 complexPortfolio composedPortfolio deposit1 |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	complexPortfolio := Portfolio with: account1 with: account2.
	composedPortfolio := Portfolio with: complexPortfolio with: account3.
		
	deposit1 := Deposit register: 100 on: account1.
		
	self assert: 1= (composedPortfolio transactionsOf:account1) size .
	self assert: ((composedPortfolio transactionsOf: account1) includes:deposit1).! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 9/12/2011 13:23'!
test17PortfolioKnowsItsPortfoliosTransactions 

	| account1 account2 account3 complexPortfolio composedPortfolio deposit1 deposit2 |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	complexPortfolio := Portfolio with: account1 with: account2.
	composedPortfolio := Portfolio with: complexPortfolio with: account3.
		
	deposit1 := Deposit register: 100 on: account1.
	deposit2 := Deposit register: 100 on: account2.
	Deposit register: 100 on: account3.
		
	self assert: 2 = (composedPortfolio transactionsOf:complexPortfolio) size .
	self assert: ((composedPortfolio transactionsOf:complexPortfolio) includes:deposit1).
	self assert: ((composedPortfolio transactionsOf:complexPortfolio) includes:deposit2).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 9/12/2011 13:24'!
test18PortfolioCanNotAnswerTransactionsOfNotManagedAccounts 

	| account1 account2 account3 complexPortfolio |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	complexPortfolio := Portfolio with: account1 with: account2.
		
	self 
		should: [ complexPortfolio transactionsOf:account3 ] 
		raise: Error 
		withExceptionDo: [ :accountNotManaged |
			self assert: Portfolio accountNotManagedMessageDescription = accountNotManaged messageText ]
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/8/2018 16:24:31'!
test19CanNotCreatePortfoliosWithRepeatedAccount 

	| account1 |

	account1 := ReceptiveAccount new.
	self 
		should: [ Portfolio with: account1 with: account1 ]
		raise: Error
		withExceptionDo: [ :invalidPortfolio |
			self assert: Portfolio accountAlreadyManagedErrorMessage  = invalidPortfolio messageText ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/13/2011 19:15'!
test20CanNotCreatePortfoliosWithAccountsManagedByOtherManagedPortfolio 

	| account1 account2 complexPortfolio |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	complexPortfolio := Portfolio with: account1 with: account2.

	self 
		should: [ Portfolio with: complexPortfolio with: account1 ]
		raise: Error
		withExceptionDo: [ :invalidPortfolio |
			self assert: Portfolio accountAlreadyManagedErrorMessage = invalidPortfolio messageText ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/8/2018 16:11:42'!
test20_01CanNotCreatePortfoliosWithAccountsManagedByOtherManagedPortfolioTwo

    | account1 account2 account3 complexPortfolio1 complexPortfolio2 |
    
    account1 := ReceptiveAccount new.
    account2 := ReceptiveAccount new.
    account3 := ReceptiveAccount new.    
    complexPortfolio1 := Portfolio with: account1 with: account2.
    complexPortfolio2 := Portfolio with: account3 with: account1.

    self 
        should: [ Portfolio with: complexPortfolio1 with: complexPortfolio2 ]
        raise: Error
        withExceptionDo: [ :invalidPortfolio |
            self assert: Portfolio accountAlreadyManagedErrorMessage = invalidPortfolio messageText ] ! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/14/2011 05:27'!
test21TransferShouldWithdrawFromFromAccountAndDepositIntoToAccount

	| fromAccount toAccount |

	fromAccount := ReceptiveAccount new. 
	toAccount := ReceptiveAccount new.

	Transfer register: 100 from: fromAccount to: toAccount.
		
	self assert: -100 = fromAccount balance.
	self assert:  100 = toAccount balance.! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 9/28/2017 15:30:52'!
test21_01TransferIsReachedFromTransacctions

	| fromAccount toAccount transfer |

	fromAccount := ReceptiveAccount new. 
	toAccount := ReceptiveAccount new.

	transfer := Transfer register: 100 from: fromAccount to: toAccount.
		
	self assert:  100 = transfer value.
	self assert: fromAccount transactions first transfer equals: transfer.
	self assert: toAccount transactions first transfer equals: transfer.
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 9/28/2017 15:27:01'!
test22AccountSummaryShouldProvideHumanReadableTransactionsDetail

	| fromAccount toAccount fromAccountLines toAccountLines|

	fromAccount := ReceptiveAccount new.
	toAccount := ReceptiveAccount new.
	Deposit register: 100 on: fromAccount.
	Withdraw register: 50 on: fromAccount.
	Transfer register: 100 from: fromAccount to: toAccount.
	
	fromAccountLines := self accountSummaryLinesOf: fromAccount.
	toAccountLines := self accountSummaryLinesOf: toAccount.
	
	self assert: 3 = fromAccountLines size.
	self assert: 'Deposito por 100' = (fromAccountLines at: 1).
	self assert: 'Extraccion por 50' = (fromAccountLines at: 2).
	self assert: 'Transferencia por -100' = (fromAccountLines at: 3).
	
	self assert: 1 = toAccountLines size.
	self assert: 'Transferencia por 100' = (toAccountLines at: 1).
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/14/2011 06:58'!
test23ShouldBeAbleToBeQueryTransferNet

	| fromAccount toAccount |
	fromAccount := ReceptiveAccount new. 
	toAccount := ReceptiveAccount new. 

	Deposit register: 100 on: fromAccount.
	Withdraw register: 50 on: fromAccount.
	Transfer register: 100 from: fromAccount to: toAccount.
	Transfer register: 250 from: toAccount to: fromAccount.
		
	self assert: 150 = (self accountTransferNetOf: fromAccount).
	self assert: -150 = (self accountTransferNetOf: toAccount).! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/14/2011 06:58'!
test24CertificateOfDepositShouldWithdrawInvestmentValue

	| account toAccount |
	account := ReceptiveAccount new. 
	toAccount := ReceptiveAccount new. 

	Deposit register: 1000 on: account.
	Withdraw register: 50 on: account.
	Transfer register: 100 from: account to: toAccount.
	CertificateOfDeposit register: 100 during: 30 at: 1/10 on: account.
		
	self assert: 100 =(self investmentNetOf:account).
	self assert: 750 = account balance.! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/14/2011 06:58'!
test25ShouldBeAbleToQueryInvestmentEarnings

	| account investmentEarnings |
	account := ReceptiveAccount new. 
		
	CertificateOfDeposit register: 100 during: 30 at: 1/10 on: account.
	CertificateOfDeposit register: 100 during: 60 at: 15/100 on: account.

	investmentEarnings := 
		(100*((1/10)/360)*30) +
		(100*((15/100)/360)*60).
		
	self assert: investmentEarnings = (self investmentEarningsOf: account).! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 8/13/2017 18:37:21'!
test26AccountSummaryShouldWorkWithCertificateOfDeposit

	| fromAccount toAccount lines |
	fromAccount := ReceptiveAccount new. 
	toAccount := ReceptiveAccount new. 

	Deposit register: 100 on: fromAccount.
	Withdraw register: 50 on: fromAccount.
	Transfer register: 100 from: fromAccount to: toAccount.
	CertificateOfDeposit register: 1000 during: 30 at: 1/10 on: fromAccount.
		
	lines := self accountSummaryLinesOf: fromAccount.
		
	self assert: 4 = lines size.
	self assert: 'Deposito por 100' =  (lines at: 1).
	self assert: 'Extraccion por 50' =  (lines at: 2).
	self assert: 'Transferencia por -100' = (lines at: 3).
	self assert: 'Plazo fijo por 1000 durante 30 dias a una tna de 10%' = (lines at: 4).! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/14/2011 06:58'!
test27ShouldBeAbleToBeQueryTransferNetWithCertificateOfDeposit

	| fromAccount toAccount |
	fromAccount := ReceptiveAccount new. 
	toAccount := ReceptiveAccount new. 

	Deposit register: 100 on: fromAccount.
	Withdraw register: 50 on: fromAccount.
	Transfer register: 100 from: fromAccount to: toAccount.
	Transfer register: 250 from: toAccount to: fromAccount.
	CertificateOfDeposit register: 1000 during: 30 at: 1/10 on: fromAccount.
		
	self assert: 150 = (self accountTransferNetOf: fromAccount).
	self assert: -150 = (self accountTransferNetOf: toAccount).! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 9/26/2011 16:29'!
test28PortfolioTreePrinterPrintsTheCompositeInDepthFirstOrder

	| account1 account2 account3 complexPortfolio composedPortfolio accountNames lines |
	
	account1 := ReceptiveAccount new. 
	account2 := ReceptiveAccount new. 
	account3 := ReceptiveAccount new. 
	complexPortfolio := Portfolio with: account1 with: account2.
	composedPortfolio := Portfolio with: complexPortfolio with: account3.

	accountNames := Dictionary new.
	accountNames at: composedPortfolio put: 'composedPortfolio'.
	accountNames at: complexPortfolio put: 'complexPortfolio'.
	accountNames at: account1 put: 'account1'.
	accountNames at: account2 put: 'account2'.
	accountNames at: account3 put: 'account3'.
		
	lines := self portofolioTreeOf: composedPortfolio namingAccountWith: accountNames.
		
	self assert: 5 = lines size.
	self assert: 'composedPortfolio' = (lines at: 1).
	self assert: ' complexPortfolio' = (lines at: 2).
	self assert: '  account1' = (lines at: 3).
	self assert: '  account2' = (lines at: 4).
	self assert: ' account3' = (lines at: 5).! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 9/26/2011 16:30'!
test29ReversePortfolioTreePrinterPrintsTheCompositeStartingFromTheLeaves

	| account1 account2 account3 complexPortfolio composedPortfolio accountNames lines |
	account1 := ReceptiveAccount new. 
	account2 := ReceptiveAccount new. 
	account3 := ReceptiveAccount new. 
	complexPortfolio := Portfolio with: account1 with: account2.
	composedPortfolio := Portfolio with: complexPortfolio with: account3.

	accountNames := Dictionary new.
	accountNames at: composedPortfolio put: 'composedPortfolio'.
	accountNames at: complexPortfolio put: 'complexPortfolio'.
	accountNames at: account1 put: 'account1'.
	accountNames at: account2 put: 'account2'.
	accountNames at: account3 put: 'account3'.
		
	lines := self reversePortofolioTreeOf: composedPortfolio namingAccountWith: accountNames.
		
	self assert: 5 = lines size.
	self assert: ' account3' = (lines at: 1).
	self assert: '  account2' = (lines at: 2).
	self assert: '  account1' = (lines at: 3).
	self assert: ' complexPortfolio' = (lines at: 4).
	self assert: 'composedPortfolio' = (lines at: 5).
	! !


!PortfolioTest methodsFor: 'test support' stamp: 'A 5/14/2018 20:38:17'!
accountSummaryLinesOf: aReceptiveAccount 
	
	^(AccountSummary with: aReceptiveAccount) value.! !

!PortfolioTest methodsFor: 'test support' stamp: 'A 5/14/2018 21:04:51'!
accountTransferNetOf: aReceptiveAccount 
	
	^(AccountTransferNet with: aReceptiveAccount) value.! !

!PortfolioTest methodsFor: 'test support' stamp: 'A 5/14/2018 20:47:40'!
investmentEarningsOf: aReceptiveAccount 
	
	^(AccountInvestmentEarnings with: aReceptiveAccount) value.! !

!PortfolioTest methodsFor: 'test support' stamp: 'A 5/14/2018 20:57:30'!
investmentNetOf: aReceptiveAccount 
	
	^(AccountInvestmentNet with: aReceptiveAccount) value.! !

!PortfolioTest methodsFor: 'test support' stamp: 'A 5/16/2018 20:30:03'!
portofolioTreeOf: aPortfolio namingAccountWith: aDictionary 
	
	^(TreePrinter on: aPortfolio withNames: aDictionary) value! !

!PortfolioTest methodsFor: 'test support' stamp: 'A 5/16/2018 20:48:46'!
reversePortofolioTreeOf: aPortfolio namingAccountWith: aDictionary 
	
	^(TreePrinter on: aPortfolio withNames: aDictionary) reverseValue ! !


!classDefinition: #AccountInvestmentEarnings category: #'PortfolioTreePrinter-Ejercicio'!
Object subclass: #AccountInvestmentEarnings
	instanceVariableNames: 'account earnings'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!AccountInvestmentEarnings methodsFor: 'initialization' stamp: 'A 5/14/2018 20:43:35'!
initializeWith: anAccount
	earnings _ 0.
	account _ anAccount .! !


!AccountInvestmentEarnings methodsFor: 'value' stamp: 'A 5/16/2018 20:51:28'!
value
	earnings _ 0.
	account transactionsDo: [ :aTransaction |
		aTransaction identifyYourselfTo: self ].
	^ earnings.! !

!AccountInvestmentEarnings methodsFor: 'value' stamp: 'A 5/14/2018 20:45:28'!
valueWithCertificateOfDeposit: aCertificateOfDeposit
	^earnings _ earnings + aCertificateOfDeposit earnings.! !

!AccountInvestmentEarnings methodsFor: 'value' stamp: 'A 5/14/2018 20:45:56'!
valueWithDeposit: aDeposit
	^earnings .! !

!AccountInvestmentEarnings methodsFor: 'value' stamp: 'A 5/14/2018 20:46:18'!
valueWithTransferDeposit: aTransferDeposit
	^earnings .! !

!AccountInvestmentEarnings methodsFor: 'value' stamp: 'A 5/14/2018 20:46:28'!
valueWithTransferWithdraw: aTransferWithdraw
	^earnings .! !

!AccountInvestmentEarnings methodsFor: 'value' stamp: 'A 5/14/2018 20:46:39'!
valueWithWithdraw: aWithdraw
	^earnings .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountInvestmentEarnings class' category: #'PortfolioTreePrinter-Ejercicio'!
AccountInvestmentEarnings class
	instanceVariableNames: ''!

!AccountInvestmentEarnings class methodsFor: 'instance creation' stamp: 'A 5/14/2018 20:43:58'!
with: anAccount
	^self new initializeWith: anAccount.! !


!classDefinition: #AccountInvestmentNet category: #'PortfolioTreePrinter-Ejercicio'!
Object subclass: #AccountInvestmentNet
	instanceVariableNames: 'account investment'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!AccountInvestmentNet methodsFor: 'initialization' stamp: 'A 5/14/2018 20:50:08'!
initializeWith: anAccount
	investment _ 0.
	account _ anAccount .! !


!AccountInvestmentNet methodsFor: 'value' stamp: 'A 5/16/2018 20:51:28'!
value
	investment _ 0.
	account transactionsDo: [ :aTransaction |
		aTransaction identifyYourselfTo: self ].
	^ investment.! !

!AccountInvestmentNet methodsFor: 'value' stamp: 'A 5/14/2018 20:55:28'!
valueWithCertificateOfDeposit: aCertificateOfDeposit
	^investment _ investment + aCertificateOfDeposit value.! !

!AccountInvestmentNet methodsFor: 'value' stamp: 'A 5/14/2018 20:55:55'!
valueWithDeposit: aDeposit
	^investment .! !

!AccountInvestmentNet methodsFor: 'value' stamp: 'A 5/14/2018 20:56:24'!
valueWithTransferDeposit: aTransferDeposit
	^investment .! !

!AccountInvestmentNet methodsFor: 'value' stamp: 'A 5/14/2018 20:56:16'!
valueWithTransferWithdraw: aTransferWithdraw
	^investment .! !

!AccountInvestmentNet methodsFor: 'value' stamp: 'A 5/14/2018 20:56:09'!
valueWithWithdraw: aWithdraw
	^investment .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountInvestmentNet class' category: #'PortfolioTreePrinter-Ejercicio'!
AccountInvestmentNet class
	instanceVariableNames: ''!

!AccountInvestmentNet class methodsFor: 'instance creation' stamp: 'A 5/14/2018 20:50:26'!
with: anAccount
	^self new initializeWith: anAccount.! !


!classDefinition: #AccountSummary category: #'PortfolioTreePrinter-Ejercicio'!
Object subclass: #AccountSummary
	instanceVariableNames: 'account summaryLines'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!AccountSummary methodsFor: 'value' stamp: 'A 5/16/2018 20:51:28'!
value
	summaryLines _ OrderedCollection new.
	account transactionsDo: [ :aTransaction |
		aTransaction identifyYourselfTo: self ].
	^ summaryLines.! !

!AccountSummary methodsFor: 'value' stamp: 'A 5/14/2018 20:37:51'!
valueWithCertificateOfDeposit: aCertificateOfDeposit

	summaryLines add: 'Plazo fijo por ', aCertificateOfDeposit value printString, ' durante ', aCertificateOfDeposit numberOfDays printString, ' dias a una tna de ', aCertificateOfDeposit percentageOfTNA printString, '%'.
	! !

!AccountSummary methodsFor: 'value' stamp: 'A 5/14/2018 20:36:33'!
valueWithDeposit: aDeposit

	summaryLines add: 'Deposito por ', aDeposit value printString
	.
	! !

!AccountSummary methodsFor: 'value' stamp: 'A 5/14/2018 20:35:28'!
valueWithTransferDeposit: aTransferDeposit

	summaryLines add: 'Transferencia por ', aTransferDeposit value printString
	.
	! !

!AccountSummary methodsFor: 'value' stamp: 'A 5/14/2018 20:35:54'!
valueWithTransferWithdraw: aTransferWithdraw

	summaryLines add: 'Transferencia por -', aTransferWithdraw value printString
	.
	! !

!AccountSummary methodsFor: 'value' stamp: 'A 5/14/2018 20:36:14'!
valueWithWithdraw: aWithdraw

	summaryLines add: 'Extraccion por ', aWithdraw value printString
	.
	! !


!AccountSummary methodsFor: 'initialization' stamp: 'A 5/14/2018 20:27:37'!
initializeWith: anAccount
	summaryLines _ OrderedCollection new.
	account _ anAccount .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountSummary class' category: #'PortfolioTreePrinter-Ejercicio'!
AccountSummary class
	instanceVariableNames: ''!

!AccountSummary class methodsFor: 'instance creation' stamp: 'A 5/14/2018 20:27:23'!
with: anAccount
	^self new initializeWith: anAccount.! !


!classDefinition: #AccountTransaction category: #'PortfolioTreePrinter-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!AccountTransaction methodsFor: 'evaluating' stamp: 'A 5/10/2018 23:22:41'!
modifyBalance: aBalance

	self subclassResponsibility ! !

!AccountTransaction methodsFor: 'evaluating' stamp: 'HernanWilkinson 7/14/2011 06:48'!
value

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
register: aValue on: account

	| withdraw |
	
	withdraw := self for: aValue.
	account register: withdraw.
		
	^ withdraw! !


!classDefinition: #CertificateOfDeposit category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransaction subclass: #CertificateOfDeposit
	instanceVariableNames: 'value tna numberOfDays account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!CertificateOfDeposit methodsFor: 'initialization' stamp: 'A 5/13/2018 14:56:20'!
initializeWith: anAmount during: aPeriodOfDays at: aTNA on: aReceptiveAccount 
	value _ anAmount.
	numberOfDays _ aPeriodOfDays.
	tna _ aTNA.
	account _ aReceptiveAccount.
	
	aReceptiveAccount register: self.! !


!CertificateOfDeposit methodsFor: 'value' stamp: 'A 5/13/2018 15:04:44'!
earnings
	^(value*(tna/360)*numberOfDays) ! !

!CertificateOfDeposit methodsFor: 'value' stamp: 'A 5/16/2018 20:51:28'!
identifyYourselfTo: anObject
	^ anObject valueWithCertificateOfDeposit: self.! !

!CertificateOfDeposit methodsFor: 'value' stamp: 'A 5/13/2018 14:57:32'!
modifyBalance: aBalance

	^ aBalance - value! !

!CertificateOfDeposit methodsFor: 'value' stamp: 'A 5/13/2018 15:07:09'!
numberOfDays
	^numberOfDays.! !

!CertificateOfDeposit methodsFor: 'value' stamp: 'A 5/13/2018 15:08:12'!
percentageOfTNA

	^1 / tna! !

!CertificateOfDeposit methodsFor: 'value' stamp: 'A 5/13/2018 14:57:03'!
value
	^value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CertificateOfDeposit class' category: #'PortfolioTreePrinter-Ejercicio'!
CertificateOfDeposit class
	instanceVariableNames: ''!

!CertificateOfDeposit class methodsFor: 'instance creation' stamp: 'A 5/13/2018 14:52:55'!
register: anAmount during: aPeriodOfDays at: aTNA on: aReceptiveAccount 
	^ self new initializeWith: anAmount during: aPeriodOfDays at: aTNA on: aReceptiveAccount.! !


!classDefinition: #Deposit category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'A 5/16/2018 20:51:28'!
identifyYourselfTo: anObject
	^ anObject valueWithDeposit: self.! !

!Deposit methodsFor: 'value' stamp: 'A 5/10/2018 23:18:45'!
modifyBalance: aBalance

	^ aBalance + value! !

!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: #'PortfolioTreePrinter-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 19:41'!
register: aValue on: account

	| withdraw |
	
	withdraw := self for: aValue.
	account register: withdraw.
		
	^ withdraw! !


!classDefinition: #TransferTransaction category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransaction subclass: #TransferTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!TransferTransaction methodsFor: 'relations' stamp: 'A 5/10/2018 23:24:08'!
transfer

	self subclassResponsibility ! !


!classDefinition: #TransferDeposit category: #'PortfolioTreePrinter-Ejercicio'!
TransferTransaction subclass: #TransferDeposit
	instanceVariableNames: 'completeTransfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!TransferDeposit methodsFor: 'relations' stamp: 'A 5/10/2018 23:32:20'!
transfer

^completeTransfer.! !


!TransferDeposit methodsFor: 'initialization' stamp: 'A 5/10/2018 23:46:43'!
initializeFor: aTransfer

	completeTransfer _ aTransfer ! !


!TransferDeposit methodsFor: 'value' stamp: 'A 5/16/2018 20:51:28'!
identifyYourselfTo: anObject
	^ anObject valueWithTransferDeposit: self.! !

!TransferDeposit methodsFor: 'value' stamp: 'A 5/10/2018 23:46:05'!
modifyBalance: aBalance

	^ aBalance + self value.! !

!TransferDeposit methodsFor: 'value' stamp: 'A 5/10/2018 23:45:10'!
value

^completeTransfer value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferDeposit class' category: #'PortfolioTreePrinter-Ejercicio'!
TransferDeposit class
	instanceVariableNames: ''!

!TransferDeposit class methodsFor: 'instance creation' stamp: 'A 5/11/2018 00:03:08'!
for: aTransfer

	^ self new initializeFor: aTransfer.! !

!TransferDeposit class methodsFor: 'instance creation' stamp: 'A 5/11/2018 00:02:57'!
register: aTransfer on: account

	| transfer |
	
	transfer := self for: aTransfer.
	account register: transfer.
		
	^ transfer! !


!classDefinition: #TransferWithdraw category: #'PortfolioTreePrinter-Ejercicio'!
TransferTransaction subclass: #TransferWithdraw
	instanceVariableNames: 'completeTransfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!TransferWithdraw methodsFor: 'relations' stamp: 'A 5/10/2018 23:32:44'!
transfer

^completeTransfer .! !


!TransferWithdraw methodsFor: 'initialization' stamp: 'A 5/10/2018 23:39:18'!
initializeFor: aTransfer

	completeTransfer _ aTransfer ! !


!TransferWithdraw methodsFor: 'value' stamp: 'A 5/16/2018 20:51:28'!
identifyYourselfTo: anObject
	^ anObject valueWithTransferWithdraw: self.! !

!TransferWithdraw methodsFor: 'value' stamp: 'A 5/10/2018 23:44:17'!
modifyBalance: aBalance

	^ aBalance - self value.! !

!TransferWithdraw methodsFor: 'value' stamp: 'A 5/10/2018 23:42:34'!
value

^completeTransfer value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferWithdraw class' category: #'PortfolioTreePrinter-Ejercicio'!
TransferWithdraw class
	instanceVariableNames: ''!

!TransferWithdraw class methodsFor: 'instance creation' stamp: 'A 5/11/2018 00:02:46'!
for: aTransfer

	^ self new initializeFor: aTransfer.! !

!TransferWithdraw class methodsFor: 'instance creation' stamp: 'A 5/11/2018 00:02:35'!
register: aTransfer on: account

	| transfer |
	
	transfer := self for: aTransfer.
	account register: transfer.
		
	^ transfer! !


!classDefinition: #Withdraw category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'A 5/16/2018 20:51:28'!
identifyYourselfTo: anObject
	^ anObject valueWithWithdraw: self.! !

!Withdraw methodsFor: 'value' stamp: 'A 5/10/2018 23:18:27'!
modifyBalance: aBalance

	^ aBalance - value! !

!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/14/2011 05:54'!
value

	^ value ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: #'PortfolioTreePrinter-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/14/2011 05:32'!
register: aValue on: account

	| withdraw |
	
	withdraw := self for: aValue.
	account register: withdraw.
		
	^ withdraw! !


!classDefinition: #AccountTransferNet category: #'PortfolioTreePrinter-Ejercicio'!
Object subclass: #AccountTransferNet
	instanceVariableNames: 'account transferNet'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!AccountTransferNet methodsFor: 'initialization' stamp: 'A 5/14/2018 20:59:09'!
initializeWith: anAccount
	transferNet _ 0.
	account _ anAccount .! !


!AccountTransferNet methodsFor: 'value' stamp: 'A 5/16/2018 20:51:28'!
value
	transferNet _ 0.
	account transactionsDo: [ :aTransaction |
		aTransaction identifyYourselfTo: self ].
	^ transferNet.! !

!AccountTransferNet methodsFor: 'value' stamp: 'A 5/14/2018 21:02:50'!
valueWithCertificateOfDeposit: aCertificateOfDeposit
	^transferNet .! !

!AccountTransferNet methodsFor: 'value' stamp: 'A 5/14/2018 21:02:14'!
valueWithDeposit: aDeposit
	^transferNet.! !

!AccountTransferNet methodsFor: 'value' stamp: 'A 5/14/2018 21:00:35'!
valueWithTransferDeposit: aTransferDeposit
	^transferNet _ transferNet + aTransferDeposit value.! !

!AccountTransferNet methodsFor: 'value' stamp: 'A 5/14/2018 21:01:52'!
valueWithTransferWithdraw: aTransferWithdraw
	^transferNet _ transferNet - aTransferWithdraw value.! !

!AccountTransferNet methodsFor: 'value' stamp: 'A 5/14/2018 21:02:27'!
valueWithWithdraw: aWithdraw
	^transferNet.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransferNet class' category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransferNet class
	instanceVariableNames: ''!

!AccountTransferNet class methodsFor: 'instance creation' stamp: 'A 5/14/2018 20:59:23'!
with: anAccount
	^self new initializeWith: anAccount.! !


!classDefinition: #SummarizingAccount category: #'PortfolioTreePrinter-Ejercicio'!
Object subclass: #SummarizingAccount
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!SummarizingAccount methodsFor: 'testing' stamp: 'HernanWilkinson 7/13/2011 18:34'!
manages: anAccount

	self subclassResponsibility ! !

!SummarizingAccount methodsFor: 'testing' stamp: 'HernanWilkinson 7/13/2011 18:34'!
registers: aTransaction

	self subclassResponsibility ! !


!SummarizingAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:34'!
balance

	self subclassResponsibility ! !

!SummarizingAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:35'!
transactions

	self subclassResponsibility ! !

!SummarizingAccount methodsFor: 'transactions' stamp: 'A 5/14/2018 20:29:35'!
transactionsDo: aClosure
	self subclassResponsibility! !


!SummarizingAccount methodsFor: 'strategy' stamp: 'A 5/16/2018 20:51:28'!
identifyYourselfTo: anObject
	self subclassResponsibility.! !


!classDefinition: #Portfolio category: #'PortfolioTreePrinter-Ejercicio'!
SummarizingAccount subclass: #Portfolio
	instanceVariableNames: 'accounts'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/8/2018 16:46:26'!
anyManagedAccountManages: anAccount 

	^accounts anySatisfy: [ :managedAccount | (managedAccount manages: anAccount) or: [ anAccount manages: managedAccount ] ] ! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/8/2018 16:46:01'!
manages: anAccount

	^ self = anAccount  or: [ self anyManagedAccountManages: anAccount ]! !

!Portfolio methodsFor: 'testing' stamp: 'HernanWilkinson 7/13/2011 19:20'!
registers: aTransaction

	^ accounts anySatisfy: [ :anAccount | anAccount registers: aTransaction ]  ! !


!Portfolio methodsFor: 'transactions' stamp: 'HAW 8/13/2017 17:47:44'!
balance

	^ accounts sum: [ :account | account balance ]
! !

!Portfolio methodsFor: 'transactions' stamp: 'HAW 9/25/2017 19:40:20'!
transactions 

	^ accounts 
		inject: OrderedCollection new 
		into: [ :transactions :account | transactions addAll: account transactions. transactions ]
	! !

!Portfolio methodsFor: 'transactions' stamp: 'A 5/14/2018 20:31:37'!
transactionsDo: anAction

	^self transactions do: [:aTransaction | anAction value: aTransaction]
	! !

!Portfolio methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 19:27'!
transactionsOf: anAccount 

	^ (self manages: anAccount)
		ifTrue: [ anAccount transactions ] 
		ifFalse: [ self error: self class accountNotManagedMessageDescription]
	! !


!Portfolio methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 19:19'!
initializeWithAll: aCollectionOfAccounts

	accounts := aCollectionOfAccounts   ! !


!Portfolio methodsFor: 'accounts' stamp: 'A 5/16/2018 20:29:22'!
accountsDo: aBlock

	accounts do: [:anAccount | aBlock value: anAccount ].! !


!Portfolio methodsFor: 'strategy' stamp: 'A 5/16/2018 20:51:28'!
identifyYourselfTo: anObject
	^ anObject valueWithPortfolio: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: #'PortfolioTreePrinter-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'instance creation' stamp: 'HAW 5/8/2018 16:33:13'!
with: leftAccount with: rightAccount

	^ self withAll: (Array with: leftAccount with: rightAccount)! !

!Portfolio class methodsFor: 'instance creation' stamp: 'HAW 5/8/2018 16:40:55'!
withAll: aCollectionOfAccounts

	self checkCreationPreconditions: aCollectionOfAccounts.
	
	^self new initializeWithAll: aCollectionOfAccounts ! !


!Portfolio class methodsFor: 'assertions' stamp: 'HernanWilkinson 9/18/2011 17:22'!
check: sourceAccount doesNotManagaAnyOf: aCollectionOfAccounts

	^ aCollectionOfAccounts do: [ :targetAccount | 
			(sourceAccount = targetAccount) not ifTrue: [ 
				(sourceAccount manages: targetAccount) ifTrue: [ self error: self accountAlreadyManagedErrorMessage ] ] ]! !

!Portfolio class methodsFor: 'assertions' stamp: 'HernanWilkinson 9/18/2011 17:21'!
checkAccountsAreUnique: aCollectionOfAccounts

	aCollectionOfAccounts asSet size = aCollectionOfAccounts size
		ifFalse: [ self error: self accountAlreadyManagedErrorMessage ]! !

!Portfolio class methodsFor: 'assertions' stamp: 'HernanWilkinson 9/18/2011 17:21'!
checkCreationPreconditions: aCollectionOfAccounts

	self checkAccountsAreUnique: aCollectionOfAccounts.
	self checkNoCircularReferencesIn: aCollectionOfAccounts! !

!Portfolio class methodsFor: 'assertions' stamp: 'HernanWilkinson 9/18/2011 17:22'!
checkNoCircularReferencesIn: aCollectionOfAccounts

	aCollectionOfAccounts do: [ :sourceAccount | self check: sourceAccount doesNotManagaAnyOf: aCollectionOfAccounts ]! !


!Portfolio class methodsFor: 'error messages' stamp: 'HernanWilkinson 7/13/2011 19:28'!
accountAlreadyManagedErrorMessage

	^ 'Account already managed'! !

!Portfolio class methodsFor: 'error messages' stamp: 'HernanWilkinson 7/13/2011 19:27'!
accountNotManagedMessageDescription
	
	^ 'Account not managed'! !


!classDefinition: #ReceptiveAccount category: #'PortfolioTreePrinter-Ejercicio'!
SummarizingAccount subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'A 5/10/2018 23:16:45'!
balance

	^ transactions inject: 0 into: [ :balance :transaction | transaction modifyBalance: balance ]! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'A 5/14/2018 20:31:52'!
transactionsDo: anAction

	^self transactions do: [:aTransaction | anAction value: aTransaction]! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'HernanWilkinson 7/13/2011 18:37'!
manages: anAccount

	^ self = anAccount 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'HernanWilkinson 7/13/2011 18:37'!
registers: aTtransaction

	^ transactions includes: aTtransaction 
! !


!ReceptiveAccount methodsFor: 'strategy' stamp: 'A 5/16/2018 20:51:28'!
identifyYourselfTo: anObject
	^ anObject valueWithReceptiveAccount: self.! !


!classDefinition: #Transfer category: #'PortfolioTreePrinter-Ejercicio'!
Object subclass: #Transfer
	instanceVariableNames: 'value fromAccount toAccount'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!Transfer methodsFor: 'value' stamp: 'A 5/10/2018 23:42:03'!
value

^value! !


!Transfer methodsFor: 'initialization' stamp: 'A 5/11/2018 00:02:16'!
initializeFor: anAmount from: startAccount to: endAccount 
	fromAccount _ startAccount .
	toAccount _ endAccount .
	value _ anAmount .
	TransferWithdraw register: self on: fromAccount .
	TransferDeposit register: self on: toAccount .
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: #'PortfolioTreePrinter-Ejercicio'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'instance creation' stamp: 'A 5/10/2018 23:56:47'!
register: anAmount from: fromAccount to: toAccount

	^self new initializeFor: anAmount from: fromAccount to: toAccount.! !


!classDefinition: #TreePrinter category: #'PortfolioTreePrinter-Ejercicio'!
Object subclass: #TreePrinter
	instanceVariableNames: 'root level lines tabulation names'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!TreePrinter methodsFor: 'initialization' stamp: 'A 5/16/2018 20:24:45'!
initializeOn: anAccount withLevel: aLevel withNames: namesDict
	root _ anAccount .
	level _ aLevel.
	names _ namesDict .

	tabulation _ ''.
	level timesRepeat: [tabulation _ tabulation, ' '].
	
	lines _ OrderedCollection new.! !


!TreePrinter methodsFor: 'value' stamp: 'A 5/16/2018 20:51:28'!
reverseValue
	lines _ OrderedCollection new.
	root identifyYourselfTo: self.
	^ lines reversed.! !

!TreePrinter methodsFor: 'value' stamp: 'A 5/16/2018 20:51:28'!
value
	lines _ OrderedCollection new.
	root identifyYourselfTo: self.
	^ lines.! !

!TreePrinter methodsFor: 'value' stamp: 'A 5/16/2018 20:41:38'!
valueWithPortfolio: aPortfolio
	lines add: (tabulation , (names associationAt: aPortfolio) value).
	
	aPortfolio accountsDo: [:childAccount | 
		lines addAll: (TreePrinter on: childAccount  withLevel: (level +1) withNames: names) value.
	].! !

!TreePrinter methodsFor: 'value' stamp: 'A 5/16/2018 20:41:41'!
valueWithReceptiveAccount: anAccount	
	lines add: (tabulation, (names associationAt: anAccount) value).! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TreePrinter class' category: #'PortfolioTreePrinter-Ejercicio'!
TreePrinter class
	instanceVariableNames: ''!

!TreePrinter class methodsFor: 'instance creation' stamp: 'A 5/16/2018 20:27:57'!
on: anAccount withLevel: aLevel withNames: namesDict

	^self new initializeOn: anAccount  withLevel: aLevel withNames: namesDict.! !

!TreePrinter class methodsFor: 'instance creation' stamp: 'A 5/16/2018 20:28:18'!
on: anAccount withNames: namesDict

	^self on: anAccount withLevel: 0 withNames: namesDict! !
