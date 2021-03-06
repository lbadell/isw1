!classDefinition: #CartTest category: #TusLibros!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test01NewCartsAreCreatedEmpty

	self assert: testObjectsFactory createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [ cart add: testObjectsFactory itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 0 of: testObjectsFactory itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 2 of: testObjectsFactory itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test06CartRemembersAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self assert: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self deny: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	self assert: (cart occurrencesOf: testObjectsFactory itemSellByTheStore) = 2! !


!CartTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 18:09'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.! !


!classDefinition: #CashierTest category: #TusLibros!
TestCase subclass: #CashierTest
	instanceVariableNames: 'testObjectsFactory debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:50'!
test01CanNotCheckoutAnEmptyCart

	| salesBook |
	
	salesBook := OrderedCollection new.
	self 
		should: [ Cashier 
			toCheckout: testObjectsFactory createCart 
			charging: testObjectsFactory notExpiredCreditCard 
			throught: self
			on: testObjectsFactory today
			registeringOn:  salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:51'!
test02CalculatedTotalIsCorrect

	| cart cashier |
	
	cart := testObjectsFactory createCart.
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	
	cashier :=  Cashier
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard 
		throught: self
		on: testObjectsFactory today 
		registeringOn: OrderedCollection new.
		
	self assert: cashier checkOut = (testObjectsFactory itemSellByTheStorePrice * 2)! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:51'!
test03CanNotCheckoutWithAnExpiredCreditCart

	| cart salesBook |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
	
	self
		should: [ Cashier 
				toCheckout: cart 
				charging: testObjectsFactory expiredCreditCard 
				throught: self
				on: testObjectsFactory today
				registeringOn: salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 19:04'!
test04CheckoutRegistersASale

	| cart cashier salesBook total |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	total := cashier checkOut.
					
	self assert: salesBook size = 1.
	self assert: salesBook first total = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 19:00'!
test05CashierChargesCreditCardUsingMerchantProcessor

	| cart cashier salesBook total creditCard debitedAmout debitedCreditCard  |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	debitBehavior := [ :anAmount :aCreditCard | 
		debitedAmout := anAmount.
		debitedCreditCard := aCreditCard ].
	total := cashier checkOut.
					
	self assert: debitedCreditCard = creditCard.
	self assert: debitedAmout = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:59'!
test06CashierDoesNotSaleWhenTheCreditCardHasNoCredit

	| cart cashier salesBook creditCard |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 	debitBehavior := [ :anAmount :aCreditCard | self error: Cashier creditCardHasNoCreditErrorMessage].
	
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	self 
		should: [cashier checkOut ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier creditCardHasNoCreditErrorMessage.
			self assert: salesBook isEmpty ]! !


!CashierTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 19:03'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	debitBehavior := [ :anAmount :aCreditCard | ]! !


!CashierTest methodsFor: 'merchant processor protocol' stamp: 'HernanWilkinson 6/17/2013 19:02'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !


!classDefinition: #TusLibrosRestInterfaceTest category: #TusLibros!
TestCase subclass: #TusLibrosRestInterfaceTest
	instanceVariableNames: 'testObjectsFactory debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosRestInterfaceTest methodsFor: 'set up' stamp: 'Luis 6/17/2018 17:47:38'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !

!TusLibrosRestInterfaceTest methodsFor: 'set up' stamp: 'Luis 6/17/2018 17:47:12'!
setUp

	testObjectsFactory _ StoreTestObjectsFactory new.
	debitBehavior := [ :anAmount :aCreditCard | ].! !


!TusLibrosRestInterfaceTest methodsFor: 'testing' stamp: 'A 6/18/2018 00:39:23'!
test01CanCreateCartWithValidData
	| interface cart |

	interface _ testObjectsFactory defaultInterface.
	cart _ interface
		createCartwith: testObjectsFactory validUsername 
		and: testObjectsFactory validPassword.
	self assert: cart = 1.! !

!TusLibrosRestInterfaceTest methodsFor: 'testing' stamp: 'A 6/18/2018 00:40:50'!
test02CanIdentifyTwoDiferentCarts
	| interface cart1 cart2 |

	interface _ testObjectsFactory defaultInterface.
	cart1 _ interface
		createCartwith: testObjectsFactory validUsername 
		and: testObjectsFactory validPassword.
	cart2 _ interface
		createCartwith: testObjectsFactory validUsername
		and: testObjectsFactory validPassword.
	self assert: cart1 = 1.
	self assert: cart2 = 2.! !

!TusLibrosRestInterfaceTest methodsFor: 'testing' stamp: 'A 6/18/2018 00:41:36'!
test03CannotCreateCartWithInvalidPassword

	| interface |.
	interface _ testObjectsFactory defaultInterface.
	
		self 
		should: [interface createCartwith: testObjectsFactory validUsername and: testObjectsFactory invalidPassword. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = TusLibrosRestInterface invalidPasswordErrorMessage.
			].
	


	
	

	! !

!TusLibrosRestInterfaceTest methodsFor: 'testing' stamp: 'A 6/18/2018 00:43:09'!
test04CannotCreateCartWithInvalidUser

	| interface |.
	interface _ testObjectsFactory defaultInterface.
	
		self 
		should: [interface createCartwith: testObjectsFactory invalidUsername and: testObjectsFactory invalidPassword. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = TusLibrosRestInterface invalidUserErrorMessage.
			].
	


	
	

	! !

!TusLibrosRestInterfaceTest methodsFor: 'testing' stamp: 'A 6/18/2018 01:22:58'!
test05ShouldNotAssignCartIdToWhenLoginWasInvalid

	| interface |.
	interface _ testObjectsFactory defaultInterface.
	
	self 
	should: [interface createCartwith: testObjectsFactory validUsername and: testObjectsFactory invalidPassword.  ]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [ :anError |
		self assert: (interface createCartwith: testObjectsFactory validUsername and: testObjectsFactory validPassword) = 1.
	].
	


	
	

	! !

!TusLibrosRestInterfaceTest methodsFor: 'testing' stamp: 'A 6/18/2018 01:24:28'!
test06ShouldNotAddItemsIfCartIdDoesNotExist

	| interface cart |.
	interface _ testObjectsFactory defaultInterface.
	cart _ interface createCartwith: testObjectsFactory validUsername and: testObjectsFactory validPassword.
	
	
	self 
	should: [interface addToCart: (cart + 1) ISBN: testObjectsFactory itemSellByTheStore Quantity: 1.]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [ :anError |
		self assert: anError messageText = TusLibrosRestInterface invalidCartIDErrorMessage.
	].


	

	


	
	

	! !

!TusLibrosRestInterfaceTest methodsFor: 'testing' stamp: 'AB 6/18/2018 10:46:30'!
test07CanListAnEmptyCart
	| interface cart |
	interface _ testObjectsFactory defaultInterface.
	cart _ interface
		createCartwith: testObjectsFactory validUsername
		and: testObjectsFactory validPassword.
	self assert: ((interface listCart: cart) size = 0).! !

!TusLibrosRestInterfaceTest methodsFor: 'testing' stamp: 'AB 6/18/2018 10:46:39'!
test08ShouldNotListCartsWithInvalidID
	| interface cart |
	interface _ testObjectsFactory defaultInterface.
	cart _ interface
		createCartwith: testObjectsFactory validUsername
		and: testObjectsFactory validPassword.
	self
		should: [ interface listCart: (cart +1)]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = TusLibrosRestInterface invalidCartIDErrorMessage ].! !

!TusLibrosRestInterfaceTest methodsFor: 'testing' stamp: 'AB 6/18/2018 10:45:21'!
test09CanAddItemsWithAValidCartID
	| interface cart |
	interface _ testObjectsFactory defaultInterface.
	cart _ interface
		createCartwith: testObjectsFactory validUsername
		and: testObjectsFactory validPassword.
	interface
		addToCart: cart
		ISBN: testObjectsFactory itemSellByTheStore
		Quantity: 2.
	self assert: ((interface listCart: cart) includesKey: testObjectsFactory itemSellByTheStore).
	self assert: ((interface listCart: cart) at: testObjectsFactory itemSellByTheStore) = 2.! !

!TusLibrosRestInterfaceTest methodsFor: 'testing' stamp: 'AB 6/18/2018 11:06:32'!
test10CanNotCheckoutWithInvalidCartID
	| interface cart card |

	card _ testObjectsFactory notExpiredCreditCard.
	interface _ testObjectsFactory defaultInterface.
	cart _ interface
		createCartwith: testObjectsFactory validUsername
		and: testObjectsFactory validPassword.
	interface
		addToCart: cart
		ISBN: testObjectsFactory itemSellByTheStore
		Quantity: 2.
		
	self
		should: [ interface checkoutCart: (cart +1) withCard: card.]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = TusLibrosRestInterface invalidCartIDErrorMessage ].
! !

!TusLibrosRestInterfaceTest methodsFor: 'testing' stamp: 'AB 6/18/2018 11:06:42'!
test11CheckoutCartReturnsTransactionID
	| interface cart card transaction |
	card _ testObjectsFactory notExpiredCreditCard.
	interface _ testObjectsFactory defaultInterface.
	cart _ interface
		createCartwith: testObjectsFactory validUsername
		and: testObjectsFactory validPassword.
	interface
		addToCart: cart
		ISBN: testObjectsFactory itemSellByTheStore
		Quantity: 2.
	transaction _ interface
		checkoutCart: cart
		withCard: card.
	self assert: transaction = 1.! !

!TusLibrosRestInterfaceTest methodsFor: 'testing' stamp: 'AB 6/18/2018 11:54:09'!
test12CanNotListPurchasesWhenInvalidUsername
	| interface |
	interface _ testObjectsFactory defaultInterface.
	self
		should: [
			interface
				listPurchases: testObjectsFactory invalidUsername
				with: testObjectsFactory invalidPassword ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = TusLibrosRestInterface invalidUserErrorMessage ].! !

!TusLibrosRestInterfaceTest methodsFor: 'testing' stamp: 'AB 6/18/2018 11:54:17'!
test13CanNotListPurchasesWhenInvalidPassword
	| interface |
	interface _ testObjectsFactory defaultInterface.
	self
		should: [
			interface
				listPurchases: testObjectsFactory validUsername
				with: testObjectsFactory invalidPassword ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = TusLibrosRestInterface invalidPasswordErrorMessage ].! !

!TusLibrosRestInterfaceTest methodsFor: 'testing' stamp: 'AB 6/18/2018 11:54:26'!
test14CanListWhenNoPurchasesWereMade
	| interface purchases |
	interface _ testObjectsFactory defaultInterface.
	purchases _ interface
		listPurchases: testObjectsFactory validUsername
		with: testObjectsFactory validPassword.
	self assert: purchases size = 0.! !

!TusLibrosRestInterfaceTest methodsFor: 'testing' stamp: 'AB 6/18/2018 12:55:22'!
test15CanListWhenOnePurchaseWasMade
	| interface cart card purchases|
	
	card _ testObjectsFactory notExpiredCreditCard.
	interface _ testObjectsFactory defaultInterface.
	cart _ interface
		createCartwith: testObjectsFactory validUsername
		and: testObjectsFactory validPassword.
	interface
		addToCart: cart
		ISBN: testObjectsFactory itemSellByTheStore
		Quantity: 2.
		
	 interface checkoutCart: cart withCard: card.
	
	purchases _ interface listPurchases: testObjectsFactory validUsername with: testObjectsFactory validPassword.
	
	self assert: purchases size = 1.
	self assert: (purchases includesKey: testObjectsFactory itemSellByTheStore).
	self assert: (purchases at: testObjectsFactory itemSellByTheStore) = 2.! !

!TusLibrosRestInterfaceTest methodsFor: 'testing' stamp: 'AB 6/18/2018 12:57:33'!
test16CanListWhenTwoPurchasesWereMade
	| interface cart cart2 card purchases|
	
	card _ testObjectsFactory notExpiredCreditCard.
	interface _ testObjectsFactory defaultInterface.
	cart _ interface
		createCartwith: testObjectsFactory validUsername
		and: testObjectsFactory validPassword.
	interface
		addToCart: cart
		ISBN: testObjectsFactory itemSellByTheStore
		Quantity: 2.
		
	cart2 _ interface
		createCartwith: testObjectsFactory validUsername
		and: testObjectsFactory validPassword.
	interface
		addToCart: cart2
		ISBN: testObjectsFactory itemSellByTheStore
		Quantity: 1.
		
	interface checkoutCart: cart withCard: card.
	interface checkoutCart: cart2 withCard: card.
	
	purchases _ interface listPurchases: testObjectsFactory validUsername with: testObjectsFactory validPassword.
	
	self assert: purchases size = 1.
	self assert: (purchases includesKey: testObjectsFactory itemSellByTheStore).
	self assert: (purchases at: testObjectsFactory itemSellByTheStore) = 3.! !

!TusLibrosRestInterfaceTest methodsFor: 'testing' stamp: 'AB 6/18/2018 13:37:23'!
test17CanNotAddItemsWhenCartInactiveFor30Minutes
	| interface cart |
	
	interface _ testObjectsFactory defaultInterface.
	interface setTimeReference: (AcceleratedTime by: 30).

	cart _ interface
		createCartwith: testObjectsFactory validUsername
		and: testObjectsFactory validPassword.
		
	self
		should: [
				interface
				addToCart: cart
				ISBN: testObjectsFactory itemSellByTheStore
				Quantity: 2. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = TusLibrosRestInterface cartExpiredErrorMessage].
! !

!TusLibrosRestInterfaceTest methodsFor: 'testing' stamp: 'AB 6/18/2018 13:49:31'!
test18CanNotCheckoutWhenCartInactiveFor30Minutes
	| interface cart card|
	
	card _ testObjectsFactory notExpiredCreditCard.
	
	interface _ testObjectsFactory defaultInterface.
	interface setTimeReference: (AcceleratedTime by: 15).

	cart _ interface
		createCartwith: testObjectsFactory validUsername
		and: testObjectsFactory validPassword.
		
	interface addToCart: cart ISBN: testObjectsFactory itemSellByTheStore Quantity: 2.
	
	interface createCartwith: testObjectsFactory validUsername and: testObjectsFactory validPassword.
		
	self
		should: [interface checkoutCart: cart withCard: card.]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = TusLibrosRestInterface cartExpiredErrorMessage].
