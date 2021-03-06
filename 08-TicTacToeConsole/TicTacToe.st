!classDefinition: #TicTacToeTest category: #TicTacToe!
TestCase subclass: #TicTacToeTest
	instanceVariableNames: 'game'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 10/27/2017 17:25:54'!
functionalException

	^Error - MessageNotUnderstood! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 10/26/2017 15:10:54'!
test01GameStartsWithAnEmptyBoarAndPlayingX

	"I initialize it on each test and not in the setUp to facilitate the restar of the test - Hernan"
	
	game _ TicTacToe new.

	self assertXIsMarkedOn: {} andOOn: {}.
	self assertIsPlayingX.
	
	! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:43:35'!
test02AfterMarkingWithXGameKeepsMarkAndNextPlayerIsO

	game _ TicTacToe new.
	
	game markAll: {1@1}.

	self assertXIsMarkedOn: {1@1} andOOn: {}.
	self assertIsPlayingO

! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:43:31'!
test03AfterMarkingWithOGameKeepsMarkAndNextPlayerIsY

	game _ TicTacToe new.

	game markAll: { 1 @ 1. 2 @ 2 }.

	self assertXIsMarkedOn: {1@1} andOOn: {2@2}.
	self assertIsPlayingX.

! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:43:28'!
test04CanNotMarkWithXWhenLastMarkWasX

	game _ TicTacToe new.
	
	game markAll: { 1@1 }.

	self
		should: [ game markWithXAt: 2 @ 2 ]
		raise: self functionalException
		withExceptionDo: [ :anError |
			self assert: TicTacToe notXTurnErrorMessage equals: anError messageText.
			self assertXIsMarkedOn: {1@1} andOOn: {} ].! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:43:23'!
test05CanNotMarkWithOWhenLastMarkWasO

	game _ TicTacToe new.

	game markAll: {1@1. 2@2 }.

	self
		should: [ game markWithOAt: 3 @ 3 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: TicTacToe notOTurnErrorMessage equals: anError messageText.
			self assertXIsMarkedOn: {1@1} andOOn: {2@2} ].! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:43:19'!
test06CanNotMarkWithXAnAlreadyMarkedPositionWithX

	game _ TicTacToe new.

	game markAll: {1@1. 2@2 }.

	self
		should: [ game markWithXAt: 1 @ 1 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: TicTacToe positionTakenErrorMessage equals: anError messageText.
			self assertXIsMarkedOn: {1@1} andOOn: {2@2} ].! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:43:16'!
test07CanNotMarkWithXAnAlreadyMarkedPositionWithO

	game _ TicTacToe new.

	game markAll: {1@1. 2@2 }.

	self
		should: [ game markWithXAt: 2 @ 2 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: TicTacToe positionTakenErrorMessage equals: anError messageText.
			self assertXIsMarkedOn: {1@1} andOOn: {2@2} ].! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:43:12'!
test08CanNotMarkWithOAnAlreadyMarkedPositionWithX

	game _ TicTacToe new.
	
	game markAll: { 1@1 }.
	
	self
		should: [ game markWithOAt: 1 @ 1 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: TicTacToe positionTakenErrorMessage equals: anError messageText.
			self assertXIsMarkedOn: {1@1} andOOn: {} ].! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:43:08'!
test09CanNotMarkWithOAnAlreadyMarkedPositionWithO

	game _ TicTacToe new.

	game markAll: {1@1. 2@2. 3@3 }.

	self
		should: [ game markWithOAt: 2 @ 2 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: TicTacToe positionTakenErrorMessage equals: anError messageText.
			self assertXIsMarkedOn: {1@1. 3@3} andOOn: {2@2} ].! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:43:04'!
test10XWinsWhenCompletesRowNumber1

	game _ TicTacToe new.

	game markAll: {1@1. 2@1. 1@2. 3@1. 1@3 }.
	
	self assertXWon.
	! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:42:59'!
test11XWinsWhenCompletesRowNumber2

	game _ TicTacToe new.

	game markAll: {2@1. 1@1. 2@2. 3@1. 2@3 }.

	self assertXWon ! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:42:54'!
test12XWinsWhenCompletesRowNumber3

	game _ TicTacToe new.

	game markAll: {3@1. 1@1. 3@2. 2@1. 3@3 }.

	self assertXWon ! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:42:50'!
test13XWinsWhenCompletesAColumn

	game _ TicTacToe new.

	game markAll: { 1@1. 2@2. 1@2. 3@3. 1@3}.

	self assertXWon ! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:42:45'!
test14XWinsWhenCompletesDiagonalGoingDown

	game _ TicTacToe new.

	game markAll: { 1@1. 1@2. 2@2. 1@3. 3@3 }.

	self assertXWon ! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:42:41'!
test15XWinsWhenCompletesDiagonalGoingUp

	game _ TicTacToe new.

	game markAll: { 1@3. 1@2. 2@2. 2@1. 3@ 1 }.

	self assertXWon ! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:42:35'!
test16OWinsWhenCompletesARow

	game _ TicTacToe new.

	game markAll: {2@1. 1@1. 2@2. 1@2. 3@1. 1@3 }.

	self assertOWon! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:42:31'!
test17OWinsWhenCompletesAColumn

	game _ TicTacToe new.

	game markAll: { 2@2. 1@1. 3@3. 1@2. 2@3. 1@3 }.

	self assertOWon! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:42:25'!
test18OWinsWhenCompletesDiagonalGoingDown

	game _ TicTacToe new.

	game markAll: { 3@2. 1@3. 1@2. 2@2. 1@1. 3@1 }.

	self assertOWon ! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:42:20'!
test19OWinsWhenCompletesDiagonalGoingUp

	game _ TicTacToe new.

	game markAll: {1@2. 1@1. 1@3. 2@2. 2@1. 3@3 }.

	self assertOWon ! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:42:15'!
test20OCanNotPlayWhenXWon

	game _ TicTacToe new.

	game markAll: { 1@1. 2@1. 1@2. 3@1. 1@3 }.
	
	self
		should: [ game markWithOAt: 3 @ 1 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: TicTacToe canNotPlayWhenGameIsOverErrorMessage equals: anError messageText.
			self assertOIsMarkedOn: {2@1. 3@1} ].! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:42:12'!
