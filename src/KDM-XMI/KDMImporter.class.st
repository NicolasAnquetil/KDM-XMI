Class {
	#name : 'KDMImporter',
	#superclass : 'XMLNodeVisitor',
	#instVars : [
		'model',
		'entities',
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

	self deprecated: 'Should not be needed anymore, all visit methods created'.

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

	entities := Dictionary new.
	currentId := '/0'.
	model := xmlRoot acceptNodeVisitor: self
]

{ #category : 'visiting' }
KDMImporter >> registerKDMObject: aNodeWithElements [

	| obj |
	obj := KDMObject new.
	obj id: (currentId , '/@' , aNodeWithElements localName).
	obj type: aNodeWithElements localName.
	
	entities at: obj id put: obj.

	aNodeWithElements attributes keysAndValuesDo: [ :att :val |
		obj attributeAt: att put: val ].


	^obj
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
KDMImporter >> visitAnnotations: anXMLNode [
  ^self visitNodeWithElements: anXMLNode
]

{ #category : 'visiting - KDM' }
KDMImporter >> visitArguments: anXMLNode [
  ^self visitNodeWithElements: anXMLNode
]

{ #category : 'visiting - KDM' }
KDMImporter >> visitAttribute: anXMLNode [
  ^self visitNodeWithElements: anXMLNode
]

{ #category : 'visiting - KDM' }
KDMImporter >> visitBody: anXMLNode [
  ^self visitNodeWithElements: anXMLNode
]

{ #category : 'visiting - KDM' }
KDMImporter >> visitBodyDeclarations: anXMLNode [
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

{ #category : 'visiting - KDM' }
KDMImporter >> visitCompilationUnits: anXMLNode [
  ^self visitNodeWithElements: anXMLNode
]

{ #category : 'visiting' }
KDMImporter >> visitElement: anXMLNode [

	| key |
	key := anXMLNode localName.
	^self visitNode: anXMLNode Key: key
]

{ #category : 'visiting - KDM' }
KDMImporter >> visitElementType: anXMLNode [
  ^self visitNodeWithElements: anXMLNode
]

{ #category : 'visiting - KDM' }
KDMImporter >> visitExpression: anXMLNode [
  ^self visitNodeWithElements: anXMLNode
]

{ #category : 'visiting - KDM' }
KDMImporter >> visitExtendedOperands: anXMLNode [
  ^self visitNodeWithElements: anXMLNode
]

{ #category : 'visiting - KDM' }
KDMImporter >> visitField: anXMLNode [
  ^self visitNodeWithElements: anXMLNode
]

{ #category : 'visiting - KDM' }
KDMImporter >> visitFragments: anXMLNode [
  ^self visitNodeWithElements: anXMLNode
]

{ #category : 'visiting - KDM' }
KDMImporter >> visitIndexUnit: anXMLNode [
  ^self visitNodeWithElements: anXMLNode
]

{ #category : 'visiting - KDM' }
KDMImporter >> visitInitializer: anXMLNode [
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
KDMImporter >> visitLeftHandSide: anXMLNode [
  ^self visitNodeWithElements: anXMLNode
]

{ #category : 'visiting - KDM' }
KDMImporter >> visitLeftOperand: anXMLNode [
  ^self visitNodeWithElements: anXMLNode
]

{ #category : 'visiting - KDM' }
KDMImporter >> visitModel: anXMLNode [
  ^self visitNodeWithElements: anXMLNode
]

{ #category : 'visiting - KDM' }
KDMImporter >> visitModifier: anXMLNode [
  ^self visitNodeWithElements: anXMLNode
]

{ #category : 'visiting' }
KDMImporter >> visitNode: anXMLNode Key: key [

	| selector |
	selector := 'visit' , key onlyLetters capitalized.
	^self perform: selector asSymbol asMutator with: anXMLNode 
]

{ #category : 'visiting' }
KDMImporter >> visitNodeWithElements: aNodeWithElements [
	| parentId obj |

	parentId := currentId.
	obj:= self registerKDMObject: aNodeWithElements.

	aNodeWithElements hasChildren ifFalse: [ ^obj ].

	currentId := obj id.

	(aNodeWithElements nodes reject: #isStringNode)
		do:  [:each | obj addChild: (each acceptNodeVisitor: self) ].

	currentId := parentId.
	
	^obj
]

{ #category : 'visiting - KDM' }
KDMImporter >> visitOrphanTypes: anXMLNode [
  ^self visitNodeWithElements: anXMLNode
]

{ #category : 'visiting - KDM' }
KDMImporter >> visitOwnedElements: anXMLNode [
  ^self visitNodeWithElements: anXMLNode
]

{ #category : 'visiting - KDM' }
KDMImporter >> visitOwnedPackages: anXMLNode [
  ^self visitNodeWithElements: anXMLNode
]

{ #category : 'visiting - KDM' }
KDMImporter >> visitParameterUnit: anXMLNode [
  ^self visitNodeWithElements: anXMLNode
]

{ #category : 'visiting - KDM' }
KDMImporter >> visitParameters: anXMLNode [
  ^self visitNodeWithElements: anXMLNode
]

{ #category : 'visiting - KDM' }
KDMImporter >> visitQualifier: anXMLNode [
  ^self visitNodeWithElements: anXMLNode
]

{ #category : 'visiting - KDM' }
KDMImporter >> visitRegion: anXMLNode [
  ^self visitNodeWithElements: anXMLNode
]

{ #category : 'visiting - KDM' }
KDMImporter >> visitReturnType: anXMLNode [
  ^self visitNodeWithElements: anXMLNode
]

{ #category : 'visiting - KDM' }
KDMImporter >> visitRightHandSide: anXMLNode [
  ^self visitNodeWithElements: anXMLNode
]

{ #category : 'visiting - KDM' }
KDMImporter >> visitRightOperand: anXMLNode [
  ^self visitNodeWithElements: anXMLNode
]

{ #category : 'visiting - KDM' }
KDMImporter >> visitSegment: anXMLNode [
  ^self visitNodeWithElements: anXMLNode
]

{ #category : 'visiting - KDM' }
KDMImporter >> visitSource: anXMLNode [
  ^self visitNodeWithElements: anXMLNode
]

{ #category : 'visiting - KDM' }
KDMImporter >> visitStatements: anXMLNode [
  ^self visitNodeWithElements: anXMLNode
]

{ #category : 'visiting - KDM' }
KDMImporter >> visitSuperClass: anXMLNode [
  ^self visitNodeWithElements: anXMLNode
]

{ #category : 'visiting - KDM' }
KDMImporter >> visitSuperInterfaces: anXMLNode [
  ^self visitNodeWithElements: anXMLNode
]

{ #category : 'visiting - KDM' }
KDMImporter >> visitType: anXMLNode [
  ^self visitNodeWithElements: anXMLNode
]

{ #category : 'visiting - KDM' }
KDMImporter >> visitTypeParameters: anXMLNode [
  ^self visitNodeWithElements: anXMLNode
]

{ #category : 'visiting - KDM' }
KDMImporter >> visitValue: anXMLNode [
  ^self visitNodeWithElements: anXMLNode
]

{ #category : 'visiting - KDM' }
KDMImporter >> visitXMI: anXMLNode [
	^self visitNodeWithElements: anXMLNode
]