! !


!classDefinition: #AcceleratedTime category: #TusLibros!
Object subclass: #AcceleratedTime
	instanceVariableNames: 'currentTime timeStep'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!AcceleratedTime methodsFor: 'as yet unclassified' stamp: 'AB 6/18/2018 13:36:58'!
initialize
	self initializeWith: 30.! !

!AcceleratedTime methodsFor: 'as yet unclassified' stamp: 'AB 6/18/2018 13:36:45'!
initializeWith: aMinutesQuantity
	currentTime _ DateAndTime now.
	timeStep _ aMinutesQuantity.! !

!AcceleratedTime methodsFor: 'as yet unclassified' stamp: 'AB 6/18/2018 13:41:55'!
now
	currentTime _ currentTime + (Duration minutes: timeStep).
	^ currentTime.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AcceleratedTime class' category: #TusLibros!
AcceleratedTime class
	instanceVariableNames: ''!

!AcceleratedTime class methodsFor: 'as yet unclassified' stamp: 'AB 6/18/2018 13:36:02'!
by: aMinutesQuantity
	^self new initializeWith: aMinutesQuantity.! !


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


!Cart methodsFor: 'initialization' stamp: 'ABC 6/14/2018 21:40:41'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 19:09'!
total

	^ items sum: [ :anItem | catalog at: anItem ]! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !


