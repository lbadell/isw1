!classDefinition: #TicTacToeTest category: #TicTacToStep21!
TestCase subclass: #TicTacToeTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToStep21'!

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'A 5/29/2018 19:16:26'!
test01NewGameShouldHaveNoPlays
	| game |
	game _ TicTacToe new.
	self assert: game Xs isEmpty.
	self assert: game Os isEmpty.! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'A 5/29/2018 19:19:43'!
test02XPlaysShouldContainPositionsOfX
	| game |
	game _ TicTacToe new.
	game putXAt: 1 @ 1.
	self assert: 1 equals: game Xs size.
	self assert: (game Xs includes: 1 @ 1).
	self assert: game Os isEmpty.! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'A 5/29/2018 19:19:57'!
test03OPlaysShouldContainPositionsOfO
	| game |
	game _ TicTacToe new.
	game putXAt: 1 @ 1.
	game putOAt: 2 @ 2.
	self assert: 1 equals: game Xs size.
	self assert: (game Xs includes: 1 @ 1).
	self assert: 1 equals: game Os size.
	self assert: (game Os includes: 2 @ 2).! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'A 5/29/2018 19:21:22'!
test04XShouldNotBeAbleToPlayWhenItIsOTurn
	| game |
	game _ TicTacToe new.
	game putXAt: 1 @ 1.
	self
		should: [ game putXAt: 2 @ 2 ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self
				assert: TicTacToe notPlayersTurnErrorMessage
				equals: anError messageText.
			self
				assert: 1
				equals: game Xs size.
			self assert: (game Xs includes: 1 @ 1).
			self assert: game Os isEmpty ].! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'A 5/29/2018 19:21:56'!
test05OShouldNotBeAbleToPlayWhenItIsXTurn
	| game |
	game _ TicTacToe new.
	game putXAt: 1 @ 1.
	game putOAt: 2 @ 2.
	self
		should: [ game putOAt: 3 @ 3 ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self
				assert: TicTacToe notPlayersTurnErrorMessage
				equals: anError messageText.
			self
				assert: 1
				equals: game Xs size.
			self assert: (game Xs includes: 1 @ 1).
			self
				assert: 1
				equals: game Os size.
			self assert: (game Os includes: 2 @ 2) ].! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'A 5/29/2018 19:22:58'!
test06XShouldNotRepeatItsOldPlays
	| game |
	game _ TicTacToe new.
	game putXAt: 1 @ 1.
	game putOAt: 2 @ 2.
	self
		should: [ game putXAt: 1 @ 1 ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self
				assert: TicTacToe positionTakenErrorMessage
				equals: anError messageText.
			self
				assert: 1
				equals: game Xs size.
			self assert: (game Xs includes: 1 @ 1).
			self
				assert: 1
				equals: game Os size.
			self assert: (game Os includes: 2 @ 2) ].! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'A 5/29/2018 19:23:45'!
test07XShouldNotPlayInTheSamePositionOfAnyOPlays
	| game |
	game _ TicTacToe new.
	game putXAt: 1 @ 1.
	game putOAt: 2 @ 2.
	self
		should: [ game putXAt: 2 @ 2 ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self
				assert: TicTacToe positionTakenErrorMessage
				equals: anError messageText.
			self
				assert: 1
				equals: game Xs size.
			self assert: (game Xs includes: 1 @ 1).
			self
				assert: 1
				equals: game Os size.
			self assert: (game Os includes: 2 @ 2) ].! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'A 5/29/2018 19:24:24'!
test08OShouldNotPlayInTheSamePositionOfAnyXPlays
	| game |
	game _ TicTacToe new.
	game putXAt: 1 @ 1.
	self
		should: [ game putOAt: 1 @ 1 ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self
				assert: TicTacToe positionTakenErrorMessage
				equals: anError messageText.
			self
				assert: 1
				equals: game Xs size.
			self assert: (game Xs includes: 1 @ 1).
			self assert: game Os isEmpty ].! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'A 5/29/2018 19:24:54'!
test09OShouldNotRepeatItsOldPlays
	| game |
	game _ TicTacToe new.
	game putXAt: 1 @ 1.
	game putOAt: 2 @ 2.
	game putXAt: 3 @ 3.
	self
		should: [ game putOAt: 2 @ 2 ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self
				assert: TicTacToe positionTakenErrorMessage
				equals: anError messageText.
			self
				assert: 2
				equals: game Xs size.
			self assert: (game Xs includes: 1 @ 1).
			self assert: (game Xs includes: 3 @ 3).
			self
				assert: 1
				equals: game Os size.
			self assert: (game Os includes: 2 @ 2) ].! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'A 5/29/2018 19:26:05'!
