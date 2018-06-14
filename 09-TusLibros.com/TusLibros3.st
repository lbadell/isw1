!classDefinition: #CartTest category: #TusLibros!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'AB 6/14/2018 10:53:59'!
test01NewCartsAreCreatedEmpty
	self assert: testObjectsFactory createEmptyCart isEmpty.! !

!CartTest methodsFor: 'tests' stamp: 'AB 6/14/2018 10:53:59'!
test02CanNotAddItemsThatDoNotBelongToStore
	| cart |
	cart _ testObjectsFactory createEmptyCart.
	self
		should: [ cart add: testObjectsFactory itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ].! !

!CartTest methodsFor: 'tests' stamp: 'AB 6/14/2018 10:53:59'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore
	| cart |
	cart _ testObjectsFactory createEmptyCart.
	cart add: testObjectsFactory itemSellByTheStore.
	self deny: cart isEmpty.! !

!CartTest methodsFor: 'tests' stamp: 'AB 6/14/2018 10:53:59'!
test04CanNotAddNonPositiveNumberOfItems
	| cart |
	cart _ testObjectsFactory createEmptyCart.
	self
		should: [
			cart
				add: 0
				of: testObjectsFactory itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ].! !

!CartTest methodsFor: 'tests' stamp: 'AB 6/14/2018 10:53:59'!
test05CanNotAddMoreThanOneItemNotSellByTheStore
	| cart |
	cart _ testObjectsFactory createEmptyCart.
	self
		should: [
			cart
				add: 2
				of: testObjectsFactory itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ].! !

!CartTest methodsFor: 'tests' stamp: 'AB 6/14/2018 10:53:59'!
test06CartRemembersAddedItems
	| cart |
	cart _ testObjectsFactory createEmptyCart.
	cart add: testObjectsFactory itemSellByTheStore.
	self assert: (cart includes: testObjectsFactory itemSellByTheStore).! !

!CartTest methodsFor: 'tests' stamp: 'AB 6/14/2018 10:53:59'!
test07CartDoesNotHoldNotAddedItems
	| cart |
	cart _ testObjectsFactory createEmptyCart.
	self deny: (cart includes: testObjectsFactory itemSellByTheStore).! !

!CartTest methodsFor: 'tests' stamp: 'AB 6/14/2018 10:53:59'!
test08CartRemembersTheNumberOfAddedItems
	| cart |
	cart _ testObjectsFactory createEmptyCart.
	cart
		add: 2
		of: testObjectsFactory itemSellByTheStore.
	self assert: (cart occurrencesOf: testObjectsFactory itemSellByTheStore) = 2.! !


!CartTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 18:09'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.! !


!classDefinition: #CashierTest category: #TusLibros!
TestCase subclass: #CashierTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'testing' stamp: 'AB 6/14/2018 11:26:54'!
checkErrorMessage: anErrorMessage WithProcessor: aProcessor AndCard: aCard
	| cart cashier salesBook |
	cart _ testObjectsFactory createSingleItemCart.
	salesBook _ OrderedCollection new.
	cashier _ Cashier
		toCheckout: cart
		charging: aCard
		on: testObjectsFactory defaultMonthOfYear
		registeringOn: salesBook
		withMerchantProcessor: aProcessor.
	self
		should: [ cashier checkOut ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = anErrorMessage.
			self assert: salesBook isEmpty ].! !

!CashierTest methodsFor: 'testing' stamp: 'AB 6/14/2018 11:40:00'!
test01CanNotCheckoutAnEmptyCart
	| salesBook aProcessor cart|
	salesBook _ OrderedCollection new.
	aProcessor _ MerchantProcessorMock with: [ :aCashier :value | aCashier transactionMadeWith: value].
	cart _ testObjectsFactory createEmptyCart.

	self
		should: [
			Cashier
				toCheckout: cart
				charging: testObjectsFactory notExpiredCreditCard
				on: testObjectsFactory defaultMonthOfYear
				registeringOn: salesBook
				withMerchantProcessor: aProcessor ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage.
			self assert: salesBook isEmpty ].! !

!CashierTest methodsFor: 'testing' stamp: 'AB 6/14/2018 11:46:17'!
test02CalculatedTotalIsCorrect
	| cart cashier aProcessor |
	aProcessor _ MerchantProcessorMock with: [ :aCashier :value | aCashier transactionMadeWith: value].
	cart _ testObjectsFactory createEmptyCart.
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	cashier _ Cashier
		toCheckout: cart
		charging: testObjectsFactory notExpiredCreditCard
		on: testObjectsFactory defaultMonthOfYear
		registeringOn: OrderedCollection new
		withMerchantProcessor: aProcessor.
	self assert: cashier purchaseValue = (testObjectsFactory itemSellByTheStorePrice * 2).! !

