!classDefinition: #TicTaeToeTest category: #TicTacToe!
TestCase subclass: #TicTaeToeTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!TicTaeToeTest methodsFor: 'as yet unclassified' stamp: 'L 5/24/2018 19:27:04'!
test01

	|game |.
	game _ TicTacToe new .
	
	self assert: game xs isEmpty .
	self assert: game os isEmpty .
	
	
	
	! !

!TicTaeToeTest methodsFor: 'as yet unclassified' stamp: 'L 5/24/2018 19:51:20'!
test02

	|game |.
	game _ TicTacToe new .
	
	game markWithXAt: 2@2.
	
	self assert: (game xs includes: 2@2).
	
	
	! !

!TicTaeToeTest methodsFor: 'as yet unclassified' stamp: 'L 5/24/2018 19:54:41'!
test03

	|game |.
	game _ TicTacToe new .
	
	game markWithXAt: 2@2.
	
	self assert: (game xs includes: 2@2).
	
	
	! !

!TicTaeToeTest methodsFor: 'as yet unclassified' stamp: 'L 5/24/2018 20:07:59'!
test06

	|game |.
	game _ TicTacToe new .
	
	game markWithXAt: 1@1.
	game markWithOAt: 2@2.
	
	self
	should: [game markWithXAt: 1@1]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [:anError |
		self assert: TicTacToe positionTakenErrorMessage equals: anError messageText.
		self assert: 1 equals: game xs size .
		self assert: 1 equals: game os size.
		self assert: (game xs includes: 1@1).
		self assert: (game os includes: 2@2).
	
	
	.
		
		 
	
	
	]! !

!TicTaeToeTest methodsFor: 'as yet unclassified' stamp: 'L 5/24/2018 20:16:27'!
test07

	|game |.
	game _ TicTacToe new .
	
	game markWithXAt: 1@1.
	game markWithOAt: 2@2.
	
	self
	should: [game markWithXAt: 2@2]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [:anError |
		self assert: TicTacToe positionTakenErrorMessage equals: anError messageText.
		self assert: 1 equals: game xs size .
		self assert: 1 equals: game os size.
		self assert: (game xs includes: 1@1).
		self assert: (game os includes: 2@2).
	
	
	.
		
		 
	
	
	]! !

!TicTaeToeTest methodsFor: 'as yet unclassified' stamp: 'L 5/24/2018 20:20:10'!
test08

	|game |.
	game _ TicTacToe new .
	
	game markWithXAt: 1@1.

	
	self
	should: [game markWithOAt: 1@1]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [:anError |
		self assert: TicTacToe positionTakenErrorMessage equals: anError messageText.
		self assert: 1 equals: game xs size .

		self assert: (game xs includes: 1@1).

	
	
	.
		
		 
	
	
	]! !

!TicTaeToeTest methodsFor: 'as yet unclassified' stamp: 'L 5/24/2018 21:25:11'!
test10

	|game |.
	game _ TicTacToe new .
	
	game markWithXAt: 1@1.
	game markWithOAt: 2@1.
	game markWithXAt: 2@2.
	game markWithOAt: 3@3.
	
	self deny: game OHasWon.
	self deny: game XHasWon.! !

!TicTaeToeTest methodsFor: 'as yet unclassified' stamp: 'L 5/24/2018 20:46:12'!
test11

	|game |.
	game _ TicTacToe new .
	
	game markWithXAt: 1@1.
	game markWithOAt: 2@1.
	game markWithXAt: 1@2.
	game markWithOAt: 3@3.
	game markWithXAt: 1@3.	
	self assert: game XHasWon.
	self deny: game OHasWon.! !

!TicTaeToeTest methodsFor: 'as yet unclassified' stamp: 'L 5/24/2018 21:02:41'!
test14

	|game |.
	game _ TicTacToe new .
	
	game markWithXAt: 1@1.
	game markWithOAt: 2@2.
	game markWithXAt: 2@1.
	game markWithOAt: 3@3.
	game markWithXAt: 3@1.	
	self assert: game XHasWon.
	self deny: game OHasWon.! !

!TicTaeToeTest methodsFor: 'as yet unclassified' stamp: 'L 5/24/2018 21:14:53'!
test15

	|game |.
	game _ TicTacToe new .
	
	game markWithXAt: 1@1.
	game markWithOAt: 1@2.
	game markWithXAt: 2@2.
	game markWithOAt: 1@3.
	game markWithXAt: 3@3.	
	self assert: game XHasWon.
	self deny: game OHasWon.! !

