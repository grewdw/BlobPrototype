# Blob Prototype

Source code for the article: "Blob, the Builder - A Step by Step Guide to SwiftUI Custom Animation".

Open the project with Xcode to see how the animation is built up step by step. There are 4 SwiftUI views, corresponding to the 4 steps in the article:

1. SimpleBlob.swift
2. AnimatedBlob.swift
3. SlidingBlob.swift
4. RefinedBlob.swift

The BlobHost view is slightly more complicated than indicated in the article. It contains a picker to cycle between the 4 blob types, another picker to choose the animation type (linear, easeIn or easeOut) and a slider to select the animation duration. With these controls you should be able to experiment without needing to change the source code.

## Usage

The easiest way to use the project is to open with Xcode and then run it in the simulator or directly on an iPhone. 
