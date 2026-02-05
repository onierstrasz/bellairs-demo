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
BellairsExamples >> bellairsAffiliation [
	<gtExample>
	<return: #BellairsAffiliation>
	| affiliation |
	affiliation := self bellairsPerson affiliation.
	self assert: affiliation name equals: 'IRISA / Université de Rennes 1'.
	self assert: affiliation workshops size equals: 8.
	self assert: affiliation persons size equals: 5.
	self assert: affiliation participations size equals: 15.
	^ affiliation
]

{ #category : 'examples' }
BellairsExamples >> bellairsCountry [
	<gtExample>
	<return: #BellairsCountry>
	| country affiliation  |
	affiliation := self bellairsAffiliation.
	country := affiliation country.
	self assert: country name equals: 'France'.
	self assert: country registry equals: affiliation registry.
	self assert: country json equals: affiliation registry json.
	self assert: country workshops size equals: 8.
	self assert: country persons size equals: 16.
	self assert: country affiliations size equals: 11.
	self assert: country participations size equals: 34.
	^ country
]

{ #category : 'examples' }
BellairsExamples >> bellairsJsonFromStoredJsonFile [
	<gtExample>
	<return: #Array>
	^ BellairsParserExamples new bellairsJsonFromStoredJsonFile
]

{ #category : 'examples' }
BellairsExamples >> bellairsParticipation [
	<gtExample>
	<return: #BellairsParticipation>
	| participation registry |
	registry := BellairsExamples new bellairsRegistry.
	participation := registry participations first.
	self
		assert: participation name
		equals: 'Benoit Combemale -- 2018 Unifying Software Reuse at Bellairs 2018'.
	self assert: participation workshops size equals: 1.
	self assert: participation persons size equals: 1.
	self assert: participation participations size equals: 1.
	^ participation
]

{ #category : 'examples' }
BellairsExamples >> bellairsPerson [
	<gtExample>
	<return: #BellairsPerson>
	| person |
	person := self bellairsParticipation person.
	self assert: person name equals: 'Benoit Combemale'.
	self assert: person workshops size equals: 8.
	self assert: person affiliations size equals: 2.
	self assert: person participations size equals: 8.
	^ person
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
BellairsExamples >> bellairsWorkshop [
	<gtExample>
	<return: #BellairsWorkshop>
	| workshop participation |
	participation := self bellairsParticipation.
	workshop := participation workshop.
	self
		assert: workshop name
		equals: '2018 Unifying Software Reuse at Bellairs 2018'.
	self assert: workshop registry equals: participation registry.
	self assert: workshop json equals: participation registry json.
	self assert: workshop persons size equals: 17.
	self assert: workshop affiliations size equals: 12.
	self assert: workshop countries size equals: 7.
	self assert: workshop participations size equals: 17.
	^ workshop
]
