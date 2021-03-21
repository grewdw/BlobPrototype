//
//  BlobTwo.swift
//  BlobPrototype
//
//  Created by David Grew on 13/03/2021.
//

import SwiftUI

struct AnimatedBlob: Shape {
    
    var position: CGFloat
    
    let blobWidthMultiplier: CGFloat
    let faceWidthMultiplier: CGFloat
    let numberOfFaces: CGFloat
    
    func path(in rect: CGRect) -> Path {
        
        var path = Path()
        
        let blobRadius = rect.width * blobWidthMultiplier / 2
        let blobCenter = CGPoint(x: calculateXPosition(for: position, with: rect.width), y: rect.midY)
        
        path.addArc(center: blobCenter, radius: blobRadius, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 360), clockwise: true)

        return path
    }
    
    var animatableData: CGFloat {
        get { position }
        set { position = newValue }
    }
    
    func calculateXPosition(for position: CGFloat, with width: CGFloat) -> CGFloat {
        let faceWidth: CGFloat = width * faceWidthMultiplier
        let totalFaceWidth: CGFloat = faceWidth * numberOfFaces
        let numberOfSpaces = numberOfFaces + 1
        let spaceWidth = (width - totalFaceWidth) / numberOfSpaces
        
        let levelFaceWidth: CGFloat = faceWidth * position
        let levelSpaceWidth: CGFloat = spaceWidth * (position + 1)
        let halfFaceWidth: CGFloat = faceWidth / 2
        
        return levelSpaceWidth + levelFaceWidth + halfFaceWidth
    }
}
