//
//  MemeAPIService.swift
//  Random Meme Generator
//
//  Created by Jordan Niedzielski on 22/08/2022.
//

import Foundation

struct MemeAPIService {
    
    func createURLQuery(parameters params: RequiredParameters) -> [URLQueryItem] {
        return [
            URLQueryItem(name: "top", value: params.top),
            URLQueryItem(name: "bottom", value: params.bottom),
            URLQueryItem(name: "meme", value: params.meme)
        ]
    }

    enum Endpoints: String {
        case meme, images
    }

    func createURLFor(endpoint: Endpoints, with parameters: RequiredParameters? = nil) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "ronreiter-meme-generator.p.rapidapi.com"
        
        switch endpoint {
        case .images:
            components.path = "/images"
            return components.url
        case .meme:
            components.path = "/meme"
            // TODO: nested function fff
            guard let parameters = parameters else {
                return nil
            }
            components.queryItems = createURLQuery(parameters: parameters)
            return components.url
        }
    }

    func createRequestWithAuthHeaders(for url: URL?) -> URLRequest? {
        guard let url = url else {
            return nil
        }
        var request = URLRequest(url: url)
        request.addValue("d3a50d3f09msh358daef88b6ede1p1975b4jsn30d7447d7047", forHTTPHeaderField: "X-RapidAPI-Key")
        request.addValue("ronreiter-meme-generator.p.rapidapi.com", forHTTPHeaderField: "X-RapidAPI-Host")
        
        return request
    }
}
