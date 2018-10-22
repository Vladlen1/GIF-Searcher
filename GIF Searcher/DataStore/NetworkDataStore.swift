//
//  NetworkDataStore.swift
//  GIF Searcher
//
//  Created by Vlad Birukov on 19/10/2018.
//  Copyright © 2018 Vlad Birukov. All rights reserved.
//

import Foundation
import RxSwift
import SwiftyJSON
import Alamofire

class NetworkDataStore {
    private let baseUrl = "http://api.giphy.com/v1/gifs/"
    private let apiKey = "dc6zaTOxFJmzC"
    private let apiKeyPath = "?api_key="
    private let trendingGifPath = "trending"
    private let searchGifPath = "search"
    private let searchQueryPath = "&q="
    private let offsetPath = "&offset="
    private let limit = 25
    
    func getGif(page: Int, searchQuery: String?) -> Observable<JSON> {
        return Observable.create{observer in
            let offset = page * self.limit
            let url = self.getUrl(searchQuery: searchQuery, offset: offset)
            
            Alamofire.request(url).responseJSON {response in
                switch response.result {
                case .success(let anyData):
                    observer.onNext(JSON(anyData))
                case .failure(let error):
                    observer.onError(error)
                }
                observer.onCompleted()
            }
            return Disposables.create()
        }
    }
    
    private func getUrl(searchQuery: String?, offset: Int) -> String {
        let url = searchQuery == nil ? self.getTrendingGifUrl(offset: offset) : self.getSearchUrl(searchQuery: searchQuery!, offset: offset)
        
        return url
    }
    
    private func getSearchUrl(searchQuery: String, offset: Int) -> String {
        let urlStr = "\(baseUrl)\(searchGifPath)\(apiKeyPath)\(apiKey)\(searchQueryPath)\(searchQuery)\(offsetPath)\(offset)"
        
        return urlStr
    }
    
    private func getTrendingGifUrl(offset: Int) -> String {
        let urlStr = "\(baseUrl)\(trendingGifPath)\(apiKeyPath)\(apiKey)\(offsetPath)\(offset)"
        
        return urlStr
    }
}
