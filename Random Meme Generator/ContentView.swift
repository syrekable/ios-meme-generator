//
//  ContentView.swift
//  Random Meme Generator
//
//  Created by Jordan Niedzielski on 22/08/2022.
//

import SwiftUI

struct ContentView: View {
    let imageIDs: [String] = ["Sad-Keanu", "Forever-Alone"]
    @State private var currentImageID = "Sad-Keanu"
    var body: some View {
        VStack {
            List {
                Picker("Meme base:", selection: $currentImageID) {
                    ForEach(imageIDs, id: \.self) { id in
                        Text(id)
                    }
                }
            }
            AsyncImage(url: URL(string: "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fi.imgur.com%2FIFeHHse.jpg&f=1&nofb=1"), scale: 1) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                } else if phase.error != nil {
                    Color.red // Indicates an error.
                } else {
                    Color.orange // Acts as a placeholder.
                }
            }
            Button("Generate meme") {
                print("Generating...")
            }
            .padding()
            .foregroundColor(.orange)
            .border(.orange)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