test21XCanNotPlayWhenOWon

	game _ TicTacToe new.

	game markAll: { 2@2. 1@1. 2@1. 1@2. 3@1. 1@3 }.

	self
		should: [ game markWithXAt: 3 @ 2 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: TicTacToe canNotPlayWhenGameIsOverErrorMessage equals: anError messageText.
			self assertXIsMarkedOn: { 2@2. 2@1. 3@1 } ]
		! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:42:08'!
test22GameCanEndUpTied

	game _ TicTacToe new.

	game markAll: { 2@2. 1@1. 1@3. 3@1. 2@1. 2@3. 1@2. 3@2. 3@3 }.

	self assertGameIsTied! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:42:01'!
test23XCanWinOnLastEmptyPosition

	game _ TicTacToe new.

	game markAll: { 2@2. 1@2. 1@1. 2@1. 1@3. 2@3. 3@2. 3@1. 3@3 }.

	self assertXWon ! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:41:58'!
test24CanNotPlayWhenGameIsTied

	game _ TicTacToe new.

	game markAll: { 2@2. 1@1. 1@3. 3@1. 2@1. 2@3. 1@2. 3@2. 3@3 }.

	self
		should: [ game markWithOAt: 1 @ 1 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: TicTacToe canNotPlayWhenGameIsOverErrorMessage equals: anError messageText ].! !

!TicTacToeTest methodsFor: 'testing' stamp: 'JG 5/12/2018 13:23:11'!
test25CanNotMarkOutsideBoard

	game _ TicTacToe new.

	#(0 4) do: [ :aPositionComponent |
		self assertCanNotMarkAt: aPositionComponent @ 1.
		self assertCanNotMarkAt: 1 @ aPositionComponent ].
	! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:49:43'!
test26OCanNotMarkWhenGameIsOver

	game _ TicTacToe new.

	game markAll: { 1@1. 2@1. 1@2. 3@1. 1@3 }.
	
	self
		should: [ game markAt: 3 @ 1 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: TicTacToe canNotPlayWhenGameIsOverErrorMessage equals: anError messageText.
			self assertOIsMarkedOn: {2@1. 3@1} ].! !


!TicTacToeTest methodsFor: 'assertions' stamp: 'HAW 10/27/2017 10:29:06'!
assertCanNotMarkAt: aPosition

	self assertCanNotMarkUsing: [ game markWithXAt: aPosition ].
	self assertCanNotMarkUsing: [ game markWithOAt: aPosition ].
	
	! !

!TicTacToeTest methodsFor: 'assertions' stamp: 'HAW 10/27/2017 10:29:29'!
assertCanNotMarkUsing: aMarkingClosure

	self
		should: aMarkingClosure 
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: TicTacToe positionOutsideBoardErrorMessage equals: anError messageText.
			self assertXIsMarkedOn: {} andOOn: {} ].! !

!TicTacToeTest methodsFor: 'assertions' stamp: 'HAW 10/26/2017 15:11:14'!
assertGameIsNotOver

	self deny: game isOver.
	self deny: game hasPlayerXWon.
	self deny: game hasPlayerOWon.
	self deny: game isTied.	! !

!TicTacToeTest methodsFor: 'assertions' stamp: 'HAW 10/26/2017 15:23:48'!
assertGameIsOver
	
	self assert: game isOver.

	self deny: game isPlayingX.
	self deny: game isPlayingO.
		
! !

!TicTacToeTest methodsFor: 'assertions' stamp: 'HAW 10/26/2017 15:40:41'!
assertGameIsTied

	self assertGameIsOver.
	
	self deny: game hasPlayerXWon.
	self deny: game hasPlayerOWon.
	self assert: game isTied.
! !

!TicTacToeTest methodsFor: 'assertions' stamp: 'HAW 10/26/2017 15:13:05'!
assertIsPlayingO
	
	self deny: game isPlayingX.
	self assert: game isPlayingO.
	self assertGameIsNotOver ! !

!TicTacToeTest methodsFor: 'assertions' stamp: 'HAW 10/26/2017 15:11:05'!
assertIsPlayingX
		
	self assert: game isPlayingX.
	self deny: game isPlayingO.
	self assertGameIsNotOver.
	! !

!TicTacToeTest methodsFor: 'assertions' stamp: 'HAW 10/26/2017 15:38:07'!
assertOIsMarkedOn: oPositions
		
	self assert: oPositions size equals: game playerOPositions size.
	self assert: (game playerOPositions difference: oPositions) isEmpty.
! !

!TicTacToeTest methodsFor: 'assertions' stamp: 'HAW 10/26/2017 15:32:18'!
assertOWon

	self assertGameIsOver.
	
	self deny: game hasPlayerXWon.
	self assert: game hasPlayerOWon.
	self deny: game isTied.
! !

!TicTacToeTest methodsFor: 'assertions' stamp: 'HAW 10/26/2017 15:37:56'!
assertXIsMarkedOn: xPositions

	self assert: xPositions size equals: game playerXPositions size.
	self assert: (game playerXPositions difference: xPositions) isEmpty.
	! !

!TicTacToeTest methodsFor: 'assertions' stamp: 'HAW 10/26/2017 15:37:44'!
assertXIsMarkedOn: xPositions andOOn: oPositions
 
	self assertXIsMarkedOn: xPositions.
	self assertOIsMarkedOn: oPositions.
	! !

!TicTacToeTest methodsFor: 'assertions' stamp: 'HAW 10/26/2017 15:23:30'!
assertXWon
	
	self assertGameIsOver.
	
	self assert: game hasPlayerXWon.
	self deny: game hasPlayerOWon.
	self deny: game isTied.
! !


!classDefinition: #TicTacToeWatcherTest category: #TicTacToe!
TestCase subclass: #TicTacToeWatcherTest
	instanceVariableNames: 'state playerOPositions playerXPositions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!TicTacToeWatcherTest methodsFor: 'as yet unclassified' stamp: 'A 6/1/2018 16:27:10'!
test01NewConsoleShouldContainAnEmptyLog

	| tictactoe  console |.
	tictactoe _ TicTacToe new .
	console _ TicTacToeConsole watching:tictactoe .
	
	self assert: console showLog = ''
	! !

