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
            AsyncImage(url: URL(string: "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fi.imgur.com%2FIFeHHse.jpg&f=1&nofb=1"), scale: 1) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .frame(height: 400)
                } else if phase.error != nil {
                    Color.red // Indicates an error.
                } else {
                    ProgressView()
                        .frame(width: 200, height: 400)
                     // Acts as a placeholder.
                }
            }
            .padding(.vertical, 5)
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
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