!Cart methodsFor: 'as yet unclassified' stamp: 'ABC 6/14/2018 21:03:05'!
itemsAsSet

	| result |.
	result _ items asSet .
	^ result .! !

!Cart methodsFor: 'as yet unclassified' stamp: 'A 6/18/2018 01:16:39'!
listItems

	^items inject: Dictionary new into: [:aResult :anItem | aResult at: anItem put: (self occurrencesOf: anItem). aResult]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: #TusLibros!
Object subclass: #Cashier
	instanceVariableNames: 'cart salesBook merchantProcessor creditCard total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:08'!
calculateTotal

	total := cart total.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:07'!
createSale

	^ Sale of: total
! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
debitTotal

	merchantProcessor debit: total from: creditCard.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
registerSale

	salesBook add: self createSale! !


!Cashier methodsFor: 'checkout' stamp: 'HernanWilkinson 6/17/2013 19:06'!
checkOut

	self calculateTotal.
	self debitTotal.
	self registerSale.

	^ total! !


!Cashier methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:53'!
initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook
	
	cart := aCart.
	creditCard := aCreditCard.
	merchantProcessor := aMerchantProcessor.
	salesBook := aSalesBook! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:22'!
assertIsNotEmpty: aCart 
	
	aCart isEmpty ifTrue: [self error: self cartCanNotBeEmptyErrorMessage ]! !

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:23'!
assertIsNotExpired: aCreditCard on: aDate
	
	(aCreditCard isExpiredOn: aDate) ifTrue: [ self error: self canNotChargeAnExpiredCreditCardErrorMessage ]! !


