!classDefinition: #MarsRoverTests category: 'Mars-Rover'!
TestCase subclass: #MarsRoverTests
	instanceVariableNames: 'norte sur este oeste'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars-Rover'!

!MarsRoverTests methodsFor: 'creation' stamp: 'IS 5/31/2022 22:33:53'!
test01MarsRoverPositionWhenCreatedIsTheSamePosition
	| marsRover |
	marsRover := MarsRover at: 0@0 facing: norte.
	self assert: marsRover position equals: 0@0.! !

!MarsRoverTests methodsFor: 'creation' stamp: 'MS 6/2/2022 14:58:28'!
test02MarsRoverDirectionWhenCreatedIsTheSameDirection
	| marsRover |
	marsRover := MarsRover at: 0@0 facing: norte.
	self assert: marsRover direction equals: norte.! !

!MarsRoverTests methodsFor: 'creation' stamp: 'IS 5/31/2022 22:34:13'!
test03MarsRoverPositionWhenCreatedIsTheSamePosition
	| marsRover |
	marsRover := MarsRover at: 0@1 facing: norte.
	self assert: marsRover position equals: 0@1.! !

!MarsRoverTests methodsFor: 'creation' stamp: 'IS 5/31/2022 22:34:36'!
test04MarsRoverDirectionWhenCreatedIsTheSameDirection
	| marsRover |
	marsRover := MarsRover at: 0@0 facing: este.
	self assert: marsRover direction equals: este.! !


!MarsRoverTests methodsFor: 'valid command executing' stamp: 'MS 6/2/2022 14:59:27'!
test05MarsRoverPositionIncreasesTowardsCurrentDirectionWhenGoingForward
	| marsRover |
	marsRover := MarsRover at: 0@0 facing: este.
	self sendCommands: 'f' to: marsRover andAssertPositionIs: (1@0) andDirectionIs: este.! !

!MarsRoverTests methodsFor: 'valid command executing' stamp: 'MS 6/2/2022 14:59:45'!
test06MarsRoverFacingEastWhenRotatingLeftChangesToFaceNorth
	| marsRover |
	marsRover := MarsRover at: 0@0 facing: este.
	
	self sendCommands: 'l' to: marsRover andAssertPositionIs: (0@0) andDirectionIs: norte.! !

!MarsRoverTests methodsFor: 'valid command executing' stamp: 'MS 6/2/2022 15:00:17'!
test07MarsRoverFacingNorthWhenRotatingLeftChangesToFaceWest
	| marsRover |
	marsRover := MarsRover at: 0@0 facing: norte.
	self sendCommands: 'l' to: marsRover andAssertPositionIs: (0@0) andDirectionIs: oeste.! !

!MarsRoverTests methodsFor: 'valid command executing' stamp: 'MS 6/2/2022 15:00:34'!
test08MarsRoverFacingNorthWhenRotatingRightChangesToFaceEast
	| marsRover |
	marsRover := MarsRover at: 0@0 facing: norte.
	self sendCommands: 'r' to: marsRover andAssertPositionIs: (0@0) andDirectionIs: este.! !

!MarsRoverTests methodsFor: 'valid command executing' stamp: 'MS 6/2/2022 15:00:39'!
test09MarsRoverCanRotateRightTwoTimesAndFacesTheOppositeDirection
	| marsRover |
	marsRover := MarsRover at: 0@0 facing: sur.
	self sendCommands: 'rr' to: marsRover andAssertPositionIs: (0@0) andDirectionIs: norte.! !

!MarsRoverTests methodsFor: 'valid command executing' stamp: 'MS 6/2/2022 15:01:22'!
test10MarsRoverCanRotateAndGoForward
	| marsRover |
	marsRover := MarsRover at: 0@0 facing: sur.	
	self sendCommands: 'rf' to: marsRover andAssertPositionIs: (-1@0) andDirectionIs: oeste.! !



!MarsRoverTests methodsFor: 'initialization' stamp: 'IS 5/31/2022 23:00:33'!
setUp
	norte := North new.
	sur := South new.
	este := East new.
	oeste := West new.
				! !


!MarsRoverTests methodsFor: 'private' stamp: 'MS 6/2/2022 14:56:21'!
sendCommands: aStringOfCommands to: aMarsRover andAssertPositionIs: aPosition andDirectionIs: aMarsRoverDirection 
	
	aMarsRover executeCommands: aStringOfCommands.
	
	self assert: aMarsRover position equals: aPosition.
	self assert: aMarsRover direction equals: aMarsRoverDirection.! !


!MarsRoverTests methodsFor: 'invalid command executing' stamp: 'MS 5/31/2022 23:20:41'!
test11MarsRoverStopsExecutionWhenReceivingInvalidCommand
	| marsRover |
	marsRover := MarsRover at: 0@0 facing: sur.
	
	self
		should: [ marsRover executeCommands: 'fbxb'. ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = MarsRover invalidCommandErrorDescription ].
		
	self assert: marsRover position equals: 0@0.! !


!classDefinition: #MarsRover category: 'Mars-Rover'!
Object subclass: #MarsRover
	instanceVariableNames: 'position direction'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars-Rover'!

!MarsRover methodsFor: 'initialization' stamp: 'IS 5/31/2022 21:57:03'!
direction
	^direction! !