test10GameShouldNotHaveAWinnerIfThereIsNotAWinningCombination
	| game |
	game _ TicTacToe new.
	game putXAt: 1 @ 1.
	game putOAt: 2 @ 1.
	game putXAt: 2 @ 2.
	game putOAt: 3 @ 3.
	self deny: game OHasWon.
	self deny: game XHasWon.! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'A 5/29/2018 19:28:48'!
test11XShouldWinIfItCompletedTheFirstRow
	| game |
	game _ TicTacToe new.
	game putXAt: 1 @ 1.
	game putOAt: 2 @ 1.
	game putXAt: 1 @ 2.
	game putOAt: 3 @ 3.
	game putXAt: 1 @ 3.
	self assert: game XHasWon.
	self deny: game OHasWon.! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'A 5/29/2018 19:29:11'!
test12XShouldWinIfItCompletedTheSecondRow
	| game |
	game _ TicTacToe new.
	game putXAt: 2 @ 1.
	game putOAt: 1 @ 1.
	game putXAt: 2 @ 2.
	game putOAt: 3 @ 1.
	game putXAt: 2 @ 3.
	self assert: game XHasWon.
	self deny: game OHasWon.! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'A 5/29/2018 19:29:58'!
test13XShouldWinIfItCompletedTheThirdRow
	| game |
	game _ TicTacToe new.
	game putXAt: 3 @ 1.
	game putOAt: 1 @ 1.
	game putXAt: 3 @ 2.
	game putOAt: 2 @ 1.
	game putXAt: 3 @ 3.
	self assert: game XHasWon.
	self deny: game OHasWon.! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'A 5/29/2018 19:30:30'!
test14XShouldWinIfItCompletedTheFirstColumn
	| game |
	game _ TicTacToe new.
	game putXAt: 1 @ 1.
	game putOAt: 2 @ 2.
	game putXAt: 2 @ 1.
	game putOAt: 3 @ 3.
	game putXAt: 3 @ 1.
	self assert: game XHasWon.
	self deny: game OHasWon.! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'A 5/29/2018 19:31:07'!
test15XShouldWinIfItCompletedTheForwardDiagonal
	| game |
	game _ TicTacToe new.
	game putXAt: 1 @ 1.
	game putOAt: 2 @ 1.
	game putXAt: 2 @ 2.
	game putOAt: 2 @ 3.
	game putXAt: 3 @ 3.
	self assert: game XHasWon.
	self deny: game OHasWon.! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'A 5/29/2018 19:31:32'!
test16XShouldWinIfItCompletedTheBackwardDiagonal
	| game |
	game _ TicTacToe new.
	game putXAt: 3 @ 1.
	game putOAt: 2 @ 1.
	game putXAt: 2 @ 2.
	game putOAt: 1 @ 2.
	game putXAt: 1 @ 3.
	self assert: game XHasWon.
	self deny: game OHasWon.! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'A 5/29/2018 19:32:28'!
test17OShouldWinIfItCompletedTheFirstRow
	| game |
	game _ TicTacToe new.
	game putXAt: 3 @ 1.
	game putOAt: 1 @ 1.
	game putXAt: 2 @ 2.
	game putOAt: 1 @ 2.
	game putXAt: 3 @ 3.
	game putOAt: 1 @ 3.
	self assert: game OHasWon.
	self deny: game XHasWon.! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'A 5/29/2018 19:34:05'!
test18OShouldNotPlayWhenXAlreadyWon
	| game |
	game _ TicTacToe new.
	game putXAt: 1 @ 1.
	game putOAt: 2 @ 1.
	game putXAt: 1 @ 2.
	game putOAt: 3 @ 1.
	game putXAt: 1 @ 3.
	self
		should: [ game putOAt: 3 @ 1 ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self
				assert: TicTacToe canNotPlayWhenGameIsOverErrorMessage
				equals: anError messageText.
			self
				assert: 2
				equals: game Os size.
			self assert: (game Os includes: 2 @ 1).
			self assert: (game Os includes: 3 @ 1) ].! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'A 5/29/2018 19:34:31'!