!Cashier class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:51'!
toCheckout: aCart charging: aCreditCard throught: aMerchantProcessor on: aDate registeringOn: aSalesBook
	
	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.
	
	^self new initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook! !


!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 18:21'!
canNotChargeAnExpiredCreditCardErrorMessage
	
	^'Can not charge an expired credit card'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:56'!
cartCanNotBeEmptyErrorMessage
	
	^'Can not check out an empty cart'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 19:02'!
creditCardHasNoCreditErrorMessage
	
	^'Credit card has no credit'! !


!classDefinition: #CreditCard category: #TusLibros!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration serialNumber ownerName'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 18:39'!
isExpiredOn: aDate 
	
	^expiration start < (Month month: aDate monthIndex year: aDate yearNumber) start ! !


!CreditCard methodsFor: 'initialization' stamp: 'A 6/18/2018 01:30:53'!
initializeExpiringOn: aMonth withNumber: aNumber andOwnerName: aName
	
	expiration _ aMonth.
	serialNumber _ aNumber.
	ownerName _ aName.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #TusLibros!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'A 6/18/2018 01:30:02'!
expiringOn: aMonth withNumber: aNumber andOwnerName: aName
	
	^self new initializeExpiringOn: aMonth withNumber: aNumber andOwnerName: aName! !


