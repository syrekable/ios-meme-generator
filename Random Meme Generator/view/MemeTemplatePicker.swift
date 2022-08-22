//
//  MemeTemplatePicker.swift
//  Random Meme Generator
//
//  Created by Jordan Niedzielski on 22/08/2022.
//

import SwiftUI

struct MemeTemplatePicker: View {
    @Binding var currentImageID: String
    let imageIDs: [String]
    let reloadAction: () -> Void
    let isLoading: Bool
    
    var body: some View {
        HStack {
            VStack {
                HStack {
                    Text("Select meme base")
                    Spacer()
                }
                HStack {
                    if !isLoading {
                        Picker("Meme base:", selection: $currentImageID) {
                            ForEach(imageIDs, id: \.self) { id in
                                Text(id.replacingOccurrences(of: "-", with: " "))
                            }
                            
                        }
                            .pickerStyle(.menu)
                    } else {
                        ProgressView()
                    }
                    
                    Spacer()
                    Button(action: reloadAction) {
                        Label("Roll again", systemImage: "dice")
                    }
                }
            }
            .padding()
        }
    }
}

struct MemeTemplatePicker_Previews: PreviewProvider {
    static var previews: some View {
        MemeTemplatePicker(currentImageID: .constant("Sad-Keanu"), imageIDs: ["Sad-Keanu", "High-Dog"], reloadAction: {}, isLoading: true)
            .previewLayout(.fixed(width: 400, height: 200))
    }
}
