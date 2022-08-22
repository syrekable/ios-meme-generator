//
//  ContentView.swift
//  Random Meme Generator
//
//  Created by Jordan Niedzielski on 22/08/2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject var memeFetcher = MemeFetcher()
    @State private var currentImageID: String = ""
    
    var body: some View {
        VStack {
            HStack {
                Text("Select meme base")
                    .font(.caption)
                Picker("Meme base:", selection: $currentImageID) {
                    ForEach(memeFetcher.imageIDs, id: \.self) { id in
                        Text(id)
                    }
                }
                .frame(width: 150)
            }
            
            VStack {
                if let image = memeFetcher.baseImage {
                    Image(uiImage: image)
                        .resizable(resizingMode: .stretch)
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