!CashierTest methodsFor: 'testing' stamp: 'AB 6/14/2018 11:40:09'!
test03CanNotCheckoutWithAnExpiredCreditCart
	| cart salesBook aProcessor |
	cart _ testObjectsFactory createSingleItemCart.
	salesBook _ OrderedCollection new.
	aProcessor _ MerchantProcessorMock with: [ :aCashier :value | aCashier transactionMadeWith: value].
	self
		should: [
			Cashier
				toCheckout: cart
				charging: testObjectsFactory expiredCreditCard
				on: testObjectsFactory defaultMonthOfYear
				registeringOn: salesBook
				withMerchantProcessor: aProcessor ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: salesBook isEmpty ].! !

!CashierTest methodsFor: 'testing' stamp: 'AB 6/14/2018 11:52:01'!
test04CheckoutRegistersASale
	| cart cashier salesBook aProcessor |
	cart _ testObjectsFactory createSingleItemCart.
	salesBook _ OrderedCollection new.
	aProcessor _ MerchantProcessorMock with: [ :aCashier :value | aCashier transactionMadeWith: value].
	cashier _ Cashier
		toCheckout: cart
		charging: testObjectsFactory notExpiredCreditCard
		on: testObjectsFactory defaultMonthOfYear
		registeringOn: salesBook
		withMerchantProcessor: aProcessor.
	cashier checkOut.
	self assert: salesBook notEmpty.
	self assert: salesBook first total = cashier purchaseValue.! !

!CashierTest methodsFor: 'testing' stamp: 'AB 6/14/2018 11:39:02'!
test05CanNotCheckoutWithoutEnoughCredit
	| aProcessor card |
	card _ testObjectsFactory notExpiredCreditCard.
	aProcessor _ MerchantProcessorMock with: [ :aCashier :value | aCashier notEnoughCredit ].
	self checkErrorMessage: Cashier notEnoughtCreditErrorMessage WithProcessor: aProcessor AndCard: card.! !

!CashierTest methodsFor: 'testing' stamp: 'AB 6/14/2018 11:39:07'!
test06CanNotCheckoutWithAStolenCard
	| aProcessor card |
	card _ testObjectsFactory notExpiredCreditCard.
	aProcessor _ MerchantProcessorMock with: [ :aCashier :value | aCashier stolenCard ].
	self checkErrorMessage: Cashier stolenCardErrorMessage WithProcessor: aProcessor AndCard: card.! !


!CashierTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 18:11'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.! !


!classDefinition: #Cart category: #TusLibros!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:06'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 17:48'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 18:04'!
catalog
	
	^ catalog! !

!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'as yet unclassified' stamp: 'HernanWilkinson 6/17/2013 18:05'!
itemsDo: aBlock
	
	^items do: aBlock ! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: #TusLibros!
Object subclass: #Cashier
	instanceVariableNames: 'cart creditCart salesBook merchantProcessor total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'initialization' stamp: 'AB 6/14/2018 11:46:39'!
initializeToCheckout: aCart charging: aCreditCard registeringOn: aSalesBook withMerchantProcessor: aMerchantProcessor
	| priceList |
	
	cart := aCart.
	creditCart := aCreditCard.
	salesBook := aSalesBook.
	merchantProcessor _ aMerchantProcessor.
	total _ 0.
	
	priceList _ cart catalog.
	cart itemsDo: [ :anItem | total := total + (priceList at: anItem)].! !


!Cashier methodsFor: 'error handling' stamp: 'ABC 6/11/2018 19:18:53'!
notEnoughCredit
	^self error: (self class notEnoughtCreditErrorMessage)! !

!Cashier methodsFor: 'error handling' stamp: 'ABC 6/11/2018 19:21:45'!
stolenCard
	^self error: (self class stolenCardErrorMessage).! !


!Cashier methodsFor: 'checkout' stamp: 'AB 6/14/2018 11:51:26'!
checkOut
	merchantProcessor debit: total to: creditCart of: self.! !

!Cashier methodsFor: 'checkout' stamp: 'AB 6/14/2018 11:46:04'!
purchaseValue
	^total! !


