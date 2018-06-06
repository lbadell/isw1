!classDefinition: #CartTest category: #TusLibros!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'as yet unclassified' stamp: 'ABC 6/4/2018 21:14:57'!
test01newCartIsEmpty

	| carrito |
	
	carrito _ Cart new.
	
	self assert: carrito isEmpty.! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'ABC 6/4/2018 21:16:41'!
test02notEmptyCartIsNotEmpty

	| carrito |
	
	carrito _ Cart new.
	carrito add: 'Libro 1 '.
	
	self deny: carrito isEmpty.! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'ABC 6/4/2018 21:30:00'!
test04canRemoveExistingItem

	| carrito |			
	carrito _ Cart new.
	carrito add: 'Libro 1'.
	carrito remove: 'Libro 1'.
	
	self assert: carrito isEmpty .		
	
! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'ABC 6/4/2018 21:34:09'!
test05addedItemBelongsToCart

	| carrito |			
	carrito _ Cart new.
	carrito add: 'Libro 1'.
	
	self assert: (carrito includes: 'Libro 1').
! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'ABC 6/4/2018 21:35:45'!
test06

	| carrito |			
	carrito _ Cart new.
	carrito add: 'Libro 1'.
	carrito add: 'Libro 2'.
	carrito remove: 'Libro 1'.
		
	self deny: (carrito includes: 'Libro 1').
	self assert: (carrito includes: 'Libro 2').! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'ABC 6/4/2018 21:42:05'!
test07

	| carrito |			
	carrito _ Cart new.
		self
		should: [ carrito remove: 'Libro 3' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cart canNotRemoveNonExistingItem ]
		
	
	! !


!classDefinition: #Cart category: #TusLibros!
Object subclass: #Cart
	instanceVariableNames: 'compras'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'as yet unclassified' stamp: 'ABC 6/4/2018 21:34:28'!
includes: aString 
	^compras includes: aString ! !

!Cart methodsFor: 'as yet unclassified' stamp: 'ABC 6/4/2018 21:18:02'!
initialize

	compras _ OrderedCollection new..! !

!Cart methodsFor: 'as yet unclassified' stamp: 'ABC 6/4/2018 21:18:50'!
isEmpty

	^ compras isEmpty .! !


!Cart methodsFor: 'accessing' stamp: 'ABC 6/4/2018 21:18:17'!
add: aString 
	compras add: aString ! !


!Cart methodsFor: '*Aconcagua-Extensions' stamp: 'ABC 6/4/2018 21:46:23'!
remove: aString 

	(compras includes: aString ) ifFalse: [^self error: self class canNotRemoveNonExistingItem ].
	compras remove: aString ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'as yet unclassified' stamp: 'ABC 6/4/2018 21:43:05'!
canNotRemoveNonExistingItem

	^ ' Fijate que el item lo hayas agregado '.
	! !
