//
//  BlobThree.swift
//  BlobPrototype
//
//  Created by David Grew on 13/03/2021.
//

import SwiftUI

struct SlidingBlob: Shape {
    
    var currentPosition: CGFloat
    
    var nextPosition: CGFloat
    var previousPosition: CGFloat
    
    let blobWidthMultiplier: CGFloat
    let faceWidthMultiplier: CGFloat
    let numberOfFaces: CGFloat
    
    init(position: CGFloat, previousPosition: CGFloat, blobWidthMultiplier: CGFloat, faceWidthMultiplier: CGFloat, numberOfFaces: CGFloat) {
        currentPosition = position
        nextPosition = position
        self.previousPosition = previousPosition
        self.blobWidthMultiplier = blobWidthMultiplier
        self.faceWidthMultiplier = faceWidthMultiplier
        self.numberOfFaces = numberOfFaces
    }
    
    func path(in rect: CGRect) -> Path {
        
        var path = Path()
        
        let radius = rect.width * blobWidthMultiplier / 2
        
        let totalDistance = nextPosition - previousPosition
        let distanceCovered = currentPosition - previousPosition
        let animationCompletion = distanceCovered / totalDistance
        
        let leftDistance = calculateLeftDistance(given: totalDistance, and: animationCompletion)
        let rightDistance = calculateRightDistance(given: totalDistance, and: animationCompletion)
        
        let leftCenter = CGPoint(x: calculateXPosition(for: leftDistance, with: rect.width), y: rect.midY)
        let rightCenter = CGPoint(x: calculateXPosition(for: rightDistance, with: rect.width), y: rect.midY)
        
        path.addArc(center: leftCenter, radius: radius, startAngle: Angle(degrees: -90), endAngle: Angle(degrees: 90), clockwise: true)
        
        path.addArc(center: rightCenter, radius: radius, startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 270), clockwise: true)

        return path
    }
    
    var animatableData: CGFloat {
        get { currentPosition }
        set { currentPosition = newValue }
    }
    
    func calculateLeftDistance(given totalDistance: CGFloat, and totalAnimationCompletion: CGFloat) -> CGFloat {
        if totalAnimationCompletion < 0.5 {
            return previousPosition
        } else {
            let secondHalfAnimationCompletion = (totalAnimationCompletion - 0.5) * 2
            let currentDistanceToCover = totalDistance * secondHalfAnimationCompletion
            return previousPosition + currentDistanceToCover
        }
    }
    
    func calculateRightDistance(given totalDistance: CGFloat, and totalAnimationCompletion: CGFloat) -> CGFloat {
        if totalAnimationCompletion < 0.5 {
            let firstHalfAnimationCompletion = totalAnimationCompletion * 2
            let currentDistanceToCover = totalDistance * firstHalfAnimationCompletion
            return previousPosition + currentDistanceToCover
        } else {
            return nextPosition
        }
    }
    
    func calculateXPosition(for level: CGFloat, with width: CGFloat) -> CGFloat {
        let faceWidth: CGFloat = width * faceWidthMultiplier
        let totalFaceWidth: CGFloat = faceWidth * numberOfFaces
        let numberOfSpaces = numberOfFaces + 1
        let spaceWidth = (width - totalFaceWidth) / numberOfSpaces
        
        let levelFaceWidth: CGFloat = faceWidth * level
        let levelSpaceWidth: CGFloat = spaceWidth * (level + 1)
        let halfFaceWidth: CGFloat = faceWidth / 2
        
        return levelSpaceWidth + levelFaceWidth + halfFaceWidth
    }
}
