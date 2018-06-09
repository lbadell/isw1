!classDefinition: #CartTest category: #TusLibros!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'as yet unclassified' stamp: 'A 6/6/2018 20:49:40'!
test01newCartIsEmpty
	| carrito catalogo |
	catalogo _ Catalog new.
	carrito _ Cart with: catalogo.

	
	self assert: carrito isEmpty.! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'A 6/6/2018 20:49:28'!
test02notEmptyCartIsNotEmpty
	| carrito catalogo |
	
	catalogo _ Catalog new.
	carrito _ Cart with: catalogo.

	catalogo addItem: 'Libro 1'.
	carrito add: 'Libro 1'.
	
	self deny: carrito isEmpty.! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'A 6/6/2018 20:49:00'!
test04canRemoveExistingItem
	| carrito catalogo |

	catalogo _ Catalog new.
	carrito _ Cart with: catalogo.
	
	catalogo addItem: 'Libro 1'.

	carrito add: 'Libro 1'.
	carrito remove: 'Libro 1'.
	
	self assert: carrito isEmpty .		
	
! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'A 6/6/2018 20:48:08'!
test05addedItemBelongsToCart
	| carrito catalogo |

	catalogo _ Catalog new.
	carrito _ Cart with: catalogo.

	catalogo addItem: 'Libro 1'.
	carrito add: 'Libro 1'.
	
	self assert: (carrito includes: 'Libro 1').
! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'A 6/6/2018 20:47:40'!
test06removedItemDoesNotBelongToCart
	| carrito catalogo |
	catalogo _ Catalog new.
	carrito _ Cart with: catalogo.
	catalogo addItem: 'Libro 1'.
	catalogo addItem: 'Libro 2'.
	
	carrito add: 'Libro 1'.
	carrito add: 'Libro 2'.
	carrito remove: 'Libro 1'.
	self deny: (carrito includes: 'Libro 1').
	self assert: (carrito includes: 'Libro 2').! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'A 6/6/2018 20:47:01'!
test07canNotRemoveItemThatDoesNotBelongToCart
	| carrito catalogo |
	catalogo _ Catalog new.
	carrito _ Cart with: catalogo.
	self
		should: [ carrito remove: 'Libro 3' ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cart canNotRemoveNonExistingItem ].! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'A 6/6/2018 20:43:34'!
test07canOnlyAddItemsInItsCatalog
	| carrito catalogo |
	catalogo _ Catalog new.
	carrito _ Cart with: catalogo.

	self
		should: [ carrito add: 'Libro 3' ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cart itemDoesNotBelongToCatalog.
			self deny: (carrito includes: 'Libro 3').
			].! !


!classDefinition: #Cart category: #TusLibros!
Object subclass: #Cart
	instanceVariableNames: 'compras catalogo'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'accessing' stamp: 'A 6/6/2018 20:41:00'!
add: anElement
	(catalogo containsItem: anElement) ifFalse: [^self error: self class itemDoesNotBelongToCatalog].
	compras add: anElement.! !

!Cart methodsFor: 'accessing' stamp: 'A 6/6/2018 20:42:17'!
includes: anElement
	^compras includes: anElement.! !

!Cart methodsFor: 'accessing' stamp: 'ABC 6/4/2018 21:18:50'!
isEmpty

	^ compras isEmpty .! !

!Cart methodsFor: 'accessing' stamp: 'A 6/6/2018 20:42:35'!
remove: anElement

	(compras includes: anElement) ifFalse: [^self error: self class canNotRemoveNonExistingItem ].
	compras remove: anElement.! !


!Cart methodsFor: 'initialization' stamp: 'A 6/6/2018 20:29:09'!
initializeWith: aCatalog
	catalogo _ aCatalog.
	compras _ OrderedCollection new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'as yet unclassified' stamp: 'ABC 6/4/2018 21:43:05'!
canNotRemoveNonExistingItem

	^ ' Fijate que el item lo hayas agregado '.
	! !

!Cart class methodsFor: 'as yet unclassified' stamp: 'A 6/6/2018 20:32:30'!
itemDoesNotBelongToCatalog

	^ 'El item no está en el catálogo'.
	! !


!Cart class methodsFor: 'instance creation' stamp: 'A 6/6/2018 20:28:12'!
with: aCatalog
	^self new initializeWith: aCatalog.! !


!classDefinition: #Catalog category: #TusLibros!
Object subclass: #Catalog
	instanceVariableNames: 'items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Catalog methodsFor: 'initialization' stamp: 'A 6/6/2018 20:39:26'!
initialize
	items _ OrderedCollection new.! !


!Catalog methodsFor: 'accessing' stamp: 'A 6/6/2018 20:40:03'!
addItem: anItem
	items add: anItem .! !

!Catalog methodsFor: 'accessing' stamp: 'A 6/6/2018 20:41:08'!
containsItem: anItem
	^items includes: anItem .! !