!TicTacToeWatcherTest methodsFor: 'as yet unclassified' stamp: 'A 6/1/2018 16:29:18'!
test02ConsoleShouldLogWhenXMakesAPlayAndThatItsOsTrun
	| tictactoe console |
	self.
	tictactoe _ TicTacToe new.
	console _ TicTacToeConsole watching: tictactoe.
	tictactoe markWithXAt: 1 @ 1.
	self assert: console showLog = 
'X marco en 1@1
Estado: Jugando O'.! !

!TicTacToeWatcherTest methodsFor: 'as yet unclassified' stamp: 'A 6/1/2018 16:30:38'!
test03ConsoleShouldLogAnyXPlay

	| tictactoe  console |.
	tictactoe _ TicTacToe new .
	console _ TicTacToeConsole watching:tictactoe .
	tictactoe markWithXAt: 2@2.
	
	
	self assert: console showLog = 
'X marco en 2@2
Estado: Jugando O'
	 
	! !

!TicTacToeWatcherTest methodsFor: 'as yet unclassified' stamp: 'A 6/1/2018 16:31:15'!
test04ConsoleShouldLogAnyOPlayAndThatItsXsTurn

	| tictactoe  console |.
	tictactoe _ TicTacToe new .
	console _ TicTacToeConsole watching:tictactoe .
	tictactoe markWithXAt: 2@2.
	tictactoe markWithOAt: 1@1.
	

	self assert: console showLog = 
'X marco en 2@2
Estado: Jugando O
O marco en 1@1
Estado: Jugando X'
	 
	! !

!TicTacToeWatcherTest methodsFor: 'as yet unclassified' stamp: 'A 6/1/2018 16:31:56'!
test05ConsoleShouldLogWhenXWonTheGame

	| tictactoe  console |.
	tictactoe _ TicTacToe new .
	console _ TicTacToeConsole watching:tictactoe .
	tictactoe markWithXAt: 2@2.
	tictactoe markWithOAt: 1@1.
	tictactoe markWithXAt: 1@3.
	tictactoe markWithOAt: 1@2.
	tictactoe markWithXAt: 3@1.	
	

	self assert: console showLog = 
'X marco en 2@2
Estado: Jugando O
O marco en 1@1
Estado: Jugando X
X marco en 1@3
Estado: Jugando O
O marco en 1@2
Estado: Jugando X
X marco en 3@1
Estado: Juego terminado - Gan� X!!'
	 
	! !

!TicTacToeWatcherTest methodsFor: 'as yet unclassified' stamp: 'A 6/1/2018 16:32:14'!
test06ConsoleShouldLogWhenOWonTheGame

	| tictactoe  console |.
	tictactoe _ TicTacToe new .
	console _ TicTacToeConsole watching:tictactoe .
	tictactoe markWithXAt: 2@2.
	tictactoe markWithOAt: 1@1.
	tictactoe markWithXAt: 1@2.
	tictactoe markWithOAt: 2@1.
	tictactoe markWithXAt: 3@3.	
	tictactoe markWithOAt: 3@1.
	

	self assert: console showLog = 
'X marco en 2@2
Estado: Jugando O
O marco en 1@1
Estado: Jugando X
X marco en 1@2
Estado: Jugando O
O marco en 2@1
Estado: Jugando X
X marco en 3@3
Estado: Jugando O
O marco en 3@1
Estado: Juego terminado - Gan� O!!'
	 
	! !

!TicTacToeWatcherTest methodsFor: 'as yet unclassified' stamp: 'A 6/1/2018 16:32:43'!
test07ConsoleShouldLogWhenGameIsTied

	| tictactoe  console |.
	tictactoe _ TicTacToe new .
	console _ TicTacToeConsole watching:tictactoe .
	tictactoe markWithXAt: 1@1.
	tictactoe markWithOAt: 2@2.
	tictactoe markWithXAt: 1@2.
	tictactoe markWithOAt: 1@3.
	tictactoe markWithXAt: 3@1.	
	tictactoe markWithOAt: 2@1.
	tictactoe markWithXAt: 2@3.	
	tictactoe markWithOAt: 3@3.
	tictactoe markWithXAt: 3@2.
	

	self assert: console showLog = 
'X marco en 1@1
Estado: Jugando O
O marco en 2@2
Estado: Jugando X
X marco en 1@2
Estado: Jugando O
O marco en 1@3
Estado: Jugando X
X marco en 3@1
Estado: Jugando O
O marco en 2@1
Estado: Jugando X
X marco en 2@3
Estado: Jugando O
O marco en 3@3
Estado: Jugando X
X marco en 3@2
Estado: Juego terminado - Empate!!'
	 
	! !

!TicTacToeWatcherTest methodsFor: 'as yet unclassified' stamp: 'A 6/1/2018 16:34:05'!
test08TwoConsolesCanStillLogWhileWatchingTheSameGame

	| tictactoe  console console2|.
	tictactoe _ TicTacToe new .
	console _ TicTacToeConsole watching: tictactoe .
	tictactoe markWithXAt: 1@1.
	console2 _ TicTacToeConsole watching: tictactoe .
	tictactoe markWithOAt: 1@2.
	
	self deny: console showLog = console2 showLog.
	self assert: console2 showLog = 
'O marco en 1@2
Estado: Jugando X'.
	self assert: console showLog = 
'X marco en 1@1
Estado: Jugando O
O marco en 1@2
Estado: Jugando X'
	 
	! !

!TicTacToeWatcherTest methodsFor: 'as yet unclassified' stamp: 'A 6/1/2018 16:34:34'!
test09ViewShouldShowAnEmptyBoardWhenWatchingANewGame

	| tictactoe view |.
	tictactoe _ TicTacToe new .
	view _ TicTacToeView watching: tictactoe.

	self assert: view showBoard = 
'  |  |  
------
  |  |  
------
  |  |  
Playing X'! !