!MarsRover methodsFor: 'initialization' stamp: 'IS 5/31/2022 21:57:03'!
initializeAt: aPoint facing: aSymbol 
	position := aPoint.
	direction := aSymbol.! !

!MarsRover methodsFor: 'initialization' stamp: 'IS 5/31/2022 21:55:03'!
position
	^position! !


!MarsRover methodsFor: 'error handling' stamp: 'IS 5/31/2022 23:09:44'!
assertValidCommand: aCharacter 
	^({ $f. $b. $l. $r } includes: aCharacter) ifFalse: [
		self error: self class invalidCommandErrorDescription 	
	]! !


!MarsRover methodsFor: 'private' stamp: 'MS 6/2/2022 15:05:31'!
executeCommand: aCharacter 
	(aCharacter = $f) ifTrue: [ self goForward ].
	(aCharacter = $b) ifTrue: [ self goBackwards ].
	(aCharacter = $l) ifTrue: [ 		self rotateLeft	 ].
	(aCharacter = $r) ifTrue: [ 		self rotateRight. 	 ].! !

!MarsRover methodsFor: 'private' stamp: 'IS 5/31/2022 22:48:04'!
goBackwards

	^ position := position + direction backwards! !

!MarsRover methodsFor: 'private' stamp: 'IS 5/31/2022 22:49:27'!
goForward
	^ position := position + direction forward! !

!MarsRover methodsFor: 'private' stamp: 'MS 6/2/2022 15:04:54'!
rotateLeft

	^ direction := direction left! !

!MarsRover methodsFor: 'private' stamp: 'MS 6/2/2022 15:05:04'!
rotateRight

	^ direction := direction right! !


!MarsRover methodsFor: 'command execution' stamp: 'IS 5/31/2022 23:04:24'!
executeCommands: aString 
	aString asOrderedCollection do: [ :command |
		self assertValidCommand: command.
		self executeCommand: command.	
	].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'Mars-Rover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'instance creation' stamp: 'IS 5/31/2022 21:47:23'!
at: aPoint facing: aSymbol 
	^self new initializeAt: aPoint facing: aSymbol ! !


!MarsRover class methodsFor: 'error descriptions' stamp: 'IS 5/31/2022 23:03:24'!
invalidCommandErrorDescription
	^'Invalid command submitted'
	! !


!classDefinition: #MarsRoverDirection category: 'Mars-Rover'!
Object subclass: #MarsRoverDirection
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars-Rover'!

!MarsRoverDirection methodsFor: 'accessing' stamp: 'IS 5/31/2022 22:49:07'!
backwards
	^self forward * -1! !

!MarsRoverDirection methodsFor: 'accessing' stamp: 'IS 5/31/2022 22:49:06'!
forward
	self subclassResponsibility ! !

!MarsRoverDirection methodsFor: 'accessing' stamp: 'IS 5/31/2022 22:41:43'!
left
	self subclassResponsibility ! !

!MarsRoverDirection methodsFor: 'accessing' stamp: 'IS 5/31/2022 22:42:14'!
right
	self subclassResponsibility ! !


!MarsRoverDirection methodsFor: 'comparing' stamp: 'IS 5/31/2022 22:37:09'!
= anotherDirection
	^self class = anotherDirection class! !


!classDefinition: #East category: 'Mars-Rover'!
MarsRoverDirection subclass: #East
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars-Rover'!

!East methodsFor: 'accessing' stamp: 'IS 5/31/2022 22:49:06'!
forward
	^1@0! !

!East methodsFor: 'accessing' stamp: 'IS 5/31/2022 23:00:22'!
left
	^North new! !

!East methodsFor: 'accessing' stamp: 'IS 5/31/2022 23:00:33'!
right
	^South new! !


!classDefinition: #North category: 'Mars-Rover'!
MarsRoverDirection subclass: #North
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars-Rover'!

!North methodsFor: 'accessing' stamp: 'IS 5/31/2022 22:49:06'!
forward
	^0@1! !

!North methodsFor: 'accessing' stamp: 'IS 5/31/2022 23:00:26'!
left
	^West new! !

!North methodsFor: 'accessing' stamp: 'IS 5/31/2022 23:00:10'!
right
	^East new! !


!classDefinition: #South category: 'Mars-Rover'!
MarsRoverDirection subclass: #South
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars-Rover'!

!South methodsFor: 'accessing' stamp: 'IS 5/31/2022 22:49:07'!
forward
	^0@-1! !

!South methodsFor: 'accessing' stamp: 'IS 5/31/2022 23:00:10'!
left
	^East new! !

!South methodsFor: 'accessing' stamp: 'IS 5/31/2022 23:00:26'!
right
	^West new! !


!classDefinition: #West category: 'Mars-Rover'!
MarsRoverDirection subclass: #West
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars-Rover'!

!West methodsFor: 'accessing' stamp: 'IS 5/31/2022 22:49:06'!
forward
	^-1@0! !

!West methodsFor: 'accessing' stamp: 'IS 5/31/2022 23:00:33'!
left
	^South new! !

!West methodsFor: 'accessing' stamp: 'IS 5/31/2022 23:00:22'!
right
	^North new! !
