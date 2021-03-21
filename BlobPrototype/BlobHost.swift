//
//  ContentView.swift
//  BlobPrototype
//
//  Created by David Grew on 13/03/2021.
//

import SwiftUI

struct BlobHost: View {
    
    @State var selectedBlobType = 3
    let blobTypes = ["Step 1 - Only Blob",
                     "Step 2 - Animated Blob",
                     "Step 3 - Sliding Blob",
                     "Step 4 - Refined Blob"]
    
    
    @State var selectedAnimationType = 2
    let animationTypes = ["easeIn", "easeOut", "linear"]
    
    @State var animationDuration: Double = 1
    
    @State var position: Int = 2
    @State private var previousPosition: Int = 0
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                
                Picker(selection: $selectedBlobType, label: Text("Select Blob Type")) {
                    ForEach(0 ..< blobTypes.count) {
                      Text(self.blobTypes[$0])
                   }
                }
            
                Picker(selection: $selectedAnimationType, label: Text("Selected Animation Type")) {
                   ForEach(0 ..< animationTypes.count) {
                      Text(self.animationTypes[$0])
                   }
                }
                
                Slider(value: $animationDuration, in: 0...5)
                    .padding(.horizontal)
                Text(String(format: "Animation duration: %.2f seconds", animationDuration))
                    
                Spacer()
                
                ZStack(alignment: .center) {
                    selectBlob()
                        .foregroundColor(Color.green)
                        .shadow(radius: 10)
                        .animation(selectAnimation())
                    Faces(position: $position, previousPosition: $previousPosition, widthMultiplier: 0.1)
                }
                .frame(width: geometry.size.width, height: geometry.size.width * 0.2)
                
                Spacer()
            }
        }
    }
    
    func selectBlob() -> AnyView {
        switch selectedBlobType {
        case 0:
            return AnyView(BasicBlob(position: position,
                                    blobWidthMultiplier: 0.15, faceWidthMultiplier: 0.1, numberOfFaces: 5))
                        
        case 1:
            return AnyView(AnimatedBlob(position: CGFloat(position),
                                   blobWidthMultiplier: 0.15, faceWidthMultiplier: 0.1, numberOfFaces: 5))
        case 2:
            return AnyView(SlidingBlob(position: CGFloat(position), previousPosition: CGFloat(previousPosition),
                                   blobWidthMultiplier: 0.15, faceWidthMultiplier: 0.1, numberOfFaces: 5))
        default:
            return AnyView(RefinedBlob(position: CGFloat(position), previousPosition: CGFloat(previousPosition),
                                     blobWidthMultiplier: 0.15, faceWidthMultiplier: 0.1, numberOfFaces: 5))
        }
    }
    
    func selectAnimation() -> Animation {
        switch selectedAnimationType {
        case 0:
            return .easeIn(duration: animationDuration)
        case 1:
            return .easeOut(duration: animationDuration)
        default:
            return .linear(duration: animationDuration)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Spacer()
            BlobHost()
            Spacer()
        }
    }
}
