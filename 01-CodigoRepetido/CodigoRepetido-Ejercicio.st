!classDefinition: #NotFound category: #'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #IdiomTest category: #'CodigoRepetido-Ejercicio'!
TestCase subclass: #IdiomTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!IdiomTest methodsFor: 'testing' stamp: 'A 4/16/2018 14:11:49'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds
	|customerBook|
	
	customerBook  := CustomerBook  new.	
	
	self testDeTiempoConPrecondicion:[] operacionAMedir:[customerBook addCustomerNamed: 'John Lennon'] menorAEsteTiempo:50.

	"Nothing more expected ->| customerBook millisecondsBeforeRunning millisecondsAfterRunning |
	
	
	
	millisecondsBeforeRunning := Time millisecondClockValue.
	customerBook addCustomerNamed: 'John Lennon'.
	millisecondsAfterRunning := Time millisecondClockValue.
	
	self assert: (millisecondsAfterRunning-millisecondsBeforeRunning) < 50 
	"
! !

!IdiomTest methodsFor: 'testing' stamp: 'A 4/16/2018 14:13:23'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds
	|customerBook oneCustomer|
	
	oneCustomer := 'Paul McCartney'.
	customerBook  := CustomerBook  new.	
	
	self testDeTiempoConPrecondicion:[customerBook addCustomerNamed: oneCustomer] operacionAMedir:[customerBook removeCustomerNamed: oneCustomer] menorAEsteTiempo:100.

	"| customerBook millisecondsBeforeRunning millisecondsAfterRunning paulMcCartney |
	
	customerBook := CustomerBook  new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	  
	millisecondsBeforeRunning := Time millisecondClockValue.
	customerBook removeCustomerNamed: paulMcCartney.
	millisecondsAfterRunning := Time millisecondClockValue.
	
	self assert: (millisecondsAfterRunning-millisecondsBeforeRunning) < 100 
	
"! !

!IdiomTest methodsFor: 'testing' stamp: 'A 4/16/2018 14:15:48'!
test03CanNotAddACustomerWithEmptyName 
	|customerBook|
	
	customerBook  := CustomerBook  new.	

	self testDeFallaDe:	
		[customerBook addCustomerNamed: ''.
		self fail ]
	esperandoError: Error
	manteniendoLasCondiciones:
		[:anError | self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
		self assert: customerBook isEmpty ] 

"
	| customerBook |
			
	customerBook := CustomerBook new.

	[ customerBook addCustomerNamed: ''.
	self fail ]
		on: Error 
		do: [ :anError | 
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: customerBook isEmpty ]
		
		"! !

!IdiomTest methodsFor: 'testing' stamp: 'A 4/16/2018 14:16:02'!
test04CanNotRemoveAnInvalidCustomer
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	
	self testDeFallaDe:
		[customerBook removeCustomerNamed: 'Paul McCartney'.
		self fail ] 
	esperandoError: NotFound
	manteniendoLasCondiciones:
		[:anError | self assert: customerBook numberOfCustomers = 1.
		self assert: (customerBook includesCustomerNamed: johnLennon)] 
	
	"
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	[ customerBook removeCustomerNamed: 'Paul McCartney'.
	self fail ]
		on: NotFound 
		do: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ]
"! !


!IdiomTest methodsFor: 'Funciones Auxiliares' stamp: 'A 4/16/2018 14:14:59'!
testDeFallaDe:unClosure esperandoError: unError manteniendoLasCondiciones:otroClosure 
	
	unClosure 
	on: unError 
	do: otroClosure
	
	"
	[ customerBook removeCustomerNamed: 'Paul McCartney'.
	self fail ] class
		on: NotFound 
		do: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ]
"! !

!IdiomTest methodsFor: 'Funciones Auxiliares' stamp: 'A 4/16/2018 14:10:52'!
testDeTiempoConPrecondicion:unClosure operacionAMedir:OtroClosure menorAEsteTiempo:tiempo

	| millisecondsBeforeRunning millisecondsAfterRunning  |
	
	unClosure value. 
	millisecondsBeforeRunning := Time millisecondClockValue.
	OtroClosure value .
	millisecondsAfterRunning := Time millisecondClockValue.
	
	"customerBook addCustomerNamed: paulMcCartney.
	  
	millisecondsBeforeRunning := Time millisecondClockValue.
	customerBook removeCustomerNamed: paulMcCartney.
	millisecondsAfterRunning := Time millisecondClockValue.
	"
	self assert: (millisecondsAfterRunning-millisecondsBeforeRunning) < tiempo 
	! !


!classDefinition: #CustomerBook category: #'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'customers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'HernanWilkinson 7/6/2011 17:56'!
includesCustomerNamed: aName

	^customers includes: aName ! !

!CustomerBook methodsFor: 'testing' stamp: 'HernanWilkinson 7/6/2011 17:48'!
isEmpty
	
	^customers isEmpty  ! !


!CustomerBook methodsFor: 'initialization' stamp: 'HernanWilkinson 7/6/2011 17:42'!
initialize

	super initialize.
	customers := OrderedCollection new! !


!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:42'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	(customers includes: aName) ifTrue: [ self signalCustomerAlreadyExists ].
	
	customers add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:56'!
numberOfCustomers
	
	^customers size! !

!CustomerBook methodsFor: 'customer management' stamp: 'HAW 4/14/2017 16:55:43'!
removeCustomerNamed: aName
 
	customers remove: aName ifAbsent: [ NotFound signal ]! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: #'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'HernanWilkinson 7/6/2011 17:57'!
customerAlreadyExistsErrorMessage

	^'Customer already exists'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'HernanWilkinson 7/6/2011 17:53'!
customerCanNotBeEmptyErrorMessage

	^'Customer name cannot be empty'! !