!TicTacToeWatcherTest methodsFor: 'as yet unclassified' stamp: 'A 6/1/2018 16:35:29'!
test10ViewShouldShowWhenXMovesAndChangeItsStateToPlayingO

	| tictactoe view |.
	tictactoe _ TicTacToe new .
	view _ TicTacToeView watching: tictactoe.
	tictactoe markWithXAt: 1@1.

	self assert: view showBoard = 
'X|  |  
------
  |  |  
------
  |  |  
Playing O'! !

!TicTacToeWatcherTest methodsFor: 'as yet unclassified' stamp: 'A 6/1/2018 16:36:18'!
test11ViewShouldShowWhenOMovesAndChangeItsStateToPlayingX

	| tictactoe view |.
	tictactoe _ TicTacToe new .
	view _ TicTacToeView watching: tictactoe.
	tictactoe markWithXAt: 2@2.
	tictactoe markWithOAt: 1@1.

	self assert: view showBoard = 
'O|  |  
------
  |X|  
------
  |  |  
Playing X'! !

!TicTacToeWatcherTest methodsFor: 'as yet unclassified' stamp: 'A 6/1/2018 16:37:24'!
test12ViewShouldCorrectlyDisplayEachSymbolIntoThePositionTheyWerePlayed

	| tictactoe view |.
	tictactoe _ TicTacToe new .
	view _ TicTacToeView watching: tictactoe.
	tictactoe markWithXAt: 2@2.
	tictactoe markWithOAt: 1@1.
	tictactoe markWithXAt: 3@1.
	self assert: view showBoard = 
'O|  |  
------
  |X|  
------
X|  |  
Playing O'! !

!TicTacToeWatcherTest methodsFor: 'as yet unclassified' stamp: 'A 6/1/2018 16:38:21'!
test13ViewsStateShouldShowThatXWonWhenTheGameWasWonByX

	| tictactoe view |.
	tictactoe _ TicTacToe new .
	view _ TicTacToeView watching: tictactoe.
	tictactoe markWithXAt: 2@2.
	tictactoe markWithOAt: 1@1.
	tictactoe markWithXAt: 1@3.
	tictactoe markWithOAt: 1@2.
	tictactoe markWithXAt: 3@1.	
	
	self assert: view showBoard = 
'O|O|X
------
  |X|  
------
X|  |  
X Won!!'! !

!TicTacToeWatcherTest methodsFor: 'as yet unclassified' stamp: 'A 6/1/2018 16:38:45'!
test14ViewsStateShouldShowThatOWonWhenTheGameWasWonByO

	| tictactoe view |.
	tictactoe _ TicTacToe new .
	view _ TicTacToeView watching: tictactoe.
	tictactoe markWithXAt: 2@2.
	tictactoe markWithOAt: 1@1.
	tictactoe markWithXAt: 3@1.
	tictactoe markWithOAt: 1@2.
	tictactoe markWithXAt: 3@2.	
	tictactoe markWithOAt: 1@3.
	
	self assert: view showBoard = 
'O|O|O
------
  |X|  
------
X|X|  
O Won!!'! !

!TicTacToeWatcherTest methodsFor: 'as yet unclassified' stamp: 'A 6/1/2018 16:39:08'!
test15ViewStateShouldShowThatGameIsTiedWhenGameIsTied

	| tictactoe view |.
	tictactoe _ TicTacToe new .
	view _ TicTacToeView watching: tictactoe.
	tictactoe markWithXAt: 1@1.
	tictactoe markWithOAt: 2@2.
	tictactoe markWithXAt: 1@2.
	tictactoe markWithOAt: 1@3.
	tictactoe markWithXAt: 3@1.	
	tictactoe markWithOAt: 2@1.
	tictactoe markWithXAt: 2@3.	
	tictactoe markWithOAt: 3@3.
	tictactoe markWithXAt: 3@2.
	
	self assert: view showBoard = 
'X|X|O
------
O|O|X
------
X|X|O
Game Tied!!'! !

!TicTacToeWatcherTest methodsFor: 'as yet unclassified' stamp: 'A 6/1/2018 16:40:11'!
test16TwoViewsShouldShowTheSameBoardNoMatterWhenTheyStartedWatchingAGame

	| tictactoe view view2 |.
	tictactoe _ TicTacToe new .
	
	view _ TicTacToeView watching: tictactoe.
	tictactoe markWithXAt: 2@2.
	tictactoe markWithOAt: 1@1.
	view2 _ TicTacToeView watching: tictactoe.

	self assert: view showBoard = view2 showBoard.
	self assert: view2 showBoard = 
'O|  |  
------
  |X|  
------
  |  |  
Playing X'! !

!TicTacToeWatcherTest methodsFor: 'as yet unclassified' stamp: 'A 6/1/2018 16:41:06'!
test17TwoViewsShouldShowTheSameStateNoMatterWhenTheyStartedWatchingAGame

	| tictactoe view view2 |.
	tictactoe _ TicTacToe new .
	
	view _ TicTacToeView watching: tictactoe.
	tictactoe markWithXAt: 2@2.
	view2 _ TicTacToeView watching: tictactoe.

	self assert: view showBoard = view2 showBoard.
	self assert: view2 showBoard = 
'  |  |  
------
  |X|  
------
  |  |  
Playing O'! !


!classDefinition: #TicTacToe category: #TicTacToe!
Object subclass: #TicTacToe
	instanceVariableNames: 'state playerOPositions playerXPositions watchers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!TicTacToe methodsFor: 'initialization' stamp: 'A 6/1/2018 03:18:48'!
addWatcher:aWatcher

	watchers add: aWatcher.
	aWatcher initializeState: state.! !

!TicTacToe methodsFor: 'initialization' stamp: 'A 6/1/2018 01:45:48'!
initialize
	playerXPositions _ OrderedCollection new.
	playerOPositions _ OrderedCollection new.
	state _ PlayingX for: self.
	watchers _ OrderedCollection new.! !


!TicTacToe methodsFor: 'marking board' stamp: 'HAW 5/31/2018 18:49:39'!
markAll: positions

	positions do: [ :aPosition | self markAt: aPosition ]! !

!TicTacToe methodsFor: 'marking board' stamp: 'HAW 5/31/2018 18:49:23'!
markAt: aPosition

	^state markAt: aPosition ! !

