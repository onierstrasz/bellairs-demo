Class {
	#name : #Bellairs2026Slides,
	#superclass : #PrioritySlideshow,
	#category : #'BellairsDemo-Slideshow'
}

{ #category : #'as yet unclassified' }
Bellairs2026Slides >> slidePriorities [
	"Instead of manually setting priorities, just list the slides in order here."

	<gtExample>
	<return: #Array>
	^ {
		#title:
	}
]

{ #category : #slides }
Bellairs2026Slides >> title: aSlide [ 
	<gtSlide>
	<text: 'A title or header slide'>
	^ (aSlide title)
		"priority: (self priorityFor: #titleSlideFor:);"
		setPriority;
		titleBottomPadding: 30;
		titleWithFormat: (self asTitle: 'Demo Slideshow Title');
		subtitleWithFormat: (self asBigText: 'with a subtitle')
]