test19XShouldNotPlayWhenOAlreadyWon
	| game |
	game _ TicTacToe new.
	game putXAt: 2 @ 2.
	game putOAt: 1 @ 1.
	game putXAt: 2 @ 1.
	game putOAt: 1 @ 2.
	game putXAt: 3 @ 1.
	game putOAt: 1 @ 3.
	self
		should: [ game putXAt: 3 @ 2 ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self
				assert: TicTacToe canNotPlayWhenGameIsOverErrorMessage
				equals: anError messageText.
			self
				assert: 3
				equals: game Xs size.
			self assert: (game Xs includes: 2 @ 2).
			self assert: (game Xs includes: 2 @ 1).
			self assert: (game Xs includes: 3 @ 1) ].! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'A 5/29/2018 19:35:20'!
test20GameShouldBeTiedAndOverIfThereIsNoValidMoveToMake
	| game |
	game _ TicTacToe new.
	game putXAt: 2 @ 2.
	game putOAt: 1 @ 1.
	game putXAt: 1 @ 3.
	game putOAt: 3 @ 1.
	game putXAt: 2 @ 1.
	game putOAt: 2 @ 3.
	game putXAt: 1 @ 2.
	game putOAt: 3 @ 2.
	game putXAt: 3 @ 3.
	self assert: game isOver.
	self deny: game XHasWon.
	self deny: game OHasWon.
	self assert: game isTied.! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'A 5/29/2018 19:37:40'!
test21GameShouldBeOverButNotTiedIfPlayerWonTheGameWithTheLastValidMove
	| game |
	game _ TicTacToe new.
	game putXAt: 2 @ 2.
	game putOAt: 1 @ 2.
	game putXAt: 1 @ 1.
	game putOAt: 2 @ 1.
	game putXAt: 1 @ 3.
	game putOAt: 2 @ 3.
	game putXAt: 3 @ 2.
	game putOAt: 3 @ 1.
	game putXAt: 3 @ 3.
	self assert: game isOver.
	self assert: game XHasWon.
	self deny: game OHasWon.
	self deny: game isTied.! !


!classDefinition: #TicTacToe category: #TicTacToStep21!
Object subclass: #TicTacToe
	instanceVariableNames: 'os xs activePlayer playerX playerO status'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToStep21'!

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'A 5/29/2018 15:03:51'!
OHasWon
	
	^status playerHasWon: playerO.! !

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'jg 5/22/2018 10:01:34'!
Os

	^os copy.! !

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'A 5/29/2018 15:03:40'!
XHasWon
	
	^status playerHasWon: playerX.! !

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'jg 5/22/2018 10:01:25'!
Xs

	^xs copy.! !

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'jg 5/22/2018 12:51:23'!
hasCompletedColumn: positions
	
	^ (1 to: 3) anySatisfy: [ :y | (positions count: [ :position | position y = y ]) = 3 ]! !

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'jg 5/22/2018 12:36:01'!
hasCompletedRow: positions

	^ (1 to: 3) anySatisfy: [ :x | (positions count: [ :posicion | posicion x = x ]) = 3 ]! !

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'jg 5/22/2018 12:56:21'!
hasDownDiagonal: positions

	^(1 to: 3) allSatisfy: [ :n | positions includes: n@n ]
! !

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'jg 5/22/2018 13:02:13'!
hasUpDiagonal: positions

	^(1 to: 3) allSatisfy: [ :n | positions includes: n@(4-n) ]! !

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'jg 5/22/2018 13:01:53'!
hasWin: positions

	^(self hasCompletedRow: positions)
		or: [(self hasCompletedColumn: positions) 
				or: [(self hasDownDiagonal: positions)
					or: [(self hasUpDiagonal: positions)]]]


! !

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'A 5/29/2018 14:47:24'!
initialize
	
	xs:= Set new.
	os:= Set new.
	
	playerX _ TicTacToePlayerX playing: self.
	playerO _ TicTacToePlayerO playing: self.
	status _ TicTacToeOngoingStatus affecting: self.
	activePlayer _ playerX.! !

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'A 5/29/2018 15:04:05'!
isGameOver
	
	^status isGameOver.! !

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'jg 5/22/2018 15:07:08'!
isOver
	
	^self XHasWon or: [ self OHasWon or: [ self isTied ]]
! !

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'A 5/29/2018 15:04:15'!
isTied
	
	^xs size = 5 and: [ os size = 4 and: [ self XHasWon not ]]! !

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'A 5/28/2018 03:18:48'!
putOAt: aPosition
	activePlayer putOAt: aPosition.! !

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'A 5/28/2018 03:15:49'!
putXAt: aPosition
	activePlayer putXAt: aPosition.! !


