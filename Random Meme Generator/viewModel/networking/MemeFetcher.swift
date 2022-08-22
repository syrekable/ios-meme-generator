//
//  MemeFetcher.swift
//  Random Meme Generator
//
//  Created by Jordan Niedzielski on 22/08/2022.
//

import Foundation
import UIKit

class MemeFetcher: ObservableObject {
    var service: MemeAPIService
    @Published var imageIDs: [String] = [String]()
    @Published var baseImage: UIImage?
    @Published var isLoading: Bool = false
    
    /// Picks 10 random elements from a collection. It usually actually works for `elements.count >= 100`.
    func pickTenRandomElements(of elements: [String]) -> [String] {
        // FIXME: it ain't 10 DISTINCT random elements
        let indices = Array(repeating: 0, count: 10).map { _ in Int.random(in: 0...elements.count) }.sorted()
        return elements.enumerated().filter { (offset, element) in
            return indices.contains(offset)
        }.map { $0.element }
    }
    
    init() {
        service = MemeAPIService()
        fetchImageIDs()
    }
    
    func fetchImageIDs() {
        isLoading = true
        let imagesURL = service.createURLFor(endpoint: .images)
        let imagesRequest = service.createRequestWithAuthHeaders(for: imagesURL)

        let getAvailableImagesTask = URLSession.shared.dataTask(with: imagesRequest!) { [unowned self] data, response, _ in
            DispatchQueue.main.async {
                self.isLoading = false
            }
            
            if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
                print("Something went wrong during image fetching. Response code: \(response.statusCode).")
                return
            }
            if let data = data {
                do {
                    let imageIDs = try JSONDecoder().decode([String].self, from: data)
                    // probably not the most efficient way of doing so
                    DispatchQueue.main.async {
                        self.imageIDs = self.pickTenRandomElements(of: imageIDs)
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
            
        }

        getAvailableImagesTask.resume()
    }
    
    func fetchBaseImage(imageID: String) {
        isLoading = true
        let emptyMemeParameters = RequiredParameters(top: "", bottom: "", meme: imageID)
        let memesURL = service.createURLFor(endpoint: .meme, with: emptyMemeParameters)
        let memesRequest = service.createRequestWithAuthHeaders(for: memesURL)
        
        let getEmptyMemeTask = URLSession.shared.dataTask(with: memesRequest!) { data, _, _ in
            DispatchQueue.main.async {
                self.isLoading = false
            }
            if let data = data {
                DispatchQueue.main.async {
                    self.baseImage = UIImage(data: data)
                }
            }
        }
        
        getEmptyMemeTask.resume()
    }
}
