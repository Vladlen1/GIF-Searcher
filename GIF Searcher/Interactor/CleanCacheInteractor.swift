//
//  CleanCacheInteractor.swift
//  GIF Searcher
//
//  Created by Vlad Birukov on 20/10/2018.
//  Copyright © 2018 Vlad Birukov. All rights reserved.
//

import Foundation
import Kingfisher

class CleanCacheInteractor {
    
    func execute() {
        KingfisherManager.shared.cache.clearMemoryCache()
        KingfisherManager.shared.cache.clearDiskCache()
        KingfisherManager.shared.cache.cleanExpiredDiskCache()
    }
}
