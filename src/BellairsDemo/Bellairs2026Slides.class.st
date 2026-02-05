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

We incrementally build a tiny island parser using PetitParser, a PEG-based scannerless parser framework. In the *Tree* view of the parser instance we can see how the parser is composed of a bunch of smaller parsers. In the *Meta* view we see how each component parser picks up some piece of information from the source lines. Luckily the input is highly regular, so we have only very few special cases to handle. Each parser component either returns a dictionary of the values found, or nil.

Notice that again what we see at the right is just an object inspector, but instead of having just the usual *Raw* view, we have views specific to the context of a parser object, such as the *Tree* view.

The whole parser is less than 100 lines of code, and was iteratively developed with minimal effort.

We apply the parser to all the lines, collect the non-empty dictionaries, and turn that into a JSON object. Once again, we are inspecting a `GtJson` object at the right, decorated with some views specific to JSONs.'>
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
	<text:
'# Exploring the Bellairs data

Now that we have wrapped the extracted data into domain entities, we can *mold* them with little contextual tools to answer the questions we have about them.

What are the topics of the various workshops? We see them here, and we can dive into the details.

Who attended? We see who they were and how often they attended.

Who were the organizers? Always the same Gang of Five.

Which countries are the participants from? Canada, France and Germany are the big winners. Curiously it seems only one person ever attended from the USA.

And who attended which workshops? Here we see a graph of all attendees with organizers highlighted in red. We can also dive into 2026 and see who at this workshop attended which workshops in the past. Now we can clearly see that there is a cohort of old timers, as well as a large batch of newcomers.

OK, let''s take a step back and consider what we have seen. First of all, we wrapped some data to create domain objects. Then we *molded* these objects to answer questions we had. Note that everything we have seen are just object inspectors on domain objects. Each *view* is a little, contextual tool.

Let''s take a look at the implementation of some of these views. Don''t pay too much attention to the details, but note that they are all pretty similar, boilerplate code. In fact, many of these can be generated automatically as we explore the domain objects.

The only view that is a little bit specialized is the graph visualization, but as we see, this is also specified in a just a few lines of code.

In addition to contextual views, we can also have contextual actions, such as opening a webpage or extracting a CSV.
And we can have contextual searches as well.

So far I have only shown you that we can mold the object inspector, but the other IDE tools are moldable as well, such as the code editor and the debugger.'>
<demo:
'- Show the *Workshops* and other views in sequence.
- Show the code of the first few views.
- Show the code of the *Graph* view with the mondrian code.
- Show the actions of the 2026 workshop, and select CSV and webpage.
- Open the CSV into the O/S (in Excel).
- Open the search tool and select "Sw".
- Open a class Coder and show some of the views.'>
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
'# Modeling the Bellairs domain objects

Now from the data we''d like to model the following domain entities: The Bellairs registry knows about a bunch of workshops, each of which has a bunch of participations listed on the websites. Each participation is for a person (possibly an organizer) with an affiliation to an institution in some country.

For  example, on participation is that of Benoit in 2018.

The idea is that each of these domain objects is just a thin wrapper around the data we have extracted. For example, the participation object just wraps the dictionary we have extracted as JSON from one of the webpages.

The registry itself wraps the entire extracted JSON, so we can use it to look anything up.
'>
<demo:
'- Inspect the participation example.
- Go to the Raw view to show the wrapped dictionary data.
- Click on the registry example and show the Raw view withe the JSON and the dictionaries for looking up persons etc.'>
	^ aSlide labelAndScenery
		setPriority;
		newFadedText: 'Modeling the Bellairs domain objects';
		scenery: Bellairs2026Slides >> #umlScenery
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

BTW, notice that what we see here at the right is actually an object inspectoron a `ZnUrl` object. You might not recognize it as such because you are probably used to seeing just the *Raw* view here.'>
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
		#summary:
		#thisSlideShow:
		#whatNext:
	)
]