!TicTacToe methodsFor: 'plays' stamp: 'A 5/29/2018 14:45:13'!
attempMoveWhenGameEnded: aMove
	self error: self class canNotPlayWhenGameIsOverErrorMessage.! !

!TicTacToe methodsFor: 'plays' stamp: 'A 5/29/2018 14:46:02'!
attempMoveWhenGameOngoing: aMove
	aMove value.! !

!TicTacToe methodsFor: 'plays' stamp: 'A 5/29/2018 15:03:14'!
player: aPlayer puts: aPosition into: positions
	status attempMove: [
		(xs includes: aPosition) ifTrue: [ self error: self class positionTakenErrorMessage ].
		(os includes: aPosition) ifTrue: [ self error: self class positionTakenErrorMessage ].
	
		positions add: aPosition.
		(self hasWin: positions) ifTrue: [status _ TicTacToeGameOverStatus affecting: self withWinner: aPlayer.].

		activePlayer _ aPlayer opponent.
	]! !

!TicTacToe methodsFor: 'plays' stamp: 'A 5/29/2018 13:06:18'!
playerOPutOAt: aPosition
	self player: playerO puts: aPosition into: os.! !

!TicTacToe methodsFor: 'plays' stamp: 'A 5/28/2018 02:59:00'!
playerOPutXAt: aPosition
	self error: self class notPlayersTurnErrorMessage.! !

!TicTacToe methodsFor: 'plays' stamp: 'A 5/28/2018 02:59:40'!
playerXPutOAt: aPosition
	self error: self class notPlayersTurnErrorMessage.! !

!TicTacToe methodsFor: 'plays' stamp: 'A 5/29/2018 13:04:36'!
playerXPutXAt: aPosition
	self player: playerX puts: aPosition into: xs.! !


!TicTacToe methodsFor: 'accessing' stamp: 'A 5/29/2018 13:08:49'!
opponentOfPlayerO
	^ playerX.! !

!TicTacToe methodsFor: 'accessing' stamp: 'A 5/29/2018 13:08:26'!
opponentOfPlayerX
	^ playerO.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TicTacToe class' category: #TicTacToStep21!
TicTacToe class
	instanceVariableNames: ''!

!TicTacToe class methodsFor: 'as yet unclassified' stamp: 'jg 5/22/2018 13:15:31'!
canNotPlayWhenGameIsOverErrorMessage
	
	^'Can not play when game is over'! !

!TicTacToe class methodsFor: 'as yet unclassified' stamp: 'A 5/28/2018 02:59:00'!
notPlayersTurnErrorMessage
	^ 'Not X turn'.! !

!TicTacToe class methodsFor: 'as yet unclassified' stamp: 'jg 5/22/2018 11:20:12'!
positionTakenErrorMessage
	
	^'Position taken'! !


!classDefinition: #TicTacToeGameStatus category: #TicTacToStep21!
Object subclass: #TicTacToeGameStatus
	instanceVariableNames: 'game'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToStep21'!

!TicTacToeGameStatus methodsFor: 'accessing' stamp: 'A 5/29/2018 13:27:04'!
isGameOver
	^self subclassResponsibility.! !

!TicTacToeGameStatus methodsFor: 'accessing' stamp: 'A 5/29/2018 15:00:13'!
playerHasWon: aPlayer
	^self subclassResponsibility.! !


!TicTacToeGameStatus methodsFor: 'plays' stamp: 'A 5/29/2018 14:24:07'!
attempMove: aMove
	^self subclassResponsibility.! !


!TicTacToeGameStatus methodsFor: 'initialization' stamp: 'A 5/29/2018 14:34:56'!
initializeWith: aGame
	game _ aGame.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TicTacToeGameStatus class' category: #TicTacToStep21!
TicTacToeGameStatus class
	instanceVariableNames: ''!

!TicTacToeGameStatus class methodsFor: 'instance creation' stamp: 'A 5/29/2018 14:34:34'!
affecting: aGame.
	^self new initializeWith: aGame.! !


!classDefinition: #TicTacToeGameOverStatus category: #TicTacToStep21!
TicTacToeGameStatus subclass: #TicTacToeGameOverStatus
	instanceVariableNames: 'winner'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToStep21'!

