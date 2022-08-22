//
//  MemeGeneratorScreen.swift
//  Random Meme Generator
//
//  Created by Jordan Niedzielski on 22/08/2022.
//

import SwiftUI

struct MemeGeneratorScreen: View {
    @EnvironmentObject var memeEditor: MemeEditor
    let image: UIImage
    var body: some View {
        VStack {
            ZStack {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                VStack {
                    TextField("Top text", text: $memeEditor.topText)
                    Spacer()
                    TextField("Bottom text", text: $memeEditor.bottomText)
                }
                    .padding()
            }
            .frame(height: 400)
            
        }
    }
}

struct MemeGeneratorScreen_Previews: PreviewProvider {
    static var previews: some View {
        MemeGeneratorScreen(image: UIImage(named: "Sample")!)
            .previewLayout(.fixed(width: 400, height: 400))
            .environmentObject(MemeEditor())
    }
}
