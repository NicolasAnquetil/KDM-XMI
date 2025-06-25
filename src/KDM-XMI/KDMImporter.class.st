Class {
	#name : 'KDMImporter',
	#superclass : 'XMLNodeVisitor',
	#instVars : [
		'model',
		'currentId'
	],
	#category : 'KDM-XMI',
	#package : 'KDM-XMI'
}

{ #category : 'instance creation' }
KDMImporter class >> on: aFilename [

	^self new
		on: aFilename ;
		yourself
]

{ #category : 'reflective operations' }
KDMImporter >> doesNotUnderstand: aMessage [
  | code |
  (aMessage selector beginsWith: 'visit')
    ifFalse: [ super doesNotUnderstand: aMessage ].

  code := aMessage selector , ' anXMLNode
  ^self visitNodeWithElements: anXMLNode'.

  self class compile: code classified: #'visiting - KDM'.

  self perform: aMessage selector with: aMessage arguments first
]

{ #category : 'accessing' }
KDMImporter >> model [

	^model
]

{ #category : 'instance creation' }
KDMImporter >> on: aFileName [

	| xmlRoot |
	xmlRoot := aFileName asFileReference readStreamDo: [ :st |
		(XMLDOMParser parse: st) document root ].

	model := Dictionary new.
	xmlRoot acceptNodeVisitor: self
]

{ #category : 'visiting' }
KDMImporter >> registerKDMObject: aNodeWithElements [

	| obj |
	1haltIf: [  currentId beginsWith: '/0/@model.5' ].
	obj := KDMObject new.
	obj id: currentId.
	obj model: model.

	aNodeWithElements attributes keysAndValuesDo: [ :att :val |
		obj attributeAt: att put: val ].

	model at: currentId put: obj
]

{ #category : 'visiting - KDM' }
KDMImporter >> visitActionRelation: anXMLNode [
  ^self visitNodeWithElements: anXMLNode
]

{ #category : 'visiting - KDM' }
KDMImporter >> visitAnnotation: anXMLNode [
  ^self visitNodeWithElements: anXMLNode
]

{ #category : 'visiting - KDM' }
KDMImporter >> visitAttribute: anXMLNode [
  ^self visitNodeWithElements: anXMLNode
]

{ #category : 'visiting - KDM' }
KDMImporter >> visitCodeElement: anXMLNode [
  ^self visitNodeWithElements: anXMLNode
]

{ #category : 'visiting - KDM' }
KDMImporter >> visitCodeRelation: anXMLNode [
  ^self visitNodeWithElements: anXMLNode
]

{ #category : 'visiting' }
KDMImporter >> visitElement: anXMLNode [

	| key |
	key := anXMLNode localName.
	self visitNode: anXMLNode Key: key
]

{ #category : 'visiting - KDM' }
KDMImporter >> visitIndexUnit: anXMLNode [
  ^self visitNodeWithElements: anXMLNode
]

{ #category : 'visiting - KDM' }
KDMImporter >> visitInventoryElement: anXMLNode [
  ^self visitNodeWithElements: anXMLNode
]

{ #category : 'visiting - KDM' }
KDMImporter >> visitItemUnit: anXMLNode [
  ^self visitNodeWithElements: anXMLNode
]

{ #category : 'visiting - KDM' }
KDMImporter >> visitModel: anXMLNode [
  ^self visitNodeWithElements: anXMLNode
]

{ #category : 'visiting' }
KDMImporter >> visitNode: anXMLNode Key: key [

	| selector |
	selector := 'visit' , key onlyLetters capitalized.
	self perform: selector asSymbol asMutator with: anXMLNode 
]

{ #category : 'visiting' }
KDMImporter >> visitNodeWithElements: aNodeWithElements [
	| parentId seq |

	aNodeWithElements hasChildren ifFalse: [ ^self ].

	parentId := currentId.
	seq := 0.
	(aNodeWithElements nodes reject: #isStringNode)
		do: [:each |
			currentId := parentId , '/@' , each localName , '.' , seq asString.
			self registerKDMObject: aNodeWithElements.
			each acceptNodeVisitor: self.
			seq := seq + 1.
		].

	currentId := parentId.
]

{ #category : 'visiting - KDM' }
KDMImporter >> visitParameterUnit: anXMLNode [
  ^self visitNodeWithElements: anXMLNode
]

{ #category : 'visiting - KDM' }
KDMImporter >> visitRegion: anXMLNode [
  ^self visitNodeWithElements: anXMLNode
]

{ #category : 'visiting - KDM' }
KDMImporter >> visitSegment: anXMLNode [
	currentId := '/0'.
  ^self visitNodeWithElements: anXMLNode
]

{ #category : 'visiting - KDM' }
KDMImporter >> visitSource: anXMLNode [
  ^self visitNodeWithElements: anXMLNode
]

{ #category : 'visiting - KDM' }
KDMImporter >> visitValue: anXMLNode [
  ^self visitNodeWithElements: anXMLNode
]

{ #category : 'visiting - KDM' }
KDMImporter >> visitXMI: anXMLNode [
	(anXMLNode nodes reject: #isStringNode)
		do: [:each | each acceptNodeVisitor: self ].

]
