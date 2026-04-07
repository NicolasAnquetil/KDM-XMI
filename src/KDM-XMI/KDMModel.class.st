Class {
	#name : 'KDMModel',
	#superclass : 'Object',
	#instVars : [
		'entities'
	],
	#category : 'KDM-XMI',
	#package : 'KDM-XMI'
}

{ #category : 'accessing' }
KDMModel >> children [

	^self entities
]

{ #category : 'accessing' }
KDMModel >> entities [

	^entities values
]

{ #category : 'initialization' }
KDMModel >> initialize [ 

	super initialize.

	entities := Dictionary new
]

{ #category : 'registry' }
KDMModel >> register: anObject [

	entities at: anObject id put: anObject.
	anObject model: self.

]