{ #category : 'slides' }
Bellairs2026Slides >> summary: aSlide [
	<gtSlide>
	<text:
'# Summary

Summing up, moldable development is a way to make software systems explainable by making it cheap to create lots of tiny contextual tools that adapt the IDE tools to answer question you have about the domain.

No matter what the domain, whether it be static data, log files, legacy code, a running system, a web API, or whatever, the moldable development process is the same: extract objects, ask questions, create contextual tools, repeat.
'>
	^ aSlide paragraph
		setPriority;
		subtitleWithFormat: (self asSubtitle: 'Summary');
		paragraphWithFormat: (self
				asText:
'
— Establish some questions you want to answer.
— Create domain objects (if they don''t already exist).
— Interact with the objects to answer questions.
— Turn the interactions into contextual tools.
— Create new objects, if you need them.
— Repeat.
')
]

{ #category : 'slides' }
Bellairs2026Slides >> thisSlideShow: aSlide [
	<gtSlide>
	<text:
'# Exploring the slideshow

I''d  like to emphasize that GT is itself built using moldable development, and contains literally thousands of tiny, contextual tools to make GT itself explainable..

As a closing example, consider that this slideshow itself is just a moldable object within GT. The slideshow authoring environment is nothing but an object inspector on a slideshow instance decorated with contextual views, actions and searches. Here''s the code of this slide.
'>
<demo:
'
— Show several of the views in sequence.
— Click on this slide to show its code.'>
	^ aSlide labelAndElement
		setPriority;
		newFadedText: 'Eating our own dog food';
		element: [ (GtPagerSettings usedPager
				createWrappedOn: (GtInspectorTool forObject: self))
				maximized ]
]

{ #category : 'slides' }
Bellairs2026Slides >> title: aSlide [ 
	<gtSlide>
<text:
'# Applying Moldable Development to the Bellairs workshop web pages

Hi. I''m Oscar Nierstrasz. I''m a retired Professor at the University of Bern.

I''ve been working the past few years for feenk, a company specialized in modernizing legacy systems. We use a process called “Moldable Development” to make software systems explainable. Rather than just talk about it, I''d like to show you how it works by applying it to the Bellairs workshop web pages.'>

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
	| scenery item1 item2 item3 item4 item5 item6 item7 item8 item9 item10 |
	scenery := GtScenery new.
	item1 := scenery
			addSceneryItem: (GtSceneryUMLClassStencil new
					label: 'BellairsParticipation';
					width: 213.280029296875;
					exampleMethodName: 'BellairsExamples>>#bellairsParticipation') asItem.
	item1 position: 188.85738118489587 @ 1481.2354939778647.
	item1 extent: 213.280029296875 @ 40.0.
	item2 := scenery
			addSceneryItem: (GtSceneryUMLClassStencil new
					label: #BellairsPerson;
					width: 153.88002014160156;
					exampleMethodName: 'BellairsExamples>>#bellairsPerson') asItem.
	item2 position: 576.8573811848959 @ 1481.2354939778647.
	item2 extent: 153.88002014160156 @ 40.0.
	item3 := scenery
			addSceneryItem: (GtSceneryUMLClassStencil new
					label: #BellairsWorkshop;
					width: 186.0640106201172;
					exampleMethodName: 'BellairsExamples>>#bellairsWorkshop') asItem.
	item3 position: 200.85738118489587 @ 1311.2354939778647.
	item3 extent: 186.0640106201172 @ 40.0.
	item4 := scenery
			addSceneryItem: (GtSceneryUMLClassStencil new
					label: #BellairsCountry;
					width: 165.68801879882813;
					exampleMethodName: 'BellairsExamples>>#bellairsCountry') asItem.
	item4 position: 1145.857381184896 @ 1480.2354939778647.
	item4 extent: 165.68801879882813 @ 40.0.
	item5 := scenery
			addSceneryItem: (GtSceneryUMLClassStencil new
					label: #BellairsAffiliation;
					width: 181.0480194091797;
					exampleMethodName: 'BellairsExamples>>#bellairsAffiliation') asItem.
	item5 position: 848.8333333333335 @ 1480.2354939778647.
	item5 extent: 181.0480194091797 @ 40.0.
	item6 := scenery
			addSceneryItem: (GtSceneryUMLClassStencil new
					label: 'BellairsWorkshopsRegistry';
					width: 277.0240478515625;
					exampleMethodName: 'BellairsExamples>>#bellairsRegistry') asItem.
	item6 position: 156.0698070773579 @ 1139.9983004180554.
	item6 extent: 277.0240478515625 @ 40.0.
	item7 := scenery
			addSceneryItem: (GtSceneryExampleStencil new
					exampleMethodName: 'BellairsExamples>>#bellairsRegistry') asItem.
	item7 position: 681.0938549289203 @ 994.9983004180554.
	item7 extent: 426.6341145833335 @ 330.15472412109375.
	item8 := scenery
			addSceneryItem: (GtSceneryTextLabelStencil new
					label: '*';
					fontSize: 24;
					width: 28.394719441731752) asItem.
	item8 position: 308.315612792969 @ 1262.8813018798828.
	item8 extent: 28.394719441731752 @ 40.0.
	item9 := scenery
			addSceneryItem: (GtSceneryTextLabelStencil new
					label: '*';
					fontSize: 24;
					width: 21.69562784830731) asItem.
	item9 position: 310.76354471842467 @ 1434.393564860026.
	item9 extent: 21.69562784830731 @ 40.0.
	item10 := scenery
			addSceneryItem: (GtSceneryTextLabelStencil new
					label: '*';
					fontSize: 24;
					width: 28.926081339518305) asItem.
	item10 position: 540.3689066569013 @ 1451.1424051920571.
	item10 extent: 28.926081339518305 @ 40.0.
	scenery
		addConnectionWithStencil: GtSceneryUMLConnectionStencil new
		from: item1
		to: item2.
	scenery
		addConnectionWithStencil: GtSceneryUMLConnectionStencil new
		from: item2
		to: item5.
	scenery
		addConnectionWithStencil: GtSceneryUMLConnectionStencil new
		from: item5
		to: item4.
	scenery
		addConnectionWithStencil: GtSceneryUMLConnectionStencil new
		from: item3
		to: item1.
	scenery
		addConnectionWithStencil: (GtSceneryStraightArcStencil new
				labelText: 'example')
		from: item6
		to: item7.
	scenery
		addConnectionWithStencil: GtSceneryUMLConnectionStencil new
		from: item6
		to: item3.
	scenery storeStringMethodName: 'Bellairs2026Slides>>#umlScenery'.
	^ scenery
]

{ #category : 'slides' }
Bellairs2026Slides >> whatNext: aSlide [
	<gtSlide>
	<text:
'# What''s next?

Glamorous Toolkoit is an open-source which we fund through contracts with customers. If you''re interested in learning more, talk to me, or download it and try it yourself.'>
	^ aSlide paragraph
		setPriority;
		subtitleWithFormat: (self asSubtitle: 'What''s next?');
		paragraphWithFormat: (self
				asText:
'
— Download GT from '), (self asCode: 'gtoolkit.com'), (self asText: '
— Try out case studies and tutorials within GT.
— Join the Discord Server.
— Ask questions.
— Have fun!
')
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

When Gunter invited me to this year''s workshop, I had lots of questions.
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