!classDefinition: #Sale category: #TusLibros!
Object subclass: #Sale
	instanceVariableNames: 'total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 18:48'!
total
	
	^ total! !


!Sale methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:47'!
initializeTotal: aTotal

	total := aTotal ! !

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
	instanceVariableNames: 'today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStore
	
	^ 'validBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStorePrice
	
	^10! !


!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
defaultCatalog
	
	^ Dictionary new
		at: self itemSellByTheStore put: self itemSellByTheStorePrice;
		yourself ! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'A 6/18/2018 01:32:27'!
expiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber - 1) withNumber: 1234 andOwnerName: 'A Name'.! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'A 6/18/2018 01:32:12'!
notExpiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber + 1) withNumber: 1234 andOwnerName: 'A Name'.! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:37'!
initialize

	today := DateAndTime now! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !


!StoreTestObjectsFactory methodsFor: 'apiRest' stamp: 'AB 6/18/2018 11:01:04'!
debit: anAmount from: aCard
	! !

!StoreTestObjectsFactory methodsFor: 'apiRest' stamp: 'AB 6/18/2018 13:09:00'!
defaultInterface
	
	^ TusLibrosRestInterface sellingItemsFrom: self defaultCatalog withUserbase: self defaultUserBase andMerchantProcessor: self.! !