!TicTacToeGameOverStatus methodsFor: 'plays' stamp: 'A 5/29/2018 14:45:35'!
attempMove: aMove
	^game attempMoveWhenGameEnded: aMove! !


!TicTacToeGameOverStatus methodsFor: 'initialization' stamp: 'A 5/29/2018 14:59:10'!
initializeWithGame: aGame andPlayer: aPlayer
	game _ aGame.
	winner _ aPlayer.! !


!TicTacToeGameOverStatus methodsFor: 'accessing' stamp: 'A 5/29/2018 15:01:44'!
isGameOver
	^true! !

!TicTacToeGameOverStatus methodsFor: 'accessing' stamp: 'A 5/29/2018 15:01:10'!
playerHasWon: aPlayer
	^winner = aPlayer.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TicTacToeGameOverStatus class' category: #TicTacToStep21!
TicTacToeGameOverStatus class
	instanceVariableNames: ''!

!TicTacToeGameOverStatus class methodsFor: 'instance creation' stamp: 'A 5/29/2018 14:57:07'!
affecting: aGame withWinner: aPlayer
	^self new initializeWithGame: aGame andPlayer: aPlayer.! !


!classDefinition: #TicTacToeOngoingStatus category: #TicTacToStep21!
TicTacToeGameStatus subclass: #TicTacToeOngoingStatus
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToStep21'!

!TicTacToeOngoingStatus methodsFor: 'accessing' stamp: 'A 5/29/2018 13:30:24'!
isGameOver
	^false! !

!TicTacToeOngoingStatus methodsFor: 'accessing' stamp: 'A 5/29/2018 15:00:34'!
playerHasWon: aPlayer
	^false! !


!TicTacToeOngoingStatus methodsFor: 'plays' stamp: 'A 5/29/2018 14:45:49'!
attempMove: aMove
	^game attempMoveWhenGameOngoing: aMove.! !


!classDefinition: #TicTacToePlayer category: #TicTacToStep21!
Object subclass: #TicTacToePlayer
	instanceVariableNames: 'game'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToStep21'!

!TicTacToePlayer methodsFor: 'actions' stamp: 'A 5/28/2018 02:47:27'!
putOAt: aPosition
	^self subclassResponsibility .! !

!TicTacToePlayer methodsFor: 'actions' stamp: 'A 5/28/2018 02:47:32'!
putXAt: aPosition
	^self subclassResponsibility .! !


!TicTacToePlayer methodsFor: 'accessing' stamp: 'A 5/29/2018 12:59:23'!
opponent
	^self subclassResponsibility ! !


!TicTacToePlayer methodsFor: 'initialization' stamp: 'A 5/29/2018 14:35:51'!
initializeWith: aTicTacToeGame
	game _ aTicTacToeGame.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TicTacToePlayer class' category: #TicTacToStep21!
TicTacToePlayer class
	instanceVariableNames: ''!

!TicTacToePlayer class methodsFor: 'instance creation' stamp: 'A 5/28/2018 02:43:56'!
playing: aTicTacToeGame
	^self new initializeWith: aTicTacToeGame .! !



!classDefinition: #TicTacToePlayerO category: #TicTacToStep21!
TicTacToePlayer subclass: #TicTacToePlayerO
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToStep21'!

!TicTacToePlayerO methodsFor: 'actions' stamp: 'A 5/28/2018 02:52:54'!
putOAt: aPosition
	^game playerOPutOAt: aPosition.! !

!TicTacToePlayerO methodsFor: 'actions' stamp: 'A 5/28/2018 02:53:16'!
putXAt: aPosition
	^game playerOPutXAt: aPosition.! !


!TicTacToePlayerO methodsFor: 'accessing' stamp: 'A 5/29/2018 13:08:49'!
opponent
	^ game opponentOfPlayerO.! !


!classDefinition: #TicTacToePlayerX category: #TicTacToStep21!
TicTacToePlayer subclass: #TicTacToePlayerX
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToStep21'!

!TicTacToePlayerX methodsFor: 'actions' stamp: 'A 5/28/2018 02:53:59'!
putOAt: aPosition
	^game playerXPutOAt: aPosition.! !

!TicTacToePlayerX methodsFor: 'actions' stamp: 'A 5/28/2018 02:54:06'!
putXAt: aPosition
	^game playerXPutXAt: aPosition.! !


!TicTacToePlayerX methodsFor: 'accessing' stamp: 'A 5/29/2018 13:08:26'!
opponent
	^ game opponentOfPlayerX.! !