!TicTaeToeTest methodsFor: 'as yet unclassified' stamp: 'L 5/24/2018 21:27:32'!
test16

	|game |.
	game _ TicTacToe new .
	
	game markWithXAt: 1@3.
	game markWithOAt: 1@2.
	game markWithXAt: 2@2.
	game markWithOAt: 2@3.
	game markWithXAt: 3@1.	
	self assert: game XHasWon.
	self deny: game OHasWon.! !

!TicTaeToeTest methodsFor: 'as yet unclassified' stamp: 'L 5/24/2018 21:30:20'!
test18

	|game |.
	game _ TicTacToe new .
	
	game markWithXAt: 1@3.
	game markWithOAt: 2@1.
	game markWithXAt: 1@2.
	game markWithOAt: 2@3.
	game markWithXAt: 3@1.	
	game markWithXAt: 1@3.
	self assert: game XHasWon.
	self deny: game OHasWon.! !


!classDefinition: #TicTacToe category: #TicTacToe!
Object subclass: #TicTacToe
	instanceVariableNames: 'os xs turn winner'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'L 5/24/2018 21:26:20'!
checkXWinnerWith:aPosition

	[ self  hasCompleteRow: xs.] value ifTrue: [winner _ #X].
	[ self  hasCompleteCol: xs.] value ifTrue: [winner _ #X].
	[ self  hasCompleteForwardDiagonal: xs.] value ifTrue: [winner _ #X].
	[ self  hasCompleteDownwardDiagonal: xs.] value ifTrue: [winner _ #X].
	
	

	

	


	


! !

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'L 5/24/2018 21:10:55'!
hasCompleteCol:positions

	^ (1 to:3) anySatisfy: [:y | (positions count: [:position | position y = y]) = 3 ]! !

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'L 5/24/2018 21:25:58'!
hasCompleteDownwardDiagonal:positions

	

	^ (1 to:3) allSatisfy: [:y | positions includes: y@(4-y)] ! !

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'L 5/24/2018 21:22:54'!
hasCompleteForwardDiagonal:positions

	

	^ (1 to:3) allSatisfy: [:y | positions includes: y@y] ! !

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'L 5/24/2018 21:05:50'!
hasCompleteRow:positions

	^ (1 to:3) anySatisfy: [:x | (positions count: [:position | position x = x]) = 3 ]! !

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'L 5/24/2018 20:21:08'!
initialize

	xs _ Set new.
	os _ Set new.
	turn _ #X! !

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'L 5/24/2018 21:34:56'!
isOver
	^ winner = #X or: [winner = #Y] or: [self isTied].! !

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'L 5/24/2018 21:41:13'!
isTied

	^ (xs size + os size = 9) or:[(winner = nil) not]! !

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'L 5/24/2018 20:26:03'!
markWithOAt:aPosition

	(turn = #X) ifTrue: [^ self error: TicTacToe wrongTurnErrorMessage].

	(xs includes: aPosition ) ifTrue: [^ self error: TicTacToe  positionTakenErrorMessage].
	(os includes: aPosition ) ifTrue: [^ self error: TicTacToe  positionTakenErrorMessage].


	os add: aPosition .
	turn _ #X .

! !

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'L 5/24/2018 20:39:25'!
markWithXAt:aPosition

	(xs includes: aPosition ) ifTrue: [^ self error: TicTacToe  positionTakenErrorMessage].
	(os includes: aPosition ) ifTrue: [^ self error: TicTacToe  positionTakenErrorMessage].

	
	xs add: aPosition .
	self checkXWinnerWith:aPosition .
	
	turn _ #O.

! !

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'L 5/24/2018 19:26:55'!
os

	^ os.! !

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'L 5/24/2018 19:23:48'!
xs

	^ xs.! !



!TicTacToe methodsFor: 'accessing' stamp: 'L 5/24/2018 20:33:17'!
OHasWon
	^ winner = #O.! !

!TicTacToe methodsFor: 'accessing' stamp: 'L 5/24/2018 20:50:08'!
XHasWon
	^ winner = #X.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TicTacToe class' category: #TicTacToe!
TicTacToe class
	instanceVariableNames: ''!

!TicTacToe class methodsFor: 'New' stamp: 'L 5/24/2018 21:32:57'!
canNotPlayWhenGameIsOver

	^ 'Termino el juego'.! !

!TicTacToe class methodsFor: 'New' stamp: 'L 5/24/2018 20:13:00'!
positionTakenErrorMessage

	^ 'Mensaje Choto '.! !

!TicTacToe class methodsFor: 'New' stamp: 'L 5/24/2018 20:24:41'!
wrongTurnErrorMessage

	^ 'Mensaje Choto '.! !