!TicTacToe methodsFor: 'marking board' stamp: 'ABC 5/31/2018 20:16:16'!
markWithOAt: aPosition

	self assertIsInBoardBounds: aPosition.
	
	state markWithOAt: aPosition.
	
! !

!TicTacToe methodsFor: 'marking board' stamp: 'ABC 5/31/2018 20:03:32'!
markWithXAt: aPosition

	self assertIsInBoardBounds: aPosition.
	
	state markWithXAt: aPosition.
	
	
	
	
	! !


!TicTacToe methodsFor: 'marking board - private' stamp: 'A 6/1/2018 01:46:46'!
add: aPosition to: positions nextPlayerState: nextPlayingState winnerState: winnerState

	positions add: aPosition.
	state := (self stateAfterAddingTo: positions with: nextPlayingState and: winnerState) for: self.
	watchers do: [:aWatcher | aWatcher changedState: state].	! !

!TicTacToe methodsFor: 'marking board - private' stamp: 'HAW 10/25/2017 15:35:08'!
assertIsFree: aPosition

	(self isTaken: aPosition) ifTrue: [ self error: self class positionTakenErrorMessage ].
! !

!TicTacToe methodsFor: 'marking board - private' stamp: 'HAW 10/27/2017 10:26:10'!
assertIsInBoardBounds: aPosition

	(aPosition between: 1@1 and: 3@3) ifFalse: [ self error: self class positionOutsideBoardErrorMessage ]! !

!TicTacToe methodsFor: 'marking board - private' stamp: 'A 6/1/2018 01:50:52'!
markWithOWhenPlayingOAt: aPosition
	self assertIsFree: aPosition.
	watchers do: [:aWatcher | aWatcher putOAt: aPosition].	
	self
		add: aPosition
		to: playerOPositions
		nextPlayerState: PlayingX
		winnerState: PlayerOWon.
	! !

!TicTacToe methodsFor: 'marking board - private' stamp: 'HAW 10/26/2017 12:30:01'!
markWithOWhenPlayingXAt: aPosition
	self error: self class notOTurnErrorMessage.! !

!TicTacToe methodsFor: 'marking board - private' stamp: 'HAW 10/26/2017 12:30:32'!
markWithXWhenPlayingOAt: aPoint
	self error: self class notXTurnErrorMessage.! !

!TicTacToe methodsFor: 'marking board - private' stamp: 'A 6/1/2018 01:50:41'!
markWithXWhenPlayingXAt: aPosition
	self assertIsFree: aPosition.
	watchers do: [:aWatcher | aWatcher putXAt: aPosition].	
	self
		add: aPosition
		to: playerXPositions
		nextPlayerState: PlayingO
		winnerState: PlayerXWon.! !

!TicTacToe methodsFor: 'marking board - private' stamp: 'ABC 5/31/2018 20:48:45'!
stateAfterAddingTo: positions with: nextPlayingState and: winnerState

	(self hasWin: positions) ifTrue: [^ winnerState  ].
	self shouldBeTiedWhenNoOneWon ifTrue: [ ^ GameTied ].

	^ nextPlayingState.! !


!TicTacToe methodsFor: 'testing game result' stamp: 'HAW 10/25/2017 16:14:31'!
hasPlayerOWon
	^ state hasPlayerOWon.! !

!TicTacToe methodsFor: 'testing game result' stamp: 'HAW 10/25/2017 15:51:46'!
hasPlayerXWon
	^ state hasPlayerXWon.! !

!TicTacToe methodsFor: 'testing game result' stamp: 'HAW 10/25/2017 13:32:14'!
isOver
	
	^state isOver! !

!TicTacToe methodsFor: 'testing game result' stamp: 'HAW 10/25/2017 15:24:01'!
isTied
	
	^ state isTied! !


!TicTacToe methodsFor: 'testing playing turn' stamp: 'HAW 10/25/2017 16:17:38'!
isPlayingO
	
	^state isPlayingO! !

!TicTacToe methodsFor: 'testing playing turn' stamp: 'HAW 10/25/2017 16:17:14'!
isPlayingX
	
	^state isPlayingX ! !


!TicTacToe methodsFor: 'testing board positions' stamp: 'HAW 10/25/2017 15:50:52'!
isTaken: aPosition
	^ (playerXPositions includes: aPosition) or: [ playerOPositions includes: aPosition ].! !


!TicTacToe methodsFor: 'positions' stamp: 'HAW 10/25/2017 15:56:16'!
playerOPositions
	^ playerOPositions copy.! !

!TicTacToe methodsFor: 'positions' stamp: 'HAW 10/25/2017 15:56:32'!
playerXPositions
	^ playerXPositions copy.! !


!TicTacToe methodsFor: 'game over testing - private' stamp: 'HAW 10/26/2017 12:22:42'!
has: positions threeOf: aPositionComponent

	^(positions collect: aPositionComponent) asBag contents values includes: 3 
	! !

!TicTacToe methodsFor: 'game over testing - private' stamp: 'HAW 10/25/2017 16:09:34'!
hasCompletedColumn: positions
	
	^self has: positions threeOf: [ :aPosition | aPosition x ]
	
	! !

!TicTacToe methodsFor: 'game over testing - private' stamp: 'HAW 10/26/2017 12:25:55'!
hasCompletedDiagonal: positions 
	
	^(self hasUpDiagonal: positions) or: [self hasDownDiagonal: positions]! !

!TicTacToe methodsFor: 'game over testing - private' stamp: 'HAW 10/25/2017 16:10:47'!
hasCompletedLine: positions
	
	^self has: positions threeOf: [ :aPosition | aPosition y ]
! !

!TicTacToe methodsFor: 'game over testing - private' stamp: 'HAW 5/31/2018 00:25:48'!
hasCompletedStraightLine: positions
	
	^(self hasCompletedColumn: positions) or: [self hasCompletedLine: positions ]! !

!TicTacToe methodsFor: 'game over testing - private' stamp: 'HAW 10/24/2017 17:12:48'!
hasDownDiagonal: positions

	^(1 to: 3) allSatisfy: [ :n | positions includes: n@(4-n) ]! !