!StoreTestObjectsFactory methodsFor: 'apiRest' stamp: 'A 6/18/2018 00:31:49'!
defaultUserBase
	
	^ Dictionary new
		at: self validUsername put: self validPassword;
		yourself ! !

!StoreTestObjectsFactory methodsFor: 'apiRest' stamp: 'A 6/18/2018 00:41:55'!
invalidPassword
	
	^'Invalid Password'! !

!StoreTestObjectsFactory methodsFor: 'apiRest' stamp: 'A 6/18/2018 00:42:09'!
invalidUsername
	
	^'Invalid username'! !

!StoreTestObjectsFactory methodsFor: 'apiRest' stamp: 'A 6/18/2018 00:24:04'!
validPassword
	
	^'Valid Password'! !

!StoreTestObjectsFactory methodsFor: 'apiRest' stamp: 'A 6/18/2018 00:23:56'!
validUsername
	
	^'Valid User'! !


!classDefinition: #TusLibrosRestInterface category: #TusLibros!
Object subclass: #TusLibrosRestInterface
	instanceVariableNames: 'logins cartIdCounter carts processor catalog transactionIDCounter clientPurchases cartOwners cartsModifiedTime currentTime'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosRestInterface methodsFor: 'initialization' stamp: 'AB 6/18/2018 13:09:59'!
initializeWith: aCatalog and: aUserBase through: aProcessor
	cartIdCounter _ 0.
	transactionIDCounter _ 0.

	catalog _ aCatalog.
	logins _ aUserBase.
	processor _ aProcessor.
	carts _ Dictionary new.
	cartOwners _ Dictionary new.
	clientPurchases _ Dictionary new.
	cartsModifiedTime _ Dictionary new.
	currentTime _ DateAndTime.
	
	logins keysDo: [:aKey | clientPurchases at: aKey put: Dictionary new]
! !


!TusLibrosRestInterface methodsFor: 'public methods' stamp: 'AB 6/18/2018 13:17:03'!
addToCart:aCartID ISBN:aISBN Quantity: aQuantity

	self assertValidCartID: aCartID .
	self assertCartNotExpired: aCartID.
	cartsModifiedTime at: cartIdCounter put: currentTime now.

	(carts at: aCartID) add: aQuantity of: aISBN.! !

!TusLibrosRestInterface methodsFor: 'public methods' stamp: 'AB 6/18/2018 13:32:57'!
checkoutCart: aCartId  withCard: aCreditCard
	
	| cashier sale cart ownerPurchases|
	
	self assertValidCartID:aCartId.
	self assertCartNotExpired: aCartId.

	sale _ OrderedCollection new.
	cart _ carts at: aCartId.
	ownerPurchases _ clientPurchases at: (cartOwners at: aCartId).

	cashier _ Cashier toCheckout: cart
							charging: aCreditCard 
							throught: processor
							on:  DateAndTime now
							registeringOn: sale.
	
	cashier checkOut.
	
	
	transactionIDCounter _ transactionIDCounter + 1.
	
	
	cart listItems keysAndValuesDo: [:anItem :aQuantity | ownerPurchases at: anItem ifAbsentPut: 0.
													 	ownerPurchases at: anItem put: (ownerPurchases at: anItem) + aQuantity ].
	
	self cleanupCart: aCartId.
	
	^ transactionIDCounter .! !

