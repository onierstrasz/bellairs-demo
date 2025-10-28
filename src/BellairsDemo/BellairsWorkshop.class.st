"
I am a Bellairs workshop held in a given year.

"
Class {
	#name : #BellairsWorkshop,
	#superclass : #AbstractBellairsEntity,
	#traits : 'TParticipationGroupViews',
	#classTraits : 'TParticipationGroupViews classTrait',
	#category : #'BellairsDemo-Model'
}

{ #category : #accessing }
BellairsWorkshop >> affiliations [
	^ super affiliations
]

{ #category : #querying }
BellairsWorkshop >> countries [
	^ super countries
]

{ #category : #querying }
BellairsWorkshop >> entries [
	^ self json select: [ :d | (d at: 'workshop') = self name ]
]

{ #category : #'as yet unclassified' }
BellairsWorkshop >> gtActionWebBrowseFor: anAction [
	<gtAction>
	^ anAction explicit
		priority: 85;
		stencil: [ BrButton new
				aptitude: BrGlamorousButtonWithIconAptitude;
				action: [ WebBrowser openOn: self webUrl ];
				icon: BrGlamorousVectorIcons link;
				label: 'Open in Web Browser' translated ]
]

{ #category : #views }
BellairsWorkshop >> gtInstitutionsFor: aView [
	<gtView>
	^ aView forward
		title: 'Affiliations';
		priority: 30;
		object: [ self participations ];
		view: #gtInstitutionsFor:
]

{ #category : #views }
BellairsWorkshop >> gtPersonsFor: aView [
	<gtView>
	^ aView forward
		title: 'Persons';
		priority: 20;
		object: [ self participations ];
		view: #gtPersonsFor:
]

{ #category : #views }
BellairsWorkshop >> gtWebpageViewFor: aView [
	<gtView>
	^ aView forward
		title: 'Webpage';
		object: [ self webUrl ];
		view: #gtWebpageFor:
]

{ #category : #initialization }
BellairsWorkshop >> initializeFrom: aDictionary [
	name := aDictionary at: 'workshop'
]

{ #category : #mondrian }
BellairsWorkshop >> mondrianBorderHighlighting: aNode [
	^ self = aNode
		ifTrue: [ BlBorder paint: Color blue width: 3 ]
		ifFalse: [ BlBorder paint: Color black width: 1 ]
]

{ #category : #mondrian }
BellairsWorkshop >> mondrianChildren [
	^ self persons
]

{ #category : #mondrian }
BellairsWorkshop >> mondrianNodeColor [
	^ Color paleRed
]

{ #category : #'as yet unclassified' }
BellairsWorkshop >> mondrianNodeElementHighlighting: aNode [
	^ BlTextElement new
		text: self year asRopedText;
		padding: (BlInsets all: 5);
		border: (self mondrianBorderHighlighting:aNode);
		background: self mondrianNodeColor;
		aptitude: (BrGlamorousWithExplicitTooltipAptitude text: self name)
]

{ #category : #querying }
BellairsWorkshop >> organizers [
	^ self participations organizers
]

{ #category : #requirement }
BellairsWorkshop >> participations [
	^ super participations
]

{ #category : #views }
BellairsWorkshop >> summary [
	^ {{'Name'.
			self name.
			self}.
		{'# Persons'.
			self persons size printString.
			self arrayOrUniqueElement: self persons}.
		{'# Affiliations'.
			self affiliations size printString.
			self arrayOrUniqueElement: self affiliations}.
		{'# Countries'.
			self countries size printString.
			self arrayOrUniqueElement: self countries}}
]

{ #category : #accessing }
BellairsWorkshop >> webUrl [
	^ ZnUrl
		fromString: 'https://bellairs20' , (self year sliceFrom: 3)
				, '.ece.mcgill.ca/participants.htm'
]

{ #category : #accessing }
BellairsWorkshop >> workshop [
	^ {self}
]

{ #category : #accessing }
BellairsWorkshop >> workshops [
	"For the graph, we want to see not only this workshop,
	but also all the other workshops the participants have been to."

	^ (self persons flatCollect: #workshops) copyWithoutDuplicates
]

{ #category : #accessing }
BellairsWorkshop >> year [
	| firstWord |
	firstWord := self name substrings first.
	self assert: (firstWord sliceTo: 2) equals: '20'.
	^ firstWord
]