!TicTacToe methodsFor: 'game over testing - private' stamp: 'HAW 10/24/2017 17:12:48'!
hasUpDiagonal: positions
	
	^(1 to: 3) allSatisfy: [ :n | positions includes: n@n ]! !

!TicTacToe methodsFor: 'game over testing - private' stamp: 'HAW 10/26/2017 12:26:17'!
hasWin: positions

	^positions size >= 3 and: [ (self hasCompletedStraightLine: positions) or: [ self hasCompletedDiagonal: positions ]].
		
	! !

!TicTacToe methodsFor: 'game over testing - private' stamp: 'HAW 10/26/2017 12:44:42'!
shouldBeTiedWhenNoOneWon

	^ playerXPositions size = 5 and: [ playerOPositions size = 4 ].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TicTacToe class' category: #TicTacToe!
TicTacToe class
	instanceVariableNames: ''!

!TicTacToe class methodsFor: 'as yet unclassified' stamp: 'HAW 10/24/2017 17:12:48'!
canNotPlayWhenGameIsOverErrorMessage
	
	^'Can not play when game is over'! !

!TicTacToe class methodsFor: 'as yet unclassified' stamp: 'HAW 10/24/2017 17:12:48'!
notOTurnErrorMessage
	
	^'Not O''s turn'! !

!TicTacToe class methodsFor: 'as yet unclassified' stamp: 'HAW 10/24/2017 17:12:48'!
notXTurnErrorMessage
	
	^'Not X''s turn'! !

!TicTacToe class methodsFor: 'as yet unclassified' stamp: 'HAW 10/27/2017 10:26:31'!
positionOutsideBoardErrorMessage
	
	^'Position is outside board'! !

!TicTacToe class methodsFor: 'as yet unclassified' stamp: 'HAW 10/24/2017 17:12:48'!
positionTakenErrorMessage
	
	^'Position taken'! !


!classDefinition: #TicTacToeState category: #TicTacToe!
Object subclass: #TicTacToeState
	instanceVariableNames: 'game'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!TicTacToeState methodsFor: 'testing game result' stamp: 'HAW 10/26/2017 12:28:07'!
hasPlayerOWon
	
	self subclassResponsibility! !

!TicTacToeState methodsFor: 'testing game result' stamp: 'HAW 10/26/2017 12:28:07'!
hasPlayerXWon
	
	self subclassResponsibility! !

!TicTacToeState methodsFor: 'testing game result' stamp: 'HAW 10/26/2017 12:28:07'!
isOver
	
	self subclassResponsibility! !

!TicTacToeState methodsFor: 'testing game result' stamp: 'HAW 10/26/2017 12:28:07'!
isTied
	
	self subclassResponsibility! !


!TicTacToeState methodsFor: 'testing playing turn' stamp: 'HAW 10/26/2017 12:28:07'!
isPlayingO
	
	self subclassResponsibility! !

!TicTacToeState methodsFor: 'testing playing turn' stamp: 'HAW 10/26/2017 12:28:07'!
isPlayingX
	
	self subclassResponsibility! !


!TicTacToeState methodsFor: 'marking board' stamp: 'HAW 5/31/2018 18:49:31'!
markAt: aPosition

	self subclassResponsibility ! !

!TicTacToeState methodsFor: 'marking board' stamp: 'HAW 10/26/2017 12:29:25'!
markWithOAt: aPosition
	self subclassResponsibility.! !

!TicTacToeState methodsFor: 'marking board' stamp: 'HAW 10/26/2017 12:30:16'!
markWithXAt: aPosition
	self subclassResponsibility.! !


!TicTacToeState methodsFor: 'initialization' stamp: 'HAW 10/25/2017 13:05:13'!
initializeFor: aGame

	game := aGame ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TicTacToeState class' category: #TicTacToe!
TicTacToeState class
	instanceVariableNames: ''!

!TicTacToeState class methodsFor: 'as yet unclassified' stamp: 'HAW 10/25/2017 13:05:29'!
for: aTicTacToe 
	
	^self new initializeFor: aTicTacToe ! !


!classDefinition: #GameOverState category: #TicTacToe!
TicTacToeState subclass: #GameOverState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!GameOverState methodsFor: 'testing game result' stamp: 'A 6/1/2018 01:39:43'!
accept: aVisitor
	^self subclassResponsibility.! !

!GameOverState methodsFor: 'testing game result' stamp: 'HAW 10/26/2017 11:53:57'!
isOver
	
	^true! !


!GameOverState methodsFor: 'testing playing turn' stamp: 'HAW 10/26/2017 12:05:23'!
isPlayingO
	
	^false! !

!GameOverState methodsFor: 'testing playing turn' stamp: 'HAW 10/26/2017 12:05:27'!
isPlayingX
	
	^false! !


!GameOverState methodsFor: 'marking board' stamp: 'HAW 5/31/2018 18:49:09'!
markAt: aPosition

	game error: game class canNotPlayWhenGameIsOverErrorMessage.! !

!GameOverState methodsFor: 'marking board' stamp: 'HAW 10/26/2017 12:29:25'!
markWithOAt: aPosition
	game error: game class canNotPlayWhenGameIsOverErrorMessage.! !

!GameOverState methodsFor: 'marking board' stamp: 'HAW 10/26/2017 12:30:16'!
markWithXAt: aPosition
	game error: game class canNotPlayWhenGameIsOverErrorMessage.! !


!classDefinition: #GameTied category: #TicTacToe!
GameOverState subclass: #GameTied
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!GameTied methodsFor: 'testing game result' stamp: 'A 6/1/2018 01:33:47'!
accept: aVisitor
	aVisitor visitGameTied.! !

!GameTied methodsFor: 'testing game result' stamp: 'HAW 10/25/2017 16:14:31'!
hasPlayerOWon
	^ false.! !

!GameTied methodsFor: 'testing game result' stamp: 'HAW 10/25/2017 15:51:46'!
hasPlayerXWon
	^ false.! !

!GameTied methodsFor: 'testing game result' stamp: 'HAW 10/25/2017 15:24:49'!
isTied
	
	^true! !


!classDefinition: #PlayerOWon category: #TicTacToe!
GameOverState subclass: #PlayerOWon
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!PlayerOWon methodsFor: 'testing game result' stamp: 'A 6/1/2018 01:17:53'!
accept: aVisitor
	^ aVisitor visitPlayerOWon.! !

