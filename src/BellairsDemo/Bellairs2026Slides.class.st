Class {
	#name : #Bellairs2026Slides,
	#superclass : #PrioritySlideshow,
	#category : #'BellairsDemo-Slideshow'
}

{ #category : #page }
Bellairs2026Slides >> bellairsParserPage [
	<lePage>
	<gtExample>
	<noTest>
	^ (LePage named: 'Parsing the Bellairs participants pages')
		addSnippet: (LeTextSnippet new
				string: 'We extract all the HTML source code, and we write a tiny PEG parser to extract the data and build a JSON.';
				yourself);
		addSnippet: (LePharoSnippet new
				code: 'allLines := BellairsParserExamples new allLines';
				yourself);
		addSnippet: (LePharoSnippet new
				code: 'parser := BellairsParser new';
				yourself);
		addSnippet: (LePharoSnippet new
				code: 'json := (allLines collect: [ :line | parser parse: line ] thenSelect: #notNil) asGtJson';
				yourself);
		yourself
]

{ #category : #slides }
Bellairs2026Slides >> bellairsParserPage: aSlide [
	<gtSlide>
<text: 
'Bellairs workshop
'>
	^ aSlide lepiterPage
		setPriority;
		startPage: (self database pageNamed: 'Parsing the Bellairs participants pages')
]

{ #category : #examples }
Bellairs2026Slides >> bellairsRegistry [
	<gtExample>
	^ BellairsExamples new bellairsRegistry
]

{ #category : #slides }
Bellairs2026Slides >> bellairsRegistry: aSlide [
	<gtSlide>
<text: 
'Bellairs workshop
'>
			^ aSlide labelAndElement
		setPriority;
		newFadedText: 'Exploring the Bellairs data';
		element: [ (GtPager
				createWrappedOn: (GtInspector forObject: self bellairsRegistry))
				maximized ]
]

{ #category : #slides }
Bellairs2026Slides >> domainModelingScenery: aSlide [
	<gtSlide>
<text: 
'TO DO -- need Scenery with witnesses.
'>
	^ aSlide labelAndScenery
		setPriority;
		newFadedText: 'Modeling the Bellairs domain objects';
		scenery: GtSceneryEditedExamples >> #reflectionScenery
]

{ #category : #slides }
Bellairs2026Slides >> lessons: aSlide [
	<gtSlide>
	<text: 'Text with a paragraph'>
	^ aSlide paragraph
		setPriority;
		subtitleWithFormat: (self asSubtitle: 'Outline');
		paragraphWithFormat: (self
				asText: 'Paragraph body.
Possibly over multiple lines.
')
]

{ #category : #examples }
Bellairs2026Slides >> participantsHtml [
	<gtExample>
	^ self participantsWebUrl retrieveContents
]

{ #category : #slides }
Bellairs2026Slides >> participantsHtml: aSlide [
	<gtSlide>
<text: 
'Bellairs workshop
'>
	^ aSlide labelAndElement
		setPriority;
		newFadedText: 'Hm. This data looks pretty regular';
		element: [ self participantsHtml  gtLiveFor: GtPhlowProtoView new ]
]

{ #category : #examples }
Bellairs2026Slides >> participantsWebUrl [
	<gtExample>
	^ ZnUrl fromString: 'https://bellairs2026.ece.mcgill.ca/participants.htm'
]

{ #category : #examples }
Bellairs2026Slides >> participantsWebpages [
	<gtExample>
	^ (self bellairsRegistry workshops sortedAs: #name) collect: #webUrl
]

{ #category : #slides }
Bellairs2026Slides >> participantsWebpages: aSlide [
	<gtSlide>
<text: 
'Bellairs workshop
'>
"	^ aSlide lepiterPage
		setPriority;
		startPage: (self database pageNamed: 'Participants webpages')"
		
					^ aSlide labelAndElement
		setPriority;
		newFadedText: 'We have webpages listing Bellairs participants going back several years.';
		element: [ (GtPager
				createWrappedOn: (self  participantsWebpages gtItemsFor: GtPhlowView empty))
				maximized ]
]

{ #category : #accessing }
Bellairs2026Slides >> slidePriorities [
	"Instead of manually setting priorities, just list the slides in order here."

	<gtExample>
	<return: #Array>
	^ #(
		#title:
		#workshopWebpage:
		#participantsWebpages:
		#participantsHtml:
		#bellairsParserPage:
		
		#domainModelingScenery:
		
		#bellairsRegistry:
		#lessons:
	)
]

{ #category : #slides }
Bellairs2026Slides >> title: aSlide [ 
	<gtSlide>
<text:
'A title or header slide'>

	^ (aSlide titleWithFooter)
		setPriority;
		titleBottomPadding: 30;
		titleWithFormat: (self asTitle: 'Using Moldable Development');
		subtitleWithFormat: (self asBigText: 'to explore Bellairs workshops');
		footerWithFormat: (self asBigText: 'oscar.nierstrasz@feenk.com')
]

{ #category : #examples }
Bellairs2026Slides >> workshopWebUrl [
	<gtExample>
	^ ZnUrl fromString: 'https://bellairs2026.ece.mcgill.ca/index.htm'
]

{ #category : #slides }
Bellairs2026Slides >> workshopWebpage: aSlide [
	<gtSlide>
<text: 
'Bellairs workshop
'>
	^ aSlide labelAndElement
		setPriority;
		newFadedText: 'What is this workshop? Who are these people?';
		element: [ self workshopWebUrl  gtWebpageFor: GtPhlowProtoView new ]
]
