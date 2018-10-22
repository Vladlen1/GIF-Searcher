//
//  GifInteractor.swift
//  GIF Searcher
//
//  Created by Vlad Birukov on 19/10/2018.
//  Copyright © 2018 Vlad Birukov. All rights reserved.
//

import Foundation
import RxSwift

class GifInteractor {
    private let gifRepository = GifRepository()
    
    func execute(page: Int, searchQuery: String?) -> Observable<[GifModel]> {
        return self.gifRepository.getGifsArray(page: page, searchQuery: searchQuery)
    }
}
