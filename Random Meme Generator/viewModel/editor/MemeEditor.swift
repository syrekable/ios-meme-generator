//
//  MemeEditor.swift
//  Random Meme Generator
//
//  Created by Jordan Niedzielski on 22/08/2022.
//

import Foundation

class MemeEditor: ObservableObject {
    @Published var topText: String = ""
    @Published var bottomText: String = ""
    @Published var templateID: String = ""
}
