"
I contain various examples of Bellairs Workshop entities, including relevant tests.

The key example is:
```
BellairsExamples new bellairsRegistry
```

"
Class {
	#name : 'BellairsExamples',
	#superclass : 'Object',
	#category : 'BellairsDemo-Examples',
	#package : 'BellairsDemo',
	#tag : 'Examples'
}

{ #category : 'examples' }
BellairsExamples >> bellairsJsonFromStoredJsonFile [
	<gtExample>
	<return: #Array>
	^ BellairsParserExamples new bellairsJsonFromStoredJsonFile
]

{ #category : 'examples' }
BellairsExamples >> bellairsRegistry [
	<gtExample>
	<return: #BellairsWorkshopsRegistry>
	| registry |
	registry := BellairsWorkshopsRegistry new
			initializeFromJson: self bellairsJsonFromStoredJsonFile.
	self assert: registry json size equals: registry participations size.
	^ registry
]

{ #category : 'examples' }
BellairsExamples >> firstAffiliation [
	<gtExample>
	<return: #BellairsAffiliation>
	| affiliation registry |
	registry := BellairsExamples new bellairsRegistry.
	affiliation := registry affiliations first.
	self assert: affiliation workshops size equals: 1.
	self assert: affiliation persons size equals: 1.
	self assert: affiliation participations size equals: 1.
	^ affiliation
]

{ #category : 'examples' }
BellairsExamples >> firstCountry [
	<gtExample>
	<return: #BellairsCountry>
	| country registry |
	registry := BellairsExamples new bellairsRegistry.
	country := registry countries first.
	self assert: country registry equals: registry.
	self assert: country json equals: registry json.
	self assert: country workshops size equals: 3.
	self assert: country persons size equals: 3.
	self assert: country affiliations size equals: 2.
	self assert: country participations size equals: 3.
	^ country
]

{ #category : 'examples' }
BellairsExamples >> firstOrganizer [
	<gtExample>
	<return: #BellairsPerson>
	| person registry |
	registry := BellairsExamples new bellairsRegistry.
	person := registry persons detect: #isOrganizer.
	self assert: person isOrganizer.
	self assert: person workshops size equals: 3.
	self assert: person affiliations size equals: 2.
	self assert: person participations size equals: 3.
	^ person
]

{ #category : 'examples' }
BellairsExamples >> firstParticipation [
	<gtExample>
	<return: #BellairsParticipation>
	| participation registry |
	registry := BellairsExamples new bellairsRegistry.
	participation := registry participations first.
	self assert: participation workshops size equals: 1.
	self assert: participation persons size equals: 1.
	self assert: participation participations size equals: 1.
	^ participation
]

{ #category : 'examples' }
BellairsExamples >> firstPerson [
	<gtExample>
	<return: #BellairsPerson>
	| person registry |
	registry := BellairsExamples new bellairsRegistry.
	person := registry persons first.
	self assert: person workshops size equals: 1.
	self assert: person affiliations size equals: 1.
	self assert: person participations size equals: 1.
	^ person
]

{ #category : 'examples' }
BellairsExamples >> firstWorkshop [
	<gtExample>
	<return: #BellairsWorkshop>
	| workshop registry |
	registry := BellairsExamples new bellairsRegistry.
	workshop := registry workshops first.
	self assert: workshop registry equals: registry.
	self assert: workshop json equals: registry json.
	self assert: workshop persons size equals: 21.
	self assert: workshop affiliations size equals: 14.
	self assert: workshop countries size equals: 6.
	self assert: workshop participations size equals: 21.
	^ workshop
]