!PlayerOWon methodsFor: 'testing game result' stamp: 'HAW 10/25/2017 16:14:31'!
hasPlayerOWon
	^ true.! !

!PlayerOWon methodsFor: 'testing game result' stamp: 'HAW 10/25/2017 15:51:46'!
hasPlayerXWon
	^ false.! !

!PlayerOWon methodsFor: 'testing game result' stamp: 'HAW 10/26/2017 12:06:24'!
isTied
	
	^false! !


!classDefinition: #PlayerXWon category: #TicTacToe!
GameOverState subclass: #PlayerXWon
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!PlayerXWon methodsFor: 'testing game result' stamp: 'A 6/1/2018 01:16:15'!
accept: aVisitor
	^ aVisitor visitPlayerXWon.! !

!PlayerXWon methodsFor: 'testing game result' stamp: 'HAW 10/25/2017 16:14:31'!
hasPlayerOWon
	^ false.! !

!PlayerXWon methodsFor: 'testing game result' stamp: 'HAW 10/25/2017 15:51:46'!
hasPlayerXWon
	^ true.! !

!PlayerXWon methodsFor: 'testing game result' stamp: 'HAW 10/25/2017 15:25:44'!
isTied
	
	^false! !


!classDefinition: #PlayingState category: #TicTacToe!
TicTacToeState subclass: #PlayingState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!PlayingState methodsFor: 'testing game result' stamp: 'A 6/1/2018 01:39:35'!
accept: aVisitor
	^self subclassResponsibility.! !

!PlayingState methodsFor: 'testing game result' stamp: 'HAW 10/26/2017 12:07:10'!
hasPlayerOWon
	^ false.! !

!PlayingState methodsFor: 'testing game result' stamp: 'HAW 10/26/2017 12:07:17'!
hasPlayerXWon
	^ false.! !

!PlayingState methodsFor: 'testing game result' stamp: 'HAW 10/26/2017 12:07:26'!
isOver
	
	^false! !

!PlayingState methodsFor: 'testing game result' stamp: 'HAW 10/26/2017 12:07:52'!
isTied
	
	^false! !


!classDefinition: #PlayingO category: #TicTacToe!
PlayingState subclass: #PlayingO
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!PlayingO methodsFor: 'testing playing turn' stamp: 'HAW 10/25/2017 16:18:36'!
isPlayingO
	
	^true! !

!PlayingO methodsFor: 'testing playing turn' stamp: 'HAW 10/25/2017 16:18:27'!
isPlayingX
	
	^false! !


!PlayingO methodsFor: 'marking board' stamp: 'A 6/1/2018 01:15:02'!
accept: aVisitor
	^ aVisitor visitPlayingO.! !

!PlayingO methodsFor: 'marking board' stamp: 'HAW 5/31/2018 18:49:13'!
markAt: aPosition

	^game markWithOAt: aPosition ! !

!PlayingO methodsFor: 'marking board' stamp: 'HAW 10/26/2017 12:29:45'!
markWithOAt: aPosition
	game markWithOWhenPlayingOAt: aPosition.! !

!PlayingO methodsFor: 'marking board' stamp: 'HAW 10/26/2017 12:30:32'!
markWithXAt: aPosition
	game markWithXWhenPlayingOAt: aPosition.! !


!classDefinition: #PlayingX category: #TicTacToe!
PlayingState subclass: #PlayingX
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!PlayingX methodsFor: 'testing playing turn' stamp: 'HAW 10/25/2017 16:17:50'!
isPlayingO
	
	^false! !

!PlayingX methodsFor: 'testing playing turn' stamp: 'HAW 10/25/2017 16:17:23'!
isPlayingX
	
	^true! !


!PlayingX methodsFor: 'marking board' stamp: 'A 6/1/2018 01:14:39'!
accept: aVisitor
	^ aVisitor visitPlayingX.! !

!PlayingX methodsFor: 'marking board' stamp: 'HAW 5/31/2018 18:49:17'!
markAt: aPosition

	^game markWithXAt: aPosition ! !

!PlayingX methodsFor: 'marking board' stamp: 'HAW 10/26/2017 12:30:01'!
markWithOAt: aPosition
	game markWithOWhenPlayingXAt: aPosition.! !

!PlayingX methodsFor: 'marking board' stamp: 'HAW 10/26/2017 12:30:46'!
markWithXAt: aPosition
	game markWithXWhenPlayingXAt: aPosition.! !


!classDefinition: #TicTacToeWatcher category: #TicTacToe!
Object subclass: #TicTacToeWatcher
	instanceVariableNames: 'game'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!TicTacToeWatcher methodsFor: 'initialization' stamp: 'A 6/1/2018 16:21:20'!
initializeState: aState
	^self subclassResponsibility.! !

!TicTacToeWatcher methodsFor: 'initialization' stamp: 'A 6/1/2018 16:20:57'!
initializeWith: aTicTacToeGame
	^self subclassResponsibility .! !


!TicTacToeWatcher methodsFor: 'events' stamp: 'A 6/1/2018 16:21:58'!
changedState: aState
	^self subclassResponsibility.! !

!TicTacToeWatcher methodsFor: 'events' stamp: 'A 6/1/2018 16:23:04'!
putOAt: aPosition
	^ self subclassResponsibility.! !

!TicTacToeWatcher methodsFor: 'events' stamp: 'A 6/1/2018 16:23:01'!
putXAt: aPosition
	^ self subclassResponsibility.! !

!TicTacToeWatcher methodsFor: 'events' stamp: 'A 6/1/2018 16:22:43'!
visitGameTied
	^self subclassResponsibility.! !

!TicTacToeWatcher methodsFor: 'events' stamp: 'A 6/1/2018 16:22:34'!
visitPlayerOWon
	^self subclassResponsibility.! !

!TicTacToeWatcher methodsFor: 'events' stamp: 'A 6/1/2018 16:22:31'!
visitPlayerXWon
	^self subclassResponsibility.! !

!TicTacToeWatcher methodsFor: 'events' stamp: 'A 6/1/2018 16:22:15'!
visitPlayingX
	^self subclassResponsibility.! !

