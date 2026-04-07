Class {
	#name : 'KDMObject',
	#superclass : 'Object',
	#instVars : [
		'type',
		'attributes',
		'id',
		'model',
		'children'
	],
	#category : 'KDM-XMI',
	#package : 'KDM-XMI'
}

{ #category : 'accessing' }
KDMObject >> addChild: anObject [

	children add: anObject 
]

{ #category : 'accessing' }
KDMObject >> attributeAt: anAttribute [

	^attributes at: anAttribute 
]

{ #category : 'accessing' }
KDMObject >> attributeAt: anAttribute ifAbsent: aBlock [

	^attributes at: anAttribute ifAbsent: aBlock
]

{ #category : 'accessing' }
KDMObject >> attributeAt: anAttribute put: aValue [

	^attributes at: anAttribute put: aValue
]

{ #category : 'accessing' }
KDMObject >> attributes [

	^ attributes
]

{ #category : 'accessing' }
KDMObject >> attributes: anObject [

	attributes := anObject
]

{ #category : 'accessing' }
KDMObject >> children [

	^children
]

{ #category : 'accessing' }
KDMObject >> id [

	^ id
]

{ #category : 'accessing' }
KDMObject >> id: anObject [

	id := anObject
]

{ #category : 'initialization' }
KDMObject >> initialize [ 

	super initialize.

	attributes := Dictionary new.
	children := OrderedCollection new
]

{ #category : 'accessing' }
KDMObject >> model [

	^ model
]

{ #category : 'accessing' }
KDMObject >> model: anObject [

	model := anObject
]

{ #category : 'printing' }
KDMObject >> printOn: aStream [

	aStream << (self type)
]

{ #category : 'accessing' }
KDMObject >> type [

	^type
]

{ #category : 'accessing' }
KDMObject >> type: aString [

	type := aString 
]
