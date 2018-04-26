!classDefinition: #OOStackTest category: #'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'Something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:31'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'Something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/8/2012 08:20'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:33'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'First'.
	secondPushedObject := 'Second'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:35'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:36'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:36'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'Something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #EndOfStack category: #'Stack-Exercise'!
Object subclass: #EndOfStack
	instanceVariableNames: 'elementList'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!EndOfStack methodsFor: 'accessing' stamp: 'A 4/26/2018 15:32:14'!
peekCurrentValue
	^ self error: OOStack stackEmptyErrorDescription.! !


!classDefinition: #OOStack category: #'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'stackList'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!
!OOStack commentStamp: '<historical>' prior: 0!
Representa a un stack. 
Contiene internamente una lista de elementos representando stacks unimembres, siendo el último el "stack vacío"
Pasa los mensajes top e isEmpty hacia su primer elemento y dependiendo de qué tipo de objeto es, la respuesta varía
Para el mensaje pop simplemente hace primero un top y remueve el primer elemento. Ya que en caso de pasar top al stack vacío se interrumpe la ejecución debido a la excepción  y no se llega a remover dicho elemento.
Para el mensaje push se agrega un stack unimembre a la lista.
El mensaje size tiene en cuenta que contiene un elemento de más, el stack vacío, y por resta uno a la cantidad de elementos de la lista.
!


!OOStack methodsFor: 'Solucion' stamp: 'A 4/26/2018 15:27:39'!
initializeInstance
	stackList _ OrderedCollection new.
	stackList addFirst: EndOfStack new.! !

!OOStack methodsFor: 'Solucion' stamp: 'A 4/26/2018 15:30:25'!
isEmpty
	^self size = 0.! !

!OOStack methodsFor: 'Solucion' stamp: 'A 4/20/2018 16:14:40'!
pop
	|topElement|
	
	topElement _ self top.
	stackList removeFirst.
	^topElement 
		! !

!OOStack methodsFor: 'Solucion' stamp: 'A 4/26/2018 15:34:05'!
push: anElement
	| newSingleStackElement |
	newSingleStackElement _ SingleStackElement with: anElement.
	stackList addFirst: newSingleStackElement.! !

!OOStack methodsFor: 'Solucion' stamp: 'A 4/20/2018 16:11:51'!
size
	^stackList size -1.! !

!OOStack methodsFor: 'Solucion' stamp: 'A 4/26/2018 15:32:52'!
top
	^(stackList at: 1) peekCurrentValue .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: #'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'HernanWilkinson 5/7/2012 11:51'!
stackEmptyErrorDescription
	
	^ 'Stack is empty'! !


!OOStack class methodsFor: 'as yet unclassified' stamp: 'A 4/20/2018 15:10:38'!
new

^super new initializeInstance! !


!classDefinition: #SingleStackElement category: #'Stack-Exercise'!
Object subclass: #SingleStackElement
	instanceVariableNames: 'singleElement'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SingleStackElement methodsFor: 'initialization' stamp: 'A 4/20/2018 16:08:21'!
initializeInstance: anElement
	singleElement := anElement.! !


!SingleStackElement methodsFor: 'accessing' stamp: 'A 4/26/2018 15:32:35'!
peekCurrentValue
	^ singleElement.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SingleStackElement class' category: #'Stack-Exercise'!
SingleStackElement class
	instanceVariableNames: ''!

!SingleStackElement class methodsFor: 'as yet unclassified' stamp: 'A 4/20/2018 16:07:48'!
with: anElement

	^self new initializeInstance: anElement! !