!TicTacToeWatcher methodsFor: 'events' stamp: 'A 6/1/2018 16:22:20'!
visitPlayingY
	^self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TicTacToeWatcher class' category: #TicTacToe!
TicTacToeWatcher class
	instanceVariableNames: ''!

!TicTacToeWatcher class methodsFor: 'instance creation' stamp: 'A 6/1/2018 16:23:46'!
watching: aTicTacToe 
	^ self new initializeWith: aTicTacToe.! !


!classDefinition: #TicTacToeConsole category: #TicTacToe!
TicTacToeWatcher subclass: #TicTacToeConsole
	instanceVariableNames: 'log'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!TicTacToeConsole methodsFor: 'accessing' stamp: 'A 6/1/2018 00:59:53'!
showLog

	^ (log inject: '' into: [:result :aLine | result,String newLineString, aLine]) withBlanksTrimmed.! !


!TicTacToeConsole methodsFor: 'initialization' stamp: 'A 6/1/2018 03:20:47'!
initializeState: aState! !

!TicTacToeConsole methodsFor: 'initialization' stamp: 'A 6/1/2018 00:58:25'!
initializeWith: aTicTacToe 
	game _ aTicTacToe .
	log _ OrderedCollection new.
	game addWatcher: self.! !


!TicTacToeConsole methodsFor: 'events' stamp: 'A 6/1/2018 01:18:22'!
changedState: aState

	^ aState accept: self .! !

!TicTacToeConsole methodsFor: 'events' stamp: 'A 6/1/2018 01:19:13'!
putOAt: aPosition
	^ self appendToLog: 'O marco en ', aPosition printString .! !

!TicTacToeConsole methodsFor: 'events' stamp: 'A 6/1/2018 01:19:08'!
putXAt: aPosition
	^ self appendToLog: 'X marco en ', aPosition printString .! !

!TicTacToeConsole methodsFor: 'events' stamp: 'A 6/1/2018 01:37:50'!
visitGameTied
	^self appendToLog: 'Estado: Juego terminado - Empate!!'.! !

!TicTacToeConsole methodsFor: 'events' stamp: 'A 6/1/2018 01:16:54'!
visitPlayerOWon
	^ self appendToLog: 'Estado: Juego terminado - Gan� O!!'.! !

!TicTacToeConsole methodsFor: 'events' stamp: 'A 6/1/2018 01:17:33'!
visitPlayerXWon
	^ self appendToLog: 'Estado: Juego terminado - Gan� X!!'.! !

!TicTacToeConsole methodsFor: 'events' stamp: 'A 6/1/2018 01:19:04'!
visitPlayingO
	^self appendToLog: 'Estado: Jugando O'.! !

!TicTacToeConsole methodsFor: 'events' stamp: 'A 6/1/2018 01:19:00'!
visitPlayingX
	^self appendToLog: 'Estado: Jugando X'.! !


!TicTacToeConsole methodsFor: 'interactions' stamp: 'A 6/1/2018 00:58:41'!
appendToLog:aLine
	log add: aLine.! !


!classDefinition: #TicTacToeView category: #TicTacToe!
TicTacToeWatcher subclass: #TicTacToeView
	instanceVariableNames: 'board state'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!TicTacToeView methodsFor: 'initialization' stamp: 'A 6/1/2018 03:19:42'!
initializeState: aState
	self changedState: aState.! !

!TicTacToeView methodsFor: 'initialization' stamp: 'A 6/1/2018 03:27:11'!
initializeWith: aTicTacToe 
	game _ aTicTacToe.
	board _ OrderedCollection new.
	state _ 'Playing X'.

	9 timesRepeat: [board add: '  '].
	game playerXPositions do: [:anXPosition | self putXAt: anXPosition].
	game playerOPositions do: [:anOPosition | self putOAt: anOPosition].
	game addWatcher: self.! !


!TicTacToeView methodsFor: 'accessing' stamp: 'A 6/1/2018 02:56:32'!
printRow: aRowNumber
	| rowOffset |
	rowOffset _ 3 * (aRowNumber - 1).
	^ (board at: (rowOffset + 1)), '|', (board at: (rowOffset + 2)), '|', (board at: (rowOffset +3)).
	! !

!TicTacToeView methodsFor: 'accessing' stamp: 'A 6/1/2018 02:43:37'!
showBoard
	| newLine result|
	newLine _ String newLineString.
	result _  (self printRow: 1), newLine,
					'------',		   newLine,
			   (self printRow: 2), newLine,
					'------',		   newLine,
			   (self printRow: 3), newLine.
	^ result, state! !


!TicTacToeView methodsFor: 'events' stamp: 'A 6/1/2018 02:49:01'!
changedState: aState
	^ aState accept: self.! !

!TicTacToeView methodsFor: 'events' stamp: 'A 6/1/2018 03:02:38'!
putOAt: aPosition
	self put: 'O' at: aPosition.! !

!TicTacToeView methodsFor: 'events' stamp: 'A 6/1/2018 03:02:06'!
putXAt: aPosition
	self put: 'X' at: aPosition.! !

!TicTacToeView methodsFor: 'events' stamp: 'A 6/1/2018 03:11:16'!
visitGameTied
	state _ 'Game Tied!!'.! !

!TicTacToeView methodsFor: 'events' stamp: 'A 6/1/2018 03:08:56'!
visitPlayerOWon
	state _ 'O Won!!'.! !

!TicTacToeView methodsFor: 'events' stamp: 'A 6/1/2018 03:06:55'!
visitPlayerXWon
	state _ 'X Won!!'.! !

!TicTacToeView methodsFor: 'events' stamp: 'A 6/1/2018 02:49:39'!
visitPlayingO
	state _ 'Playing O'.! !

!TicTacToeView methodsFor: 'events' stamp: 'A 6/1/2018 03:03:40'!
visitPlayingX
	state _ 'Playing X'.! !


!TicTacToeView methodsFor: 'private' stamp: 'A 6/1/2018 03:02:16'!
put: aString at: aPosition
	board
		at: aPosition x - 1 * 3 + aPosition y
		put: aString.! !
