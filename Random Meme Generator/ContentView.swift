//
//  ContentView.swift
//  Random Meme Generator
//
//  Created by Jordan Niedzielski on 22/08/2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject var memeFetcher = MemeFetcher()
    @State var currentImageID: String = ""
    
    var body: some View {
        VStack {
            MemeTemplatePicker(currentImageID: $currentImageID,
                               imageIDs: memeFetcher.imageIDs,
                               reloadAction: memeFetcher.fetchImageIDs
                               , isLoading: memeFetcher.isLoading)
            
            VStack {
                if let image = memeFetcher.baseImage {
                    if !memeFetcher.isLoading {
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                } else {
                    ProgressView()
                }
            }
                .frame(height: 400)
            
            Button("Generate meme") {
                print("Generating...")
            }
            .padding()
            .foregroundColor(.orange)
            .border(.orange)
        }
            .padding()
        .onChange(of: memeFetcher.imageIDs) { newValue in
            currentImageID = newValue[0]
        }
        .onChange(of: currentImageID) { newValue in
            memeFetcher.fetchBaseImage(imageID: newValue)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