!Cashier methodsFor: 'messages' stamp: 'AB 6/14/2018 11:50:40'!
transactionMadeWith: value
	salesBook add: (Sale of: value).
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'instance creation' stamp: 'ABC 6/11/2018 19:06:13'!
toCheckout: aCart charging: aCreditCard on: aDate registeringOn: aSalesBook withMerchantProcessor: aMerchantProcessor
	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.
	
	^self new initializeToCheckout: aCart charging: aCreditCard registeringOn: aSalesBook withMerchantProcessor: aMerchantProcessor.! !


!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:22'!
assertIsNotEmpty: aCart 
	
	aCart isEmpty ifTrue: [self error: self cartCanNotBeEmptyErrorMessage ]! !

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:23'!
assertIsNotExpired: aCreditCard on: aDate
	
	(aCreditCard isExpiredOn: aDate) ifTrue: [ self error: self canNotChargeAnExpiredCreditCardErrorMessage ]! !


!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 18:21'!
canNotChargeAnExpiredCreditCardErrorMessage
	
	^'Can not charge an expired credit card'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:56'!
cartCanNotBeEmptyErrorMessage
	
	^'Can not check out an empty cart'! !

!Cashier class methodsFor: 'error messages' stamp: 'ABC 6/11/2018 19:17:37'!
notEnoughtCreditErrorMessage
	^'Credit card does not have enough credit'.! !

!Cashier class methodsFor: 'error messages' stamp: 'ABC 6/11/2018 19:22:22'!
stolenCardErrorMessage
	^'The credit card is stolen'.! !


!classDefinition: #CreditCard category: #TusLibros!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'initialization' stamp: 'AB 6/14/2018 10:42:58'!
initializeExpiringOn: aMonthOfYear
	
	expiration := aMonthOfYear.! !


!CreditCard methodsFor: 'checking' stamp: 'AB 6/14/2018 10:44:01'!
isExpiredOn: aMonthOfYear
	
	^expiration < aMonthOfYear.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #TusLibros!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'as yet unclassified' stamp: 'HernanWilkinson 6/17/2013 18:38'!
expiringOn: aMonth 
	
	^self new initializeExpiringOn: aMonth! !


!classDefinition: #MerchantProcessorMock category: #TusLibros!
Object subclass: #MerchantProcessorMock
	instanceVariableNames: 'responseBlock'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessorMock methodsFor: 'initialization' stamp: 'ABC 6/11/2018 19:01:39'!
initializeWith: aBlockClosure 
	responseBlock _ aBlockClosure.! !


!MerchantProcessorMock methodsFor: 'accessing' stamp: 'AB 6/14/2018 11:38:16'!
debit: anAmount to: aCreditCard of: aCashier
	responseBlock value: aCashier value: anAmount.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MerchantProcessorMock class' category: #TusLibros!
MerchantProcessorMock class
	instanceVariableNames: ''!

!MerchantProcessorMock class methodsFor: 'instance creation' stamp: 'ABC 6/11/2018 19:01:02'!
with: aBlockClosure 
	^self new initializeWith: aBlockClosure.! !


!MerchantProcessorMock class methodsFor: 'as yet unclassified' stamp: 'ABC 6/11/2018 19:00:54'!
initializeWith: aBlockClosure 
	self shouldBeImplemented.! !


!classDefinition: #Sale category: #TusLibros!
Object subclass: #Sale
	instanceVariableNames: 'total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:47'!
initializeTotal: aTotal

	total := aTotal ! !


!Sale methodsFor: 'accessing' stamp: 'HernanWilkinson 6/17/2013 18:48'!
total
	
	^ total! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: #TusLibros!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:47'!
of: aTotal

	"should assert total is not negative or 0!!"
	^self new initializeTotal: aTotal ! !


!classDefinition: #StoreTestObjectsFactory category: #TusLibros!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'AB 6/14/2018 10:53:59'!
createEmptyCart
	^ Cart acceptingItemsOf: self defaultCatalog.! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'AB 6/14/2018 10:55:25'!
createSingleItemCart
	^ self createEmptyCart add: self itemSellByTheStore.! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
defaultCatalog
	
	^ Dictionary new
		at: self itemSellByTheStore put: self itemSellByTheStorePrice;
		yourself ! !


!StoreTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'AB 6/14/2018 10:59:40'!
defaultMonthOfYear
	^ GregorianMonthOfYear current.! !

!StoreTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'AB 6/14/2018 10:59:40'!
expiredCreditCard
	^ CreditCard expiringOn: (self defaultMonthOfYear previousMonth: January).! !

!StoreTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'AB 6/14/2018 10:59:40'!
notExpiredCreditCard
	^ CreditCard expiringOn: (self defaultMonthOfYear nextMonth: January).! !


!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStore
	
	^ 'validBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStorePrice
	
	^10! !
