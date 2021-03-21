//
//  Faces.swift
//  BlobPrototype
//
//  Created by David Grew on 13/03/2021.
//

import SwiftUI

struct Faces: View {
    
    @Binding var position: Int
    @Binding var previousPosition: Int
    
    var widthMultiplier: CGFloat
    
    private let faces: [String] = ["😫","☹️","😐","🙂","😃"]
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
            
                HStack(spacing: 0) {
                    Spacer()
                    ForEach(0..<5) { i in
                        Button(action: {
                            self.previousPosition = self.position
                            position = i
                        }) {
                            Text(faces[i])
                                .font(.system(size: geometry.size.width * widthMultiplier * 0.9))
                                .frame(width: geometry.size.width * widthMultiplier, alignment: .center)
                        }
                        Spacer()
                    }
                }
                
                Spacer()
            }
        }
    }
}

struct Faces_Previews: PreviewProvider {
    static var previews: some View {
        PreviewWrapper()
            .previewLayout(.fixed(width: 500, height: 100))
    }
    
    private struct PreviewWrapper: View {
        
        @State private var position: Int = 2
        @State private var previousPosition: Int = 0
        
        var body: some View {
            Faces(position: $position, previousPosition: $previousPosition, widthMultiplier: 0.1)
        }
    }
}
