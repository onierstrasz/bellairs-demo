Class {
	#name : 'Bellairs2026Slides',
	#superclass : 'PrioritySlideshow',
	#category : 'BellairsDemo-Slideshow',
	#package : 'BellairsDemo',
	#tag : 'Slideshow'
}

{ #category : 'page' }
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
			code: 'json := (allLines
					collect: [ :line | parser parse: line ] 
					thenSelect: #notNil)
						asGtJson';
			yourself);
	yourself
]

{ #category : 'slides' }
Bellairs2026Slides >> bellairsParserPage: aSlide [
	<gtSlide>
<text: 
'# Parsing the Bellairs participants pages

This sounds like a job for an island parser! We start by caching all the files and extracting their contents, line by line. By the way, please note that this is just an object inspector on an `Array` of `ByteString` objects.

We incrementally build a tiny island parser using PetitParser, a PEG-based scannerless parser framework.
In the *Tree* view of the parser instance we can see how the parser is composed of a bunch of smaller parsers.
In the *Meta* view we see how each component parser picks up some piece of information from the source lines.
Luckily the input is highly regular, so we have only very few special cases to handle.
Each parser component either returns a dictionary of the values found, or nil.

Notice that again what we see at the right is just an object inspector, but instead of having just the usual *Raw* view, we have views specific to the context of a parser object, such as the *Tree* view.

The whole parser is less than 100 lines of code, and was iteratively developed with minimal effort.

We apply the parser to all the lines, collect the non-empty dictionaries, and turn that into a JSON object.
Once again, we are inspecting a `GtJson` object at the right, decorated with some views specific to JSONs.'>
<demo:
'- Inspect each of the three snippets in turn.
- Dive into some of the strings of the array of lines.
- Show the *Tree* view and *Meta* view ofthe parser.
- Show The two JSON-specific views.'>
	^ aSlide lepiterPage
		setPriority;
		startPage: (self database pageNamed: 'Parsing the Bellairs participants pages')
]

{ #category : 'examples' }
Bellairs2026Slides >> bellairsRegistry [
	<gtExample>
	^ BellairsExamples new bellairsRegistry
]

{ #category : 'slides' }
Bellairs2026Slides >> bellairsRegistry: aSlide [
	<gtSlide>
	<text: 'Bellairs workshop
'>
	^ aSlide labelAndElement
		setPriority;
		newFadedText: 'Exploring the Bellairs data';
		element: [ (GtPagerSettings usedPager
				createWrappedOn: (GtInspectorTool forObject: self bellairsRegistry))
				maximized ]
]

{ #category : 'slides' }
Bellairs2026Slides >> domainModelingScenery: aSlide [
	<gtSlide>
<text: 
'TO DO -- need Scenery with witnesses.
'>
	^ aSlide labelAndScenery
		setPriority;
		newFadedText: 'TO DO: Modeling the Bellairs domain objects';
		scenery: Bellairs2026Slides >> #umlScenery
]

{ #category : 'slides' }
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

{ #category : 'examples' }
Bellairs2026Slides >> participantsHtml [
	<gtExample>
	^ self participantsWebUrl retrieveContents
]

{ #category : 'slides' }
Bellairs2026Slides >> participantsHtml: aSlide [
	<gtSlide>
	<text: '# The HTML source code looks pretty regular

If we take a closer look at the source code of the web pages, we discover that they are formatted consistently over the years. Maybe we can exploit this fact to extract the raw data.
'>
	^ aSlide labelAndElement
		setPriority;
		newFadedText: 'Hm. This data looks pretty regular';
		element: [ self participantsHtml gtLiveFor: GtPhlowProtoView new ]
]

{ #category : 'examples' }
Bellairs2026Slides >> participantsWebUrl [
	<gtExample>
	^ ZnUrl fromString: 'https://bellairs2026.ece.mcgill.ca/participants.htm'
]

{ #category : 'examples' }
Bellairs2026Slides >> participantsWebpages [
	<gtExample>
	^ (self bellairsRegistry workshops sortedAs: #name) collect: #webUrl
]

{ #category : 'slides' }
Bellairs2026Slides >> participantsWebpages: aSlide [
	<gtSlide>
	<text:
'# Legacy Bellairs participant web pages

Luckily I could find a bunch of legacy web pages of past events.
Clicking around I can see who participated in a given year, but I cannot get an overview of who was a repeat participant, who were the organizers, and so on. I am stuck with the views that were hard-coded in the web pages.

BTW, notice that what we see here at the right is actually an object inspectoron a `ZnUrl` object.
You might not recognize it as such because you are probably used to seeing just the *Raw* view here.
'>
<demo: 
'- Show the Webpage view of a few urls.
- Show the raw view.'>
	^ aSlide labelAndElement
		setPriority;
		newFadedText: 'We have webpages listing Bellairs participants going back several years.';
		element: [ (GtPagerSettings usedPager
				createWrappedOn: (GtInspectorTool forObject: self participantsWebpages viewSelector: #gtItemsFor:))
				maximized ]
]

{ #category : 'accessing' }
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

{ #category : 'slides' }
Bellairs2026Slides >> title: aSlide [ 
	<gtSlide>
<text:
'# Applying Moldable Development to the Bellairs workshop web pages

Hi. I''m Oscar Nierstrasz. I''m a retired Professor at the University of Bern.
I''ve been working the past few years for feenk, a company specialized in modernizing legacy systems.
We use a process called “Moldable Development” to make software systems explainable.
Rather than just talk about it, I''d like to show you how it works by applying it to the Bellairs workshop web pages.
'>

	^ (aSlide titleWithFooter)
		setPriority;
		titleBottomPadding: 30;
		titleWithFormat: (self asTitle: 'Applying Moldable Development');
		subtitleWithFormat: (self asBigText: 'to the Bellairs workshop web pages');
		footerWithFormat: (self asBigCode: 'oscar.nierstrasz@feenk.com')
]

{ #category : 'scenery' }
Bellairs2026Slides >> umlScenery [
	"NB: Generated by GtScenery>>#storeAsExampleMethod -- do not edit."

	<gtExample>
	<noTest>
	<storedScenery>
	<return: #GtScenery>
	| scenery item1 item2 item3 item4 item5 item6 item7 item8 item9 item10 item11 item12 |
	scenery := GtScenery new.
	item1 := scenery
			addSceneryItem: (GtSceneryPackageInspectorStencil new packageName: #BellairsDemo) asItem.
	item1 position: -114.16666666666663 @ 123.23549397786462.
	item1 extent: 300.0 @ 400.0.
	item2 := scenery
			addSceneryItem: (GtSceneryUMLClassStencil new
					label: 'BellairsParticipation';
					width: 213.280029296875;
					exampleMethodName: 'BellairsExamples>>#firstParticipation') asItem.
	item2 position: 292.85738118489587 @ 602.2354939778646.
	item2 extent: 213.280029296875 @ 40.0.
	item3 := scenery
			addSceneryItem: (GtSceneryUMLClassStencil new
					label: #BellairsPerson;
					exampleMethodName: 'BellairsExamples>>#firstOrganizer') asItem.
	item3 position: 630.8573811848959 @ 420.2354939778646.
	item3 extent: 153.88002014160156 @ 40.0.
	item4 := scenery
			addSceneryItem: (GtSceneryUMLClassStencil new
					label: #BellairsWorkshop;
					width: 186.0640106201172;
					exampleMethodName: 'BellairsExamples>>#firstWorkshop') asItem.
	item4 position: 657.8573811848959 @ 715.2354939778646.
	item4 extent: 186.0640106201172 @ 40.0.
	item5 := scenery
			addSceneryItem: (GtSceneryExampleStencil new
					exampleMethodName: 'BellairsExamples>>#firstWorkshop') asItem.
	item5 position: 1210.857381184896 @ 783.2354939778647.
	item5 extent: 342.14325291206774 @ 238.09595399796058.
	item6 := scenery
			addSceneryItem: (GtSceneryExampleStencil new
					exampleMethodName: 'BellairsExamples>>#firstOrganizer') asItem.
	item6 position: 978.857381184896 @ 144.23549397786462.
	item6 extent: 406.7752673191519 @ 260.7265797998862.
	item7 := scenery
			addSceneryItem: (GtSceneryUMLClassStencil new
					label: #BellairsCountry;
					width: 165.68801879882813;
					exampleMethodName: 'BellairsExamples>>#firstCountry') asItem.
	item7 position: 501.85738118489587 @ 902.2354939778647.
	item7 extent: 165.68801879882813 @ 40.0.
	item8 := scenery
			addSceneryItem: (GtSceneryUMLClassStencil new
					label: #BellairsWorkshopsRegistry;
					width: 277.0240478515625;
					exampleMethodName: 'BellairsExamples>>#bellairsRegistry') asItem.
	item8 position: -175.16666666666663 @ 576.2354939778646.
	item8 extent: 277.0240478515625 @ 40.0.
	item9 := scenery
			addSceneryItem: (GtSceneryExampleStencil new
					exampleMethodName: 'BellairsExamples>>#bellairsRegistry') asItem.
	item9 position: -114.14261881510413 @ 731.2354939778646.
	item9 extent: 525.0111577208982 @ 332.938489433354.
	item10 := scenery
			addSceneryItem: (GtSceneryExampleStencil new
					exampleMethodName: 'BellairsExamples>>#firstCountry') asItem.
	item10 position: 831.8573811848958 @ 922.235493977865.
	item10 extent: 296.22022613185754 @ 265.1839973309518.
	item11 := scenery
			addSceneryItem: (GtSceneryUMLClassStencil new
					label: #BellairsAffiliation;
					exampleMethodName: 'BellairsExamples>>#firstAffiliation') asItem.
	item11 position: 949.8333333333335 @ 536.2354939778646.
	item11 extent: 181.0480194091797 @ 40.0.
	item12 := scenery
			addSceneryItem: (GtSceneryExampleStencil new
					exampleMethodName: 'BellairsExamples>>#firstAffiliation') asItem.
	item12 position: 1315.8813527425132 @ 493.2354939778646.
	item12 extent: 429.4880040497369 @ 227.63840629561253.
	scenery
		addConnectionWithStencil: (GtSceneryStraightArcStencil new
				labelText: 'example')
		from: item4
		to: item5.
	scenery
		addConnectionWithStencil: GtSceneryUMLConnectionStencil new
		from: item2
		to: item4.
	scenery
		addConnectionWithStencil: (GtSceneryStraightArcStencil new
				labelText: 'example')
		from: item3
		to: item6.
	scenery
		addConnectionWithStencil: GtSceneryUMLConnectionStencil new
		from: item2
		to: item7.
	scenery
		addConnectionWithStencil: GtSceneryUMLConnectionStencil new
		from: item2
		to: item3.
	scenery
		addConnectionWithStencil: (GtSceneryStraightArcStencil new
				labelText: 'example')
		from: item8
		to: item9.
	scenery
		addConnectionWithStencil: (GtSceneryStraightArcStencil new
				labelText: 'example')
		from: item7
		to: item10.
	scenery
		addConnectionWithStencil: GtSceneryUMLConnectionStencil new
		from: item8
		to: item2.
	scenery
		addConnectionWithStencil: GtSceneryUMLConnectionStencil new
		from: item3
		to: item11.
	scenery
		addConnectionWithStencil: (GtSceneryStraightArcStencil new
				labelText: 'example')
		from: item11
		to: item12.
	scenery storeStringMethodName: 'Bellairs2026Slides>>#umlScenery'.
	^ scenery
]

{ #category : 'examples' }
Bellairs2026Slides >> workshopWebUrl [
	<gtExample>
	^ ZnUrl fromString: 'https://bellairs2026.ece.mcgill.ca/index.htm'
]

{ #category : 'slides' }
Bellairs2026Slides >> workshopWebpage: aSlide [
	<gtSlide>
<text: 
'# What is this workshop?

When Gunter invited me to this year''s wrkshop, I had lots of questions.
- What is the history of this workshop?
- What topics have been addressed over time?
- Who are the organizers?
- Who has participated regularly over the years?
'>
	^ aSlide labelAndElement
		setPriority;
		newFadedText: 'What is this workshop? Who are these people?';
		element: [ self workshopWebUrl  gtWebpageFor: GtPhlowProtoView new ]
]
