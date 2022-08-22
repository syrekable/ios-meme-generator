//
//  ContentView.swift
//  Random Meme Generator
//
//  Created by Jordan Niedzielski on 22/08/2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject var memeFetcher = MemeFetcher()
    @StateObject var memeEditor: MemeEditor = MemeEditor()
    @State private var currentImageID: String = ""
    @State private var isMemePresented: Bool = false
    
    var body: some View {
        ScrollView {
            VStack {
                MemeTemplatePicker(currentImageID: $currentImageID,
                                   imageIDs: memeFetcher.imageIDs,
                                   reloadAction: memeFetcher.fetchImageIDs
                                   , isLoading: memeFetcher.isLoading)
                
                VStack {
                    if let image = memeFetcher.baseImage {
                        if !memeFetcher.isLoading {
                            MemeGeneratorScreen(image: image)
                                .environmentObject(memeEditor)
                        }
                    } else {
                        ProgressView()
                    }
                }
                    .frame(height: 400)
                
                Button("Generate meme") {
                    memeFetcher.generateMeme(with: memeEditor.toRequiredParameters)
                }
                    .padding(10)
                    .foregroundColor(.orange)
                    .border(.orange)
            }
                .padding()
            .onChange(of: memeFetcher.imageIDs) { newValue in
                currentImageID = newValue[0]
            }
            .onChange(of: currentImageID) { newValue in
                memeFetcher.fetchBaseImage(imageID: newValue)
                memeEditor.clean()
                memeEditor.changeTemplate(to: newValue)
            }
            .onChange(of: memeFetcher.generatedMeme) { newValue in
                guard newValue != nil else {
                    fatalError("Generated meme is nil.")
                }
                isMemePresented = true
            }
        }
        .sheet(isPresented: $isMemePresented, onDismiss: {
            isMemePresented = false
            memeEditor.clean()
            memeFetcher.fetchImageIDs()
        }) {
            VStack {
                Text("That's your meme! Screenshot it or smth")
                Image(uiImage: memeFetcher.generatedMeme!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            .padding()
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
