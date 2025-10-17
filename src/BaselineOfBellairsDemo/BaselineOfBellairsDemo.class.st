Class {
	#name : #BaselineOfBellairsDemo,
	#superclass : #BaselineOf,
	#category : #BaselineOfBellairsDemo
}

{ #category : #loading }
BaselineOfBellairsDemo class >> loadLepiter [
	IceRepository registry  
		detect: [ :aRepository |
			aRepository name = 'bellairs-demo' ]
		ifFound: [ :aRepository | 
			| defaultDatabase currentProperties |
			defaultDatabase := LeDatabasesRegistry defaultLogicalDatabase.
			currentProperties := defaultDatabase properties.
			currentProperties addRegisteredDirectory: aRepository repositoryDirectory / 'lepiter'.
			defaultDatabase reload ]
		ifNone: [
			self inform: 'Repository not found.' ]
]

{ #category : #baseline }
BaselineOfBellairsDemo >> baseline: spec [
	<baseline>
		^ spec for: #common do: [
			spec package: 'BellairsDemo'
		]
]
