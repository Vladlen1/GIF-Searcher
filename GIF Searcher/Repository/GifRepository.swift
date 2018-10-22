//
//  GifRepository.swift
//  GIF Searcher
//
//  Created by Vlad Birukov on 19/10/2018.
//  Copyright © 2018 Vlad Birukov. All rights reserved.
//

import Foundation
import RxSwift

class GifRepository {
    private let networkDataStore = NetworkDataStore()
    private let jsonToGifModels = JSON_to_GifModels()
    
    func getGifsArray(page: Int, searchQuery: String?) -> Observable<[GifModel]> {
        return self.networkDataStore.getGif(page: page, searchQuery: searchQuery).map({[unowned self] json -> [GifModel] in
            let gifModels = self.jsonToGifModels.transform(json: json)
            return gifModels
        })
    }
}