!TusLibrosRestInterface methodsFor: 'public methods' stamp: 'AB 6/18/2018 13:16:26'!
createCartwith: aUsername and: aPassword
	self assertValidUsername: aUsername.
	self assertValidPassword: aPassword of: aUsername.
	cartIdCounter _ cartIdCounter + 1.
	carts at: cartIdCounter put: (Cart acceptingItemsOf: catalog).
	cartOwners at: cartIdCounter put: aUsername.
	cartsModifiedTime at: cartIdCounter put: currentTime now.

	^ cartIdCounter.! !

!TusLibrosRestInterface methodsFor: 'public methods' stamp: 'A 6/18/2018 01:16:00'!
listCart:aCartID

	self assertValidCartID: aCartID.
		
	^ (carts at: aCartID) listItems. 
	
	
	
	


	! !

!TusLibrosRestInterface methodsFor: 'public methods' stamp: 'AB 6/18/2018 11:50:34'!
listPurchases:aClientID with:aPassword
	self assertValidUsername: aClientID.
	self assertValidPassword: aPassword of: aClientID.
	
	^ clientPurchases at: aClientID.

	
	
	! !

!TusLibrosRestInterface methodsFor: 'public methods' stamp: 'AB 6/18/2018 13:10:29'!
setTimeReference: aReference
	currentTime _ aReference.
	
	
	
	


	! !


!TusLibrosRestInterface methodsFor: 'assertions' stamp: 'AB 6/18/2018 13:30:33'!
assertCartNotExpired: aCartId
	((currentTime now - (cartsModifiedTime at: aCartId) ) totalSeconds) / 60 >= 30 ifTrue: [^ self error: self class cartExpiredErrorMessage].! !

!TusLibrosRestInterface methodsFor: 'assertions' stamp: 'A 6/18/2018 01:09:24'!
assertValidCartID: aCartId
	(carts includesKey: aCartId) ifFalse: [ ^ self error: self class invalidCartIDErrorMessage ].! !

!TusLibrosRestInterface methodsFor: 'assertions' stamp: 'A 6/18/2018 00:37:10'!
assertValidPassword: aPassword of: aUsername
	(logins at: aUsername) = aPassword ifFalse: [ ^ self error: TusLibrosRestInterface invalidPasswordErrorMessage ].! !

!TusLibrosRestInterface methodsFor: 'assertions' stamp: 'A 6/18/2018 00:34:19'!
assertValidUsername: aUsername
	(logins includesKey: aUsername) ifFalse: [ ^ self error: TusLibrosRestInterface invalidUserErrorMessage ].! !


!TusLibrosRestInterface methodsFor: 'as yet unclassified' stamp: 'AB 6/18/2018 13:33:05'!
cleanupCart: aCartId
	carts removeKey: aCartId.
	cartOwners removeKey: aCartId.
	cartsModifiedTime removeKey: aCartId.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosRestInterface class' category: #TusLibros!
TusLibrosRestInterface class
	instanceVariableNames: ''!

!TusLibrosRestInterface class methodsFor: 'error messages' stamp: 'AB 6/18/2018 13:30:16'!
cartExpiredErrorMessage
	^ ' The Cart is expired'.! !

!TusLibrosRestInterface class methodsFor: 'error messages' stamp: 'A 6/18/2018 01:09:24'!
invalidCartIDErrorMessage
	^ ' The CartID provided is invalid'.! !

!TusLibrosRestInterface class methodsFor: 'error messages' stamp: 'ABC 6/14/2018 20:19:19'!
invalidPasswordErrorMessage

	^ ' Password Invalida '.! !

!TusLibrosRestInterface class methodsFor: 'error messages' stamp: 'ABC 6/14/2018 20:23:28'!
invalidUserErrorMessage

	^ ' Usuario Invalido '.! !


!TusLibrosRestInterface class methodsFor: 'instance creation' stamp: 'AB 6/18/2018 10:51:45'!
sellingItemsFrom: aCatalog withUserbase: aLoginDictionary andMerchantProcessor: aProcessor
	^ self new initializeWith: aCatalog and: aLoginDictionary through: aProcessor.! !
