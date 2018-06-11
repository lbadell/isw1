!classDefinition: #CartTest category: #TusLibros!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:08'!
test01NewCartsAreCreatedEmpty

	self assert: self createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [ cart add: self itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 0 of: self itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 2 of: self itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test06CartRemembersAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self assert: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := self createCart.
	
	self deny: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: 2 of: self itemSellByTheStore.
	self assert: (cart occurrencesOf: self itemSellByTheStore) = 2! !


!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:48'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:43'!
defaultCatalog
	
	^ Array with: self itemSellByTheStore! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:44'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:43'!
itemSellByTheStore
	
	^ 'validBook'! !


!classDefinition: #CashierTest category: #TusLibros!
TestCase subclass: #CashierTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'as yet unclassified' stamp: 'ABC 6/7/2018 19:05:32'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'ABC 6/7/2018 19:05:42'!
defaultCatalog
	
	^ Array with: self itemSellByTheStore! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'ABC 6/7/2018 19:06:33'!
defaultPriceList

	| prices| .
	prices _ Dictionary new.
	prices add:'validBook' -> 20  .
	
	^ prices .
	
	! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'ABC 6/7/2018 19:05:51'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'ABC 6/7/2018 19:05:59'!
itemSellByTheStore
	
	^ 'validBook'! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'A 6/11/2018 01:52:02'!
test01CashierCantCheckoutAnEmptyCart
	| carrito cashier |

	carrito _ CartTest new createCart.
	cashier _ Cashier with: self defaultPriceList.
	
	self
		should: [ cashier checkout: carrito ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier EmptyCart.
			self assert: carrito isEmpty ].! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'A 6/11/2018 01:51:48'!
test02CashierCanCheckoutCartWithSingleItemReturningTicketWithCorrectValue
	| carrito cashier ticket |

	carrito _ self createCart.
	cashier _ Cashier with: self defaultPriceList.

	carrito add: 1 of: self itemSellByTheStore.
	ticket _ cashier checkout: carrito.

	self assert: ticket value = 20.! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'A 6/11/2018 01:51:28'!
test03CashierCanCheckoutMultipleItemsReturningTicketWithCorrectValue
	| carrito cashier ticket |

	carrito _ self createCart.
	cashier _ Cashier with: self defaultPriceList.
	
	carrito add: 2 of: self itemSellByTheStore.
	ticket _ cashier checkout: carrito.
	
	self assert: ticket value = 40.! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'A 6/11/2018 01:50:53'!
test04CashierShouldNotCheckoutItemsNotInPriceList
	| carrito cashier |
	
	carrito _ Cart acceptingItemsOf: (Array with: self itemNotSellByTheStore).
	cashier _ Cashier with: self defaultPriceList.

	carrito add: 1 of: self itemNotSellByTheStore.
	self
		should: [ cashier checkout: carrito ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cashier invalidItemErrorMessage ].! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'A 6/11/2018 01:50:06'!
test05CashierShouldNotProcessAnExpiredCard
	| carrito cashier ticket card |

	carrito _ self createCart.
	cashier _ Cashier with: self defaultPriceList at: (GregorianMonthOfYear julyOf: (GregorianYear number: 2018)).
	card _ CreditCard withId: 1 expiringAt: (GregorianMonthOfYear juneOf: (GregorianYear number: 2018)).
		
	carrito add: 1 of: self itemSellByTheStore.
	ticket _ cashier checkout: carrito.
	self
		should: [cashier cash: ticket with: card ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cashier cardExpiredErrorMessage ].! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'A 6/11/2018 01:49:20'!
test06CashierShouldNotProcessARejectedCard
	| carrito cashier ticket card |

	carrito _ self createCart.
	cashier _ Cashier with: self defaultPriceList at: (GregorianMonthOfYear juneOf: (GregorianYear number: 2018)).
	card _ CreditCard withId: -1 expiringAt: (GregorianMonthOfYear julyOf: (GregorianYear number: 2018)).

	carrito add: 1 of: self itemSellByTheStore.
	ticket _ cashier checkout: carrito.

	self
		should: [cashier cash: ticket with: card ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cashier cardRejectedErrorMessage.
			self assert: cashier totalSold = 0 ].! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'A 6/11/2018 01:49:55'!
test07CashierCanProcessAValidCard
	| carrito cashier ticket card |
	
	carrito _ self createCart.
	cashier _ Cashier with: self defaultPriceList at: (GregorianMonthOfYear juneOf: (GregorianYear number: 2018)).
	card _ CreditCard withId: 1 expiringAt: (GregorianMonthOfYear julyOf: (GregorianYear number: 2018)).
	
	carrito add: 1 of: self itemSellByTheStore.
	ticket _ cashier checkout: carrito.
	cashier cash: ticket with: card.
	
	self assert: cashier totalSold = 20.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CashierTest class' category: #TusLibros!
CashierTest class
	instanceVariableNames: ''!

!CashierTest class methodsFor: 'as yet unclassified' stamp: 'ABC 6/7/2018 19:01:53'!
EmptyCart

	^'Carritos Vacios no se pueden checkoutear '.! !


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


!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidItem: anItem

	(catalog includes: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 17:48'!
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


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !


!Cart methodsFor: 'as yet unclassified' stamp: 'ABC 6/7/2018 19:12:27'!
items

	^ items copy .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: #TusLibros!
Object subclass: #Cashier
	instanceVariableNames: 'priceList monthOfYear total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'error messages' stamp: 'A 6/11/2018 01:08:32'!
cardExpiredErrorMessage
	
	^'The credit card expired'! !

!Cashier methodsFor: 'error messages' stamp: 'A 6/11/2018 01:27:58'!
cardRejectedErrorMessage
	
	^'The credit card was rejected'! !

!Cashier methodsFor: 'error messages' stamp: 'A 6/10/2018 15:23:03'!
invalidItemErrorMessage
	
	^'Item is not in price list'! !


!Cashier methodsFor: 'assertions' stamp: 'A 6/11/2018 01:21:37'!
assertCardNotExpired: aCreditCard 
	aCreditCard expirationDate < monthOfYear ifTrue: [^self error: self cardExpiredErrorMessage]! !

!Cashier methodsFor: 'assertions' stamp: 'A 6/10/2018 15:32:10'!
assertIsValidItem: anItem
	(priceList includesKey: anItem) ifFalse: [^self error: self invalidItemErrorMessage].! !


!Cashier methodsFor: 'accessing' stamp: 'A 6/11/2018 00:58:43'!
cash: aTicket with: aCreditCard 
	self assertCardNotExpired: aCreditCard.
	
	self process: aTicket value to: aCreditCard! !

!Cashier methodsFor: 'accessing' stamp: 'A 6/10/2018 16:29:29'!
checkout: aCart 
	(aCart isEmpty ) ifTrue: [^self error: self class EmptyCart ].

	^ aCart items inject: 0 into:[:total :anItem |
		self assertIsValidItem: anItem.
		total + priceList at:anItem ] ! !

!Cashier methodsFor: 'accessing' stamp: 'A 6/11/2018 01:43:45'!
process: anAmount to: aCreditCard 
	aCreditCard id = 1 ifFalse: [^self error: self cardRejectedErrorMessage].
	total _ total + anAmount.! !

!Cashier methodsFor: 'accessing' stamp: 'A 6/11/2018 01:44:00'!
totalSold
	^total.! !


!Cashier methodsFor: 'initialization' stamp: 'A 6/11/2018 01:43:28'!
initializeWith:aPriceList at: aMonthOfTheYear

	priceList _ aPriceList .
	monthOfYear _ aMonthOfTheYear.
	total _ 0.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'as yet unclassified' stamp: 'ABC 6/7/2018 19:03:01'!
EmptyCart

	^ 'Carritos Vacios no se pueden checkoutear '.! !

!Cashier class methodsFor: 'as yet unclassified' stamp: 'A 6/11/2018 01:04:39'!
with:aPriceList

	^ self new initializeWith: aPriceList at: GregorianMonthOfYear current.! !

!Cashier class methodsFor: 'as yet unclassified' stamp: 'A 6/11/2018 01:04:15'!
with:aPriceList at: aMonthOfTheYear

	^ self new initializeWith: aPriceList at: aMonthOfTheYear.! !


!classDefinition: #CreditCard category: #TusLibros!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration cardId'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'initialization' stamp: 'A 6/11/2018 01:29:58'!
initializeWithId: anId andExpiration: aGregorianMonthOfYear 
	expiration _ aGregorianMonthOfYear.
	cardId _ anId.! !


!CreditCard methodsFor: 'accessing' stamp: 'A 6/11/2018 01:07:08'!
expirationDate
	^expiration.! !

!CreditCard methodsFor: 'accessing' stamp: 'A 6/11/2018 01:28:26'!
id
	^cardId.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #TusLibros!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'A 6/11/2018 01:29:16'!
withId: anId expiringAt: aGregorianMonthOfYear 
	^self new initializeWithId: anId andExpiration: aGregorianMonthOfYear.! !
