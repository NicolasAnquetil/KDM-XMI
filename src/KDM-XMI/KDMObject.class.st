Class {
	#name : 'KDMObject',
	#superclass : 'Object',
	#instVars : [
		'attributes',
		'id',
		'model'
	],
	#category : 'KDM-XMI',
	#package : 'KDM-XMI'
}

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

	attributes := Dictionary new
]

{ #category : 'accessing' }
KDMObject >> model [

	^ model
]

{ #category : 'accessing' }
KDMObject >> model: anObject [

	model := anObject
]
