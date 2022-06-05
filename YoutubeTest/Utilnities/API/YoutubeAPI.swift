//
//  YoutubeAPI.swift
//  YoutubeTest
//
//  Created by Anh Nguyen on 05/06/2022.
//

import Foundation

class YoutubeAPI {
    static let shared = YoutubeAPI()
    private var session: URLSession
    
    init() {
        session = URLSession(configuration: Self.makeSessionConfiguration())
    }
    
    static private func makeSessionConfiguration() -> URLSessionConfiguration {
        let configuration = URLSessionConfiguration.default
        let headers = [
            "Content-Type": "application/json; charset=utf-8",
            "Accept": "application/json"
        ]
        configuration.httpAdditionalHeaders = headers
        configuration.urlCache = .shared
        configuration.requestCachePolicy = .reloadRevalidatingCacheData
        configuration.timeoutIntervalForRequest = 60
        configuration.timeoutIntervalForResource = 120
        return configuration
    }
    
    func getYoutubeSearchResult(_ keyword: String, completion: @escaping ((String?) -> Void)) {
        let url: String = "https://www.youtube.com/results?search_query=\(keyword)"
        
        guard let url = URL(string: url) else {
            return
        }
        
        session.dataTask(with: url) { data, response, error in
            guard let data = data else {
                return
            }
            let response = String(data: data, encoding: .ascii)
            completion(response)
        }
        .resume()
    }
}
